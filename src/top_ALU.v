`timescale 1ns / 1ps

module top_ALU #(
    parameter NB_OPERANDO = 8,
    parameter NB_OUT = 8,
    parameter NB_OPCODE = 6
) (
    input wire [NB_OPERANDO - 1 : 0] switches,
    input wire [2:0] botones,
    input wire clock,
    input wire out_enable,
    input wire reset,
    output reg [NB_OUT - 1 : 0] leds     
);

  reg [NB_OPERANDO - 1 : 0] reg_a;
  reg [NB_OPERANDO - 1 : 0] reg_b;
  reg [NB_OPCODE - 1 : 0] reg_opcode;
  wire [NB_OUT - 1 : 0] out;


  always@(posedge clock) begin: sincronizacion_io
    if(reset==1'b1)
      begin
        reg_a <= {NB_OPERANDO {1'b0}};
        reg_b <= {NB_OPERANDO {1'b0}};
        reg_opcode <= {NB_OPCODE {1'b0}};
        leds <= {NB_OUT {1'b0}};
      end
    else if(botones[0]==1'b1)
      reg_a <= switches;
    else if(botones[1]==1'b1)
      reg_b <= switches;
    else if(botones[2]==1'b1)
      reg_opcode <= switches;
    else if(out_enable==1'b1)
      leds <= out;
  end


ALU my_alu(.dato_a(reg_a), .dato_b(reg_b), .opcode(reg_opcode), .out(out));

endmodule
