`timescale 1 ns / 1 ps
`include "spimemory.v"

module spiTest();
  reg clk;
  reg sclk_pin;
  reg cs_pin;
  wire miso_pin;
  reg mosi_pin;
  wire [3:0] leds;
  wire q0;
  
  integer counter; // used in for loops
  
  initial clk=0;
  always #10 clk= !clk;    // 50MHz Clock

  
  spiMemory dut(clk, sclk_pin, cs_pin, miso_pin, mosi_pin, leds, q0);
  initial begin
    $dumpfile("spimemory.vcd");
    $dumpvars(0, clk, sclk_pin, cs_pin, miso_pin, mosi_pin, q0);
    
    // initial output
    cs_pin <= 1;
    mosi_pin <= 0;
    sclk_pin <= 0; #100
    sclk_pin <= 1; #100
    
    $display("sclk_pin | cs_pin | mosi_pin | miso_pin |");
    $display("   %b     | %b      | %b        |   %b     |%b", sclk_pin, cs_pin, mosi_pin, miso_pin, q0);
    
    // write operation
    
    // give address 1 and write bits
    cs_pin = 0;
    for (counter = 0; counter < 16; counter = counter + 1) begin 
      if (counter == 6 || counter > 7) begin //write 1's to address
        mosi_pin <= 1;
      end
      else begin
        mosi_pin <= 0;
      end
      sclk_pin <= 0; #100
      sclk_pin <= 1; #100;
    end
    $display("Wrote 11111111 to address 1");
		$display("   %b     | %b      | %b        |   %b     |%b", sclk_pin, cs_pin, mosi_pin, miso_pin, q0);
    cs_pin <= 1;
    sclk_pin <= 0; #100
    sclk_pin <= 1; #100
    //
    
    
    
    
    //read operation
    cs_pin <= 0;
    for (counter = 0; counter < 8; counter = counter + 1) begin 
      if (counter == 0) begin //resetting mosi_pin to read from address 
        mosi_pin <= 0;
      end
      else if(counter==6) begin
        mosi_pin<=1;
      end
      sclk_pin <= 0; #100
      sclk_pin <= 1; #100;
    end
    // now output the bits that were read from address 1
    $display("Reading data at address 1");
    for (counter = 0; counter < 8; counter = counter + 1) begin
      sclk_pin <= 0; #100
      sclk_pin <= 1; #100
      $display("   %b     | %b      | %b        |   %b     |%b", sclk_pin, cs_pin, mosi_pin, miso_pin, q0);
    end
    cs_pin <= 1;
    sclk_pin <= 0; #100
    sclk_pin <= 1; #100

    
    // write operation in same address
    
    //read operation
    sclk_pin <= 0; #100
    sclk_pin <= 1; #100

    #100000 
    $finish;
   
  end
endmodule