`timescale 1ns / 10ps

module ALU #(
  parameter NB_OPERANDO = 8,
  parameter NB_OUT = NB_OPERANDO,
  parameter NB_OPCODE = 6
) (
  input wire [NB_OPERANDO - 1 : 0] dato_a,
  input wire [NB_OPERANDO - 1 : 0] dato_b,
  input wire [NB_OPCODE - 1 : 0] opcode,
  output wire [NB_OUT - 1 : 0] out
);

  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR = 6'b100101;
  localparam XOR = 6'b100110;
  localparam SRA = 6'b000011;
  localparam SRL = 6'b000010;
  localparam NOR = 6'b100111;

  reg [NB_OUT-1:0] result;


  always @(*) begin : ALU_operation
    case (opcode)
      ADD: result = dato_a + dato_b;
      SUB: result = dato_a - dato_b;
      AND: result = dato_a & dato_b;
      OR:  result = dato_a | dato_b;
      SRA: result = dato_a >>> dato_b;
      SRL: result = dato_a >> dato_b;
      XOR: result = dato_a ^ dato_b;
      NOR: result = ~(dato_a | dato_b);
      default: result = {NB_OUT{1'b0}};
    endcase
  end

  assign out =  result[NB_OUT - 1:0];

endmodule
