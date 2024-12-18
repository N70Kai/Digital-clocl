//响铃模块包括闹钟
module Bell(
input clk_50M,
input [7:0] alarm_hour_time,//闹钟时
input [7:0] alarm_minute_time,//闹钟分
input [7:0] alarm_second_time,//闹钟秒	
input [7:0] hour_time,//时
input [7:0] minute_time,//分
input [7:0] second_time,//秒	
output bell_out////闹钟使能，5秒
);
reg alarm_bell=0;//闹钟使能
always@(posedge clk_50M)
	if(alarm_hour_time==hour_time && alarm_minute_time==minute_time && second_time<8'd6)//闹钟持续5秒
		alarm_bell<=1;//闹钟使能，5秒
	else if(minute_time==8'd0 && second_time<8'd6)//整点报时--5秒
		alarm_bell<=1;//
	else	
		alarm_bell<=0;

assign bell_out=alarm_bell;
			

endmodule