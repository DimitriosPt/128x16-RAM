`include "ram64x8.v"
module ram64x16(addrs, dataIn, _ce, _we, _oe, dataOut);
input[5:0] addrs;
input[15:0] dataIn;
input _ce, _we, _oe;
output [15:0] dataOut;
//first half of data goes to address a on u1
ram64x8 u1(addrs, dataIn[15:8], _ce, _we, _oe, dataOut[15:8]);
//second half of data goes to address a on u2
ram64x8 u2(addrs, dataIn[7:0], _ce, _we, _oe, dataOut[7:0]);
endmodule