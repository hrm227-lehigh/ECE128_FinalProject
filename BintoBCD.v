module BintoBCD(
input clk,
input en,
input [11:0] bin_in,
output [15:0] bcd_out,
output rdy
);

parameter idle = 3'b000;
parameter setup = 3'b001;
parameter add = 3'b010;
parameter shift = 3'b011;
parameter done = 3'b100;

reg [27:0] bcd_data = 0;
reg [2:0] state = 0;
reg [3:0] sh_counter = 0;
reg result_rdy = 0;

always@ (posedge clk) begin
	case(state)
	
		idle: begin
			result_rdy <= 0;
			if(en) begin
				state <= setup;
			end
		end
		
		setup: begin
			bcd_data <= {16'b0, bin_in};
			sh_counter <= 0;
			state <= add;
		end
		
		add: begin
			if(bcd_data[27:24]>= 5) begin
				bcd_data[27:24] <= bcd_data[27:24]+3;
			end
			
			if(bcd_data[23:20]>= 5) begin
				bcd_data[23:20] <= bcd_data[23:20]+3;
			end
			
			if(bcd_data[19:16]>= 5) begin
				bcd_data[19:16] <= bcd_data[19:16]+3;
			end
				
			if(bcd_data[15:12]>= 5) begin
				bcd_data[15:12] <= bcd_data[15:12]+3;
			end
			
			state <= shift;
		end
		
		shift: begin
			bcd_data <= bcd_data << 1;
			sh_counter <= sh_counter +1;
			
			if(sh_counter == 11) begin
				state <= done;
			end
			else begin
				state <= add;
			end
		end
		
		done: begin
			result_rdy <= 1;
			state <= idle;
		end
		
		default: begin
			state <= idle;
		end
	endcase
end
assign bcd_out = bcd_data[27:12];
assign rdy = result_rdy;

endmodule