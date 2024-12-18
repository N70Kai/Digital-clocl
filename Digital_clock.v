//顶层模块
module Digital_clock(
input clk_50M,//时钟
input alarm_SW,//闹钟时间设置键，0--显示正常计时；1--显示设置闹钟时间
input MODE_SW,//MODE 模式设置按键--0:计时，1：设置时间
input AH_key,//AH 修改小时
input AM_key,//AM 修改分钟
input SW_hour,//12小时和24小时切换

output [3:0] led_mode,//led显示当前模式

output  [7:0] HEX0,//数码管-低亮
output  [7:0] HEX1,//数码管-低亮
output  [7:0] HEX2,//数码管-低亮
output  [7:0] HEX3,//数码管-低亮
output  [7:0] HEX4,//数码管-低亮
output  [7:0] HEX5 //数码管-低亮
);
wire [3:0] state_mode;//当前模式
wire [7:0] hour_time;//时
wire [7:0] minute_time;//分
wire [7:0] second_time;//秒
wire [7:0] alarm_hour_time;//闹钟时
wire [7:0] alarm_minute_time;//闹钟分
wire [7:0] alarm_second_time;//闹钟秒

wire clk_1Hz;
wire bell_out;
wire [3:0] week_day;//星期

//分频到1Hz
fenping fenping_Hz(
. clk_50M(clk_50M),
. clk_1Hz(clk_1Hz)
);

//设置模式模块
set_mode i_set_mode(
. clk_50M(clk_50M),
. alarm_SW(alarm_SW),
. MODE_SW(MODE_SW),
. led_mode(led_mode),//led显示当前模式
. state_mode(state_mode)//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
);

//计时模块
jishi i_jishi(
. clk_50M(clk_50M),
. clk_1Hz(clk_1Hz),
. state_mode(state_mode),//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间

. AH_key(AH_key),//AH 修改小时
. AM_key(AM_key),//AM 修改分钟
. week_day(week_day),//星期
. hour_time(hour_time),//时
. minute_time(minute_time),//分
. second_time(second_time)//秒
);

//闹钟模块
alarm_clock i_alarm_clock(

. clk_50M(clk_50M),
. state_mode(state_mode),////当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间

. AH_key(AH_key),//AH 修改小时
. AM_key(AM_key),//AM 修改分钟

. alarm_hour_time(alarm_hour_time),//时
. alarm_minute_time(alarm_minute_time),//分
. alarm_second_time(alarm_second_time)//秒
);

//闹铃模块
Bell i_Bell(
. clk_50M(clk_50M),

. alarm_hour_time(alarm_hour_time),//闹钟时
. alarm_minute_time(alarm_minute_time),//闹钟分
. alarm_second_time(alarm_second_time),//闹钟秒

. hour_time(hour_time),//时
. minute_time(minute_time),//分
. second_time(second_time),//秒	
. bell_out(bell_out)////闹钟使能，5秒
);

//显示模块
display i_display(
. clk(clk_50M),
. SW_hour(SW_hour),//12小时和24小时切换
. state_mode(state_mode),//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
. bell_en(bell_out),//闹钟使能，5秒
. week_day(week_day),//星期	
. hour_time(hour_time),//时
. minute_time(minute_time),//分
. second_time(second_time),//秒	

. alarm_hour_time(alarm_hour_time),//闹钟时
. alarm_minute_time(alarm_minute_time),//闹钟分
. alarm_second_time(alarm_second_time),//闹钟秒

. HEX0(HEX0),//数码管-低亮
. HEX1(HEX1),//数码管-低亮
. HEX2(HEX2),//数码管-低亮
. HEX3(HEX3),//数码管-低亮
. HEX4(HEX4),//数码管-低亮
. HEX5(HEX5),//数码管-低亮
. HEX6(HEX6) //数码管-低亮
);


endmodule