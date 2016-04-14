module test;
  reg[18:0] io_Vout = 0;
  reg[18:0] io_Vref = 0;
  reg[18:0] io_delta = 0;
  wire[18:0] io_G;
  reg clk = 0;
  reg reset = 1;
  integer clk_len;
  always #clk_len clk = ~clk;
  reg vcdon = 0;
  reg [1023:0] vcdfile = 0;
  reg [1023:0] vpdfile = 0;

  /*** DUT instantiation ***/
  AGC AGC(
    .clk(clk),
    .reset(reset),
    .io_Vout(io_Vout),
    .io_Vref(io_Vref),
    .io_delta(io_delta),
    .io_G(io_G));

  initial begin
    clk_len = `CLOCK_PERIOD;
    $init_clks(clk_len);
    $init_rsts(reset);
    $init_ins(io_Vout, io_Vref, io_delta);
    $init_outs(io_G);
    $init_sigs(AGC);
    /*** VCD & VPD dump ***/
    if ($value$plusargs("vcdfile=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, AGC);
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
