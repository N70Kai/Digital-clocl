
module display(
	input clk,
	input SW_hour,
	input bell_en,
	input [3:0] state_mode,
	input [7:0] alarm_hour_time,
   input [7:0] alarm_minute_time,
   input [7:0] alarm_second_time,
	input [7:0] hour_time,
	input [7:0] minute_time,
	input [7:0] second_time,
	input [3:0] week_day,
	
	output  reg [7:0] HEX0,
	output  reg [7:0] HEX1,
	output  reg [7:0] HEX2,
	output  reg [7:0] HEX3,
	output  reg [7:0] HEX4,
	output  reg [7:0] HEX5,
	output  reg [7:0] HEX6 
);


reg [7:0] display_hour_time;
reg [7:0] display_minute_time;
reg [7:0] display_second_time;


always@(posedge clk)
	case(state_mode)
		4'd0,4'd1:
			if(SW_hour==1)
				begin
					if(hour_time>=12)
						display_hour_time<=hour_time-12;
					else
						display_hour_time<=hour_time;
				display_minute_time<=minute_time;//
				display_second_time<=second_time;		
				end
			else
				begin
				display_hour_time<=hour_time;//
				display_minute_time<=minute_time;//
				display_second_time<=second_time;//	
				end
		4'd2,4'd3:
			begin
			display_hour_time<=alarm_hour_time;//
			display_minute_time<=alarm_minute_time;//
			display_second_time<=alarm_second_time;//	
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
		second_time_one <= display_second_time %8'd10;//
		second_time_ten <= display_second_time /8'd10;//		
		minute_time_one <= display_minute_time %8'd10;//		
		minute_time_ten <= display_minute_time /8'd10;//		
		hour_time_one <= display_hour_time %8'd10;//	
		hour_time_ten <= display_hour_time /8'd10;//
end

///////////////////////////////

reg [31:0] time_count=32'd0;
reg clk_bell=0;
always@(posedge clk)
	if(time_count==32'd250)begin
		time_count<=32'd0;
		clk_bell<=~clk_bell;
		end
	else begin
		time_count<=time_count+32'd1;
		end

///////////////////////////////
 


always @(posedge clk)
begin
	if(bell_en==1 && clk_bell)
		HEX0<= 8'b1111_1111;
	else
		case (second_time_one)  
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
	if(bell_en==1 && clk_bell)
		HEX1<= 8'b1111_1111;
	else
		case (second_time_ten)  
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
	if(bell_en==1 && clk_bell)
		HEX2<= 8'b1111_1111;
	else
		case (minute_time_one)  
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
	if(bell_en==1 && clk_bell)
		HEX3<= 8'b1111_1111;
	else
		case (minute_time_ten)  
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
	if(bell_en==1 && clk_bell)
		HEX4<= 8'b1111_1111;
	else
		case (hour_time_one)  
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
	if(bell_en==1 && clk_bell)
		HEX5<= 8'b1111_1111;
	else
		case (hour_time_ten)
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


always @(posedge clk)
begin
		case (week_day)  
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
