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



always @(posedge clk) begin   //every posedge, update states and audio_output
state <= next; 
audio_out<=audio_select; end


always @(*) begin

	case (state)

	`check: begin audio_select = audio_out; hold=1;    //check to see if we are in playing or pause state, keep hold1, address doesnt change
		if(!pause) next = `reading;
		else next = `check;
		end
	

	`reading: begin audio_select = audio_out; hold=1;   //audio output stays same, if the read flash is finished then move on
		if(finish) next = `timing;
		else next = `reading;
		end

	`timing: begin audio_select = audio_out; hold=1;  //audio still same, if we get posedge of 22hz clk, then move on
		if(clk_2) next = `output_lower;
		else next = `timing;
		end

	`output_lower: begin next = `wait_1; hold=1;         //depending on direction, either put lower bits or upper, keep holding address
		if(direction) audio_select = audio_data[15:8];
		else audio_select = audio_data[31:24];
		end

	`wait_1: begin next = `timing_2; hold=1;    //move onto next state to allow output
		audio_select = audio_out; 
		end

	`timing_2: begin audio_select = audio_out; hold=1;   //check for next posedge of 22hz
		if(clk_2) next = `output_upper;
		else next = `timing_2;
		end

 	`output_upper: begin next = `wait_2; hold=1;   //put the other side bits into output
		if(direction) audio_select = audio_data[31:24];	
		else audio_select = audio_data[15:8];
		end
 
	`wait_2: begin next = `check; hold=0;   //take hold off, so address can inc/dec
		audio_select = audio_out; 
		end
	


	default: begin next = `check;
		audio_select = 8'b0; 
		hold=1;
		end
	
	endcase 
end




endmodule 