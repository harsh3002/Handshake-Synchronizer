
`timescale 1ns/1ns

module handshake_synchro_tb;

wire synchro_out_tb;
wire synchro_busy_tb;
reg pulse_in_tb;
reg clk_slow_tb;
reg clk_fast_tb;
reg reset_tb;

handshake_synchro dut(
.synchro_out(synchro_out_tb),
.synchro_busy(synchro_busy_tb),
.pulse_in(pulse_in_tb),
.clk_slow(clk_slow_tb),
.clk_fast(clk_fast_tb),
.reset(reset_tb));

initial begin
	    clk_slow_tb<=0;
	forever #20 clk_slow_tb<=~clk_slow_tb;
end

initial begin
	    clk_fast_tb<=0;
	forever #10 clk_fast_tb<=~clk_fast_tb;
end

initial begin
	    reset_tb<=1;
	#30 reset_tb<=0;
end

initial begin
	#50 pulse_in_tb<=1;   #10 pulse_in_tb<=0;
	#300 pulse_in_tb<=1;   #10 pulse_in_tb<=0;
	#300 pulse_in_tb<=1;   #10 pulse_in_tb<=0;
	#300 pulse_in_tb<=1;   #10 pulse_in_tb<=0;
	#300 pulse_in_tb<=1;   #10 pulse_in_tb<=0;

end
endmodule
