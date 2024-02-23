module tb_slower_clk;
    reg clk = 1'b0;
    wire sclk;
    slower_2m_clock #(.N(2),.M(3)) m1(clk,sclk);   
    
    always #50 clk=~clk;

    initial begin
        #1000;
        $stop;
    end
    

endmodule