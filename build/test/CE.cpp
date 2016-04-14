#include "CE.h"

const val_t CE_t::T71[] = {0x0L, 0x0L};
const val_t CE_t::T20[] = {0x0L, 0x0L};

void CE_t::init ( val_t rand_init ) {
  this->__srand(rand_init);
  CE__stored_Weight_r_1.randomize(&__rand_seed);
  CE__stored_Weight_r_0.randomize(&__rand_seed);
  CE__sigCount.randomize(&__rand_seed);
  CE__PTCount.randomize(&__rand_seed);
  CE__stored_Weight_i_1.randomize(&__rand_seed);
  CE__stored_Weight_i_0.randomize(&__rand_seed);
  clk.len = 1;
  clk.cnt = 0;
  clk.values[0] = 0;
}


int CE_t::clock ( dat_t<1> reset ) {
  uint32_t min = ((uint32_t)1<<31)-1;
  if (clk.cnt < min) min = clk.cnt;
  clk.cnt-=min;
  if (clk.cnt == 0) clock_lo( reset );
  if (clk.cnt == 0) clock_hi( reset );
  if (clk.cnt == 0) clk.cnt = clk.len;
  return min;
}


void CE_t::print ( FILE* f ) {
}
void CE_t::print ( std::ostream& s ) {
}


void CE_t::dump_init ( FILE* f ) {
}


void CE_t::dump ( FILE* f, int t, dat_t<1> reset ) {
}




void CE_t::clock_lo ( dat_t<1> reset, bool assert_fire ) {
  val_t T0;
  T0 = (CE__io_signalIn_real.values[0] >> 39) & 1;
  val_t T1;
  { T1 = CE__io_signalIn_real.values[0] | T0 << 40;}
  val_t T2;
  { T2 = 0x0L-T1;}
  T2 = T2 & 0x1ffffffffffL;
  val_t T3;
  T3 = (T1 >> 40) & 1;
  val_t T4;
  { T4 = TERNARY_1(T3, T2, T1);}
  val_t T5;
  { T5 = 0x0L-CE__io_signalIn_real.values[0];}
  T5 = T5 & 0xffffffffffL;
  val_t T6;
  T6 = (CE__io_signalIn_real.values[0] >> 39) & 1;
  val_t T7;
  { T7 = TERNARY_1(T6, T5, CE__io_signalIn_real.values[0]);}
  val_t T8;
  T8 = (CE__PTCount.values[0] >> 0) & 1;
  val_t T9;
  { T9 = TERNARY_1(T8, CE__stored_Weight_r_1.values[0], CE__stored_Weight_r_0.values[0]);}
  val_t T10;
  T10 = (T9 >> 33) & 1;
  val_t T11;
  { T11 = T10 | T10 << 1;}
  val_t T12;
  { T12 = T11 | T11 << 2;}
  val_t T13;
  { T13 = T12 | T11 << 4;}
  val_t T14;
  { T14 = T9 | T13 << 34;}
  val_t T15;
  { T15 = 0x0L-T14;}
  T15 = T15 & 0xffffffffffL;
  val_t T16;
  T16 = (T14 >> 39) & 1;
  val_t T17;
  { T17 = TERNARY_1(T16, T15, T14);}
  val_t T18[2];
  *reinterpret_cast<dat_t<80>*>(&T18) = *reinterpret_cast<dat_t<40>*>(&T17) * *reinterpret_cast<dat_t<40>*>(&T7);
  val_t T19[2];
  { T19[0] = T20[0]-T18[0]; val_t __c = T20[0]-T18[0] > T20[0]; T19[1] = T20[1]-T18[1]-__c;}
  T19[1] = T19[1] & 0xffffL;
  val_t T21;
  { T21 = T16 ^ T6;}
  val_t T22[2];
  { T22[0] = TERNARY_1(T21, T19[0], T18[0]); T22[1] = TERNARY_1(T21, T19[1], T18[1]);}
  val_t T23[2];
  { T23[0] = T22[0]; T23[1] = T22[1];}
  T23[1] = T23[1] & 0x1ffL;
  val_t T24;
  { T24 = T23[0] >> 32 | T23[1] << 32;}
  T24 = T24 & 0x1ffffffffffL;
  val_t T25;
  T25 = (T24 >> 40) & 1;
  val_t T26;
  { T26 = TERNARY(T25, 0xffffffL, 0x0L);}
  val_t T27[2];
  { T27[0] = T24 | T26 << 41; T27[1] = T26 >> 23;}
  val_t T28;
  { T28 = T27[0];}
  T28 = T28 & 0x1ffffffffffL;
  val_t T29;
  { T29 = T28;}
  T29 = T29 & 0xffffffffffL;
  val_t T30;
  { T30 = 0x0L-CE__io_signalIn_real.values[0];}
  T30 = T30 & 0xffffffffffL;
  val_t T31;
  T31 = (CE__io_signalIn_real.values[0] >> 39) & 1;
  val_t T32;
  { T32 = TERNARY_1(T31, T30, CE__io_signalIn_real.values[0]);}
  val_t T33;
  T33 = (T9 >> 33) & 1;
  val_t T34;
  { T34 = T33 | T33 << 1;}
  val_t T35;
  { T35 = T34 | T34 << 2;}
  val_t T36;
  { T36 = T35 | T34 << 4;}
  val_t T37;
  { T37 = T9 | T36 << 34;}
  val_t T38;
  { T38 = 0x0L-T37;}
  T38 = T38 & 0xffffffffffL;
  val_t T39;
  T39 = (T37 >> 39) & 1;
  val_t T40;
  { T40 = TERNARY_1(T39, T38, T37);}
  val_t T41[2];
  *reinterpret_cast<dat_t<80>*>(&T41) = *reinterpret_cast<dat_t<40>*>(&T40) * *reinterpret_cast<dat_t<40>*>(&T32);
  val_t T42[2];
  { T42[0] = T20[0]-T41[0]; val_t __c = T20[0]-T41[0] > T20[0]; T42[1] = T20[1]-T41[1]-__c;}
  T42[1] = T42[1] & 0xffffL;
  val_t T43;
  { T43 = T39 ^ T31;}
  val_t T44[2];
  { T44[0] = TERNARY_1(T43, T42[0], T41[0]); T44[1] = TERNARY_1(T43, T42[1], T41[1]);}
  val_t T45[2];
  { T45[0] = T44[0]; T45[1] = T44[1];}
  T45[1] = T45[1] & 0x1ffL;
  val_t T46;
  { T46 = T45[0] >> 32 | T45[1] << 32;}
  T46 = T46 & 0x1ffffffffffL;
  val_t T47;
  T47 = (T46 >> 40) & 1;
  val_t T48;
  { T48 = TERNARY(T47, 0xffffffL, 0x0L);}
  val_t T49[2];
  { T49[0] = T46 | T48 << 41; T49[1] = T48 >> 23;}
  val_t T50;
  { T50 = T49[0];}
  T50 = T50 & 0x1ffffffffffL;
  val_t T51;
  { T51 = T50;}
  T51 = T51 & 0xffffffffffL;
  val_t T52;
  *reinterpret_cast<dat_t<32>*>(&T52) = CE__sigCount / dat_t<2>(0x2);
  val_t T53;
  T53 = T52 * 0x2L;
  val_t T54;
  { T54 = T53;}
  T54 = T54 & 0xffffffffL;
  val_t T55;
  { T55 = CE__sigCount.values[0]-T54;}
  T55 = T55 & 0xffffffffL;
  val_t T56;
  T56 = T55 == 0x1L;
  val_t T57;
  { T57 = TERNARY_1(T56, T51, T29);}
  { CE__io_signalOut_real.values[0] = T57;}
  val_t T58;
  T58 = (CE__io_signalOut_real.values[0] >> 39) & 1;
  val_t T59;
  { T59 = CE__io_signalOut_real.values[0] | T58 << 40;}
  val_t T60;
  { T60 = 0x0L | 0x0L << 1;}
  val_t T61;
  { T61 = T60 | T60 << 2;}
  val_t T62;
  { T62 = T61 | T60 << 4;}
  val_t T63;
  { T63 = 0x100000000L | T62 << 34;}
  val_t T64;
  { T64 = T63 | 0x0L << 40;}
  val_t T65;
  { T65 = T64-T59;}
  T65 = T65 & 0x1ffffffffffL;
  val_t T66;
  { T66 = 0x0L-T65;}
  T66 = T66 & 0x1ffffffffffL;
  val_t T67;
  T67 = (T65 >> 40) & 1;
  val_t T68;
  { T68 = TERNARY_1(T67, T66, T65);}
  val_t T69[2];
  *reinterpret_cast<dat_t<82>*>(&T69) = *reinterpret_cast<dat_t<41>*>(&T68) * *reinterpret_cast<dat_t<41>*>(&T4);
  val_t T70[2];
  { T70[0] = T71[0]-T69[0]; val_t __c = T71[0]-T69[0] > T71[0]; T70[1] = T71[1]-T69[1]-__c;}
  T70[1] = T70[1] & 0x3ffffL;
  val_t T72;
  { T72 = T67 ^ T3;}
  val_t T73[2];
  { T73[0] = TERNARY_1(T72, T70[0], T69[0]); T73[1] = TERNARY_1(T72, T70[1], T69[1]);}
  val_t T74[2];
  { T74[0] = T73[0]; T74[1] = T73[1];}
  T74[1] = T74[1] & 0x7fffL;
  val_t T75;
  T75 = (T74[1] >> 14) & 1;
  val_t T76[2];
  { T76[0] = T74[0]; T76[1] = T74[1] | T75 << 15;}
  val_t T77[2];
  { T77[0] = 0x0L | T9 << 32; T77[1] = T9 >> 32;}
  val_t T78;
  T78 = (T9 >> 33) & 1;
  val_t T79;
  { T79 = T78 | T78 << 1;}
  val_t T80;
  { T80 = T79 | T79 << 2;}
  val_t T81;
  { T81 = T80 | T80 << 4;}
  val_t T82;
  { T82 = T81 | T80 << 8;}
  val_t T83;
  { T83 = T82 | T78 << 12;}
  val_t T84[2];
  { T84[0] = T77[0]; T84[1] = T77[1] | T83 << 2;}
  val_t T85;
  T85 = (T9 >> 33) & 1;
  val_t T86[2];
  { T86[0] = T84[0]; T86[1] = T84[1] | T85 << 15;}
  val_t T87[2];
  { T87[0] = T86[0]+T76[0]; val_t __c = T86[0]+T76[0] < T86[0]; T87[1] = T86[1]+T76[1]+__c;}
  T87[1] = T87[1] & 0xffffL;
  val_t T88[2];
  { T88[0] = T87[0]; T88[1] = T87[1];}
  T88[1] = T88[1] & 0x7fffL;
  val_t T89;
  { T89 = T88[0] >> 32 | T88[1] << 32;}
  T89 = T89 & 0x7fffffffffffL;
  val_t T90;
  T90 = (T89 >> 46) & 1;
  val_t T91;
  { T91 = TERNARY(T90, 0x3ffffL, 0x0L);}
  val_t T92[2];
  { T92[0] = T89 | T91 << 47; T92[1] = T91 >> 17;}
  val_t T93;
  { T93 = T92[0];}
  T93 = T93 & 0x7fffffffffffL;
  val_t T94;
  { T94 = T93;}
  T94 = T94 & 0x3ffffffffL;
  val_t T95;
  T95 = 0x1L << T8;
  T95 = T95 & 0x3L;
  val_t T96;
  T96 = (T95 >> 1) & 1;
  val_t T97;
  { T97 = T56 & T96;}
  val_t T98;
  { T98 = TERNARY_1(T97, T94, CE__stored_Weight_r_1.values[0]);}
  { T99.values[0] = TERNARY(reset.values[0], 0x100000000L, T98);}
  val_t T100;
  T100 = (T95 >> 0) & 1;
  val_t T101;
  { T101 = T56 & T100;}
  val_t T102;
  { T102 = TERNARY_1(T101, T94, CE__stored_Weight_r_0.values[0]);}
  { T103.values[0] = TERNARY(reset.values[0], 0x100000000L, T102);}
  val_t T104;
  { T104 = CE__sigCount.values[0]+0x1L;}
  T104 = T104 & 0xffffffffL;
  val_t T105;
  T105 = CE__sigCount.values[0] != 0x4L;
  val_t T106;
  { T106 = TERNARY_1(T105, T104, CE__sigCount.values[0]);}
  val_t T107;
  { T107 = T105 ^ 0x1L;}
  val_t T108;
  { T108 = TERNARY(T107, 0x0L, T106);}
  { T109.values[0] = TERNARY(reset.values[0], 0x0L, T108);}
  val_t T110;
  { T110 = TERNARY(T107, 0x0L, CE__PTCount.values[0]);}
  val_t T111;
  { T111 = CE__PTCount.values[0]+0x1L;}
  T111 = T111 & 0xffffffffL;
  val_t T112;
  { T112 = TERNARY_1(T56, T111, T110);}
  { T113.values[0] = TERNARY(reset.values[0], 0x0L, T112);}
  val_t T114;
  T114 = (CE__io_signalIn_imag.values[0] >> 39) & 1;
  val_t T115;
  { T115 = CE__io_signalIn_imag.values[0] | T114 << 40;}
  val_t T116;
  { T116 = 0x0L-T115;}
  T116 = T116 & 0x1ffffffffffL;
  val_t T117;
  T117 = (T115 >> 40) & 1;
  val_t T118;
  { T118 = TERNARY_1(T117, T116, T115);}
  val_t T119;
  { T119 = 0x0L-CE__io_signalIn_imag.values[0];}
  T119 = T119 & 0xffffffffffL;
  val_t T120;
  T120 = (CE__io_signalIn_imag.values[0] >> 39) & 1;
  val_t T121;
  { T121 = TERNARY_1(T120, T119, CE__io_signalIn_imag.values[0]);}
  val_t T122;
  T122 = (CE__PTCount.values[0] >> 0) & 1;
  val_t T123;
  { T123 = TERNARY_1(T122, CE__stored_Weight_i_1.values[0], CE__stored_Weight_i_0.values[0]);}
  val_t T124;
  T124 = (T123 >> 33) & 1;
  val_t T125;
  { T125 = T124 | T124 << 1;}
  val_t T126;
  { T126 = T125 | T125 << 2;}
  val_t T127;
  { T127 = T126 | T125 << 4;}
  val_t T128;
  { T128 = T123 | T127 << 34;}
  val_t T129;
  { T129 = 0x0L-T128;}
  T129 = T129 & 0xffffffffffL;
  val_t T130;
  T130 = (T128 >> 39) & 1;
  val_t T131;
  { T131 = TERNARY_1(T130, T129, T128);}
  val_t T132[2];
  *reinterpret_cast<dat_t<80>*>(&T132) = *reinterpret_cast<dat_t<40>*>(&T131) * *reinterpret_cast<dat_t<40>*>(&T121);
  val_t T133[2];
  { T133[0] = T20[0]-T132[0]; val_t __c = T20[0]-T132[0] > T20[0]; T133[1] = T20[1]-T132[1]-__c;}
  T133[1] = T133[1] & 0xffffL;
  val_t T134;
  { T134 = T130 ^ T120;}
  val_t T135[2];
  { T135[0] = TERNARY_1(T134, T133[0], T132[0]); T135[1] = TERNARY_1(T134, T133[1], T132[1]);}
  val_t T136[2];
  { T136[0] = T135[0]; T136[1] = T135[1];}
  T136[1] = T136[1] & 0x1ffL;
  val_t T137;
  { T137 = T136[0] >> 32 | T136[1] << 32;}
  T137 = T137 & 0x1ffffffffffL;
  val_t T138;
  T138 = (T137 >> 40) & 1;
  val_t T139;
  { T139 = TERNARY(T138, 0xffffffL, 0x0L);}
  val_t T140[2];
  { T140[0] = T137 | T139 << 41; T140[1] = T139 >> 23;}
  val_t T141;
  { T141 = T140[0];}
  T141 = T141 & 0x1ffffffffffL;
  val_t T142;
  { T142 = T141;}
  T142 = T142 & 0xffffffffffL;
  val_t T143;
  { T143 = 0x0L-CE__io_signalIn_imag.values[0];}
  T143 = T143 & 0xffffffffffL;
  val_t T144;
  T144 = (CE__io_signalIn_imag.values[0] >> 39) & 1;
  val_t T145;
  { T145 = TERNARY_1(T144, T143, CE__io_signalIn_imag.values[0]);}
  val_t T146;
  T146 = (T123 >> 33) & 1;
  val_t T147;
  { T147 = T146 | T146 << 1;}
  val_t T148;
  { T148 = T147 | T147 << 2;}
  val_t T149;
  { T149 = T148 | T147 << 4;}
  val_t T150;
  { T150 = T123 | T149 << 34;}
  val_t T151;
  { T151 = 0x0L-T150;}
  T151 = T151 & 0xffffffffffL;
  val_t T152;
  T152 = (T150 >> 39) & 1;
  val_t T153;
  { T153 = TERNARY_1(T152, T151, T150);}
  val_t T154[2];
  *reinterpret_cast<dat_t<80>*>(&T154) = *reinterpret_cast<dat_t<40>*>(&T153) * *reinterpret_cast<dat_t<40>*>(&T145);
  val_t T155[2];
  { T155[0] = T20[0]-T154[0]; val_t __c = T20[0]-T154[0] > T20[0]; T155[1] = T20[1]-T154[1]-__c;}
  T155[1] = T155[1] & 0xffffL;
  val_t T156;
  { T156 = T152 ^ T144;}
  val_t T157[2];
  { T157[0] = TERNARY_1(T156, T155[0], T154[0]); T157[1] = TERNARY_1(T156, T155[1], T154[1]);}
  val_t T158[2];
  { T158[0] = T157[0]; T158[1] = T157[1];}
  T158[1] = T158[1] & 0x1ffL;
  val_t T159;
  { T159 = T158[0] >> 32 | T158[1] << 32;}
  T159 = T159 & 0x1ffffffffffL;
  val_t T160;
  T160 = (T159 >> 40) & 1;
  val_t T161;
  { T161 = TERNARY(T160, 0xffffffL, 0x0L);}
  val_t T162[2];
  { T162[0] = T159 | T161 << 41; T162[1] = T161 >> 23;}
  val_t T163;
  { T163 = T162[0];}
  T163 = T163 & 0x1ffffffffffL;
  val_t T164;
  { T164 = T163;}
  T164 = T164 & 0xffffffffffL;
  val_t T165;
  { T165 = TERNARY_1(T56, T164, T142);}
  { CE__io_signalOut_imag.values[0] = T165;}
  val_t T166;
  T166 = (CE__io_signalOut_imag.values[0] >> 39) & 1;
  val_t T167;
  { T167 = CE__io_signalOut_imag.values[0] | T166 << 40;}
  val_t T168;
  { T168 = 0x0L | 0x0L << 1;}
  val_t T169;
  { T169 = T168 | T168 << 2;}
  val_t T170;
  { T170 = T169 | T168 << 4;}
  val_t T171;
  { T171 = 0x100000000L | T170 << 34;}
  val_t T172;
  { T172 = T171 | 0x0L << 40;}
  val_t T173;
  { T173 = T172-T167;}
  T173 = T173 & 0x1ffffffffffL;
  val_t T174;
  { T174 = 0x0L-T173;}
  T174 = T174 & 0x1ffffffffffL;
  val_t T175;
  T175 = (T173 >> 40) & 1;
  val_t T176;
  { T176 = TERNARY_1(T175, T174, T173);}
  val_t T177[2];
  *reinterpret_cast<dat_t<82>*>(&T177) = *reinterpret_cast<dat_t<41>*>(&T176) * *reinterpret_cast<dat_t<41>*>(&T118);
  val_t T178[2];
  { T178[0] = T71[0]-T177[0]; val_t __c = T71[0]-T177[0] > T71[0]; T178[1] = T71[1]-T177[1]-__c;}
  T178[1] = T178[1] & 0x3ffffL;
  val_t T179;
  { T179 = T175 ^ T117;}
  val_t T180[2];
  { T180[0] = TERNARY_1(T179, T178[0], T177[0]); T180[1] = TERNARY_1(T179, T178[1], T177[1]);}
  val_t T181[2];
  { T181[0] = T180[0]; T181[1] = T180[1];}
  T181[1] = T181[1] & 0x7fffL;
  val_t T182;
  T182 = (T181[1] >> 14) & 1;
  val_t T183[2];
  { T183[0] = T181[0]; T183[1] = T181[1] | T182 << 15;}
  val_t T184[2];
  { T184[0] = 0x0L | T123 << 32; T184[1] = T123 >> 32;}
  val_t T185;
  T185 = (T123 >> 33) & 1;
  val_t T186;
  { T186 = T185 | T185 << 1;}
  val_t T187;
  { T187 = T186 | T186 << 2;}
  val_t T188;
  { T188 = T187 | T187 << 4;}
  val_t T189;
  { T189 = T188 | T187 << 8;}
  val_t T190;
  { T190 = T189 | T185 << 12;}
  val_t T191[2];
  { T191[0] = T184[0]; T191[1] = T184[1] | T190 << 2;}
  val_t T192;
  T192 = (T123 >> 33) & 1;
  val_t T193[2];
  { T193[0] = T191[0]; T193[1] = T191[1] | T192 << 15;}
  val_t T194[2];
  { T194[0] = T193[0]+T183[0]; val_t __c = T193[0]+T183[0] < T193[0]; T194[1] = T193[1]+T183[1]+__c;}
  T194[1] = T194[1] & 0xffffL;
  val_t T195[2];
  { T195[0] = T194[0]; T195[1] = T194[1];}
  T195[1] = T195[1] & 0x7fffL;
  val_t T196;
  { T196 = T195[0] >> 32 | T195[1] << 32;}
  T196 = T196 & 0x7fffffffffffL;
  val_t T197;
  T197 = (T196 >> 46) & 1;
  val_t T198;
  { T198 = TERNARY(T197, 0x3ffffL, 0x0L);}
  val_t T199[2];
  { T199[0] = T196 | T198 << 47; T199[1] = T198 >> 17;}
  val_t T200;
  { T200 = T199[0];}
  T200 = T200 & 0x7fffffffffffL;
  val_t T201;
  { T201 = T200;}
  T201 = T201 & 0x3ffffffffL;
  val_t T202;
  T202 = 0x1L << T122;
  T202 = T202 & 0x3L;
  val_t T203;
  T203 = (T202 >> 1) & 1;
  val_t T204;
  { T204 = T56 & T203;}
  val_t T205;
  { T205 = TERNARY_1(T204, T201, CE__stored_Weight_i_1.values[0]);}
  { T206.values[0] = TERNARY(reset.values[0], 0x100000000L, T205);}
  val_t T207;
  T207 = (T202 >> 0) & 1;
  val_t T208;
  { T208 = T56 & T207;}
  val_t T209;
  { T209 = TERNARY_1(T208, T201, CE__stored_Weight_i_0.values[0]);}
  { T210.values[0] = TERNARY(reset.values[0], 0x100000000L, T209);}
}


void CE_t::clock_hi ( dat_t<1> reset ) {
  dat_t<34> CE__stored_Weight_r_1__shadow = T99;
  dat_t<34> CE__stored_Weight_r_0__shadow = T103;
  dat_t<32> CE__sigCount__shadow = T109;
  dat_t<32> CE__PTCount__shadow = T113;
  dat_t<34> CE__stored_Weight_i_1__shadow = T206;
  dat_t<34> CE__stored_Weight_i_0__shadow = T210;
  CE__stored_Weight_r_1 = T99;
  CE__stored_Weight_r_0 = T103;
  CE__sigCount = T109;
  CE__PTCount = T113;
  CE__stored_Weight_i_1 = T206;
  CE__stored_Weight_i_0 = T210;
}


void CE_api_t::init_sim_data (  ) {
  sim_data.inputs.clear();
  sim_data.outputs.clear();
  sim_data.signals.clear();
  CE_t* mod = dynamic_cast<CE_t*>(module);
  assert(mod);
  sim_data.inputs.push_back(new dat_api<40>(&mod->CE__io_signalIn_real));
  sim_data.inputs.push_back(new dat_api<40>(&mod->CE__io_signalIn_imag));
  sim_data.outputs.push_back(new dat_api<40>(&mod->CE__io_signalOut_real));
  sim_data.outputs.push_back(new dat_api<40>(&mod->CE__io_signalOut_imag));
  sim_data.signals.push_back(new dat_api<34>(&mod->CE__stored_Weight_r_1));
  sim_data.signal_map["CE.stored_Weight_r_1"] = 0;
  sim_data.signals.push_back(new dat_api<34>(&mod->CE__stored_Weight_r_0));
  sim_data.signal_map["CE.stored_Weight_r_0"] = 1;
  sim_data.signals.push_back(new dat_api<32>(&mod->CE__sigCount));
  sim_data.signal_map["CE.sigCount"] = 2;
  sim_data.signals.push_back(new dat_api<32>(&mod->CE__PTCount));
  sim_data.signal_map["CE.PTCount"] = 3;
  sim_data.signals.push_back(new dat_api<34>(&mod->CE__stored_Weight_i_1));
  sim_data.signal_map["CE.stored_Weight_i_1"] = 4;
  sim_data.signals.push_back(new dat_api<34>(&mod->CE__stored_Weight_i_0));
  sim_data.signal_map["CE.stored_Weight_i_0"] = 5;
  sim_data.clk_map["clk"] = new clk_api(&mod->clk);
}
