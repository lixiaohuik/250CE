module test;
  reg[39:0] io_signalIn_real = 0;
  reg[39:0] io_signalIn_imag = 0;
  wire[39:0] io_signalOut_real;
  wire[39:0] io_signalOut_imag;
  reg clk = 0;
  reg reset = 1;
  integer clk_len;
  always #clk_len clk = ~clk;
  reg vcdon = 0;
  reg [1023:0] vcdfile = 0;
  reg [1023:0] vpdfile = 0;

  /*** DUT instantiation ***/
  CE CE(
    .clk(clk),
    .reset(reset),
    .io_signalIn_real(io_signalIn_real),
    .io_signalIn_imag(io_signalIn_imag),
    .io_signalOut_real(io_signalOut_real),
    .io_signalOut_imag(io_signalOut_imag));

  initial begin
    clk_len = `CLOCK_PERIOD;
    $init_clks(clk_len);
    $init_rsts(reset);
    $init_ins(io_signalIn_real, io_signalIn_imag);
    $init_outs(io_signalOut_real, io_signalOut_imag);
    $init_sigs(CE);
    /*** VCD & VPD dump ***/
    if ($value$plusargs("vcdfile=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, CE);
      $dumpoff;
      vcdon = 0;
    end
    if ($value$plusargs("vpdfile=%s", vpdfile)) begin
      $vcdplusfile(vpdfile);
      $vcdpluson(0);
      $vcdplusautoflushon;
    end
    if ($test$plusargs("vpdmem")) begin
      $vcdplusmemon;
    end
  end

  always @(negedge clk) begin
    $tick();
    if (vcdfile && (reset)) begin
      $dumpoff;
      vcdon = 0;
    end
    else if (vcdfile && !vcdon) begin
      $dumpon;
      vcdon = 1;
    end
  end

endmodule
