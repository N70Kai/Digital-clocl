//计时模块
module jishi(
input clk_50M,
input clk_1Hz,
input [3:0] state_mode,//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
input AH_key,//AH 修改小时
input AM_key,//AM 修改分钟
output [3:0] week_day,//星期
output [7:0] hour_time,//时
output [7:0] minute_time,//分
output [7:0] second_time//秒
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

assign AH_key_negedge=~AH_key_buf0 & AH_key_buf1;//按键下降沿
assign AM_key_negedge=~AM_key_buf0 & AM_key_buf1; //按键下降沿

reg [7:0] hour=8'd12;//时
reg [7:0] minute=8'd59;//分
reg [7:0] second=8'd00;//秒

reg [3:0] week=4'd1;//星期
always@(posedge clk_50M)
	case(state_mode)
		4'd0,4'd2,4'd3://除设置时间的状态下，其他状态均计时
			if(clk_1Hz)//1秒钟变一次
				if(hour==8'd23 && minute==8'd59 && second==8'd59)
					if(week==4'd7)
						week<=4'd1;
					else
						week<=week+4'd1;
				else
					week<=week;
		default:;
	endcase
					
assign week_day=week;						

always@(posedge clk_50M)
	case(state_mode)
		4'd0,4'd2,4'd3://除设置时间的状态下，其他状态均计时
			if(clk_1Hz)//1秒钟变一次
				if(hour==8'd23 && minute==8'd59 && second==8'd59)begin
					hour<=8'd0;  
					minute<=8'd0;  
					second<=8'd0;
					end
				else if(minute==8'd59 && second==8'd59)begin  
				   hour<=hour+8'd1;
					minute<=8'd0;  
					second<=8'd0;				
					end
				else if(second==8'd59)begin  
				   hour<=hour;
					minute<=minute+8'd1;  
					second<=8'd0;				
					end	
				else begin  
				   hour<=hour;
					minute<=minute;  
					second<=second+8'd1;				
					end
		4'd1:begin//4'd1设置时间
			if(AH_key_negedge)
				if(hour==8'd23)
					hour<=8'd0;
				else
					hour<=hour+8'd1;
			else
				;
			if(AM_key_negedge)
				if(minute==8'd59)
					minute<=8'd0;
				else
					minute<=minute+8'd1;
			else
				;
			end
		default:;
	endcase

assign hour_time=hour;
assign minute_time=minute;
assign second_time=second;
	
endmodule