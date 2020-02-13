`define check 3'b000
`define reading 3'b001
`define timing 3'b010
`define output_lower 3'b011 
`define wait_1 3'b100
`define timing_2 3'b101
`define output_upper 3'b110
`define wait_2 3'b111

module audio_out(clk, clk_2, finish, direction, pause, hold, audio_data, audio_out);
input clk, clk_2, finish;
input direction, pause;

input [31:0] audio_data;
output reg [7:0] audio_out;
output reg hold;

reg [7:0] audio_select;
reg [3:0] state, next;



always @(posedge clk) begin
state <= next; 
audio_out<=audio_select; end


always @(*) begin

case (state)

`check: begin audio_select = audio_out; hold=1;
	if(!pause) next = `reading;
	else next = `check;
	end
	

`reading: begin audio_select = audio_out; hold=1;
	if(finish) next = `timing;
	  else next = `reading;
	 end

`timing: begin audio_select = audio_out; hold=1;
	if(clk_2) next = `output_lower;
	else next = `timing;
	end

`output_lower: begin next = `wait_1; hold=1;
	if(direction) audio_select = audio_data[15:8];
	else audio_select = audio_data[31:24];
	end

`wait_1: begin next = `timing_2; hold=1;
	audio_select = audio_out; 
	end

`timing_2: begin audio_select = audio_out; hold=1;
	if(clk_2) next = `output_upper;
	else next = `timing_2;
	end

`output_upper: begin next = `wait_2; hold=1;
	if(direction) audio_select = audio_data[31:24];	
	else audio_select = audio_data[15:8];
	end

`wait_2: begin next = `check; hold=0;
	audio_select = audio_out; 
	end



default: begin next = `check;
	audio_select = 8'b0; 
	hold=1;
	 end
	
endcase 
end




endmodule 