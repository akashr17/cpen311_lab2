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


// assign values of finish and read using the bits of states
assign finish = state[4];
assign read = state[3];


always @(*) begin

	case(state)  //depending on state, check the following

	`Initial: begin if(!start)   //**** this start is actually a pause, so if not pause move onto next state
		next = `Wait;
		else next = `Initial; end

	`Wait: begin if(!wait_request)  //if there isnt a wait request, movee to read
		next = `Read;
		else next = `Wait; end

	`Read: next = `Valid;   //this state encodes the value of read going to 1, move to valid
		

	`Valid: begin if(!data_valid)   //if data valid, stay till not valid
		next = `Finish;
		else next = `Valid; end

	`Finish: next = `Initial;  //restart, also exerts finish flag
		

	default: next = `Initial;

endcase
end

always @(posedge clk) begin
state<=next;   //every posedge, update the state
end

endmodule 