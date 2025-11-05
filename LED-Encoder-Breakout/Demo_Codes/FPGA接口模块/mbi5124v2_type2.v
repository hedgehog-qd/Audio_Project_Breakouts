`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/11 19:45:51
// Design Name: 
// Module Name: mbi5124v2_type2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mbi5124v2_type2(
    input wire clk,
    input wire rstn,
    input wire [4:0] value,  // 输入0-16亮对应的灯
    
    output reg sdi = 'b0,
    output reg le = 'b0,
    output reg oe = 'b1,
    output reg led_clk = 'b0,
    
    output reg [15:0] leds = 'b0
    );
    
    always @(*) begin
        // 根据 value 设置 leds
        case(value)
            5'd0:       leds = 16'b1111_1111_1111_1111;
            5'd1:       leds = 16'b1111_1111_1111_1110;
            5'd2:       leds = 16'b1111_1111_1111_1101;
            5'd3:       leds = 16'b1111_1111_1111_1011;
            5'd4:       leds = 16'b1111_1111_1111_0111;
            5'd5:       leds = 16'b1111_1111_1110_1111;
            5'd6:       leds = 16'b1111_1111_1101_1111;
            5'd7:       leds = 16'b1111_1111_1011_1111;
            5'd8:       leds = 16'b1111_1111_0111_1111;
            5'd9:       leds = 16'b1111_1110_1111_1111;
            5'd10:      leds = 16'b1111_1101_1111_1111;
            5'd11:      leds = 16'b1111_1011_1111_1111;
            5'd12:      leds = 16'b1111_0111_1111_1111;
            5'd13:      leds = 16'b1110_1111_1111_1111;
            5'd14:      leds = 16'b1101_1111_1111_1111;
            5'd15:      leds = 16'b1011_1111_1111_1111;
            5'd16:      leds = 16'b0111_1111_1111_1111;
            default:    leds = 16'b1111_1111_1111_1111;
        endcase
    end
    reg [5:0] state = 'b0;
    always@(posedge clk) begin
        // 根据state转换输出时序
        case(state)
            'd0:    sdi <= leds[0];
            'd1:    led_clk <= 'b1;
            'd2:    begin led_clk <= 'b0; sdi <= leds[1]; end
            'd3:    led_clk <= 'b1;
            'd4:    begin led_clk <= 'b0; sdi <= leds[2]; end
            'd5:    led_clk <= 'b1;
            'd6:    begin led_clk <= 'b0; sdi <= leds[3]; end
            'd7:    led_clk <= 'b1;
            'd8:    begin led_clk <= 'b0; sdi <= leds[4]; end
            'd9:    led_clk <= 'b1;
            'd10:   begin led_clk <= 'b0; sdi <= leds[5]; end
            'd11:   led_clk <= 'b1;
            'd12:   begin led_clk <= 'b0; sdi <= leds[6]; end
            'd13:   led_clk <= 'b1;
            'd14:   begin led_clk <= 'b0; sdi <= leds[7]; end
            'd15:   led_clk <= 'b1;
            'd16:   begin led_clk <= 'b0; sdi <= leds[8]; end
            'd17:   led_clk <= 'b1;
            'd18:   begin led_clk <= 'b0; sdi <= leds[9]; end
            'd19:   led_clk <= 'b1;
            'd20:   begin led_clk <= 'b0; sdi <= leds[10]; end
            'd21:   led_clk <= 'b1;
            'd22:   begin led_clk <= 'b0; sdi <= leds[11]; end
            'd23:   led_clk <= 'b1;
            'd24:   begin led_clk <= 'b0; sdi <= leds[12]; end
            'd25:   led_clk <= 'b1;
            'd26:   begin led_clk <= 'b0; sdi <= leds[13]; end
            'd27:   led_clk <= 'b1;
            'd28:   begin led_clk <= 'b0; sdi <= leds[14]; end
            'd29:   led_clk <= 'b1;
            'd30:   begin led_clk <= 'b0; sdi <= leds[15]; end
            'd31:   led_clk <= 'b1;
            'd32:   begin led_clk <= 'b0; sdi <= leds[16]; end
            'd33:   begin  oe <= 'b1; end
            'd34:   begin led_clk <= 'b0;  end
            'd35:   begin le <= 'b1; end
            'd36:   begin le <= 'b0; oe <= 'b0; end
            default: sdi <= 'b0;
        endcase
    end
    always@(posedge clk) begin
        // state加法
        if(!rstn || (state >= 'd37)) begin
            state <= 'b0;
        end else begin
            state <= state + 1'b1;
        end
    end
    
endmodule
