`define character_B 8'h42 //back
`define character_D 8'h44 //pause
`define character_E 8'h45 //play
`define character_F 8'h46 //forward
`define character_lowercase_b 8'h62
`define character_lowercase_d 8'h64
`define character_lowercase_e 8'h65
`define character_lowercase_f 8'h66

module keyboard_fsm_tb();

 reg  clk_tb;
  reg [7:0] letters_tb;
  wire [1:0] direction_tb;

//instantiating module we want to test
keyboard_fsm DUT(.clk(clk_tb),.letters(letters_tb),.direction(direction_tb));
 

initial begin
//clk is 0 
clk_tb = 0;

forever begin  //make a clock go up and down every #1
clk_tb = 0;
#1;
clk_tb =1;
#1;
end
end

initial begin
letters_tb = `character_E;  //should be a wave of period 10, up for 5 down for 5
#4;
letters_tb = `character_D; //should be a wave of period 4, up for 2 down for 2
#4;
letters_tb = `character_F; //should be a wave of period 20, up for 10 down for 10
#4;
letters_tb = `character_E; //should be a wave of period 20, up for 10 down for 10
#4;
letters_tb = `character_B; //should be a wave of period 20, up for 10 down for 10
#4;
letters_tb = `character_D; //should be a wave of period 20, up for 10 down for 10
#4;
letters_tb = `character_E; //should be a wave of period 20, up for 10 down for 10
#4;


end
endmodule
