module multiseg_driver(clk, bcd_in, seg_an, seg_cat);
input clk;
input [15:0] bcd_in;
output [3:0] seg_an;
output [6:0] seg_cat;

wire [3:0] bcd_val;

anode_generator an1(clk, bcd_in, seg_an, bcd_val);
seven_seg_decoder seven1(bcd_val, seg_cat);


endmodule

//-----------------------------------------------

module anode_generator(clk, bcd_in, seg_an, bcd_out);
input clk;
input [15:0] bcd_in;
output [3:0] seg_an;
output reg [3:0] bcd_out;

reg [9:0] g_count = 0;
reg [3:0] anode = 4'b1110;
assign seg_an = anode;

always@(posedge clk)
	begin
	   g_count <= g_count + 1;
	
	   if (g_count == 1023)begin
            //do something
            anode <= {anode[0], anode[3:1]};
	   end
	    case(anode)
		      4'b1110: bcd_out <= bcd_in[3:0];
		      4'b1101: bcd_out <= bcd_in[7:4];
		      4'b1011: bcd_out <= bcd_in[11:8];
		      4'b0111: bcd_out <= bcd_in[15:12];
	        endcase	
    end
endmodule
//------------------------
module seven_seg_decoder(data_in, seg);
output reg [6:0] seg;
input [3:0] data_in;

always@*
	begin
	
	case(data_in)
	4'b0000: seg = 7'b0000001;
	4'b0001: seg = 7'b1001111;
	4'b0010: seg = 7'b0010010;
	4'b0011: seg = 7'b0000110;
	4'b0100: seg = 7'b1001100;
	4'b0101: seg = 7'b0100100;
	4'b0110: seg = 7'b0100000;
	4'b0111: seg = 7'b0001111;
	4'b1000: seg = 7'b0000000;
	4'b1001: seg = 7'b0000100;
	
	default: seg = 7'b0110000;
	
	endcase
	
	end
endmodule


