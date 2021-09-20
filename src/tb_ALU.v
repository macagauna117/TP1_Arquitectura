`timescale 10ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2021 05:19:40 PM
// Design Name: 
// Module Name: tb_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ALU;
  
  reg [7:0] a;
  reg [7:0] b;
  wire [7:0] res;
  reg [5:0] opcode;

  ALU instance_ALU(.dato_a(a), .dato_b(b), .out(res), .opcode(opcode));
  
  initial
    begin
      #0
      a = 8'b00001000;
      b = 8'b00000010;
      opcode = 6'b0;
      #5
      opcode = 6'b100000; // SUM
      #1
      $display(res);
      #5
      opcode = 6'b100010; // SUB
      #1
      $display(res);
      #5
      opcode = 6'b100100; // AND
      #1
      $display(res);
      #5
      opcode = 6'b100101; // OR (deberia dar 3)
      a = 8'b00000011;
      b = 8'b00000001;
      #1
      $display(res);
      #5
      opcode = 6'b100110; // XOR (deberia dar 2)
      #1
      $display(res);
      #5
      opcode = 6'b100111; // NOR (deberia dar 252)
      #1
      $display(res);
      #5
      opcode = 6'b000011;
      a = 8'b10000011;
      b = 8'b00000001;
      #1
      $display(res);
      #5
      opcode = 6'b000010; // SRL (deberia dar 65)
      #1
      $display(res);
      
      
      
      $finish;
    end
endmodule




















