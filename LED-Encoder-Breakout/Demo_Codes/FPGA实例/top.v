`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/10 21:30:12
// Design Name: 
// Module Name: top
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


module top(
    input wire clk,
    // Encoder
    input wire enc_sw,
    input wire enc_A,
    input wire enc_B,
    // MBI5124
    output wire mbi_clk,
    output wire mbi_sdi,
    output wire mbi_le,
    output wire mbi_oe,  // active low
    // Test LED (CW & CCW)
    output wire led0,
    output wire led1
    );
    
    wire axis_clk;
    
    clk_wiz_0 clk_wiz(  // axis_clk => 50MHz
        .clk_in1(clk),
        .axis_clk(axis_clk)
    );
    
    reg [4:0] value = 'b0;
    wire [5:0] data;
    encoder encoderctrl(
        .clk(axis_clk),
        .A(enc_A),
        .B(enc_B),
        .cw(led0),
        .ccw(led1),
        .data(data)
    );
    reg [15:0] leds = 'b0;
    mbi5124_shiftout ledsctrl(
        .clk(axis_clk),
        .rstn(1'b1),
        .leds(leds),
        .led_clk(mbi_clk),
        .sdi(mbi_sdi),
        .le(mbi_le),
        .oe(mbi_oe)
    );
    always@(posedge axis_clk) begin
        case(data)  // Edit LED style here
            6'd0:       leds = 16'b1111_1111_1111_1111;
            6'd1:       leds = 16'b1111_1111_1111_1111;
            6'd2:       leds = 16'b1111_1111_1111_1111;
            6'd3:       leds = 16'b1111_1111_1111_1110;
            6'd4:       leds = 16'b1111_1111_1111_1100;
            6'd5:       leds = 16'b1111_1111_1111_1000;
            6'd6:       leds = 16'b1111_1111_1111_0000;
            6'd7:       leds = 16'b1111_1111_1110_0000;
            6'd8:       leds = 16'b1111_1111_1100_0000;
            6'd9:       leds = 16'b1111_1111_1000_0000;
            6'd10:      leds = 16'b1111_1111_0000_0000;
            6'd11:      leds = 16'b1111_1110_0000_0000;
            6'd12:      leds = 16'b1111_1100_0000_0000;
            6'd13:      leds = 16'b1111_1000_0000_0000;
            6'd14:      leds = 16'b1111_0000_0000_0000;
            6'd15:      leds = 16'b1110_0000_0000_0000;
            6'd16:      leds = 16'b1100_0000_0000_0000;
            6'd17:      leds = 16'b1000_0000_0000_0000;
            6'd18:      leds = 16'b0000_0000_0000_0000;  // Default - All OFF
            6'd19:      leds = 16'b0000_0000_0000_0001;
            6'd20:      leds = 16'b0000_0000_0000_0011;
            6'd21:      leds = 16'b0000_0000_0000_0111;
            6'd22:      leds = 16'b0000_0000_0000_1111;
            6'd23:      leds = 16'b0000_0000_0001_1111;
            6'd24:      leds = 16'b0000_0000_0011_1111;
            6'd25:      leds = 16'b0000_0000_0111_1111;
            6'd26:      leds = 16'b0000_0000_1111_1111;
            6'd27:      leds = 16'b0000_0001_1111_1111;
            6'd28:      leds = 16'b0000_0011_1111_1111;
            6'd29:      leds = 16'b0000_0111_1111_1111;
            6'd30:      leds = 16'b0000_1111_1111_1111;
            6'd31:      leds = 16'b0001_1111_1111_1111;
            6'd32:      leds = 16'b0011_1111_1111_1111;
            6'd33:      leds = 16'b0111_1111_1111_1111;
            6'd34:      leds = 16'b1111_1111_1111_1111;
            6'd35:      leds = 16'b1111_1111_1111_1111;
            6'd36:      leds = 16'b1111_1111_1111_1111;
            default:    leds = 16'b0000_0000_0000_0000;
        endcase
    end
    
    
endmodule
