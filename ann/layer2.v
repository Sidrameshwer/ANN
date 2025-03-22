    module layer2(input clk,rst,
                  input [31:0]x,
                  output reg [31:0]out,
                  output reg done );
    wire [31:0]out1[0:1];
    wire done1;
    integer i;
    neuron4 n4 (clk,rst,x,out1[0],done1);
    neuron5 n5 (clk,rst,x,out1[1],done1);
    parameter s0=0,s1=1,s2=2,s3=3;
    reg [1:0]state,next_state;
    always @(posedge clk)
        begin
            if(rst)
                state<=s0;
            else
                state<=next_state;
            case(state)
            s0: begin
                out<=0;
                done<=0;
                i<=0;
                end 
            s1:begin
            
            end
            s2: begin
                    out<=out1[i];
                    i<=i+1;
                    done<=1;
                end
            endcase
        end
    always @(*)
        begin
            case(state)
            s0:next_state=done1?s1:s0;
            s1:begin
                if(i<2)
                    next_state=s2;
                else
                    next_state=s0;
                end
            endcase
        end
    endmodule
