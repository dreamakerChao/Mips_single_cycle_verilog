module slower_2m_clock   
#(parameter N=3, M=5)    // M <= 2^N-1
(
    input wire clk,
    output wire slower_clk
);

reg [N-1:0] r_reg=0;
reg [N-1:0] r_next=0;
reg clock=0;
reg clock_next=0;

//register
always @(posedge clk)
        begin
            r_reg <= r_next;
            clock <= clock_next;  
        end

// next-state logic
always @*
    if (r_reg == M-1)
        begin
            r_next = 0;
            clock_next = ~clock;
        end
    else
        begin
            r_next = r_reg + 1;
            clock_next = clock;
        end
    
// output logic
assign slower_clk = clock;
endmodule

