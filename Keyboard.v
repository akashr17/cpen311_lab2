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



// the states are encoded to have the pause and direction flags in the 2 lowest bits

always @(*) begin

	case(state)
	`idle: begin if((letters == `character_E)) begin  //same as pause when going forward  //if E then play forward
		next = `forward_play; end
		else if((letters == `character_B) ) begin  //if B then go to pause but backward
		next = `pause; end
		else next = `idle;end
		
	`forward_play: begin if((letters == `character_D) ) begin  //if d, go to idle, which is puase in a forward state
		next = `idle; end
		else if((letters == `character_B) ) begin  
		next = `backward_play; end //if B then play  backwards
		else begin
		next = `forward_play; end
		end

	`backward_play: begin if((letters == `character_F)) begin   //if F then play forwards
		next = `forward_play; end
		else if((letters == `character_D) ) begin  //if D then go to pause
		next = `pause; end
		else begin
		next = `backward_play; end
		end

	`pause: begin if((letters == `character_E)) begin  //if E then play backwards
		next = `backward_play; end
		else if((letters == `character_F))  //if F then go to idle/forward pause
		next = `idle;
		else begin
		next = state; end
		end

	default: begin 
		next = `idle; end
	endcase
end

endmodule