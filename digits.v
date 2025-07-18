module digits(
    input clk, reset,
    input BJP_FIG, CONG_FIG, NOTA_FIG,
    input [9:0] BJP_COUNT, NOTA_COUNT, CONG_COUNT,
    output reg [3:0] ones, tens, hundreds, thousands
);
    reg [9:0] temp_count;
    
    always @(posedge clk) begin
        if(reset) begin
            temp_count <= 0;
        end else begin
            case({BJP_FIG, CONG_FIG, NOTA_FIG})
                3'b100: temp_count <= BJP_COUNT;
                3'b010: temp_count <= CONG_COUNT;
                3'b001: temp_count <= NOTA_COUNT;
                default: temp_count <= 0;
            endcase
        end
    end
    
    always @* begin
        ones = temp_count % 10;
        tens = (temp_count / 10) % 10;
        hundreds = (temp_count / 100) % 10;
        thousands = (temp_count / 1000) % 10;
    end
endmodule
