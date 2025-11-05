`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 22:20:35
// Design Name: 
// Module Name: encoder_cw_ccw
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

// 编码器型号：EC11E1834403
// 脉冲数：18
// 默认在18，反转最小减少到0，正转最大增加到36

module encoder_cw_ccw(
    input wire clk,
    input wire A,
    input wire B,
    
    output reg cw = 'b0,
    output reg ccw = 'b0
    );
    reg negedgeA = 'b0;
    reg [20:0] counter = 'b0;
    reg buf_clk = 'b0;
    always@(posedge clk) begin
        if(counter >= 'd50_000) begin  // 此处为1毫秒计数器，按照时钟调整，我们的时钟是50MHz
            counter <= 'b0;
            buf_clk <= 'b1;
        end else begin
            counter <= counter + 'b1;
            buf_clk <= 'b0;
        end
    end
    reg buf_A = 'b0;
    reg last_time_A = 'b0;
    always@(posedge clk) begin  // A信号去抖
        if(buf_clk == 'b1) begin
            if(A == last_time_A) begin
                buf_A <= A;
            end
            last_time_A <= A;
        end
    end
    reg buf_B = 'b0;
    reg last_time_B = 'b0;
    always@(posedge clk) begin  // B信号去抖
        if(buf_clk == 'b1) begin
            if(B == last_time_B) begin
                buf_B <= B;
            end
            last_time_B <= B;
        end
    end
    
    reg lastA = 'b0;
    always@(posedge clk) begin  // A下降沿检测
        if(lastA != buf_A) begin
            if(buf_A == 'b0) begin
                negedgeA <= 'b1;
            end
        end else begin
            negedgeA <= 'b0;
        end
        lastA <= buf_A;
    end
    always@(posedge clk) begin  // 在A下降沿的时候检测B状态来判断正反转
        if(negedgeA == 'b1) begin
            if(buf_B == 'b0) begin
                cw <= 'b0;
                ccw <= 'b1;
            end else begin
                cw <= 'b1;
                ccw <= 'b0;
            end
        end
    end
    
endmodule
