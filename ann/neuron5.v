`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2025 12:22:50
// Design Name: 
// Module Name: neuron5
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


module neuron5 #(parameter N = 3)
                (input clk,rst,
                input [31:0] x,
                 output reg [31:0] out,
                 output reg done);

reg [31:0] W[0:(N-1)];
//reg [31:0] X[0:(N-1)];
reg [31:0] bias ;
reg [31:0] x_temp, w;
wire [31:0] out1, temp_out;
wire [31:0] relu_in;
//reg clr_in = 0;
//reg done=0;  // Changed wire to reg
integer i=0;

mac m1 (clk, w, x_temp, out1);
//assign relu_in = out1 + bias;
add_fp a3(out1,bias,relu_in);
ReLu m2 (relu_in, temp_out);

initial begin
     bias=32'h3E4CCCCD; // 0.2
     W[0] = 32'h3F333333; // 0.7
     W[1] = 32'h3E99999A; // 0.3
     W[2] = 32'h3E4CCCCD; // 0.2
    
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
    if (i == N-1) 
        done <= 1'b1;  // Set done when i reaches N

end

// Output Logic
always @(*) begin
    if (done)
        out = temp_out;
    else
        out = 32'd0;  // Clear output until calculations finish
end
endmodule
