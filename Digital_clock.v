//Top 
module Digital_clock(
input clk_50M,
input alarm_SW,
input MODE_SW,
input AH_key,
input AM_key,
input SW_hour,

output [3:0] led_mode,

output  [7:0] HEX0,
output  [7:0] HEX1,
output  [7:0] HEX2,
output  [7:0] HEX3,
output  [7:0] HEX4,
output  [7:0] HEX5 
);
wire [3:0] state_mode;
wire [7:0] hour_time;
wire [7:0] minute_time;
wire [7:0] second_time;
wire [7:0] alarm_hour_time;
wire [7:0] alarm_minute_time;
wire [7:0] alarm_second_time;

wire clk_1Hz;
wire bell_out;
wire [3:0] week_day;


fenping fenping_Hz(
. clk_50M(clk_50M),
. clk_1Hz(clk_1Hz)
);


set_mode i_set_mode(
. clk_50M(clk_50M),
. alarm_SW(alarm_SW),
. MODE_SW(MODE_SW),
. led_mode(led_mode),
. state_mode(state_mode)
);

//计时模块
jishi i_jishi(
. clk_50M(clk_50M),
. clk_1Hz(clk_1Hz),
. state_mode(state_mode),

. AH_key(AH_key),
. AM_key(AM_key),
. week_day(week_day),
. hour_time(hour_time),
. minute_time(minute_time),
. second_time(second_time)
);


alarm_clock i_alarm_clock(

. clk_50M(clk_50M),
. state_mode(state_mode),

. AH_key(AH_key),
. AM_key(AM_key),

. alarm_hour_time(alarm_hour_time),
. alarm_minute_time(alarm_minute_time),
. alarm_second_time(alarm_second_time)
);


Bell i_Bell(
. clk_50M(clk_50M),

. alarm_hour_time(alarm_hour_time),/
. alarm_minute_time(alarm_minute_time),
. alarm_second_time(alarm_second_time),

. hour_time(hour_time),
. minute_time(minute_time),
. second_time(second_time),
. bell_out(bell_out)
);


display i_display(
. clk(clk_50M),
. SW_hour(SW_hour),
. state_mode(state_mode),
. bell_en(bell_out),
. week_day(week_day),
. hour_time(hour_time),
. minute_time(minute_time),
. second_time(second_time),

. alarm_hour_time(alarm_hour_time),
. alarm_minute_time(alarm_minute_time),
. alarm_second_time(alarm_second_time),

. HEX0(HEX0),
. HEX1(HEX1),
. HEX2(HEX2),
. HEX3(HEX3),
. HEX4(HEX4),
. HEX5(HEX5),
. HEX6(HEX6) 
);


endmodule
