module vending_machine_top(
    input  clk,

    input  n0,n1,n2,n3,n4,
    input  d0,d1,d2,

    output [3:0] seg_an,
    output [6:0] seg_cat,

    output soda_led,
    output change_led
);

wire [11:0] total; // total to be calculated then used to calculate the change to be displayed on seven segment display
wire [2:0] nickels = n0 + n1 + n2 + n3 + n4;
wire [1:0] dimes = d0 + d1 + d2;
assign total = (nickels*5) + (dimes*10);

assign soda_led = (total >= 25);
assign change_led = (total > 25);

wire [11:0] change_out = (total > 25) ? (total - 25): 0;


wire [15:0] bcd_value;
wire bcd_ready;

BintoBCD BCD1(
    .clk(clk),
    .en(1'b1),
    .bin_in(change_out),
    .bcd_out(bcd_value),
    .rdy(bcd_ready)
);

reg [15:0] display;

always@(posedge clk) begin
    if(bcd_ready)
        display <= bcd_value;
end

multiseg_driver multi1(
    .clk(clk),
    .bcd_in(display),
    .seg_an(seg_an),
    .seg_cat(seg_cat)
);

endmodule

