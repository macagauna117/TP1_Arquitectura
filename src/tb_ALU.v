`timescale 1ns / 1ps
`define MEDIO_PERIODO 10
module tb_ALU # (
    parameter NB_OPERANDO = 8,
    parameter NB_OPCODE = 6,
    parameter NB_OUT = 8
    );
    
  // 8 instrucciones en total
  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR = 6'b100101;
  localparam XOR = 6'b100110;
  localparam SRA = 6'b000011;
  localparam SRL = 6'b000010;
  localparam NOR = 6'b100111;
  
  reg [NB_OPERANDO - 1:0] dato_a;
  reg [NB_OPERANDO - 1:0] dato_b;
  reg [NB_OPCODE - 1:0] opcode;
  wire [NB_OPERANDO - 1:0] out;
  reg [NB_OPERANDO - 1:0] expect;
  reg [NB_OPERANDO - 1:0] out1;
  reg clock;
  integer i;
    
  initial begin
    dato_a = {NB_OPERANDO {1'b0}};
    dato_b = {NB_OPERANDO {1'b0}};
    opcode = {NB_OPCODE {1'b0}};
    clock = 1'b0;
  end


  always begin
    #`MEDIO_PERIODO clock = ~clock;
  end
    
  always@(posedge clock) begin
    dato_a <= $random;
    dato_b <= $random;
    i <= ($random) % 8;
    case(i)
       0: opcode <= ADD;
       1: opcode <= SUB;
       2: opcode <= AND;
       3: opcode <= OR;
       4: opcode <= XOR;
       5: opcode <= NOR;
       6: opcode <= SRA;
       7: opcode <= SRL;
       default: opcode <= {NB_OPCODE {1'b0}};
    endcase
  end
    
  always@(posedge clock) begin: assertion
  
    case(opcode)
      ADD: expect <= dato_a + dato_b;
      SUB: expect <= dato_a - dato_b;
      AND: expect <= dato_a & dato_b;
      OR: expect <= dato_a | dato_b;
      XOR: expect <= dato_a ^ dato_b;
      NOR: expect <= ~(dato_a | dato_b);
      SRA: expect <= $signed (dato_a) >>> dato_b;
      SRL: expect <= dato_a >> dato_b;
      default: expect <= {NB_OUT {1'b0}};
    endcase
    out1 <= out;
    if(expect != out1) begin
      $display("Error en operacion %b en tiempo %d ns", opcode, $time);
    end
  end
   
 /* Instanciacion de la ALU */
  ALU#(
      .NB_OPERANDO(NB_OPERANDO),
      .NB_OPCODE(NB_OPCODE),
      .NB_OUT(NB_OUT)
      ) 
  my_alu (
      .dato_a(dato_a),
      .dato_b(dato_b), 
      .opcode(opcode), 
      .out(out)
  );

endmodule
