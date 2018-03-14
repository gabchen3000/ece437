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
  datapath_cache_if.cache dcif,
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
	logic [2:0]					idx; //0 - 8
	logic [3:0]					flushcount, nxt_flushcount;
	logic								goflush, offset, dirtyloop, miss, frame1_valid, frame2_valid, frame1_dirty, frame2_dirty, lru[7:0], nxt_lru[7:0]; //lru 0 for left, 1 for right
	word_t							count, nxt_count, frame1_data_1, frame1_data_2, frame2_data_1, frame2_data_2;
	
	typedef enum logic[3:0] {IDLE, LD1, LD2, WB1, WB2, FLUSH1, FLUSH2, DIRTY, COUNT, HALT} state_t;
	state_t							cur_state, nxt_state;

	assign tag = dcif.dmemaddr[31:6];
	assign idx = dcif.dmemaddr[5:3];
	assign offset = dcif.dmemaddr[2];

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
		end
	end

	//frames and blocks
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			frame1[7:0] <= '0;
			frame2[7:0] <= '0;
		end
		else if (cif.dwait == 0) begin
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
				if (dcif.halt) begin
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
				if (cif.dwait) begin
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
				if (cif.dwait) begin
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
				if (cif.dwait) begin
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
					nxt_state = COUNT;
				end
			end

			COUNT: begin
				if (!cif.dwait) begin
					nxt_state = HALT;
				end
			end

			HALT: begin
				nxt_state = HALT;
			end

		endcase
	end

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
		dirtyloop = 1;
		goflush = 0;
		nxt_flushcount = flushcount;

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


		casez (cur_state)
			IDLE: begin
				if (dcif.dmemREN) begin
					if ((tag == frame1[idx].tag) && frame1[idx].valid) begin
						nxt_count = count + 1;
						dcif.dhit = 1;
						dcif.dmemload = frame1[idx].data[offset];
						nxt_lru[idx] = 1;
					end
					else if ((tag == frame2[idx].tag) && frame2[idx].valid) begin
						nxt_count = count + 1;
						dcif.dhit = 1;
						dcif.dmemload = frame2[idx].data[offset];
						nxt_lru[idx] = 0;
					end
					else begin
						miss = 1;
						nxt_count = count - 1;
					end
				end
				else if (dcif.dmemWEN) begin
					if (tag == frame1[idx].tag) begin
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
					end
					else if (tag == frame2[idx].tag) begin
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
					end
					else begin
						miss = 1;
						nxt_count = count - 1;
					end
				end
				else if (dcif.halt) begin
					dirtyloop = 1;
				end
			end

			LD1: begin
				cif.dREN = 1;
				cif.daddr = {dcif.dmemaddr[31:3], 3'b000}; //load the first words first, set index 2 to 0
				if (lru[idx] == 0) begin
					frame1_data_1 = cif.dload;
				end
				else begin
					frame2_data_1 = cif.dload;
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
					nxt_lru[idx] = 1;
				end
				else begin
					frame2_data_2 = cif.dload;
					frame2_valid = 1;
					frame2_dirty = 0;
					frame2_tag = tag;
					nxt_lru[idx] = 0;
				end
			end

			WB1: begin
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

			WB2: begin
				cif.dWEN = 1;
				if (lru[idx] == 0) begin
					cif.daddr = {frame1[idx].tag, idx, 3'b100}; //write the second words, set index 2 to 1
					cif.dstore = frame1[idx].data[1];
					nxt_lru[idx] = 1;
				end
				else begin
					cif.daddr = {frame2[idx].tag, idx, 3'b100}; //write the second words first, set index 2 to 1
					cif.dstore = frame2[idx].data[1];
					nxt_lru[idx] = 0;
				end
			end

			FLUSH1: begin
				cif.dWEN = 1;
				if (flushcount[3] == 0) begin
					cif.daddr = {frame1[flushcount].tag, flushcount, 3'b000};
					cif.dstore = frame1[flushcount].data[0];
				end
				else begin
					cif.daddr = {frame2[flushcount - 8].tag, (flushcount - 8), 3'b000};
					cif.dstore = frame2[flushcount - 8].data[0];
				end
			end

			FLUSH2: begin
				cif.dWEN = 1;
				if (flushcount[3] == 0) begin
					cif.daddr = {frame1[flushcount].tag, flushcount, 3'b100};
					cif.dstore = frame1[flushcount].data[1];
				end
				else begin		
					cif.daddr = {frame2[flushcount - 8].tag, (flushcount - 8), 3'b100};
					cif.dstore = frame2[flushcount - 8].data[1];
				end
				if (!cif.dwait) begin
					nxt_flushcount = flushcount + 1;
				end
			end

			DIRTY: begin
				if (flushcount[3] == 0) begin
					if (frame1[flushcount].dirty) begin					
						goflush = 1;
					end
					else begin
						nxt_flushcount = flushcount + 1;
					end
				end
				else begin
					if (frame2[flushcount - 8].dirty) begin
						goflush = 1;
					end
					else begin
						nxt_flushcount = flushcount + 1;
					end
				end
				if (flushcount == 15) begin
					dirtyloop = 0;
				end
				else begin
					dirtyloop = 1;
				end
			end

			COUNT: begin
				cif.dWEN = 1;
				cif.daddr = 32'h3100;
				cif.dstore = count;
			end

			HALT: begin

			end

		endcase
	end

endmodule
