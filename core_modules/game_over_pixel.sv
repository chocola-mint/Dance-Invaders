module game_over_pixel(
    input clk,
    input [9:0] h_cnt,
    input [9:0] v_cnt,
    output logic [11:0] pixel_out,
    output logic valid
    );
    logic [5:0] mem_txt_addr;
    reg reg_h_cnt_compressed;
    reg reg_v_cnt_compressed;
    parameter G = 16;
    parameter A = 10;
    parameter M = 22;
    parameter E = 14;
    parameter O = 24;
    parameter V = 25;
    parameter R = 31;
    always @* begin
        valid=0;
        mem_txt_addr=0;
        reg_h_cnt_compressed=0;
        reg_v_cnt_compressed=0;
        if(v_cnt>=28&&v_cnt<140) begin
        if(h_cnt>=160&&h_cnt<240) begin
            mem_txt_addr=G;
            reg_h_cnt_compressed=(h_cnt-160)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        else if(h_cnt>=240&&h_cnt<320) begin
            reg_h_cnt_compressed=(h_cnt-240)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            mem_txt_addr=A;
            valid=1;
        end
        else if(h_cnt>=320&&h_cnt<400) begin
            mem_txt_addr=M;
            reg_h_cnt_compressed=(h_cnt-320)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        else if(h_cnt>=400&&h_cnt<480)begin
            mem_txt_addr=E;
            reg_h_cnt_compressed=(h_cnt-400)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        end



        else if(v_cnt>=160&&v_cnt<272) begin
            if(h_cnt>=160&&h_cnt<240) begin
            mem_txt_addr=O;
            reg_h_cnt_compressed=(h_cnt-160)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        else if(h_cnt>=240&&h_cnt<320) begin
            reg_h_cnt_compressed=(h_cnt-240)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            mem_txt_addr=V;
            valid=1;
        end
        else if(h_cnt>=320&&h_cnt<400) begin
            mem_txt_addr=E;
            reg_h_cnt_compressed=(h_cnt-320)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        else if(h_cnt>=400&&h_cnt<480)begin
            mem_txt_addr=R;
            reg_h_cnt_compressed=(h_cnt-400)>>4;
            reg_v_cnt_compressed=(v_cnt-28)>>4;
            valid=1;
        end
        end
    end
    memory_txt over(
        .clk(clk),
        .txt_addr(mem_txt_addr),
        .h_point(wire_h_cnt_compressed),
        .v_point(wire_v_cnt_compressed),
        .pixel(pixel_out)
    );

endmodule