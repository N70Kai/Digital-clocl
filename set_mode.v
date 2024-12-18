//设置当前模式
module set_mode(
input clk_50M,
input alarm_SW,//闹钟时间设置键，0--显示计时；1--显示设置闹钟时间
input MODE_SW,//MODE 模式设置按键--0:正常计时，1：设置时间
output reg [3:0] led_mode,//led显示当前模式
output [3:0] state_mode//当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间
);

reg [3:0] mode_state=4'd0;
always@(posedge clk_50M)
	case({alarm_SW,MODE_SW})
		2'b00:mode_state<=4'd0;//正常计时
		2'b01:mode_state<=4'd1;//设置时间
		2'b10:mode_state<=4'd2;//显示闹钟时间
		2'b11:mode_state<=4'd3;//设置闹钟时间
		default:;
	endcase
		
//LED	显示当前模式	
always@(posedge clk_50M)
	case(mode_state)
		4'd0:led_mode<=4'b0001;
		4'd1:led_mode<=4'b0010;
		4'd2:led_mode<=4'b0100;
		4'd3:led_mode<=4'b1000;
		default:;
	endcase
			
assign state_mode=mode_state;//输出当前模式，4'd0:计时，4'd1设置时间 ，4'd2显示闹钟时间,4'd3设置闹钟时间

endmodule