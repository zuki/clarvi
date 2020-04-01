module clarvi_soc_top (
    input  logic        CLK12M,
    input  logic        USER_BTN,
    output logic [7:0]  LED,
    input  logic        UART_RX,
    output logic        UART_TX
    );

    logic CLK50;

    pll u1 (
        .inclk0(CLK12M),
        .c0(CLK50)
    );

    clarvi_soc u0 (
        .clk_clk       (CLK50),
        .reset_reset_n (USER_BTN),
        .uart_rxd      (UART_RX),
        .uart_txd      (UART_TX),
        .pio_export    (LED) 
    );

endmodule
