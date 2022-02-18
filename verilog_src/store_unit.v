`timescale 1ns / 1ps
`include "COREV.vh"



module store_unit(
    input  [`DataBusBits-1:0] regval,
    input  [`DataBusBits-1:0] instruction,
    output reg [`DataBusBits-1:0] tostore
    );
    
    wire [2:0] funct3;
    wire [6:0]opcode;
    wire zero24;
    wire zero16;
    
    assign funct3=instruction[14:12];
    assign opcode=instruction[6:0]; 
    assign [23:0] zero24= 16'b000000000000000000000000; 
    assign [15:0] zero16= 16'b0000000000000000; 
    
    always @(*) begin
            case({funct3,opcode})
                `SB:
                    tostore={{24{regval[7]}}, regval[7:0]};
                `SH:
                    tostore={{16{regval[15]}}, regval[15:0]};
                `SW:
                    tostore=regval;
                 default:
                    tostore={zero16,zero16};
            endcase
    end
endmodule
