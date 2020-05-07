`timescale 1ns / 1ps

module main_tb(

);

localparam CLK_FREQ_MHZ   = 50;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;     

reg  [9:0]   sw_i;
wire [9:0]   led_o;
reg          btn_i;
reg          rstn_i;
reg          clk_i;
wire [6:0]   hex_o;
wire [1:0]   hex_on_o;

main DUT (
 .clk_i      (  clk_i    ),
 .rstn_i     (  rstn_i   ),
 .btn_i      (  btn_i    ),
 .sw_i       (  sw_i     ),
 .led_o      (  led_o    ),
 .hex_o      (  hex_o    ),
 .hex_on_o   (  hex_on_o )
);

initial begin
    clk_i = 1'b1;
    forever begin
      #CLK_SEMIPERIOD clk_i=~clk_i;
    end
end

initial begin //������������� ����� ����� 20 ��
    rstn_i = 1'b1;
    #(2*CLK_SEMIPERIOD);
    rstn_i = 1'b0;
    #(2*CLK_SEMIPERIOD);
    rstn_i = 1'b1;
end

initial begin
    sw_i  [9:0]   =     10'b0;
    btn_i         =      1'b0;
    repeat(40)begin
        #(CLK_SEMIPERIOD - 1);
        sw_i[9:0] = $random();
        #(3*CLK_SEMIPERIOD);
        btn_i     =      1'b1;
        #(3*CLK_SEMIPERIOD);
        btn_i     =      1'b0;
    end
end    

endmodule