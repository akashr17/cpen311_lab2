
module address_change (clk, direction, hold, address);
input clk, direction, hold;

output reg [22:0] address;
reg [22:0] last_address = 23'h7FFFF;

reg [22:0]  next_address;

always @(posedge clk) begin
address <= next_address;
end

always @(*) begin
	
		if(hold)
			next_address = address;

		else if(direction) begin

		if(address<=last_address)
		next_address = address+1'b1;
		else 
		next_address = 23'b0;
		end

		else if(!direction) begin
		if(address>23'b0)
		next_address = address-1'b1;
		else 
		next_address = last_address;
		end

		else next_address = 23'b0;
	
end
endmodule