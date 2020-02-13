`define Initial 5'b00_000
`define Wait 5'b00_001
`define Read 5'b01_010
`define Valid 5'b00_011
`define Finish 5'b10_100

module flash_read (clk, wait_request, data_valid, start,read, finish);
input clk, wait_request, data_valid, start;
output read, finish;

reg [4:0] state;
reg [4:0] next;

assign finish = state[4];
assign read = state[3];


always @(*) begin

	case(state)
	`Initial: if(!start) 
		next = `Wait;
		else next = `Initial;
	`Wait: if(!wait_request)
		next = `Read;
		else next = `Wait;
	`Read: next = `Valid;
		

	`Valid: if(!data_valid)
		next = `Finish;
		else next = `Valid;
	`Finish: next = `Initial;
		

	default: next = `Initial;

endcase
end

always @(posedge clk) begin
state<=next;
end

endmodule 