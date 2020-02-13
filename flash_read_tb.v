

module flash_read_tb();

reg clk_tb, start_tb, wait_request_tb, data_valid_tb;
wire read_tb, finish_tb;


//instantiating module we want to test
//keyboard_fsm DUT(.clk(clk_tb),.letters(letters_tb),.direction(direction_tb));
 flash_read DUT(.clk(clk_tb), .start(start_tb), .wait_request(wait_request_tb), .data_valid(data_valid_tb), .read(read_tb), .finish(finish_tb));

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
start_tb=0;
wait_request_tb = 0; data_valid_tb=0;
#4;
start_tb =1;
#12;
wait_request_tb=1;
#12;
wait_request_tb=0; data_valid_tb =1;
#12;
wait_request_tb=1;
#12;
data_valid_tb =1;
#12;
start_tb =0;
#20;

end
endmodule
