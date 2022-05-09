`timescale 1ns / 1ps


module max_finder #(parameter INDATA_WIDTH = 47, NN4=10, PREVLAYER_COUNT =10)(
    input clk,find_max,
    input [INDATA_WIDTH-1:0]input_data,
    input valid_input,
    input reset,
    output reg [3:0]predicted_output,
    output reg found_max
    );
    reg [0:INDATA_WIDTH-1]max;
    reg [0:3]index;
    reg [0:3] address;
    reg x,y;
    integer correction=0;
    always @(negedge clk)
    begin
        if(reset)
        begin
        address=0;
        index=0;
        y=0;
        x=0;
        correction=correction+1;
        found_max=0;
        end
          if(find_max && (!valid_input) && (found_max==0)&& (input_data!==28'bx))
          begin
             if(x==0)
             begin
                max=input_data;
                x=1;
                index=0;
             end
            if(max<input_data)
                begin
                max=input_data;
                index=address;
                end
             address = address+1;
             if(address==10)
             found_max=1;
          end
         if(found_max)
         begin
         if(correction==0)
         predicted_output= index;
         else if(correction >1)
         predicted_output= index-2;
         max=0;
         end
            
        end
endmodule
