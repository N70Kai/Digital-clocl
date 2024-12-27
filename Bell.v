
module Bell(
input clk_50M,
input [7:0] alarm_hour_time,
input [7:0] alarm_minute_time,
input [7:0] alarm_second_time,
input [7:0] hour_time,
input [7:0] minute_time,
input [7:0] second_time,
output bell_out
);
reg alarm_bell=0;
always@(posedge clk_50M)
	if(alarm_hour_time==hour_time && alarm_minute_time==minute_time && second_time<8'd6)
		alarm_bell<=1;
	else if(minute_time==8'd0 && second_time<8'd6)
		alarm_bell<=1;//
	else	
		alarm_bell<=0;

assign bell_out=alarm_bell;
			

endmodule
