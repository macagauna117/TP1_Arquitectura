`timescale 1ns / 1ps
//////////////////
//Testbech general
//////////////////
module testbench_top();

  //Local parameters
  localparam        NB_OPERANDO = 8;
  localparam        NB_OPCODE   = 6;
  localparam        NB_OUT      = NB_OPERANDO;
  //Operaciones
  localparam        ADD = 6'b100_000    ;
  localparam        SUB = 6'b100_010    ;
  localparam        AND = 6'b100_100    ;
  localparam        OR  = 6'b100_101    ;
  localparam        XOR = 6'b100_110    ;
  localparam        SRA = 6'b000_011    ;
  localparam        SRL = 6'b000_010    ;
  localparam        NOR = 6'b100_111    ; 
  
  //Inputs 
  reg                  clk          ;
  reg                  reset        ;
  reg    [NB_OPERANDO-1:0] switch       ;
  reg                  boton_1      ;
  reg                  boton_2      ;
  reg                  boton_3      ;
  reg                  boton_4      ;
  
  //Outputs
  wire  [NB_OUT-1:0]   out ;
  

//Bloque initial
    initial begin
        //Reg´s initialization
        #0
        clk         =   1'b1                ;
        reset       =   1'b1                ;
        boton_1     =   1'b0                ;
        boton_2     =   1'b0                ;
        boton_3     =   1'b0                ;
        boton_4     =   1'b0                ;
        switch      =   {NB_OPERANDO-1{1'b0}}   ;
        
        #30
        reset   =   1'b0    ;
        
        #15
        switch  =   -8'd64  ;
        #15
        boton_1 =   1'b1    ;
        #60
        boton_1 =   1'b0    ;
        #15
        switch  =   8'd1    ;
        #30
        boton_2 =   1'b1    ;
        #60
        boton_2 =   1'b0    ;
        #15
        switch  =   ADD  ; 
        #30
        boton_3 =   1'b1    ;
        #60
        boton_3 =   1'b0    ;        
        #30
        boton_4 =   1'b1    ;
        #60
        boton_4 =   1'b0    ;
        
        #15
        switch  = SUB    ;
        #30
        boton_3 = 1'b1      ;
        #60
        boton_3 = 1'b0      ;        
        #30
        boton_4 = 1'b1      ;
        #60
        boton_4 = 1'b0      ;
        
        #1000
        $monitor("Todo joya");
        $finish;
    end
        
        always begin
        #10 clk <= ~clk;
        end
                
    top_alu
    #(
        .NB_OPERANDO            (NB_OPERANDO),
        .NB_OPCODE              (NB_OPCODE),
        .NB_OUT                 (NB_OPERANDO)
    )
    uut_top_alu
    (
        .i_clk              (clk)       ,                                      
        .i_reset            (reset)     ,
        .i_switch           (switch)    ,
        .i_boton_1          (boton_1)   ,
        .i_boton_2          (boton_2)   ,
        .i_boton_3          (boton_3)   ,
        .i_boton_4          (boton_4)   ,
        .out        (out)
    );
    
endmodule