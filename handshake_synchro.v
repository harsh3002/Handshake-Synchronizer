
`timescale 1ns/1ns

module handshake_synchro(
output synchro_out,
output synchro_busy,
input pulse_in,
input clk_slow,
input clk_fast,
input reset);

reg dff_clk_fast;    		// Input data register;
reg dff_delay_out;   		// Delay flop for edge Detection
wire dual_flop_out_source; 	// Dual flop output slow clock
wire dual_flop_out_dest;		// Dual flop output fast clock
wire mux_out1;
wire mux_out2;

mux2_1  mux2(
.out(mux_out2),
.a(mux_out1),
.b(1'b1),
.sel(pulse_in));

mux2_1  mux1(
.out(mux_out1),
.a(mux_out2),
.b(1'b0),
.sel(dual_flop_out_dest));

dual_flop_synchro synchro1(
.sync_out(dual_flop_out_source),
.clk(clk_slow),
.reset(reset),
.data_in(dff_clk_fast));

dual_flop_synchro synchro2(
.sync_out(dual_flop_out_dest),
.clk(clk_fast),
.reset(reset),
.data_in(dual_flop_out_source));

always@(posedge clk_fast) begin
	if(reset) 
		dff_clk_fast<=0;
	else 
		dff_clk_fast<=mux_out2;
end

always@(posedge clk_slow) begin
	if(reset) 
		dff_delay_out<=0;
	else 
		dff_delay_out<=dual_flop_out_source;
end

assign synchro_out =  dual_flop_out_source & (!dff_delay_out);
assign synchro_busy =  dual_flop_out_dest | mux_out2;

endmodule 
