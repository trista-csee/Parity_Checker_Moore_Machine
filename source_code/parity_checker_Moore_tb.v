`timescale 1ns/1ps

module parity_checker_Moore_tb;

parameter period = 10; // 10ns = 100MHz

reg clk,reset,x;
wire parity;
                    
// Instantiate parity_checker_Moore
parity_checker_Moore parity_checker_Moore_inst(
    .clk(clk), 
    .reset(reset), 
    .x(x), 
    .parity(parity));

// generate a clock 
always begin
   # (period / 2) clk = ~clk;
end

initial begin
    clk = 0;
    reset = 1;
    x = 0;
     
    @(posedge clk);            
    reset = 0;
    @(posedge clk);  
    reset = 0;
    @(posedge clk);  
    @(posedge clk);    
    @(posedge clk);   
    x = 1;  // x rising , check fsm output 
    @(posedge clk);  
    @(posedge clk);    
    @(posedge clk);   
    x = 0;
    @(posedge clk);  
    @(posedge clk);    
    @(posedge clk);  

    #2;  // wait 2 ns
    x = 1;  // x rising , check fsm output 
    @(posedge clk);  
    @(posedge clk);    
    @(posedge clk); 

    #2; // wait 2ns
    x = 0;
    @(posedge clk);  
    @(posedge clk);    
    @(posedge clk); 
    
    $finish();
end 

endmodule