//分频模块，分频到1Hz
module fenping(
input clk_50M,
output reg clk_1Hz
);

reg [31:0] time_count=32'd0;
always@(posedge clk_50M)
	if(time_count==32'd50000000)begin//50M计数50000000次得到1Hz信号,改小为500便于仿真
		time_count<=32'd0;
		clk_1Hz<=1;
		end
	else begin
		time_count<=time_count+32'd1;
		clk_1Hz<=0;
		end
		
endmodule