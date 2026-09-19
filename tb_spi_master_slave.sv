`timescale 1ns/1ps

module tb_spi_master_slave;

    logic       clk;
    logic       rst;
    logic       start;
    logic [7:0] master_tx_data;
    logic [7:0] slave_tx_data;

    logic [7:0] master_rx_data;
    logic [7:0] slave_rx_data;
    logic       busy;
    logic       done;
    logic       spi_sclk;
    logic       spi_mosi;
    logic       spi_miso;
    logic       spi_cs_n;

    spi_master_slave_top #(
        .CLK_DIV(4)
    ) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .master_tx_data(master_tx_data),
        .slave_tx_data(slave_tx_data),
        .master_rx_data(master_rx_data),
        .slave_rx_data(slave_rx_data),
        .busy(busy),
        .done(done),
        .spi_sclk(spi_sclk),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .spi_cs_n(spi_cs_n)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("spi.vcd");
        $dumpvars(0, tb_spi_master_slave);

        rst = 1'b1;
        start = 1'b0;
        master_tx_data = 8'hA5;
        slave_tx_data = 8'h3C;

        #30;
        rst = 1'b0;

        #20;
        start = 1'b1;

        #10;
        start = 1'b0;

        wait(done);

        #20;

        $display("Master TX Data = %h", master_tx_data);
        $display("Slave TX Data  = %h", slave_tx_data);
        $display("Master RX Data = %h", master_rx_data);
        $display("Slave RX Data  = %h", slave_rx_data);

        if (master_rx_data == slave_tx_data)
            $display("MASTER RX TEST: PASS");
        else
            $display("MASTER RX TEST: FAIL");

        if (slave_rx_data == master_tx_data)
            $display("SLAVE RX TEST: PASS");
        else
            $display("SLAVE RX TEST: FAIL");

        #20;
        $finish;
    end

endmodule
