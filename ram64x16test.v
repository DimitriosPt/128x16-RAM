`include "ram64x16.v"
module ram64x8test();
    reg [5:0] adrs;
    reg [15:0] content;
    reg _ce, _we, _oe;
    wire [15:0] dataIn, dataOut;
    assign dataIn = ~_ce & ~_we & _oe ? content : 16'hzz;
    ram64x16 u1(adrs, dataIn, _ce, _we, _oe, dataOut);
    initial begin
      $monitor("%4d: adrs = %h  _ce = %b _we = %b _oe = %b dataIn = %h dataOut = %h", $time, adrs, _ce, _we, _oe, dataIn, dataOut);
      //write
      adrs = 6'b000000; content = 16'hFFFF;
      _ce = 0; _we = 0; _oe = 1;
      #10 _ce = 1; _we = 0; _oe = 1;

      #50 adrs = 6'b010000; content = 16'hEEEE;
      _ce = 0; _we = 0; _oe = 1;
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #50 adrs = 6'b100000; content = 16'hDDDD;
      _ce = 0; _we = 0; _oe = 1;
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #50 adrs = 6'b110000; content = 16'hCCCC;
      _ce = 0; _we = 0; _oe = 1;
      #10
      _ce = 1; _we = 1; _oe = 1;
      
      //read
      #40 adrs = 6'b000000;
      _ce = 0; _we = 1; _oe = 0;
      #10 _ce = 1; _we = 1; _oe = 1;

      #50 adrs = 6'b010000;
      _ce = 0; _we = 1; _oe = 0;
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #50 adrs = 6'b100000;
      _ce = 0; _we = 1; _oe = 0;
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #50 adrs = 6'b110000;
      _ce = 0; _we = 1; _oe = 0;
      #10
      _ce = 1; _we = 1; _oe = 1;
      #30
      $finish;
    end
endmodule