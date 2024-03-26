
`timescale 1ns/1ns

module mux2_1(
output out,
input a,
input b,
input sel);

assign out  =  ( a & !sel )  |  ( b & sel ) ;

endmodule 
