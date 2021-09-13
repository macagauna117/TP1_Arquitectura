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

  always @(*) begin : ALU_operation
    case (opcode)
      ADD: out = dato_a + dato_b;

  end

endmodule
