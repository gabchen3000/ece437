/*
  this block is the dcache
*/

// interfaces
`include "datapath_cache_if.vh"
`include "caches_if.vh"

// cpu types
`include "cpu_types_pkg.vh"

module dcache (
  input logic CLK, nRST,
  datapath_cache_if.dcache dcif,
  caches_if.dcache cif
);
  // import types
  import cpu_types_pkg::*;

/*
	logic valid;
	logic dirty;
	logic [DTAG_W - 1:0] tag; ->26bits
	word_t [1:0] data;
*/
	dcache_frame [7:0]	frame1, frame2;//1kbits in total, two words (64bits) per block
	logic [25:0]				tag, frame1_tag, frame2_tag;
	logic [2:0]					idx, flushcountIDX; //0 - 8
	logic [4:0]					flushcount, nxt_flushcount;
	logic								goflush, offset, dirtyloop, nxt_dirtyloop, miss, frame1_valid, frame2_valid, frame1_dirty, frame2_dirty, lru[7:0], nxt_lru[7:0]; //lru 0 for left, 1 for right
	word_t							count, nxt_count, frame1_data_1, frame1_data_2, frame2_data_1, frame2_data_2;
	//coherence signals
	logic								stagmiss, snoopdone, snoopoffset, matchframe, frame1_snoopvalid[7:0], frame2_snoopvalid[7:0], frame1_snoopdirty[7:0], frame2_snoopdirty[7:0];
	logic [25:0]				snooptag, frame1_snooptag[7:0], frame2_snooptag[7:0];
	logic [2:0]					snoopidx;	

	typedef enum logic[3:0] {IDLE, LD1, LD2, WB1, WB2, FLUSH1, FLUSH2, DIRTY, COUNT, HALT, SNOOPING, CO_WB0, CO_WB1} state_t;
	state_t							cur_state, nxt_state;

	assign tag = dcif.dmemaddr[31:6];
	assign idx = dcif.dmemaddr[5:3];
	assign offset = dcif.dmemaddr[2];
	//coherence tag copies

//33 bits for linked register, 32 bits address and a valid (status) bit
//if this core is trying to store or store conditional, break the link when finished
//this also applies for when the other cache is snooping into this cache

	//state machine
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			cur_state <= IDLE;
			lru[7] <= 0;
			lru[6] <= 0;
			lru[5] <= 0;
			lru[4] <= 0;
			lru[3] <= 0;
			lru[2] <= 0;
			lru[1] <= 0;
			lru[0] <= 0;
			count <= 0;
			flushcount <= 0;
			dirtyloop <= 1;

			frame1_snooptag[0] <= 0;
			frame1_snooptag[1] <= 0;
			frame1_snooptag[2] <= 0;
			frame1_snooptag[3] <= 0;
			frame1_snooptag[4] <= 0;
			frame1_snooptag[5] <= 0;
			frame1_snooptag[6] <= 0;
			frame1_snooptag[7] <= 0;
			frame2_snooptag[0] <= 0;
			frame2_snooptag[1] <= 0;
			frame2_snooptag[2] <= 0;
			frame2_snooptag[3] <= 0;
			frame2_snooptag[4] <= 0;
			frame2_snooptag[5] <= 0;
			frame2_snooptag[6] <= 0;
			frame2_snooptag[7] <= 0;

			frame1_snoopvalid[0] <= 0;
			frame1_snoopvalid[1] <= 0;
			frame1_snoopvalid[2] <= 0;
			frame1_snoopvalid[3] <= 0;
			frame1_snoopvalid[4] <= 0;
			frame1_snoopvalid[5] <= 0;
			frame1_snoopvalid[6] <= 0;
			frame1_snoopvalid[7] <= 0;
			frame2_snoopvalid[0] <= 0;
			frame2_snoopvalid[1] <= 0;
			frame2_snoopvalid[2] <= 0;
			frame2_snoopvalid[3] <= 0;
			frame2_snoopvalid[4] <= 0;
			frame2_snoopvalid[5] <= 0;
			frame2_snoopvalid[6] <= 0;
			frame2_snoopvalid[7] <= 0;

			frame1_snoopdirty[0] <= 0;
			frame1_snoopdirty[1] <= 0;
			frame1_snoopdirty[2] <= 0;
			frame1_snoopdirty[3] <= 0;
			frame1_snoopdirty[4] <= 0;
			frame1_snoopdirty[5] <= 0;
			frame1_snoopdirty[6] <= 0;
			frame1_snoopdirty[7] <= 0;
			frame2_snoopdirty[0] <= 0;
			frame2_snoopdirty[1] <= 0;
			frame2_snoopdirty[2] <= 0;
			frame2_snoopdirty[3] <= 0;
			frame2_snoopdirty[4] <= 0;
			frame2_snoopdirty[5] <= 0;
			frame2_snoopdirty[6] <= 0;
			frame2_snoopdirty[7] <= 0;
		end
		else begin
			cur_state <= nxt_state;
			lru[7] <= nxt_lru[7];
			lru[6] <= nxt_lru[6];
			lru[5] <= nxt_lru[5];
			lru[4] <= nxt_lru[4];
			lru[3] <= nxt_lru[3];
			lru[2] <= nxt_lru[2];
			lru[1] <= nxt_lru[1];
			lru[0] <= nxt_lru[0];
			count <= nxt_count;
			flushcount <= nxt_flushcount;
			dirtyloop <= nxt_dirtyloop;

			frame1_snooptag[0] <= frame1[0].tag;
			frame1_snooptag[1] <= frame1[1].tag;
			frame1_snooptag[2] <= frame1[2].tag;
			frame1_snooptag[3] <= frame1[3].tag;
			frame1_snooptag[4] <= frame1[4].tag;
			frame1_snooptag[5] <= frame1[5].tag;
			frame1_snooptag[6] <= frame1[6].tag;
			frame1_snooptag[7] <= frame1[7].tag;
			frame2_snooptag[0] <= frame2[0].tag;
			frame2_snooptag[1] <= frame2[1].tag;
			frame2_snooptag[2] <= frame2[2].tag;
			frame2_snooptag[3] <= frame2[3].tag;
			frame2_snooptag[4] <= frame2[4].tag;
			frame2_snooptag[5] <= frame2[5].tag;
			frame2_snooptag[6] <= frame2[6].tag;
			frame2_snooptag[7] <= frame2[7].tag;

			frame1_snoopvalid[0] <= frame1[0].valid;
			frame1_snoopvalid[1] <= frame1[1].valid;
			frame1_snoopvalid[2] <= frame1[2].valid;
			frame1_snoopvalid[3] <= frame1[3].valid;
			frame1_snoopvalid[4] <= frame1[4].valid;
			frame1_snoopvalid[5] <= frame1[5].valid;
			frame1_snoopvalid[6] <= frame1[6].valid;
			frame1_snoopvalid[7] <= frame1[7].valid;
			frame2_snoopvalid[0] <= frame2[0].valid;
			frame2_snoopvalid[1] <= frame2[1].valid;
			frame2_snoopvalid[2] <= frame2[2].valid;
			frame2_snoopvalid[3] <= frame2[3].valid;
			frame2_snoopvalid[4] <= frame2[4].valid;
			frame2_snoopvalid[5] <= frame2[5].valid;
			frame2_snoopvalid[6] <= frame2[6].valid;
			frame2_snoopvalid[7] <= frame2[7].valid;

			frame1_snoopdirty[0] <= frame1[0].dirty;
			frame1_snoopdirty[1] <= frame1[1].dirty;
			frame1_snoopdirty[2] <= frame1[2].dirty;
			frame1_snoopdirty[3] <= frame1[3].dirty;
			frame1_snoopdirty[4] <= frame1[4].dirty;
			frame1_snoopdirty[5] <= frame1[5].dirty;
			frame1_snoopdirty[6] <= frame1[6].dirty;
			frame1_snoopdirty[7] <= frame1[7].dirty;
			frame2_snoopdirty[0] <= frame2[0].dirty;
			frame2_snoopdirty[1] <= frame2[1].dirty;
			frame2_snoopdirty[2] <= frame2[2].dirty;
			frame2_snoopdirty[3] <= frame2[3].dirty;
			frame2_snoopdirty[4] <= frame2[4].dirty;
			frame2_snoopdirty[5] <= frame2[5].dirty;
			frame2_snoopdirty[6] <= frame2[6].dirty;
			frame2_snoopdirty[7] <= frame2[7].dirty;
		end
	end

	//frames and blocks
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			frame1[7:0] <= '0;
			frame2[7:0] <= '0;
		end
		else begin
			frame1[idx].valid <= frame1_valid;
			frame1[idx].dirty <= frame1_dirty;
			frame1[idx].tag <= frame1_tag;
			frame1[idx].data[0] <= frame1_data_1;
			frame1[idx].data[1] <= frame1_data_2;
			frame2[idx].valid <= frame2_valid;
			frame2[idx].dirty <= frame2_dirty;
			frame2[idx].tag <= frame2_tag;
			frame2[idx].data[0] <= frame2_data_1;
			frame2[idx].data[1] <= frame2_data_2;
		end
	end

	//nextstate logic
	always_comb begin
		nxt_state = cur_state;
		casez (cur_state)

			IDLE: begin
				if (cif.ccwait) begin
					nxt_state = SNOOPING;
				end
				else if (dcif.halt) begin
					nxt_state = DIRTY;
				end
				else if (miss) begin
					if (lru[idx] == 0) begin
						nxt_state = frame1[idx].dirty ? WB1 : LD1;
					end
					else begin
						nxt_state = frame2[idx].dirty ? WB1 : LD1;
					end
				end
				else begin
					nxt_state = IDLE;
				end
			end

			LD1: begin
				if (cif.ccwait) begin
					nxt_state = SNOOPING;
				end
				else if (cif.dwait) begin
					nxt_state = LD1;
				end
				else begin
					nxt_state = LD2;
				end
			end

			LD2: begin
				if (cif.dwait) begin
					nxt_state = LD2;
				end
				else begin
					nxt_state = IDLE;
				end
			end

			WB1: begin
				if (cif.ccwait) begin
					nxt_state = SNOOPING;
				end				
				else if (cif.dwait) begin
					nxt_state = WB1;
				end
				else begin
					nxt_state = WB2;
				end
			end

			WB2: begin
				if (cif.dwait) begin
					nxt_state = WB2;
				end
				else begin
					nxt_state = LD1;
				end
			end

			FLUSH1: begin
				if (cif.ccwait) begin
					nxt_state = SNOOPING;
				end				
				else if (cif.dwait) begin
					nxt_state = FLUSH1;
				end
				else begin
					nxt_state = FLUSH2;
				end
			end

			FLUSH2: begin
				if (cif.dwait) begin
					nxt_state = FLUSH2;
				end
				else begin
					nxt_state = DIRTY;
				end
			end

			DIRTY: begin
				if (goflush) begin
					nxt_state = FLUSH1;
				end
				else if (!dirtyloop) begin
					nxt_state = HALT;
				end
			end

			COUNT: begin	//we can delete count.
				if (!cif.dwait) begin
					nxt_state = HALT;
				end
			end

			HALT: begin
				nxt_state = HALT;
			end

			SNOOPING: begin
				if (snoopdone) begin
					nxt_state = IDLE;
				end
				else begin
					if (matchframe == 0) begin
						nxt_state = frame1[snoopidx].dirty ? CO_WB0 : SNOOPING;
					end
					else begin
						nxt_state = frame2[snoopidx].dirty ? CO_WB0 : SNOOPING;
					end
				end
			end

			CO_WB0: begin
				if (!cif.dwait) begin
					nxt_state = CO_WB1;
				end
			end

			CO_WB1: begin
				if (!cif.dwait) begin
					nxt_state = IDLE;
				end
			end

		endcase
	end

	assign snooptag = cif.ccsnoopaddr[31:6];
	assign snoopidx = cif.ccsnoopaddr[5:3];
	assign snoopoffset = cif.ccsnoopaddr[2];

	//output logic
	always_comb begin
		nxt_count = count;
		miss = 0;
		dcif.dhit = 0;
		dcif.dmemload = 0;
		nxt_lru[7] = lru[7];
		nxt_lru[6] = lru[6];
		nxt_lru[5] = lru[5];
		nxt_lru[4] = lru[4];
		nxt_lru[3] = lru[3];
		nxt_lru[2] = lru[2];
		nxt_lru[1] = lru[1];
		nxt_lru[0] = lru[0];
		cif.dWEN = 0;
		cif.dREN = 0;
		cif.daddr = 0;
		cif.dstore = 0;
		nxt_dirtyloop = dirtyloop;
		goflush = 0;
		nxt_flushcount = flushcount;
		flushcountIDX = flushcount[2:0];

		frame1_valid = frame1[idx].valid;
		frame1_dirty = frame1[idx].dirty;
		frame1_tag = frame1[idx].tag;
		frame1_data_1 = frame1[idx].data[0];
		frame1_data_2 = frame1[idx].data[1];
		frame2_valid = frame2[idx].valid;
		frame2_dirty = frame2[idx].dirty;
		frame2_tag = frame2[idx].tag;
		frame2_data_1 = frame2[idx].data[0];
		frame2_data_2 = frame2[idx].data[1];
		dcif.flushed = 0;
		cif.cctrans = 0;
		cif.ccwrite = dcif.dmemWEN;

		snoopdone = 0;
		stagmiss = 1;

		casez (cur_state)
			IDLE: begin
				if (cif.ccwait) begin
					
				end
				else if (dcif.dmemREN) begin
					if ((tag == frame1[idx].tag) && frame1[idx].valid) begin
						nxt_count = count + 1;
						dcif.dhit = 1;
						dcif.dmemload = frame1[idx].data[offset];
						nxt_lru[idx] = 1;
						cif.cctrans = 0;
						//cif.ccwrite = 0;
					end
					else if ((tag == frame2[idx].tag) && frame2[idx].valid) begin
						nxt_count = count + 1;
						dcif.dhit = 1;
						dcif.dmemload = frame2[idx].data[offset];
						nxt_lru[idx] = 0;
						cif.cctrans = 0;
						//cif.ccwrite = 0;
					end
					else begin
						miss = 1;
						nxt_count = count - 1;
						cif.cctrans = 1;
						/*if (lru[idx] == 0) begin
							cif.cctrans = frame1[idx].dirty ? 0 : 1;
						end
						else begin
							cif.cctrans = frame2[idx].dirty ? 0 : 1;
						end*/
						//cif.ccwrite = 0;
					end
				end
				else if (dcif.dmemWEN) begin
					if ((tag == frame1[idx].tag) && frame1[idx].valid) begin
						cif.cctrans = 1; //shared -> modified transition
						nxt_count = count + 1;
						dcif.dhit = 1;
						frame1_dirty = 1;
						if (offset == 0) begin
							frame1_data_1 = dcif.dmemstore;
						end
						else begin
							frame1_data_2 = dcif.dmemstore;
						end
						nxt_lru[idx] = 1;
						cif.cctrans = 1;
						//cif.ccwrite = 0;
					end
					else if ((tag == frame2[idx].tag) && frame2[idx].valid) begin
						cif.cctrans = 1; //shared -> modified transition
						nxt_count = count + 1;
						dcif.dhit = 1;
						frame2_dirty = 1;
						if (offset == 0) begin
							frame2_data_1 = dcif.dmemstore;
						end
						else begin
							frame2_data_2 = dcif.dmemstore;
						end
						nxt_lru[idx] = 0;
						cif.cctrans = 1;
						//cif.ccwrite = 0;
					end
					else begin
						miss = 1;
						nxt_count = count - 1;
						cif.cctrans = 1;
							//cif.ccwrite = frame1[idx].dirty ? 0 : 1;	
					end
				end
				else if (dcif.halt) begin
					nxt_dirtyloop = 1;
					cif.cctrans = 0;
					//cif.ccwrite = 0;
				end
			end

			LD1: begin
				if (cif.ccwait) begin
					
				end
					else begin
					cif.dREN = 1;
					cif.daddr = {dcif.dmemaddr[31:3], 3'b000}; //load the first words first, set index 2 to 0
					if (lru[idx] == 0) begin
						frame1_data_1 = cif.dload;
					end
					else begin
						frame2_data_1 = cif.dload;
					end
				end
			end

			LD2: begin
				cif.dREN = 1;
				cif.daddr = {dcif.dmemaddr[31:3], 3'b100}; //load the second word, set index 2 to 1
				if (lru[idx] == 0) begin
					frame1_data_2 = cif.dload;
					frame1_valid = 1;
					frame1_dirty = 0;
					frame1_tag = tag;
					if (!cif.dwait) begin
						nxt_lru[idx] = 1;
					end
				end
				else begin
					frame2_data_2 = cif.dload;
					frame2_valid = 1;
					frame2_dirty = 0;
					frame2_tag = tag;
					if (!cif.dwait) begin
						nxt_lru[idx] = 0;
					end
				end
			end

			WB1: begin
				if (cif.ccwait) begin
					
				end
				else begin
					cif.dWEN = 1;
					if (lru[idx] == 0) begin
						cif.daddr = {frame1[idx].tag, idx, 3'b000}; //write the first words first, set index 2 to 0
						cif.dstore = frame1[idx].data[0];
					end
					else begin
						cif.daddr = {frame2[idx].tag, idx, 3'b000}; //write the first words first, set index 2 to 0
						cif.dstore = frame2[idx].data[0];
					end
				end
			end

			WB2: begin
				cif.dWEN = 1;
				if (lru[idx] == 0) begin
					cif.daddr = {frame1[idx].tag, idx, 3'b100}; //write the second words, set index 2 to 1
					cif.dstore = frame1[idx].data[1];
					cif.cctrans = 1;
					//cif.ccwrite = 1;
				end
				else begin
					cif.daddr = {frame2[idx].tag, idx, 3'b100}; //write the second words first, set index 2 to 1
					cif.dstore = frame2[idx].data[1];
					cif.cctrans = 1;
					//cif.ccwrite = 1;
				end
			end

			FLUSH1: begin
				if (cif.ccwait) begin
					
				end
				else begin
					cif.dWEN = 1;
					if (flushcount[3] == 0) begin
						cif.daddr = {frame1[flushcountIDX].tag, flushcountIDX, 3'b000};
						cif.dstore = frame1[flushcountIDX].data[0];
					end
					else begin
						cif.daddr = {frame2[flushcountIDX].tag, flushcountIDX, 3'b000};
						cif.dstore = frame2[flushcountIDX].data[0];
					end
				end
			end

			FLUSH2: begin
				cif.dWEN = 1;
				if (flushcount[3] == 0) begin
					cif.daddr = {frame1[flushcountIDX].tag, flushcountIDX, 3'b100};
					cif.dstore = frame1[flushcountIDX].data[1];
				end
				else begin		
					cif.daddr = {frame2[flushcountIDX].tag, flushcountIDX, 3'b100};
					cif.dstore = frame2[flushcountIDX].data[1];
				end
				if (!cif.dwait) begin
					nxt_flushcount = flushcount + 1;
				end
			end

			DIRTY: begin
				if (flushcount[3] == 0) begin
					if (frame1[flushcountIDX].dirty) begin					
						goflush = 1;
					end
					else begin
						nxt_flushcount = flushcount + 1;
					end
				end
				else begin
					if (frame2[flushcountIDX].dirty) begin
						goflush = 1;
					end
					else begin
						nxt_flushcount = flushcount + 1;
					end
				end
				if (flushcount >= 16) begin
					nxt_dirtyloop = 0;
					goflush = 0;
					nxt_flushcount = 16;
				end
				else begin
					nxt_dirtyloop = 1;
				end
			end

			COUNT: begin
				cif.dWEN = 1;
				cif.daddr = 32'h3100;
				cif.dstore = count;
			end

			HALT: begin
				dcif.flushed = 1;
			end

			SNOOPING: begin //cctrans happens here so that it corresponds correctly with the memory control
				if ((snooptag == frame1_snooptag[snoopidx]) && frame1_snoopvalid[snoopidx]) begin	//match tag, frame1
					stagmiss = 0;
					matchframe = 0;
					if (!frame1_snoopdirty[snoopidx]) begin //match tag, frame1, not dirty
						frame1_valid = !cif.ccinv;
						snoopdone = 1;
						//cif.cctrans = 0;
						//cif.ccwrite = 0;
					end
					else begin //match tag, frame1, dirty
						cif.cctrans = 1;
						//cif.ccwrite = 1;
					end
				end
				else if ((snooptag == frame2_snooptag[snoopidx]) && frame2_snoopvalid[snoopidx]) begin
					stagmiss = 0;
					matchframe = 1;
					if (!frame2_snoopdirty[snoopidx]) begin //match tag, frame2, not dirty
						frame2_valid = !cif.ccinv;
						snoopdone = 1;
						//cif.cctrans = 1;
						//cif.ccwrite = 0;
					end
					else begin  //match tag, frame2, dirty
						cif.cctrans = 1;
						//cif.ccwrite = 1;
					end
				end
				else begin  //not match tag
					stagmiss = 1;
					snoopdone = 1;
					//cif.cctrans = 1;
					//cif.ccwrite = 0;
				end
			end

			CO_WB0: begin
				cif.dWEN = 1;
				//cif.ccwrite = 1;	
				if (matchframe == 0) begin
					cif.daddr = {frame1[snoopidx].tag, snoopidx, 3'b000};
					cif.dstore = frame1[snoopidx].data[0];
				end	
				else begin
					cif.daddr = {frame2[snoopidx].tag, snoopidx, 3'b000};
					cif.dstore = frame2[snoopidx].data[0];
				end
			end

			CO_WB1: begin
				//cif.ccwrite = 1;	
				cif.dWEN = 1;
				if (matchframe == 0) begin
					cif.daddr = {frame1[snoopidx].tag, snoopidx, 3'b100};
					cif.dstore = frame1[snoopidx].data[1];
					frame1_valid = !cif.ccinv;
					frame1_dirty = 0;
				end	
				else begin
					cif.daddr = {frame2[snoopidx].tag, snoopidx, 3'b100};
					cif.dstore = frame2[snoopidx].data[1];
					frame2_valid = !cif.ccinv;
					frame2_dirty = 0;
				end
			end

			HALT: begin
				cif.cctrans = cif.ccwait;
				//cif.ccwrite = !cif.ccwait;
			end

		endcase
	end

endmodule
