`include "ram64x8.v"
module ram64x8test();
	integer f;
    reg [5:0] adrs;
    reg [7:0] content;
    reg _ce, _we, _oe;
    wire [7:0] dataIn, dataOut;
    assign dataIn = ~_ce & ~_we & _oe ? content : 8'hz;
    ram64x8 u1(adrs, dataIn, _ce, _we, _oe, dataOut);
    initial begin
      f = $fopen("64x8test.txt","w");
	  $fwrite(f,"Time:	Address in Hex| Address in decimal|Data in Hex|Data in Decimal|DataOut in Hex|DataOut in Decimal\n");
      //write
     
	 #5 _ce = 0; _we = 0; _oe = 1;
	  #1 content = 8'hFF;
	  #1 adrs = 6'b000000; 
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
      #10 _ce = 1; _we = 0; _oe = 1;
		
      
      #5 _ce = 0; _we = 0; _oe = 1;
	  #1 adrs = 6'b010000; 
	  #1 content = 8'hEE;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #5 _ce = 0; _we = 0; _oe = 1;
	  #1 adrs = 6'b100000; 
	  #1 content = 8'hDD;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
      #10 _ce = 1; _we = 1; _oe = 1;
      
      #5 _ce = 0; _we = 0; _oe = 1;
	  #1 adrs = 6'b110000; 
	  #1 content = 8'hCC;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
      #10 _ce = 1; _we = 1; _oe = 1;
      
      //read 
      #5 _ce = 0; _we = 1; _oe = 0;
	  #5 adrs = 6'b000000;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
	  #10 _ce = 1; _we = 1; _oe = 1;

      #5 _ce = 0; _we = 1; _oe = 0;
	  #5 adrs = 6'b010000;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
	  #10 _ce = 1; _we = 1; _oe = 1;
      
      #5 _ce = 0; _we = 1; _oe = 0;
	  #5 adrs = 6'b100000;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
	  #10 _ce = 1; _we = 1; _oe = 1;
      
      #5 _ce = 0; _we = 1; _oe = 0;
	  #5 adrs = 6'b110000;
	  $fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
	  #10 _ce = 1; _we = 1; _oe = 1;
      #30
      $finish;
    end
endmodule