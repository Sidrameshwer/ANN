module layer1(input clk,rst,
              input [31:0]x,
              output reg [31:0]out,
              output reg done );
wire [31:0]out1[0:2];
wire done1;
integer i;
neuron n1 (clk,rst,x,out1[0],done1);
neuron2 n2 (clk,rst,x,out1[1],done1);
neuron3 n3 (clk,rst,x,out1[2],done1);
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
        //s3: done<=1;
        endcase
    end
always @(*)
    begin
    //next_state=s0;
        case(state)
        s0:next_state=done1?s1:s0;
        s1:begin
            if(i<3)
                next_state=s2;
            else
                next_state=s0;
            end
        //s3:next_state=s3;
        endcase
    end
endmodule
