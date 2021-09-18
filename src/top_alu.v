module top_alu
#(
    //¨PARAMETERS
    parameter           NB_OPERANDO = 8,
    parameter           NB_OPCODE   = 6
  )
 (  
    //INPUTS 
    input   wire                  i_clk       ,
    input   wire                  i_reset     ,
    input   wire    [NB_OPERANDO-1:0] i_switch    ,
    input   wire                  i_boton_1   ,
    input   wire                  i_boton_2   ,
    input   wire                  i_boton_3   ,
    input   wire                  i_boton_4   ,
    
    //OUTPUT
    output  wire    [NB_OUT-1:0] out
     
  );
  
  //Localparam
  
  //Local regs & wires
  reg   [NB_OPERANDO-1:0]   a          ;
  reg   [NB_OPERANDO-1:0]   b          ;
  reg   [NB_OPCODE  -1:0]   opcode     ;
 
  wire  [NB_OUT-1:0]   result       ;
  reg   [NB_OUT-1:0]   reg_resultado   ;

  
  always @(posedge i_clk) begin
    if(i_reset) begin
        a  <= {NB_OPERANDO{1'b0}};
        b  <= {NB_OPERANDO{1'b0}};
        opcode <= {NB_OPCODE{1'b0}};
        reg_resultado <= {NB_OUT{1'b0}};
    end
    else begin
        if      (i_boton_1)    a        <= i_switch             ;
        else if (i_boton_2)    b        <= i_switch             ;
        else if (i_boton_3)    opcode       <= i_switch[NB_OPCODE-1:0]  ;
        else if (i_boton_4)    reg_resultado <= result            ;
    end  
  end
  
  //Output assign
  assign out = reg_resultado[NB_OUT-1:0]   ;
  
  //Module instance
  ALU instance_ALU(.dato_a(a), .dato_b(b), .out(out), .opcode(opcode));

endmodule