module spi_master_slave_top #(
    parameter CLK_DIV = 4
)(
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    input  logic [7:0] master_tx_data,
    input  logic [7:0] slave_tx_data,

    output logic [7:0] master_rx_data,
    output logic [7:0] slave_rx_data,
    output logic       busy,
    output logic       done,
    output logic       spi_sclk,
    output logic       spi_mosi,
    output logic       spi_miso,
    output logic       spi_cs_n
);

    logic [7:0] master_rx;
    logic [7:0] slave_rx;
    logic       master_busy;
    logic       master_done;
    logic       master_sclk;
    logic       master_mosi;
    logic       master_cs_n;
    logic       slave_miso;
    logic       slave_done;

    spi_master #(
        .CLK_DIV(CLK_DIV)
    ) master_inst (
        .clk(clk),
        .rst(rst),
        .start(start),
        .tx_data(master_tx_data),
        .miso(slave_miso),
        .rx_data(master_rx),
        .busy(master_busy),
        .done(master_done),
        .sclk(master_sclk),
        .mosi(master_mosi),
        .cs_n(master_cs_n)
    );

    spi_slave slave_inst (
        .clk(clk),
        .rst(rst),
        .cs_n(master_cs_n),
        .sclk(master_sclk),
        .mosi(master_mosi),
        .tx_data(slave_tx_data),
        .miso(slave_miso),
        .rx_data(slave_rx),
        .done(slave_done)
    );

    assign master_rx_data = master_rx;
    assign slave_rx_data  = slave_rx;
    assign busy           = master_busy;
    assign done           = master_done;
    assign spi_sclk       = master_sclk;
    assign spi_mosi       = master_mosi;
    assign spi_miso       = slave_miso;
    assign spi_cs_n       = master_cs_n;

endmodule
