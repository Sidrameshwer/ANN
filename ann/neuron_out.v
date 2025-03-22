module neuron_out #(parameter N = 2)
                (input clk,rst,
                input [31:0] x,
                 output reg [31:0] out,
                 output reg done);

reg [31:0] W[0:(N-1)];

reg [31:0] bias ;
reg [31:0] x_temp, w;
wire [31:0] out1, temp_out;
wire [31:0] in;

integer i=0;

mac m1 (clk, w, x_temp, out1);
add_fp a3(out1,bias,in);
sigmoid m2 (in, temp_out);

initial begin
    bias=32'h3E99999A; // 0.3
    W[0] = 32'h3F19999A; // 0.6
    W[1] = 32'hBE99999A; // -0.4
    
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
    if (i == N-1) 
        done <= 1'b1;  

end

always @(*) begin
    if (done)
        out = temp_out;
    else
        out = 32'd0;  
end
endmodule
