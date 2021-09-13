// Code your testbench here
// or browse Examples
module testbench_ej1;
  
  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] res;
  reg [5:0] opcode;

  ALU instance_ALU(.dato_a(a), .dato_b(b), .out(res), .opcode(opcode));
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
      #0
      a = 8'b00000010;
      b = 8'b00001000;
      opcode = 6'b0;
      #5
      opcode = 6'b100000;
      #5
      $finish;
    end
endmodule