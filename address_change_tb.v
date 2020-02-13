module address_change_tb ();

reg clk_tb;
reg [1:0] direction_tb;
wire start_tb;
wire [22:0] address_tb;

 address_change DUT(.clk(clk_tb), .direction(direction_tb), .start(start_tb), .address(address_tb));
initial begin
//clk is 0 
clk_tb = 0;
direction_tb = 2'b00;
forever begin  //make a clock go up and down every #1
clk_tb = 0;
#1;
clk_tb =1;
#1;
end
end

initial begin

direction_tb = 2'b00;
#10;
direction_tb = 2'b10;
#10;
direction_tb = 2'b11;
#10;
direction_tb = 2'b01;
#10;

end
endmodule