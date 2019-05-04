//
// exc.v
//
// David Van Campenhout
//
// generation of exception addresses
//


module exc( mask, undef_instr, swi, 
		prefetch_abort, data_abort, irq, fiq, address);

  input	[1:0]	mask;		// [irq disable, fiq disable]
  input		undef_instr;		// undefined instruction
  input		swi;		// software interrupt
  input		prefetch_abort; // prefetch abort
  input		data_abort;	// data abort
  input		irq;		// interrupt request
  input		fiq;		// fast interrupt request
  output [4:2]	address;	

  reg [4:2]	address;

  always @( mask or undef_instr or swi or 
		prefetch_abort or data_abort or irq or fiq )
  begin
	address = 3'b0;
	if ( data_abort)		address = 3'd5;
	else if (fiq & !mask[1]) 	address = 3'd7;
	else if (irq & !mask[0])	address = 3'd6;
	else if (swi)			address = 3'd2;
	else if (prefetch_abort)	address = 3'd4;
	else if (undef_instr)		address = 3'd1;	
  end //always

endmodule


