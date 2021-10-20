`timescale 1ns / 1ps
`define MEDIO_PERIODO 10

module tb_top;
  parameter NB_OPERANDO = 8;
  parameter NB_OUT = 8;
  parameter NB_OPCODE = 6;
  reg [NB_OPERANDO - 1 : 0] sw;
  reg [2:0] btns;
  reg clock;
  reg out_enable;
  reg reset;
  wire [NB_OUT - 1 : 0] leds;
  integer state;
  
  reg [NB_OPERANDO - 1:0] dato_a;
  reg [NB_OPERANDO - 1:0] dato_b;
  reg [NB_OPCODE - 1:0] opcode;
  reg [NB_OUT - 1:0] expected;


  // 8 instrucciones en total
  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR = 6'b100101;
  localparam XOR = 6'b100110;
  localparam SRA = 6'b000011;
  localparam SRL = 6'b000010;
  localparam NOR = 6'b100111;
  
  localparam LOAD_A = 6'b000001;
  localparam LOAD_B = 6'b000010;
  localparam LOAD_OPCODE = 6'b000100;
  localparam UPDATE_RES = 6'b001000;

  top_ALU
  top
  (
    .switches(sw),
    .botones(btns),
    .clock(clock), 
    .out_enable(out_enable),
    .reset(reset), 
    .leds(leds)
  );
  
  
  initial 
  begin
    clock = 1'b0;
    reset = 1'b1;
    out_enable = 1'b0;
    dato_a = {NB_OPERANDO {1'b0}};
    dato_b = {NB_OPERANDO {1'b0}};
    expected = {NB_OUT {1'b0}};
    opcode = {NB_OPCODE {1'b0}};
    repeat(2)@(posedge clock);
    reset = 1'b0;
    state = LOAD_A;
  end

  initial $monitor("switch = %b, botones = %b, leds = %b", sw, btns, leds, $time);

  always begin
    #`MEDIO_PERIODO clock = ~clock;
  end

  always@(posedge clock) 
  begin
    if(state == LOAD_A) 
    begin
      out_enable = 1'b0;
      sw = $random;
      dato_a = sw;
      btns = 3'b001;
      state = LOAD_B;
    end
    else if(state == LOAD_B) 
    begin
      sw =  $random;
      dato_b = sw;
      btns = 3'b010;
      state = LOAD_OPCODE;
    end
    else if(state == LOAD_OPCODE) 
    begin
      case(($random) % 8)
        0: sw = ADD;
        1: sw = SUB;
        2: sw = AND;
        3: sw = OR;
        4: sw = XOR;
        5: sw = SRA;
        6: sw = SRL;
        7: sw = NOR;
        default: sw = {6 {1'b0}};
      endcase
      opcode = sw;
      btns = 3'b100;
      state = UPDATE_RES;
    end
    else if(state == UPDATE_RES) 
    begin
      btns = 3'b000;
      out_enable = 1'b1;
      state = LOAD_A;
    end
  end
    
  always@(posedge clock) begin: assertion_operation
    if(out_enable == 1'b1) 
    begin   
      case(opcode)
        ADD: expected <= dato_a + dato_b;
        SUB: expected <= dato_a - dato_b;
        AND: expected <= dato_a & dato_b;
        OR: expected <= dato_a | dato_b;
        XOR: expected <= dato_a ^ dato_b;
        NOR: expected <= ~(dato_a | dato_b);
        SRA: expected <= $signed(dato_a) >>> dato_b;
        SRL: expected <= dato_a >> dato_b;
        default: expected <= {NB_OUT {1'b0}};
      endcase
      if(expected != leds) 
      begin
        $display("Error en operacion %b en tiempo %d ns", opcode, $time);
        $stop;
      end
    end
  end
endmodule
