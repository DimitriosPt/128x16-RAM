`include "ram16x4.v"
module ram16x8(addrs, dataIn, _ce, _we, _oe, dataOut);
input[3:0] addrs;
input[7:0] dataIn;
input _ce, _we, _oe;
output [7:0] dataOut;
//first half of data goes to address a on u1
ram16x4 u1(addrs, dataIn[7:4], _ce, _we, _oe, dataOut[7:4]);
//second half of data goes to address a on u2
ram16x4 u2(addrs, dataIn[3:0], _ce, _we, _oe, dataOut[3:0]);
endmodule