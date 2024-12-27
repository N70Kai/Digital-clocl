
module alarm_clock(
input clk_50M,
input [3:0] state_mode,
input AH_key,//
input AM_key,//
output [7:0] alarm_hour_time,
output [7:0] alarm_minute_time,
output [7:0] alarm_second_time
);

wire AH_key_negedge;
wire AM_key_negedge;
reg AH_key_buf0;
reg AH_key_buf1;
reg AM_key_buf0;
reg AM_key_buf1;

always@(posedge clk_50M)
begin
	AH_key_buf0<=AH_key;
	AH_key_buf1<=AH_key_buf0;
end

always@(posedge clk_50M)
begin
	AM_key_buf0<=AM_key;
	AM_key_buf1<=AM_key_buf0;
end

assign AH_key_negedge=~AH_key_buf0 & AH_key_buf1;
assign AM_key_negedge=~AM_key_buf0 & AM_key_buf1;

reg [7:0] hour=8'd21;
reg [7:0] minute=8'd59;
reg [7:0] second=8'd00;

always@(posedge clk_50M)
	if(state_mode==4'd3)begin	
			if(AH_key_negedge)
				if(hour==8'd23)
					hour<=8'd0;
				else
					hour<=hour+8'd1;
			else
				hour<=hour;
				
			if(AM_key_negedge)
				if(minute==8'd59)
					minute<=8'd0;
				else
					minute<=minute+8'd1;
			else
				minute<=minute;
		end

assign alarm_hour_time=hour;
assign alarm_minute_time=minute;
assign alarm_second_time=second;


endmodule
