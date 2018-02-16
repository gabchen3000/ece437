/*
forward unit module
*/

// interface include
`include "forward_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module forward_unit (
  forward_unit_if.fu fuif
);

  // import types
  import cpu_types_pkg::*;

	always_comb begin
    fuif.forwardselA = '0;
    fuif.forwardselB = '0;

    if(fuif.MEMRegWr) begin
      if(fuif.id_ex_rs == fuif.MEMwsel && fuif.id_ex_rs != 0) begin
				if(fuif.MEMlui) begin
					fuif.forwardselA = 2'd3;
				end
				else begin
        	fuif.forwardselA = 2'd2;
				end
      end
      else if (fuif.id_ex_rt == fuif.MEMwsel && fuif.id_ex_rt != 0) begin
				if(fuif.MEMlui) begin
					fuif.forwardselB = 2'd3;
				end
				else begin
        	fuif.forwardselB = 2'd2;
				end
      end
    end

    if(fuif.WBRegWr) begin
      if(fuif.id_ex_rs == fuif.WBwsel && fuif.id_ex_rs != 0) begin
        fuif.forwardselA = 2'd2;
      end
      else if (fuif.id_ex_rt == fuif.WBwsel && fuif.id_ex_rt != 0) begin
        fuif.forwardselB = 2'd2;
      end

    end
  end

endmodule
