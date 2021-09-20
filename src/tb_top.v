//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2021 03:22:19 PM
// Design Name: 
// Module Name: tb_top
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


`timescale 1ns / 1ps
//////////////////
//Testbech general
//////////////////
module testbench_top # (
  parameter        NB_OPERANDO = 8,
  parameter        NB_OPCODE   = 6,
  parameter        NB_OUT      = NB_OPERANDO
)
(
    output reg clk,
    output reg reset,
    output reg    [NB_OPERANDO-1:0] switch,
    output reg boton_1,
    output reg boton_2,
    output reg boton_3,
    output reg boton_4
);

  //Local parameters

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
  


  //Flags
  reg                   test_start  ;
  reg                   fail        ;

  //Outputs
  wire  [NB_OUT-1:0]   out ;
  

//Bloque initial
    initial begin
        //Reg´s initialization
        #0
        test_start  =   1'b0                ;   
        clk         =   1'b1                ;
        reset       =   1'b1                ;
        fail        =   1'b0                ;
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
