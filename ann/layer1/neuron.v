module neuron #(parameter N = 10)
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
     bias=32'h3DCCCCCD; // 0.1
     W[0] = 32'h3DCCCCCD; // 0.1
     W[1] = 32'hBE4CCCCD; // -0.2
     W[2] = 32'h3E99999A; // 0.3
     W[3] = 32'h3ECCCCCD; // 0.4
     W[4] = 32'h3DCCCCCD; // 0.1
     W[5] = 32'hBE99999A; // -0.3
     W[6] = 32'hBE4CCCCD; // -0.2
     W[7] = 32'h3F000000; // 0.5
     W[8] = 32'h3F333333; // 0.7
     W[9] = 32'h3E99999A; // 0.3
end


always @(posedge clk) begin
    if(rst) 
    begin
    i<=0;
    x_temp<=0;
    w<=0;
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
        done <= 1'b1;  
        end
end

always @(*) begin
    if (done)
        out = temp_out;
    else
        out = 32'd0;  
end
endmodule
