//显示模块
module display(
	input clk,
	input SW_hour,//12小时和24小时切换
	input bell_en,//闹钟使能，5秒,高电平时数码管闪烁
	input [3:0] state_mode,//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
	input [7:0] alarm_hour_time,//闹钟时
   input [7:0] alarm_minute_time,//闹钟分
   input [7:0] alarm_second_time,//闹钟秒	
	input [7:0] hour_time,//时
	input [7:0] minute_time,//分
	input [7:0] second_time,//秒	
	input [3:0] week_day,//星期
	
	output  reg [7:0] HEX0,//数码管-低亮
	output  reg [7:0] HEX1,//数码管-低亮
	output  reg [7:0] HEX2,//数码管-低亮
	output  reg [7:0] HEX3,//数码管-低亮
	output  reg [7:0] HEX4,//数码管-低亮
	output  reg [7:0] HEX5,//数码管-低亮
	output  reg [7:0] HEX6 //数码管-低亮--显示星期
);


reg [7:0] display_hour_time;//显示时
reg [7:0] display_minute_time;//显示分
reg [7:0] display_second_time;//显示秒

//SW_hour,//12小时和24小时切换
always@(posedge clk)
	case(state_mode)//4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
		4'd0,4'd1:
			if(SW_hour==1)//12小时进制
				begin
					if(hour_time>=12)
						display_hour_time<=hour_time-12;//显示时,大于12则减去12，转换为12进制
					else
						display_hour_time<=hour_time;//小于12不用减
				display_minute_time<=minute_time;//显示分
				display_second_time<=second_time;//显示秒		
				end
			else//24小时进制
				begin
				display_hour_time<=hour_time;//显示时
				display_minute_time<=minute_time;//显示分
				display_second_time<=second_time;//显示秒		
				end
		4'd2,4'd3://（闹钟时间）
			begin
			display_hour_time<=alarm_hour_time;//显示时
			display_minute_time<=alarm_minute_time;//显示分
			display_second_time<=alarm_second_time;//显示秒		
			end
	default:;
endcase
			
reg [3:0] second_time_one=4'd0;
reg [3:0] second_time_ten=4'd0;
reg [3:0] minute_time_one=4'd0;
reg [3:0] minute_time_ten=4'd0;
reg [3:0] hour_time_one=4'd0;
reg [3:0] hour_time_ten=4'd0;
always @(posedge clk ) 
begin
		second_time_one <= display_second_time %8'd10;//秒个位
		second_time_ten <= display_second_time /8'd10;//秒十位			
		minute_time_one <= display_minute_time %8'd10;//分钟个位		
		minute_time_ten <= display_minute_time /8'd10;//分钟十位		
		hour_time_one <= display_hour_time %8'd10;//小时个位		
		hour_time_ten <= display_hour_time /8'd10;//小时十位
end

///////////////////////////////
//产生数码管闪烁的使能1Hz信号
reg [31:0] time_count=32'd0;
reg clk_bell=0;//数码管闪烁的使能1Hz信号
always@(posedge clk)
	if(time_count==32'd250)begin//50M计数50000000次得到1Hz信号,改小为500便于仿真
		time_count<=32'd0;
		clk_bell<=~clk_bell;//数码管闪烁的使能1Hz信号
		end
	else begin
		time_count<=time_count+32'd1;
		end

///////////////////////////////
 

////////////////////////////////////////////////////段选输出///////////////////////////////////////////
always @(posedge clk)
begin//clk_bell数码管闪烁的使能1Hz信号
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX0<= 8'b1111_1111;//数码管灭
	else
		case (second_time_one)  //数字显示码	
		8'd0: HEX0<= 8'b1100_0000;
		8'd1: HEX0<= 8'b1111_1001;
		8'd2: HEX0<= 8'b1010_0100;
		8'd3: HEX0<= 8'b1011_0000;
		8'd4: HEX0<= 8'b1001_1001;
		8'd5: HEX0<= 8'b1001_0010;
		8'd6: HEX0<= 8'b1000_0010;
		8'd7: HEX0<= 8'b1111_1000;
		8'd8: HEX0<= 8'b1000_0000;
		8'd9: HEX0<= 8'b1001_0000;
		default:;
		endcase
end

always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX1<= 8'b1111_1111;//数码管灭
	else
		case (second_time_ten)  //数字显示码	
		8'd0: HEX1<= 8'b1100_0000;
		8'd1: HEX1<= 8'b1111_1001;
		8'd2: HEX1<= 8'b1010_0100;
		8'd3: HEX1<= 8'b1011_0000;
		8'd4: HEX1<= 8'b1001_1001;
		8'd5: HEX1<= 8'b1001_0010;
		8'd6: HEX1<= 8'b1000_0010;
		8'd7: HEX1<= 8'b1111_1000;
		8'd8: HEX1<= 8'b1000_0000;
		8'd9: HEX1<= 8'b1001_0000;
		default:;
		endcase
end


always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX2<= 8'b1111_1111;//数码管灭
	else
		case (minute_time_one)  //数字显示码	
		8'd0: HEX2<= 8'b1100_0000;
		8'd1: HEX2<= 8'b1111_1001;
		8'd2: HEX2<= 8'b1010_0100;
		8'd3: HEX2<= 8'b1011_0000;
		8'd4: HEX2<= 8'b1001_1001;
		8'd5: HEX2<= 8'b1001_0010;
		8'd6: HEX2<= 8'b1000_0010;
		8'd7: HEX2<= 8'b1111_1000;
		8'd8: HEX2<= 8'b1000_0000;
		8'd9: HEX2<= 8'b1001_0000;
		default:;
		endcase
end

always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX3<= 8'b1111_1111;//数码管灭
	else
		case (minute_time_ten)  //数字显示码	
		8'd0: HEX3<= 8'b1100_0000;
		8'd1: HEX3<= 8'b1111_1001;
		8'd2: HEX3<= 8'b1010_0100;
		8'd3: HEX3<= 8'b1011_0000;
		8'd4: HEX3<= 8'b1001_1001;
		8'd5: HEX3<= 8'b1001_0010;
		8'd6: HEX3<= 8'b1000_0010;
		8'd7: HEX3<= 8'b1111_1000;
		8'd8: HEX3<= 8'b1000_0000;
		8'd9: HEX3<= 8'b1001_0000;
		default:;
		endcase
end


always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX4<= 8'b1111_1111;//数码管灭
	else
		case (hour_time_one)  //数字显示码	
		8'd0: HEX4<= 8'b1100_0000;
		8'd1: HEX4<= 8'b1111_1001;
		8'd2: HEX4<= 8'b1010_0100;
		8'd3: HEX4<= 8'b1011_0000;
		8'd4: HEX4<= 8'b1001_1001;
		8'd5: HEX4<= 8'b1001_0010;
		8'd6: HEX4<= 8'b1000_0010;
		8'd7: HEX4<= 8'b1111_1000;
		8'd8: HEX4<= 8'b1000_0000;
		8'd9: HEX4<= 8'b1001_0000;
		default:;
		endcase
end

always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)//闹钟使能，5秒,高电平时数码管闪烁
		HEX5<= 8'b1111_1111;//数码管灭
	else
		case (hour_time_ten)  //数字显示码	
		8'd0: HEX5<= 8'b1100_0000;
		8'd1: HEX5<= 8'b1111_1001;
		8'd2: HEX5<= 8'b1010_0100;
		8'd3: HEX5<= 8'b1011_0000;
		8'd4: HEX5<= 8'b1001_1001;
		8'd5: HEX5<= 8'b1001_0010;
		8'd6: HEX5<= 8'b1000_0010;
		8'd7: HEX5<= 8'b1111_1000;
		8'd8: HEX5<= 8'b1000_0000;
		8'd9: HEX5<= 8'b1001_0000;
		default:;
		endcase
end

//显示星期
always @(posedge clk)
begin
		case (week_day)  //数字显示码	
		8'd0: HEX6<= 8'b1100_0000;
		8'd1: HEX6<= 8'b1111_1001;
		8'd2: HEX6<= 8'b1010_0100;
		8'd3: HEX6<= 8'b1011_0000;
		8'd4: HEX6<= 8'b1001_1001;
		8'd5: HEX6<= 8'b1001_0010;
		8'd6: HEX6<= 8'b1000_0010;
		8'd7: HEX6<= 8'b1111_1000;
		8'd8: HEX6<= 8'b1000_0000;
		8'd9: HEX6<= 8'b1001_0000;
		default:;
		endcase
end
endmodule
