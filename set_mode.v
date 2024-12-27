
module set_mode(
input clk_50M,
input alarm_SW,
input MODE_SW,
output reg [3:0] led_mode,
output [3:0] state_mode
);

reg [3:0] mode_state=4'd0;
always@(posedge clk_50M)
	case({alarm_SW,MODE_SW})
		2'b00:mode_state<=4'd0;
		2'b01:mode_state<=4'd1;
		2'b10:mode_state<=4'd2;
		2'b11:mode_state<=4'd3;
		default:;
	endcase
		
	
always@(posedge clk_50M)
	case(mode_state)
		4'd0:led_mode<=4'b0001;
		4'd1:led_mode<=4'b0010;
		4'd2:led_mode<=4'b0100;
		4'd3:led_mode<=4'b1000;
		default:;
	endcase
			
assign state_mode=mode_state;

endmodule
