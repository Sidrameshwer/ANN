`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.03.2025 23:34:41
// Design Name: 
// Module Name: neuron2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module neuron2 #(parameter N = 10)
                (input clk,rst,
                input [31:0] x,
                 output reg [31:0] out,
                 output reg done);

reg [31:0] W[0:(N-1)];
reg [31:0] bias ;
reg [31:0] x_temp, w;
wire [31:0] out1, temp_out;
wire [31:0] relu_in;
integer i=0;

mac m1 (clk, w, x_temp, out1);
add_fp a3(out1,bias,relu_in);
ReLu m2 (relu_in, temp_out);

initial begin
     bias = 32'h3DCCCCCD; // 0.1
     W[0] = 32'hBF19999A; // -0.6
     W[1] = 32'h3DCCCCCD; // 0.1
     W[2] = 32'h3E4CCCCD; // 0.2
     W[3] = 32'hBE99999A; // -0.3
     W[4] = 32'h3F000000; // 0.5
     W[5] = 32'h3F19999A; // 0.6
     W[6] = 32'h3E99999A; // 0.3
     W[7] = 32'hBE4CCCCD; // -0.2
     W[8] = 32'h3F333333; // 0.7
     W[9] = 32'h3ECCCCCD; // 0.4
end

// Sequential Logic for Data Feeding
always @(posedge clk) begin
    if(rst) 
    begin
    i<=0;
    x_temp<=0;
    w<=0;
//    out<=0;
     done<=0;
    end
    else begin
    if (!done) begin
        x_temp <= x;
        w <= W[i];
        i <= i + 1;
        end
    else begin
        x_temp<=0;
        w<=0;
    end
    end
    if (i == N-1) begin
        done <= 1'b1;  // Set done when i reaches N
        i<=i+1;
    end
    
end

// Output Logic
always @(*) begin
    if (done)
        out <= temp_out;
    else
        out <= 32'd0;
end
endmodule
/*module neuron2 #(parameter N = 10)
                (input clk, rst,
                 input [31:0] x,
                 output reg [31:0] out,
                 output reg done);

reg [31:0] W[0:(N-1)];
reg [31:0] bias;
reg [31:0] x_temp, w;
wire [31:0] out1, temp_out;
wire [31:0] relu_in;
integer i = 0;

mac m1 (clk, w, x_temp, out1);
add_fp a3 (out1, bias, relu_in);
ReLu m2 (relu_in, temp_out);

initial begin
    bias = 32'h3F800000;
    W[0] = 32'h3F800000;  // 1.0
    W[1] = 32'hBF800000;  // -1.0
    W[2] = 32'h3F000000;  // 0.5
    W[3] = 32'hBF000000;  // -0.5
    W[4] = 32'h40000000;  // 2.0
    W[5] = 32'hC0000000;  // -2.0
    W[6] = 32'h3FC00000;  // 1.5
    W[7] = 32'hBFC00000;  // -1.5
    W[8] = 32'h3E800000;  // 0.25
    W[9] = 32'hBE800000;  // -0.25
end

// Sequential Logic for Data Feeding
always @(posedge clk) begin
    if (rst) begin
        i <= 0;
        x_temp <= 0;
        w <= 0;
        out <= 0;
        done <= 0;
    end 
    else begin
        if (!done) begin
            x_temp <= x;
            w <= W[i];
            i <= i + 1;
        end 
        else begin
            x_temp <= 0;
            w <= 0;
        end

        if (i == N) // Ensure `done` is set only once
            done <= 1'b1;
    end
end

// Output Logic
always @(posedge clk) begin
    if (rst)
        out <= 32'd0;
    else if (done)
        out <= temp_out;
    else
        out <= 32'd0;
end

endmodule
*/