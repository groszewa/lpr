// 
// arm_chip.v
// 
// David Van Campenhout
// 
// pads
// 

`define slim 1
`define pitch 		"4MA"
`define powertype 	"REGULAR"
`define outdrive 	"4MA"
`define pull_type 	"None"
`define schmitt		0
`define level_shifting 	0

module arm_chip( gnd_pad1, vdd_pad1, gnd_pad2, vdd_pad2, 
		gnd_pad3, vdd_pad3, gnd_pad4, vdd_pad4, 
		clear_pad, phi1_pad, phi2_pad, 
 		test_pad, scanin_pad, scanout_pad, 
		dataBus_pad, addressBus_pad,
		mem_word_byte_pad, mem_write_read_pad, mem_req_bar_pad,
		mode_bar_pad
);

input 		gnd_pad1;
input		vdd_pad1;
input 		gnd_pad2;
input		vdd_pad2;
input 		gnd_pad3;
input		vdd_pad3;
input 		gnd_pad4;
input		vdd_pad4;
input		clear_pad;
input		phi1_pad;
input		phi2_pad;
input		test_pad;
input		scanin_pad;

inout	[31:0]	dataBus_pad;

output	[25:0] 	addressBus_pad;

output	[1:0]	mode_bar_pad;
output		mem_word_byte_pad;
output		mem_write_read_pad;
output		mem_req_bar_pad;
output		scanout_pad;

wire		clear;
wire		phi1;
wire		phi2;
wire 		scanin;
wire	[25:0]	addressBus;
wire	[31:0]	dataBus;

wire	[1:0]	mode_bar;
wire		mem_write_read;
wire		mem_word_bye;
wire		mem_req_bar;
wire		scanout;
wire		en_buses_bar;

supply1 	vdd, Vdd, VDD;
supply0 	vss, Vss, VSS, gnd, Gnd, GND;

padout_tri #( 6, 11, `slim, `pitch)
	outpad_ab5_0 ( .EN( en_buses_bar), .IN0( addressBus[5:0]), 
			.PADPIN( addressBus_pad[5:0]));
padvdd #(12, `slim, `powertype, `pitch)
	pwrpad2 (vdd_pad1);
padgnd #(13, `slim, `powertype, `pitch)
	pwrpad1 (gnd_pad1);

padout_tri #( 14, 20, `slim, `pitch)
	outpad_ab12_6 ( .EN( en_buses_bar), .IN0( addressBus[12:6]), 
			.PADPIN( addressBus_pad[12:6]));
padout_tri #( 26, 38, `slim, `pitch)
	outpad_ab25_13 ( .EN( en_buses_bar), .IN0( addressBus[25:13]), 
			.PADPIN( addressBus_pad[25:13]));

padvdd #(39, `slim, `powertype, `pitch)
	pwrpad4 (vdd_pad2);
padgnd #(40, `slim, `powertype, `pitch)
	pwrpad3 (gnd_pad2);

padbi #( 41, 50, `slim, 
	`outdrive, `level_shifting, `schmitt, `pull_type )
	bipad_db_9_0 ( .EN( en_buses_bar), .DIR( memoryRead), 
		.BISIG( dataBus[9:0]) , .PADPIN( dataBus_pad[9:0]));

padbi #( 56, 61, `slim, 
	`outdrive, `level_shifting, `schmitt, `pull_type )
	bipad_db_15_10 ( .EN( en_buses_bar), .DIR( memoryRead), 
		.BISIG( dataBus[15:10]) , .PADPIN( dataBus_pad[15:10]));

padvdd #(62, `slim, `powertype, `pitch)
	pwrpad6 (vdd_pad3);
padgnd #(63, `slim, `powertype, `pitch)
	pwrpad5 (gnd_pad3);

padbi #( 64, 70, `slim, 
	`outdrive, `level_shifting, `schmitt, `pull_type )
	bipad_db_22_16 ( .EN( en_buses_bar), .DIR( memoryRead), 
		.BISIG( dataBus[22:16]) , .PADPIN( dataBus_pad[22:16]));

padbi #( 76, 84, `slim, 
	`outdrive, `level_shifting, `schmitt, `pull_type )
	bipad_db_31_23 ( .EN( en_buses_bar), .DIR( memoryRead), 
		.BISIG( dataBus[31:23]) , .PADPIN( dataBus_pad[31:23]));

padvdd #(85, `slim, `powertype, `pitch)
	pwrpad8 (vdd_pad4);
padgnd #(86, `slim, `powertype, `pitch)
	pwrpad7 (gnd_pad4);

padin_unbuf #( 87, 87, `slim, `pitch)
	inpad1 (phi2_pad, phi2);
padin_unbuf #( 88, 88, `slim, `pitch)
	inpad2 (phi1_pad , phi1);

padin_unbuf #( 89, 89, `slim, `pitch)
	inpad3 (scanin_pad, scanin);
padin_unbuf #( 90, 90, `slim, `pitch)
	inpad4 (test_pad, test);
padin_unbuf #( 91, 91, `slim, `pitch)
	inpad5 (clear_pad, clear);
padout #( 92, 92, `slim, `pitch)
	outpad1 ( mem_write_read, mem_write_read_pad);
padout #( 93, 93, `slim, `pitch)
	outpad2 ( mem_req_bar, mem_req_bar_pad);
padout #( 94, 94, `slim, `pitch)
	outpad3 ( mem_word_byte, mem_word_byte_pad);
padout #( 95, 95, `slim, `pitch)
	outpad4 ( scanout, scanout_pad);
padout #( 96, 96, `slim, `pitch)
	outpad5 ( mode_bar, mode_bar_pad);


arm ARM( .phi1( phi1),  
	.phi2( phi2), 
	.clear( clear), 
	.scanin( scanin), 
	.test( test), 
	.scanout( scanout),
	.dataBus( dataBus), 
	.addressBus( addressBus), 
	.en_buses_bar( en_buses_bar),
	.memoryRead( memoryRead),
//	.memoryWrite( memoryWrite),
	.mem_word_byte( mem_word_byte),
	.mem_req_bar( mem_req_bar), 
	.mem_write_read( mem_write_read), 
	.mode_bar ( mode_bar )
);

endmodule  


