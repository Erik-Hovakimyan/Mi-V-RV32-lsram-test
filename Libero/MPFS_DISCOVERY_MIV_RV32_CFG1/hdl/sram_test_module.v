module sram_test_module(
    input               clk,
    input               rst_n,

    input               start_test,
    input               clr_status,

    input       [19:0]  data_read_portA,

    output              wen_portA,
    output reg  [9:0]   addr_portA,
    output reg  [19:0]  data_write_portA,

    output reg          error_latch,
    output reg          done_latch,
    output reg          done_irq
);

    parameter [19:0] INIT_VAL_ADDR0 = 20'h74D0D;
    parameter [19:0] INC_VAL        = 20'd2;
    parameter [9:0]  LAST_ADDR      = 10'd1023;

    // READ ONLY (do not overwrite init)
    // Based on your evidence, WEN=0 disables write (active-high enable),
    // so keep it at 0 for read-only.
    assign wen_portA = 1'b0;

    always @(*) data_write_portA = 20'd0;

    // start pulse sync
    reg st0, st1, st_prev;
    always @(posedge clk) begin
        if(!rst_n) begin st0<=0; st1<=0; st_prev<=0; end
        else begin st0<=start_test; st1<=st0; st_prev<=st1; end
    end
    wire start_pulse = st1 & ~st_prev;

    localparam IDLE  = 2'd0;
    localparam SETUP = 2'd1;
    localparam CHECK = 2'd2;

    reg [1:0]  state;
    reg [19:0] expected;
    reg [1:0]  wait_cnt;

    // sample register
    reg [19:0] rd_sample;

    always @(posedge clk) begin
        if(!rst_n) begin
            state      <= IDLE;
            addr_portA <= 10'd0;
            expected   <= INIT_VAL_ADDR0;
            wait_cnt   <= 2'd0;
            rd_sample  <= 20'd0;

            error_latch <= 1'b0;
            done_latch  <= 1'b0;
            done_irq    <= 1'b0;
        end else begin

            if (clr_status) begin
                error_latch <= 1'b0;
                done_latch  <= 1'b0;
                done_irq    <= 1'b0;
            end

            case(state)
                IDLE: begin
                    addr_portA <= 10'd0;
                    expected   <= INIT_VAL_ADDR0;
                    wait_cnt   <= 2'd0;

                    if(start_pulse) begin
                        // clear results for this run
                        error_latch <= 1'b0;
                        done_latch  <= 1'b0;
                        done_irq    <= 1'b0;

                        state <= SETUP;
                    end
                end

                // put address, then wait a couple cycles for data to become valid
                SETUP: begin
                    if (wait_cnt != 2'd2)
                        wait_cnt <= wait_cnt + 1'b1;
                    else begin
                        wait_cnt <= 2'd0;
                        state <= CHECK;
                    end
                end

                // sample and compare, then increment address
                CHECK: begin
                    rd_sample <= data_read_portA;

                    if (data_read_portA != expected)
                        error_latch <= 1'b1;

                    if (addr_portA == LAST_ADDR) begin
                        done_latch <= 1'b1;
                        done_irq   <= 1'b1;
                        state <= IDLE;
                    end else begin
                        addr_portA <= addr_portA + 10'd1;
                        expected   <= expected + INC_VAL;
                        state <= SETUP;
                    end
                end
            endcase
        end
    end

endmodule