`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/01 15:54:03
// Design Name: Mother Board
// Module Name: mother_board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The top module of the central board.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`include "typedefs.svh"
`include "constants.svh"

module mother_board(
    input clk,
    input rst,
    input RxD,
    output [15:0] led,
    output [3:0] DIGIT,
    output [6:0] DISPLAY,
    
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync
    
    );
    
    wire [MESSAGE_SIZE-1:0] datagram;
    control_core (
    .clk(clk),
    .rst(rst),
    .RxD(RxD),
    .datagram(datagram),
    .led(led),
    .DIGIT(DIGIT),
    .DISPLAY(DISPLAY)
    );
    wire packet_valid = 1;
    /*
    wire ctrl_req;
    wire interface_ack;
    wire [5:0] ctrl_out;
    sender #(.n(MESSAGE_SIZE))
    (
    .clk_sender(clk),
    .wire_ack(interface_ack),
    .wire_data_in(datagram),
    .rst(rst),
    .reg_data_out(ctrl_out),
    .reg_req(ctrl_req)
    );
    
    wire [MESSAGE_SIZE-1:0] recv_data;
    receiver #(.n(MESSAGE_SIZE))
    (
    .clk_receiver(clk),
    .wire_req(ctrl_req),
    .wire_data_deliver(ctrl_out),
    .wire_data_out(recv_data),
    .reg_ack(interface_ack),
    .reg_valid(packet_valid)
    );
    */
    reg [MESSAGE_SIZE-1:0] reg_datagram;
    always @(posedge clk) begin
        if(rst) reg_datagram <= 0;
        else if(packet_valid) reg_datagram <= datagram;
    end
    
    output_interface(
    .clk(clk),
    .rst(rst),
    .datagram(reg_datagram),
    .vgaRed(vgaRed),
    .vgaGreen(vgaGreen),
    .vgaBlue(vgaBlue),
    .hsync(hsync),
    .vsync(vsync)
    );
    
    
endmodule