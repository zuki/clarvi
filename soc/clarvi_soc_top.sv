module clarvi_soc_top (
    input  logic        CLK12M,
    input  logic        USER_BTN,
    output logic [7:0]  LED,
    output logic [11:0] DRAM_ADDR,
    output logic [1:0]  DRAM_BA,
    output logic        DRAM_CAS_N,
    output logic        DRAM_CKE,
    output logic        DRAM_CLK,
    output logic        DRAM_CS_N,
    inout  logic [15:0] DRAM_DQ,
    output logic        DRAM_LDQM,  // DQM0
    output logic        DRAM_RAS_N,
    output logic        DRAM_UDQM,  // DQM1
    output logic        DRAM_WE_N,
    input  logic        UART_RX,
    output logic        UART_TX
    );

    logic CLK50, sdram_clk;

    pll u1 (
        .inclk0(CLK12M),
        .c0(CLK50),
        .c1(sdram_clk),
        .c2(DRAM_CLK)
    );

    clarvi_soc u0 (
        .clk_clk         (CLK50),
        .sdram_clock_clk (sdram_clk),
        .reset_reset_n   (USER_BTN),
        .sdram_addr      (DRAM_ADDR),
        .sdram_ba        (DRAM_BA),
        .sdram_cas_n     (DRAM_CAS_N),
        .sdram_cke       (DRAM_CKE),
        .sdram_cs_n      (DRAM_CS_N),
        .sdram_dq        (DRAM_DQ),
        .sdram_dqm       ({DRAM_UDQM,DRAM_LDQM}),
        .sdram_ras_n     (DRAM_RAS_N),
        .sdram_we_n      (DRAM_WE_N),
        .uart_rxd        (UART_RX),
        .uart_txd        (UART_TX),
        .pio_export      (LED)
    );

endmodule
