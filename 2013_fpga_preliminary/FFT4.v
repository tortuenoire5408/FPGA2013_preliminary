module FFT4(clk, rst, i0, i1, i2, i3, o0, o1, o2, o3);
input clk, rst;
input [63:0] i0, i1, i2, i3;
output [63:0] o0, o1, o2, o3;
//---------------------------------------------------------------------------------
reg [63:0] o0, o1, o2, o3;

reg [31:0] sub1_0, sub1_1,
           sub2_0, sub2_1,
           sub2_c0, sub2_c1;
reg [64:0] real_0, real_1,
           imag_0, imag_1;
//---------------------------------------------------------------------------------
always@(posedge clk or posedge rst) begin
    if(rst) begin
        o0 = 0; o1 = 0; o2 = 0; o3 = 0;
    end else begin
        o0 = {i0[63:32] + i2[63:32], i0[31:0] + i2[31:0]};
        o1 = {i1[63:32] + i3[63:32], i1[31:0] + i3[31:0]};

        sub1_0 = i0[63:32] - i2[63:32];
        sub2_0 = i0[31:0] - i2[31:0];
        sub2_c0 = 0 - sub2_0;
        real_0 = {{32{sub1_0[31]}}, sub1_0} * {32'h0000, 32'h00010000} + {{32{sub2_c0[31]}}, sub2_c0} * {32'h0000, 32'h00000000};
        imag_0 = {{32{sub1_0[31]}}, sub1_0} * {32'h0000, 32'h00000000} + {{32{sub2_0[31]}}, sub2_0} * {32'h0000, 32'h00010000};
        o2 = {real_0[47:16], imag_0[47:16]};

        sub1_1 = i1[63:32] - i3[63:32];
        sub2_1 = i1[31:0] - i3[31:0];
        sub2_c1 = 0 - sub2_1;
        real_1 = {{32{sub1_1[31]}}, sub1_1} * {32'h0000, 32'h00000000} + {{32{sub2_c1[31]}}, sub2_c1} * {32'hFFFF, 32'hFFFF0000};
        imag_1 = {{32{sub1_1[31]}}, sub1_1} * {32'hFFFF, 32'hFFFF0000} + {{32{sub2_1[31]}}, sub2_1} * {32'h0000, 32'h00000000};
        o3 = {real_1[47:16], imag_1[47:16]};
    end
end

//---------------------------------------------------------------------------------
endmodule