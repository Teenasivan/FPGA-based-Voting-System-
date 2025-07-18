module voting_machine(
    input clk, reset,
    input BJP, CONG, NOTA,
    input BJP_FIG, CONG_FIG, NOTA_FIG,
    output BJP_CONF, CONG_CONF, NOTA_CONF,
    output [0:6] seg,
    output [3:0] digit
);
    parameter CONFIRM_TIME = 50_000_000;  // Key parameter
    
    reg [9:0] BJP_COUNT=0, NOTA_COUNT=0, CONG_COUNT=0;
    wire [3:0] ones,tens,hundreds,thousands;
    
    digits digits_inst(clk,reset,BJP_FIG,CONG_FIG,NOTA_FIG,
                     BJP_COUNT,NOTA_COUNT,CONG_COUNT,
                     ones,tens,hundreds,thousands);
    seven_seg display(clk,reset,ones,tens,hundreds,thousands,seg,digit);
    
    reg [31:0] counter = 0;
    reg [2:0] state = 0;
    
    assign BJP_CONF = (state == 1);
    assign CONG_CONF = (state == 2);
    assign NOTA_CONF = (state == 3);
    
    always @(posedge clk) begin
        if(reset) begin
            BJP_COUNT <= 0;
            CONG_COUNT <= 0;
            NOTA_COUNT <= 0;
            counter <= 0;
            state <= 0;
        end else begin
            case(state)
                0: begin  // Idle
                    if(BJP) begin
                        counter <= 0;
                        state <= 1;
                    end else if(CONG) begin
                        counter <= 0;
                        state <= 2;
                    end else if(NOTA) begin
                        counter <= 0;
                        state <= 3;
                    end
                end
                
                1: begin  // BJP
                    if(counter < CONFIRM_TIME) begin
                        counter <= counter + 1;
                    end else begin
                        BJP_COUNT <= BJP_COUNT + 1;
                        state <= 0;
                    end
                end
                
                2: begin  // CONG
                    if(counter < CONFIRM_TIME) begin
                        counter <= counter + 1;
                    end else begin
                        CONG_COUNT <= CONG_COUNT + 1;
                        state <= 0;
                    end
                end
                
                3: begin  // NOTA
                    if(counter < CONFIRM_TIME) begin
                        counter <= counter + 1;
                    end else begin
                        NOTA_COUNT <= NOTA_COUNT + 1;
                        state <= 0;
                    end
                end
            endcase
        end
    end
endmodule