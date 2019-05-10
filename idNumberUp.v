`include "ram128x16.v"
module idNumberUpTest();
	integer i,f;
    reg [6:0] adrs;
    reg [15:0] content;
    reg _ce, _we, _oe;
    wire [15:0] dataIn, dataOut;
    assign dataIn = ~_ce & ~_we & _oe ? content : 16'hz;
    ram128x16 u1(adrs, dataIn, _ce, _we, _oe, dataOut);
    initial begin
		f = $fopen("idNumberUp.txt","w");
		$monitor("%4d: adrs = %h  dataInHex = %h DataInDecimal= %d dataOutHex = %h dataOutDecimal = %d \n",
														$time, adrs, dataIn, dataIn, dataOut, dataOut);
		//write
		
		#5 _ce = 0; _we =0; _oe =1;
		$fwrite(f,"Time:	Address in Hex| Address in decimal|Data in Hex|Data in Decimal|DataOut in Hex|DataOut in Decimal\n");
		for(i = 0; i<=127; i= i+1) 
		begin 	
			#5 content = (9804+ i); //last 4 digits of my student ID plus 1000 plus i
			#1 adrs=i;
			$fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
		end
		#10 _ce = 1; _we = 1; _oe = 1;
		$fwrite(f,"Time:	Address in Hex| Address in decimal|Data in Hex|Data in Decimal|DataOut in Hex|DataOut in Decimal\n");
	
		#5 _ce = 0; _we = 1; _oe = 0;
		for(i = 0; i<=127; i= i+1) 
		begin 	
			#1 adrs=i;
			$fwrite(f,"%4d:\t\t\t\t%h\t\t\t\t  %d\t\t  %h\t\t\t %d\t\t\t %h\t\t\t  %d \n",
									$time, adrs, adrs, dataIn, dataIn, dataOut, dataOut);
		end
		#10 _ce = 1; _we = 1; _oe = 1;

      $finish;
    end
endmodule