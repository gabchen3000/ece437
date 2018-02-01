/*
request unit module
*/

// interface include
`include "cache_control_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module request_unit (
  input logic CLK, nRST,
  request_unit_if.ru ruif
);

always_ff @(posedge CLK, negedge nRST) begin

	if (nRST == 0) begin
		ruif.dmemREN <= '0;
		ruif.dmemWEN <= '0;
	end
	else if (ruif.dhit) begin
		ruif.dmemREN <= 0;
		ruif.dmemWEN <= 0;
	end
	else if (ruif.ihit) begin
		ruif.dmemREN <= ruif.dREN;
		ruif.dmemWEN <= ruif.dWEN;
	end

end

endmodule
