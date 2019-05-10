`include "ram16x4.v"
module ram16x4test();
	integer i;
    reg [3:0] adrs;
    reg [3:0] content;
    reg _ce, _we, _oe;
    wire [3:0] dataIn, dataOut;
    assign dataIn = ~_ce & ~_we & _oe ? content : 4'hz;
    ram16x4 u1(adrs, dataIn, _ce, _we, _oe, dataOut);
    initial begin
      $monitor("%4d: adrs = %h  dataIn = %h dataOut = %h", $time, adrs, dataIn, dataOut);
      //write
	    content = 4'h0;

		for(i = 4'b0000; i<=4'b1111; i= i+1) 
		begin //loop that writes 0000 to all cells		
			#1 adrs=i; _ce = 0; _we = 0; _oe = 1;
		end
		#10 _ce=1; _we =1; _oe=1;
		
		$display("now reading");
		for(i = 4'b0000; i<=4'b1111; i= i+1) 
		begin //loop that reads all cells
			#1 adrs=i; _ce = 0; _we = 1; _oe = 0;
		end
	  
      $finish;
    end
endmodule