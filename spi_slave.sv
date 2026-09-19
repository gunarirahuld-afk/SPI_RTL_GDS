module spi_slave (
    input  logic       clk,
    input  logic       rst,
    input  logic       cs_n,
    input  logic       sclk,
    input  logic       mosi,
    input  logic [7:0] tx_data,

    output logic       miso,
    output logic [7:0] rx_data,
    output logic       done
);

    logic [7:0] tx_shift;
    logic [7:0] rx_shift;
    logic [2:0] bit_count;
    logic       cs_n_d;
    logic       sclk_d;

    wire cs_active = ~cs_n;
    wire cs_start  = cs_n_d & ~cs_n;
    wire sclk_rise = sclk & ~sclk_d;
    wire sclk_fall = ~sclk & sclk_d;

    always_ff @(posedge clk) begin
        if (rst) begin
            tx_shift <= 8'b0;
            rx_shift <= 8'b0;
            rx_data <= 8'b0;
            bit_count <= 3'b0;
            miso <= 1'b0;
            done <= 1'b0;
            cs_n_d <= 1'b1;
            sclk_d <= 1'b0;
        end
        else begin
            cs_n_d <= cs_n;
            sclk_d <= sclk;
            done <= 1'b0;

            if (cs_start) begin
                tx_shift <= tx_data;
                rx_shift <= 8'b0;
                bit_count <= 3'b0;
                miso <= tx_data[7];
            end
            else if (!cs_active) begin
                miso <= 1'b0;
                bit_count <= 3'b0;
            end
            else begin
                if (sclk_rise) begin
                    rx_shift <= {rx_shift[6:0], mosi};

                    if (bit_count == 3'd7) begin
                        rx_data <= {rx_shift[6:0], mosi};
                        done <= 1'b1;
                    end
                end

                if (sclk_fall) begin
                    if (bit_count != 3'd7) begin
                        bit_count <= bit_count + 1'b1;
                        tx_shift <= {tx_shift[6:0], 1'b0};
                        miso <= tx_shift[6];
                    end
                end
            end
        end
    end

endmodule
