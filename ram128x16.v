`include "ram64x16.v"
module ram128x16(adrs, dataIn, _ce, _we, _oe, dataOut);
	input [6:0] adrs;
	input [15:0] dataIn;
	input _ce, _we,_oe;
	output [15:0] dataOut;

	reg[1:0] _cee;
	ram64x16 u1(adrs[5:0], dataIn, _cee[0], _we, _oe, dataOut);
	ram64x16 u2(adrs[5:0], dataIn, _cee[1], _we, _oe, dataOut);
	//2 to 1 decode
	//based on the first bit of address
	//it decides which chip to enable
	always@(*)
	begin
		if(_ce == 0)
			case(adrs[6])
			0: _cee = 2'b10; //turn on 1st chip because active low
	
			1: _cee = 2'b01;

			default: _cee = 4'hf;
			endcase
		else _cee = 4'hf;	
	end
endmodule