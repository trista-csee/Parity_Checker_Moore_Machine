module parity_checker_Moore (
    input clk, 
    input reset, 
    input x, 
    output parity // wire for dataflow modeling constructs to compute output
    //output reg parity  // reg for always block to compute output
);

parameter S0=0, S1=1;
reg current_state, next_state;

// always block to update current state
always @(posedge clk or posedge reset) begin // asynchronous reset
    if (reset)       
        current_state <= S0; 
    else      
        current_state <= next_state;
end

// The output block when it is simple, can be modeled using dataflow modeling constructs. 
assign parity = (current_state==S0) ? 1'b0: 1'b1;
/*
// always block to compute output
always @(current_state) begin
    case(current_state)        
        S0: parity = 0;         
        S1: parity = 1;      
    endcase  
end
*/

// always block to compute next state 
always @(current_state or x) begin
    next_state = S0;     
    
    case(current_state)        
        S0: if(x)
            next_state = S1;                         
        S1: if(!x)               
            next_state = S1;      
    endcase  
end

endmodule