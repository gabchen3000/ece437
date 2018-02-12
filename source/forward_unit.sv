/*
forward unit module
*/

// interface include
`include "forward_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

module forward_unit (
  foward_unit_if.a222 fuif
);

  // import types
  import cpu_types_pkg::*;

	always_comb begin
    fuif.forwardselA = '0;
    fuif.forwardselB = '0;

    if(fuif.MEMRegWr) begin
      if(fuif.id_ex_rs == fuif.MEMwsel) begin
        fuif.forwardselA = 2'd2;
      end
      else if (fuif.id_ex_rt == fuif.MEMwsel) begin
        fuif.forwardselB = 2'd2;
      end
    end

    if(fuif.WBRegWr) begin
      if(fuif.id_ex_rs == fuif.WBwsel) begin
        fuif.forwardselA = 2'd1;
      end
      else if (fuif.id_ex_rt == fuif.WBwsel) begin
        fuif.forwardselB = 2'd1;
      end

    end
  end

endmodule
