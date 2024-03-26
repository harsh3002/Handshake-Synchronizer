
`timescale 1ns/1ns

module dual_flop_synchro(
output  sync_out,
input reset,
input clk,
input data_in);


reg D_ff1,D_ff2;

always@(posedge clk) begin
	if(reset) begin
		D_ff1<=0;
		D_ff2<=0;
	end
	else begin
		D_ff1<=data_in;
		D_ff2<=D_ff1;
	end
end

assign sync_out=D_ff2;
endmodule 


