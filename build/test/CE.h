#ifndef __CE__
#define __CE__

#include "emulator.h"

class CE_t : public mod_t {
 private:
  val_t __rand_seed;
  void __srand(val_t seed) { __rand_seed = seed; }
  val_t __rand_val() { return ::__rand_val(&__rand_seed); }
 public:
  dat_t<1> reset;
  dat_t<32> T109;
  dat_t<32> CE__sigCount;
  dat_t<32> T113;
  dat_t<32> CE__PTCount;
  dat_t<34> T99;
  dat_t<34> CE__stored_Weight_r_1;
  dat_t<34> T103;
  dat_t<34> CE__stored_Weight_r_0;
  dat_t<34> T206;
  dat_t<34> CE__stored_Weight_i_1;
  dat_t<34> T210;
  dat_t<34> CE__stored_Weight_i_0;
  dat_t<40> CE__io_signalIn_real;
  dat_t<40> CE__io_signalOut_real;
  dat_t<40> CE__io_signalIn_imag;
  dat_t<40> CE__io_signalOut_imag;
    static const val_t T20[2];
    static const val_t T71[2];
  clk_t clk;

  void init ( val_t rand_init = 0 );
  void clock_lo ( dat_t<1> reset, bool assert_fire=true );
  void clock_hi ( dat_t<1> reset );
  int clock ( dat_t<1> reset );
  void print ( FILE* f );
  void print ( std::ostream& s );
  void dump ( FILE* f, int t, dat_t<1> reset=LIT<1>(0) );
  void dump_init ( FILE* f );

};

#include "emul_api.h"
class CE_api_t : public emul_api_t {
 public:
  CE_api_t(mod_t* m) : emul_api_t(m) { }
  void init_sim_data();
};

#endif
