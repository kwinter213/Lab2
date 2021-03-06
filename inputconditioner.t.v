//------------------------------------------------------------------------
// Input Conditioner test bench
//------------------------------------------------------------------------
`timescale 1 ns / 1 ps
`include "inputconditioner.v"

module testConditioner();

    reg clk;
    reg pin;
    wire conditioned;
    wire rising;
    wire falling;
    
    inputconditioner dut(.clk(clk),
                 .noisysignal(pin),
             .conditioned(conditioned),
             .positiveedge(rising),
             .negativeedge(falling));


    // Generate clock (50MHz)
    initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock
    
    initial begin
      $dumpfile("inputconditioner.vcd");
      $dumpvars(0,dut);
    // Your Test Code
    // Be sure to test each of the three conditioner functions:
    // Synchronization, Debouncing, Edge Detection
    $display("Input     Time    Conditioned Signal      Clock       Posedge     NegEdge");
    pin = 0;
    #150
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd0, conditioned, clk, rising, falling);
      
    pin = 1;
    #110
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd110, conditioned, clk, rising, falling);

    #40
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd150, conditioned, clk, rising, falling);
    
    pin = 0;
    #10
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd160, conditioned, clk, rising, falling);
               
    pin = 1;
    #10
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd170, conditioned, clk, rising, falling);

    #13
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd200, conditioned, clk, rising, falling);

    pin = 0;
    #90
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd290, conditioned, clk, rising, falling);

    #2
    pin =  1;
    #100
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd392, conditioned, clk, rising, falling);

    #8
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd400, conditioned, clk, rising, falling);

    #10
    $display("%b        %d         %b                      %b           %b          %b", pin, 10'd410, conditioned, clk, rising, falling);
      
    #10000 
    $finish;
    end
endmodule
