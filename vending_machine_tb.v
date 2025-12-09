module tb_vending_machine_top;
reg clk;
reg n0, n1, n2, n3, n4;
reg d0, d1, d2;

wire [3:0] seg_an;
wire [6:0] seg_cat;
wire soda_led;
wire change_led;

vending_machine_top uut (.clk(clk), .n0(n0), .n1(n1), .n2(n2), .n3(n3), .n4(n4),.d0(d0), .d1(d1), .d2(d2),.seg_an(seg_an),
    .seg_cat(seg_cat),
    .soda_led(soda_led),
    .change_led(change_led)
);


initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    n0 = 0; n1 = 0; n2 = 0; n3 = 0; n4 = 0; d0 = 0; d1 = 0; d2 = 0; // Initialize all coins to 0
    #100; d0 = 1; d1 = 1; d2 = 1;
    #2000; d0 = 0; d1 = 0; d2 = 0;
    #20; d0 = 1; d1 = 1; d2 = 1; n0 = 1;
    #2000; d0 = 0; d1 = 0; d2 = 0; n0 = 0;
    #20; n0 = 1; n1 = 1; n2 = 1; n3 = 1; n4 = 1;
    #2000; n0 = 0; n1 = 0; n2 = 0; n3 = 0; n4 = 0;
    #20; d0 = 1; d1 = 1; n0 = 1;
    #2000; d0 = 0; d1 = 0; n0 = 0;
    #20; d0 = 1; d1 = 1; d2 = 1; n0 = 1; n1 = 1; n2 = 1; n3 = 1; n4 = 1;
    #2000; d0 = 0; d1 = 0; n0 = 0;
    #20; $stop;
end

endmodule