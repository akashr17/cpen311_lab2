
module address_change (clk, direction, hold, address);
input clk, direction, hold;

output reg [22:0] address;
reg [22:0] last_address = 23'h7FFFF;

reg [22:0]  next_address;

always @(posedge clk) begin
address <= next_address;
end

always @(*) begin
	
		if(hold)   //if holding address from the output module, keep address same
		next_address = address;

		else if(direction) begin  //if forward direction
		if(address<=last_address)
		next_address = address+1'b1;  //add 1 if its less than max
		else 
		next_address = 23'b0;  //if max, then go to 0
		end

		else if(!direction) begin  //if backwards
		if(address>23'b0)
		next_address = address-1'b1;  //sub 1 if greater than 0
		else 
		next_address = last_address;  //if 0 go to max
		end

		else next_address = 23'b0;  //else default, go to 0
	
end
endmodule