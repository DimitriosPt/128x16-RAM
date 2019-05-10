module ram16x4(adrs, dataIn, _ce, _we, _oe, dataOut);
input [3:0] adrs;
input [3:0] dataIn;
input _ce, _we, _oe;
output [3:0] dataOut;
	
reg [0:15][3:0] memory;
assign dataOut = ~_ce & _we & ~_oe ? memory[adrs]: 4'hz;
always@(*)
begin
//if _chip is enabled, _write is enabled, _output is disabled
if(_ce == 0)
	if(_we ==0 && _oe==1)
		memory[adrs] = dataIn;
end
endmodule

