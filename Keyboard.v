`define character_B 8'h42 //back
`define character_D 8'h44 //pause
`define character_E 8'h45 //play
`define character_F 8'h46 //forward
`define character_lowercase_b 8'h62
`define character_lowercase_d 8'h64
`define character_lowercase_e 8'h65
`define character_lowercase_f 8'h66

`define idle 4'b00_11
`define forward_play 4'b01_01
`define backward_play 4'b10_00
`define pause 4'b11_10

module keyboard_fsm(clk, letters, direction, pause);

input clk;
input [7:0] letters;
output  direction ;
output  pause ;

// reg[1:0] next_direction;
reg [3:0]state;
reg [3:0]next;

assign  direction = state[0];
assign pause = state[1];

always @(posedge clk) begin
state<=next;

end

//always @(*) begin
//direction <= next_direction;
//end





always @(*) begin

	case(state)
	`idle: begin 
		if((letters == `character_E)) begin
		next = `forward_play;
		end
	
		else if((letters == `character_B) ) begin
		next = `pause;
		end
		
		else 
		next = `idle;
		end
		

	`forward_play: begin
		if((letters == `character_D) ) begin
		next = `idle;
		end
	
		else if((letters == `character_B) ) begin
		next = `backward_play;
		end

		else begin
		next = `forward_play;
		end
		end

	`backward_play: begin
		if((letters == `character_F)) begin
		next = `forward_play;
		end
	
		else if((letters == `character_D) ) begin
		next = `pause;
		end

		else begin
		next = `backward_play;
		end
		end

	`pause: begin

		if((letters == `character_E)) begin
		next = `backward_play;
		end
	
		else if((letters == `character_F))
		next = `idle;
		
		
		else begin
		next = state;
		end
		end


	default: begin 
		next = `idle;
		end
	endcase
end

endmodule