`include "ram16x8.v"
module ram64x8(adrs, dataIn, _ce, _we, _oe, dataOut);
	input [5:0] adrs;
	input [7:0] dataIn;
	input _ce, _we,_oe;
	output [7:0] dataOut;

	reg[3:0] _cee;
	ram16x8 u1(adrs[3:0], dataIn, _cee[0], _we, _oe, dataOut);
	ram16x8 u2(adrs[3:0], dataIn, _cee[1], _we, _oe, dataOut);
	ram16x8 u3(adrs[3:0], dataIn, _cee[2], _we, _oe, dataOut);
	ram16x8 u4(adrs[3:0], dataIn, _cee[3], _we, _oe, dataOut);

	//2 to 4 decode
	//based on the first 2 bits of address
	//it decides which chip to enable
	always@(*)
	begin
		if(_ce == 0)
			case(adrs[5:4])
			0: _cee = 4'b1110; //turn on 1st chip because active low
	
			1: _cee = 4'b1101;

			2: _cee = 4'b1011;

			3: _cee = 4'b0111;

			default: _cee = 4'hf;
			endcase
		else _cee = 4'hf;	
	end
endmodule