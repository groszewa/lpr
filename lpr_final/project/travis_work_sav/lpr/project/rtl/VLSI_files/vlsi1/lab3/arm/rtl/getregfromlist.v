// 
// getregfromlist.v
// 
// David Van Campenhout
// 
// no ffs
// 

module getregfromlist( 	reglist, xreg, toggle);

  input [15:0]	reglist;

  output [3:0] 	xreg;  
  output [15:0]	toggle;

  reg [3:0] 	xreg;  
  reg [15:0] 	toggle;

  always begin : logic
	@(reglist)
	xreg	= 4'd0;
	toggle	= 16'h0;
        casex (reglist)		// casex <> case !!!@#$%^&*
			16'bxxxxxxxxxxxxxxx1:	
begin
	xreg	= 4'd0;
	toggle 	 = 16'h1;
end
			16'bxxxxxxxxxxxxxx10:	
begin
	xreg	= 4'd1;
	toggle 	= 16'h2;
end
			16'bxxxxxxxxxxxxx100:
begin
	xreg	= 4'd2;
	toggle	= 16'h4;
end
			16'bxxxxxxxxxxxx1000:
begin
	xreg	= 4'd3;
	toggle	= 16'h8;
end
			16'bxxxxxxxxxxx10000:
begin
	xreg	= 4'd4;
	toggle	= 16'h10;
end
			16'bxxxxxxxxxx100000:
begin
	xreg	= 4'd5;
	toggle	= 16'h20;
end
			16'bxxxxxxxxx1000000:
begin
	xreg	= 4'd6;
	toggle	= 16'h40;
end
			16'bxxxxxxxx10000000:
begin
	xreg	= 4'd7;
	toggle	= 16'h80;
end
			16'bxxxxxxx100000000:
begin
	xreg	= 4'd8;
	toggle	= 16'h100;
end
			16'bxxxxxx1000000000:
begin
	xreg	= 4'd9;
	toggle	= 16'h200;
end
			16'bxxxxx10000000000:
begin
	xreg	= 4'd10;
	toggle	= 16'h400;
end
			16'bxxxx100000000000:
begin
	xreg	= 4'd11;
	toggle	= 16'h800;
end
			16'bxxx1000000000000:
begin
	xreg	= 4'd12;
	toggle	= 16'h1000;
end
			16'bxx10000000000000:
begin
	xreg	= 4'd13;
	toggle	= 16'h2000;
end
			16'bx100000000000000:
begin
	xreg	= 4'd14;
	toggle	= 16'h4000;
end
			16'b1000000000000000:
begin
	xreg	= 4'd15;
	toggle	= 16'h8000;
end
			default:
begin
	xreg	= 4'd0;
	toggle	= 16'h0;
end
		endcase
                
	end // logic

endmodule









