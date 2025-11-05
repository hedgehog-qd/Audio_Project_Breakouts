`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/13 00:04:19
// Design Name: 
// Module Name: mbi5124_shiftout
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


module mbi5124_shiftout(
    input wire clk,
    input wire rstn,
    input wire [15:0] leds,  // 高位在前
    
    output reg sdi = 'b0,
    output reg le = 'b0,
    output reg oe = 'b1,
    output reg led_clk = 'b0
    );
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
