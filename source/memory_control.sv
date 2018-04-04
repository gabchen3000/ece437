/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

	logic		snoopcache, iselect, prev_iselect, wbcache;
	typedef enum logic[3:0] {IDLE, IArbitrate, INSTR, NONCO_WB0, NONCO_WB1, DArbitrate, SNOOP, WB0, WB1, MEM0, MEM1} state_t;
	state_t							cur_state, nxt_state;
	word_t							iload0, iload1;


/*
assign ccif.ramWEN = ccif.dWEN;
assign ccif.ramstore = ccif.dstore;
assign ccif.ramREN = ccif.dREN || (ccif.iREN && !ccif.dWEN && !ccif.dREN);


//ramaddr will either be iaddr or daddr depending on iren, dren and dwen
always_comb begin
	ccif.ramaddr = 0;
	if (ccif.dWEN || ccif.dREN) begin
		ccif.ramaddr = ccif.daddr;
	end
	else begin
		ccif.ramaddr = ccif.iaddr;
	end
end


//deal with dwait and iwait, load data from ram when ramstate = ACCESS

always_comb begin
	ccif.dwait = 1;
	ccif.iwait = 1;
	ccif.dload = 0;
	ccif.iload = 0;
	if (ccif.ramstate == ACCESS) begin
		if (ccif.dWEN) begin
			ccif.dwait = 0;
		end
		else if (ccif.dREN) begin
			ccif.dwait = 0;
			ccif.dload = ccif.ramload;
		end
		else begin
			ccif.iwait = 0;
			ccif.iload = ccif.ramload;
		end
	end
end
*/

	//state machine
	always_ff @(posedge CLK, negedge nRST) begin
		if (nRST == 0) begin
			cur_state <= IDLE;
			iselect <= 1;
			snoopcache <= 1;
			ccif.iload[0] <= 0;
			ccif.iload[1] <= 0;
		end
		else begin
			ccif.iload[0] <= iload0;
			ccif.iload[1] <= iload1;

			cur_state <= nxt_state;
			if (cur_state == IDLE) begin
				snoopcache <= ccif.cctrans[0] ? 1 : 0;
			end
			if (cur_state == IDLE && nxt_state == IArbitrate) begin
				iselect <= !iselect;
			end
			else if (cur_state == IArbitrate) begin
				iselect <= (ccif.iREN[iselect]) ? iselect : !iselect;
			end
			else begin
				iselect <= iselect;
			end
		end
	end

	//nextstate logic
	always_comb begin
		nxt_state = cur_state;
		casez (cur_state)

			IDLE: begin

				if (ccif.dWEN[0] || ccif.dWEN[1]) begin
					nxt_state = NONCO_WB0;
				end
				else if (ccif.cctrans[0] || ccif.cctrans[1]) begin
					nxt_state = DArbitrate;
				end
				else if (ccif.iREN[0] || ccif.iREN[1]) begin
					nxt_state = IArbitrate;
				end
			end

			DArbitrate: begin
				if (ccif.dREN[0] || ccif.dREN[1] || ccif.dWEN[0] || ccif.dWEN[1]) begin
					nxt_state = SNOOP;
				end
				else begin
					nxt_state = IDLE;
				end
			end

			SNOOP: begin
				if (!ccif.cctrans[snoopcache]) begin //???
					nxt_state = MEM0;
				end
				if (ccif.cctrans[snoopcache]) begin //???
					nxt_state = WB0;
				end
			end

			MEM0: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = MEM1;
				end
			end

			MEM1: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = IDLE;
				end
			end

			WB0: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = WB1;
				end
			end

			WB1: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = IDLE;
				end
			end

			NONCO_WB0: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = NONCO_WB1;
				end
			end

			NONCO_WB1: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = IDLE;
				end
			end

			IArbitrate: begin
				nxt_state = INSTR;
				if (ccif.dWEN[0] || ccif.dWEN[1]) begin
					nxt_state = NONCO_WB0;
				end
				else if (ccif.cctrans[0] || ccif.cctrans[1]) begin
					nxt_state = DArbitrate;
				end

			end

			INSTR: begin
				if (ccif.ramstate == ACCESS) begin
					nxt_state = IDLE;
				end
				if (ccif.dWEN[0] || ccif.dWEN[1]) begin
					nxt_state = NONCO_WB0;
				end
				else if (ccif.cctrans[0] || ccif.cctrans[1]) begin
					nxt_state = DArbitrate;
				end
			end

		endcase
	end

	//output logic
	always_comb begin
		ccif.ramWEN = 0;
		ccif.ramREN = 0;
		ccif.ramstore = 0;
		ccif.ramaddr = 0;
		//ccif.iload[0] = 0;
		iload0 = ccif.iload[0];
		ccif.dload[0] = 0;
		ccif.dwait[0] = 1;
		ccif.iwait[0] = 1;
		ccif.ccinv[0] = ccif.ccwrite[1];
		ccif.ccwait[0] = 0;
		ccif.ccsnoopaddr[0] = 0;
		//ccif.iload[1] = 0;
		iload1 = ccif.iload[1];
		ccif.dload[1] = 0;
		ccif.dwait[1] = 1;
		ccif.iwait[1] = 1;
		ccif.ccinv[1] = ccif.ccwrite[0];
		ccif.ccwait[1] = 0;
		ccif.ccsnoopaddr[1] = 0;
		//prev_iselect = prev_iselect;

		casez (cur_state)

			IDLE: begin
				//iselect = !prev_iselect;
				wbcache = ccif.dWEN[0] ? 0 : 1;
			end

			DArbitrate: begin
				if (nxt_state == IDLE) begin
					//ccif.ccinv[snoopcache] = 1;
				end
				ccif.ccwait[snoopcache] = 1;
			end

			SNOOP: begin
				ccif.ccwait[snoopcache] = 1;
				ccif.ccsnoopaddr[snoopcache] = ccif.daddr[!snoopcache];
			end

			MEM0: begin
				ccif.ramaddr = ccif.daddr[!snoopcache];
				ccif.ramREN = ccif.dREN[!snoopcache];
				ccif.dwait[!snoopcache] = 0;
				ccif.dload[!snoopcache] = ccif.ramload;
				ccif.ccwait[snoopcache] = 1;
				ccif.ccsnoopaddr[snoopcache] = ccif.daddr[!snoopcache];
			end

			MEM1: begin
				ccif.ramaddr = ccif.daddr[!snoopcache];
				ccif.ramREN = ccif.dREN[!snoopcache];
				ccif.dwait[!snoopcache] = 0;
				ccif.dload[!snoopcache] = ccif.ramload;
				//ccif.ccinv[snoopcache] = ccif.ccwrite[!snoopcache];
				ccif.ccwait[snoopcache] = 1;
				ccif.ccsnoopaddr[snoopcache] = ccif.daddr[!snoopcache];
			end

			WB0: begin
				ccif.ramaddr = ccif.daddr[snoopcache];
				ccif.ramstore = ccif.dstore[snoopcache];
				ccif.ramWEN = ccif.dWEN[snoopcache];
				ccif.dload[!snoopcache] = ccif.ramstore;
				ccif.ccwait[snoopcache] = 1;
				ccif.ccsnoopaddr[snoopcache] = ccif.daddr[!snoopcache];
				if (ccif.ramstate == ACCESS) begin
					ccif.dwait[snoopcache] = 0;
					ccif.dwait[!snoopcache] = 0;
				end
			end

			WB1: begin
				ccif.ramaddr = ccif.daddr[snoopcache];
				ccif.ramstore = ccif.dstore[snoopcache];
				ccif.ramWEN = ccif.dWEN[snoopcache];
				ccif.dload[!snoopcache] = ccif.ramstore;
				//ccif.ccinv[snoopcache] = ccif.ccwrite[!snoopcache];
				ccif.ccwait[snoopcache] = 1;
				ccif.ccsnoopaddr[snoopcache] = ccif.daddr[!snoopcache];
				if (ccif.ramstate == ACCESS) begin
					ccif.dwait[snoopcache] = 0;
					ccif.dwait[!snoopcache] = 0;
				end
			end

			NONCO_WB0: begin
				ccif.ramaddr = ccif.daddr[wbcache];
				ccif.ramstore = ccif.dstore[wbcache];
				ccif.ramWEN = ccif.dWEN[wbcache];
				ccif.dwait[wbcache] = 0;
				if (ccif.ramstate == ACCESS) begin
					ccif.dwait[wbcache] = 0;
				end
			end

			NONCO_WB1: begin
				ccif.ramaddr = ccif.daddr[wbcache];
				ccif.ramstore = ccif.dstore[wbcache];
				ccif.ramWEN = ccif.dWEN[wbcache];
				ccif.dwait[wbcache] = 0;
			end

			IArbitrate: begin
				//iselect = (ccif.iREN[iselect]) ? iselect : !iselect;
			end

			INSTR: begin
				ccif.ramREN = 1;
				ccif.ramaddr = ccif.iaddr[iselect];
				if (iselect == 0) begin				
					iload0 = ccif.ramload;
				end
				else begin
					iload1 = ccif.ramload;
				end
				ccif.iwait[iselect] = 0;
				//prev_iselect = iselect;
			end

		endcase
	end


endmodule
