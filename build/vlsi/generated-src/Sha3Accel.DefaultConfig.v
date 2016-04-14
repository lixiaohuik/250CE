module CtrlModule(input clk, input reset,
    input  io_rocc_req_val,
    output io_rocc_req_rdy,
    input [1:0] io_rocc_funct,
    input [63:0] io_rocc_rs1,
    input [63:0] io_rocc_rs2,
    input [4:0] io_rocc_rd,
    output io_busy,
    output io_dmem_req_val,
    input  io_dmem_req_rdy,
    output[6:0] io_dmem_req_tag,
    output[31:0] io_dmem_req_addr,
    output[4:0] io_dmem_req_cmd,
    output[2:0] io_dmem_req_typ,
    input  io_dmem_resp_val,
    input [6:0] io_dmem_resp_tag,
    input [63:0] io_dmem_resp_data,
    output[4:0] io_round,
    output io_stage,
    output io_absorb,
    output[4:0] io_aindex,
    output io_init,
    output io_write,
    output[2:0] io_windex,
    output[63:0] io_buffer_out
);

  wire[3:0] byte_offset;
  reg [63:0] msg_len;
  wire[63:0] T506;
  wire[63:0] T0;
  wire[63:0] T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  reg  busy;
  wire T507;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire[63:0] T508;
  reg [31:0] hashed;
  wire[31:0] T509;
  wire[31:0] T17;
  wire[31:0] T18;
  wire[31:0] T19;
  wire T20;
  wire T21;
  wire T22;
  reg [2:0] state;
  wire[2:0] T510;
  wire[2:0] T23;
  wire[2:0] T24;
  wire[2:0] T25;
  wire[2:0] T26;
  wire[2:0] T27;
  wire[2:0] T28;
  wire[2:0] T29;
  wire[2:0] T30;
  wire[2:0] T31;
  wire[2:0] T32;
  wire[2:0] T33;
  wire T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  reg  sindex;
  wire T511;
  wire T41;
  wire T42;
  wire T43;
  wire T44;
  wire T45;
  wire T46;
  reg [4:0] rindex;
  wire[4:0] T512;
  wire[4:0] T47;
  wire[4:0] T48;
  wire[4:0] T49;
  wire[4:0] T50;
  wire T51;
  wire T52;
  wire T53;
  wire T54;
  wire T55;
  wire T56;
  wire T57;
  wire T58;
  wire[63:0] T513;
  wire T59;
  wire[63:0] T514;
  wire T60;
  wire T61;
  wire T62;
  wire T63;
  wire T64;
  wire T65;
  wire T66;
  reg  writes_done_3;
  wire T515;
  wire T67;
  wire T68;
  wire T69;
  wire T70;
  wire[3:0] T71;
  wire[1:0] T72;
  wire[1:0] T516;
  wire[4:0] T73;
  wire[4:0] T74;
  reg [6:0] dmem_resp_tag_reg;
  wire T75;
  wire T76;
  wire[4:0] T77;
  wire T78;
  wire T79;
  reg  writes_done_2;
  wire T517;
  wire T80;
  wire T81;
  wire T82;
  wire T83;
  wire T84;
  reg  writes_done_1;
  wire T518;
  wire T85;
  wire T86;
  wire T87;
  wire T88;
  reg  writes_done_0;
  wire T519;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire T93;
  wire T94;
  reg  buffer_valid;
  wire T520;
  wire T95;
  wire T96;
  wire T97;
  wire T98;
  wire T99;
  wire T100;
  wire T101;
  wire T102;
  wire T103;
  wire T104;
  wire T105;
  wire T106;
  wire T107;
  wire T108;
  wire[63:0] T521;
  reg [31:0] read;
  wire[31:0] T522;
  wire[31:0] T109;
  wire[31:0] T110;
  wire[31:0] T111;
  wire[31:0] T112;
  wire[31:0] T113;
  wire T114;
  wire T115;
  wire T116;
  wire T117;
  wire T118;
  reg [2:0] mem_s;
  wire[2:0] T523;
  wire[2:0] T119;
  wire[2:0] T120;
  wire[2:0] T121;
  wire[2:0] T122;
  wire[2:0] T123;
  wire[2:0] T124;
  wire[2:0] T125;
  wire[2:0] T126;
  wire[2:0] T127;
  wire[2:0] T128;
  wire[2:0] T129;
  wire[2:0] T130;
  wire[2:0] T131;
  wire[2:0] T132;
  wire[2:0] T133;
  wire[2:0] T134;
  wire[2:0] T135;
  wire[2:0] T136;
  wire[2:0] T137;
  wire T138;
  wire T139;
  wire T140;
  wire T141;
  wire T142;
  reg [4:0] buffer_count;
  wire[4:0] T524;
  wire[4:0] T143;
  wire[4:0] T144;
  wire[4:0] T145;
  wire[4:0] T146;
  wire[4:0] T147;
  wire[4:0] T148;
  wire[4:0] T149;
  wire T150;
  wire T151;
  wire[4:0] T152;
  wire T153;
  wire T154;
  wire[4:0] T155;
  wire T156;
  wire T157;
  wire T158;
  wire T159;
  wire T160;
  wire[63:0] T525;
  wire T161;
  wire[63:0] T526;
  wire T162;
  wire T163;
  wire T164;
  wire T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  reg [4:0] mindex;
  wire[4:0] T527;
  wire[4:0] T170;
  wire[4:0] T171;
  wire[4:0] T172;
  wire[4:0] T173;
  wire[4:0] T174;
  wire[4:0] T175;
  wire[4:0] T176;
  wire T177;
  wire T198;
  wire T199;
  wire T200;
  wire T201;
  wire T202;
  wire T203;
  wire[63:0] T528;
  wire[31:0] T204;
  wire T205;
  wire T206;
  wire[63:0] T529;
  wire T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire T212;
  wire T213;
  wire T214;
  wire T215;
  wire T216;
  reg  areg;
  wire T530;
  wire T217;
  wire T218;
  wire T219;
  wire T220;
  wire T221;
  wire T222;
  reg [4:0] pindex;
  wire[4:0] T531;
  wire[4:0] T180;
  wire[4:0] T181;
  wire[4:0] T182;
  wire[4:0] T183;
  wire[4:0] T184;
  wire[4:0] T185;
  wire[4:0] T186;
  wire[4:0] T187;
  wire[4:0] T188;
  wire[4:0] T189;
  wire T190;
  wire T191;
  reg  wait_for_sram;
  wire T532;
  wire T192;
  wire T193;
  wire T194;
  wire T195;
  wire T196;
  wire T223;
  wire T224;
  wire T225;
  wire T226;
  wire T227;
  wire T228;
  wire T229;
  reg [4:0] aindex;
  wire[4:0] T533;
  wire[4:0] T230;
  wire[4:0] T231;
  wire[4:0] T232;
  wire T233;
  wire T234;
  wire[31:0] T235;
  wire T236;
  wire T237;
  wire[63:0] T238;
  wire T239;
  wire T240;
  wire[63:0] T534;
  wire T241;
  wire T242;
  wire T243;
  wire T244;
  wire T245;
  wire T246;
  wire[63:0] T535;
  wire[63:0] T247;
  wire T248;
  wire T249;
  wire T250;
  wire T251;
  wire[63:0] T536;
  wire[31:0] T252;
  wire T253;
  wire T254;
  wire T255;
  wire T256;
  reg  next_buff_val;
  wire T537;
  wire T178;
  wire T179;
  wire T197;
  wire T257;
  wire T258;
  wire T259;
  wire T260;
  wire T261;
  wire[63:0] T538;
  wire T262;
  wire T263;
  wire T264;
  wire T265;
  reg [4:0] rindex_reg;
  wire T266;
  wire T267;
  reg [1:0] rocc_s;
  wire[1:0] T539;
  wire T268;
  wire[4:0] words_filled;
  wire[4:0] T269;
  wire T270;
  wire[63:0] buffer_rdata;
  wire[63:0] T271;
  wire[4:0] T452;
  wire[4:0] T453;
  wire[4:0] T454;
  wire[4:0] T455;
  wire[4:0] T456;
  wire[4:0] T457;
  wire[4:0] T458;
  wire[4:0] T459;
  wire[4:0] T460;
  wire T426;
  wire T310;
  wire T311;
  wire T312;
  wire T313;
  wire T314;
  wire T315;
  wire T316;
  wire T317;
  wire T296;
  wire T297;
  wire T298;
  wire T299;
  wire T300;
  wire T301;
  wire T302;
  wire T303;
  wire T427;
  wire T326;
  wire T327;
  wire T319;
  wire T320;
  wire T321;
  wire T428;
  wire T332;
  wire T333;
  wire T334;
  wire T335;
  wire T336;
  wire T337;
  wire T338;
  wire T339;
  wire T340;
  wire T429;
  wire T345;
  wire T346;
  wire T347;
  wire T348;
  wire T430;
  wire T353;
  wire T354;
  wire T355;
  wire T356;
  wire T357;
  wire T431;
  wire T362;
  wire T363;
  wire T364;
  wire T365;
  wire T366;
  wire T432;
  wire T371;
  wire T372;
  wire T373;
  wire T374;
  wire T375;
  wire T433;
  wire T380;
  wire T381;
  wire T382;
  wire T383;
  wire T384;
  wire T434;
  wire T389;
  wire T390;
  wire T391;
  wire T392;
  wire T393;
  wire[63:0] T272;
  wire[63:0] buffer_wdata;
  wire[63:0] T273;
  wire[63:0] T274;
  wire[63:0] T275;
  wire[63:0] T276;
  wire[63:0] T277;
  wire[63:0] T278;
  wire[63:0] T279;
  wire[63:0] T280;
  wire[63:0] T281;
  wire[63:0] T282;
  wire[63:0] T283;
  wire[63:0] T284;
  wire[63:0] T285;
  wire[63:0] T286;
  wire[63:0] T287;
  wire T288;
  wire T289;
  wire T290;
  wire T291;
  wire T292;
  wire[4:0] T293;
  wire T294;
  wire T295;
  wire T304;
  wire T305;
  wire[63:0] T306;
  wire[55:0] T307;
  wire T308;
  wire T309;
  wire T318;
  wire[63:0] T322;
  wire[55:0] T323;
  wire T324;
  wire T325;
  wire[63:0] T540;
  wire[15:0] T328;
  wire[7:0] T329;
  wire T330;
  wire T331;
  wire[63:0] T541;
  wire[23:0] T341;
  wire[15:0] T342;
  wire T343;
  wire T344;
  wire[63:0] T542;
  wire[31:0] T349;
  wire[23:0] T350;
  wire T351;
  wire T352;
  wire[63:0] T543;
  wire[39:0] T358;
  wire[31:0] T359;
  wire T360;
  wire T361;
  wire[63:0] T544;
  wire[47:0] T367;
  wire[39:0] T368;
  wire T369;
  wire T370;
  wire[63:0] T545;
  wire[55:0] T376;
  wire[47:0] T377;
  wire T378;
  wire T379;
  wire[63:0] T385;
  wire[55:0] T386;
  wire T387;
  wire T388;
  wire T394;
  wire T395;
  wire T396;
  wire T397;
  wire T398;
  wire T399;
  wire T400;
  wire T401;
  wire[4:0] T402;
  wire[63:0] buffer_waddr;
  wire[63:0] T546;
  wire[4:0] T435;
  wire[4:0] T436;
  wire[4:0] T437;
  wire[4:0] T438;
  wire[4:0] T439;
  wire[4:0] T440;
  wire[4:0] T441;
  wire[4:0] T442;
  wire[4:0] T443;
  wire[4:0] T444;
  wire[4:0] T445;
  wire[4:0] T446;
  wire[4:0] T447;
  wire[4:0] T448;
  wire[4:0] T449;
  wire[4:0] T450;
  wire[4:0] T451;
  wire buffer_wen;
  wire T403;
  wire T404;
  wire T405;
  wire T406;
  wire T407;
  wire T408;
  wire T409;
  wire T410;
  wire T411;
  wire T412;
  wire T413;
  wire T414;
  wire T415;
  wire T416;
  wire T417;
  wire T418;
  wire T419;
  wire T420;
  wire T421;
  wire T422;
  wire T423;
  wire T424;
  wire T425;
  wire[4:0] T547;
  reg [4:0] buffer_raddr;
  reg [2:0] windex;
  wire[2:0] T548;
  wire[2:0] T461;
  wire[2:0] T462;
  wire[2:0] T463;
  wire[2:0] T464;
  wire T465;
  wire T466;
  wire T467;
  wire T468;
  wire T469;
  wire T470;
  reg [4:0] R471;
  wire T472;
  wire[4:0] T473;
  wire[4:0] T474;
  wire[4:0] T475;
  wire[31:0] T549;
  wire[63:0] T476;
  wire[63:0] T477;
  wire[63:0] T478;
  wire[63:0] T550;
  wire[7:0] T479;
  reg [63:0] msg_addr;
  wire[63:0] T551;
  wire[63:0] T480;
  wire[63:0] T481;
  wire[63:0] T482;
  wire[63:0] T483;
  wire T484;
  wire[63:0] T485;
  wire[63:0] T486;
  wire[63:0] T487;
  wire[63:0] T552;
  wire[5:0] T488;
  reg [63:0] hash_addr;
  wire[63:0] T553;
  wire[63:0] T489;
  wire[63:0] T490;
  wire[6:0] T554;
  wire[4:0] T491;
  wire[4:0] T492;
  wire[4:0] T493;
  wire[4:0] T555;
  wire T494;
  wire T495;
  wire T496;
  wire T497;
  wire T498;
  wire[63:0] T556;
  wire T499;
  wire T500;
  wire T501;
  wire T502;
  wire T503;
  wire T504;
  wire T505;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    msg_len = {2{$random}};
    busy = {1{$random}};
    hashed = {1{$random}};
    state = {1{$random}};
    sindex = {1{$random}};
    rindex = {1{$random}};
    writes_done_3 = {1{$random}};
    dmem_resp_tag_reg = {1{$random}};
    writes_done_2 = {1{$random}};
    writes_done_1 = {1{$random}};
    writes_done_0 = {1{$random}};
    buffer_valid = {1{$random}};
    read = {1{$random}};
    mem_s = {1{$random}};
    buffer_count = {1{$random}};
    mindex = {1{$random}};
    areg = {1{$random}};
    pindex = {1{$random}};
    wait_for_sram = {1{$random}};
    aindex = {1{$random}};
    next_buff_val = {1{$random}};
    rindex_reg = {1{$random}};
    rocc_s = {1{$random}};
    buffer_raddr = {1{$random}};
    windex = {1{$random}};
    R471 = {1{$random}};
    msg_addr = {2{$random}};
    hash_addr = {2{$random}};
  end
// synthesis translate_on
`endif

  assign byte_offset = msg_len % 4'h8;
  assign T506 = reset ? 64'h0 : T0;
  assign T0 = T268 ? 64'h0 : T1;
  assign T1 = T2 ? io_rocc_rs1 : msg_len;
  assign T2 = T7 & T3;
  assign T3 = T5 & T4;
  assign T4 = io_rocc_funct == 2'h1;
  assign T5 = T6 ^ 1'h1;
  assign T6 = io_rocc_funct == 2'h0;
  assign T7 = T267 & T8;
  assign T8 = io_rocc_req_val & T9;
  assign T9 = busy ^ 1'h1;
  assign T507 = reset ? 1'h0 : T10;
  assign T10 = T268 ? 1'h0 : T11;
  assign T11 = T13 ? 1'h1 : T12;
  assign T12 = T2 ? 1'h1 : busy;
  assign T13 = T266 & T14;
  assign T14 = busy & T15;
  assign T15 = T94 & T16;
  assign T16 = T508 <= msg_len;
  assign T508 = {32'h0, hashed};
  assign T509 = reset ? 32'h0 : T17;
  assign T17 = T268 ? 32'h0 : T18;
  assign T18 = T20 ? T19 : hashed;
  assign T19 = hashed + 32'h88;
  assign T20 = T22 & T21;
  assign T21 = 5'h10 <= io_aindex;
  assign T22 = 3'h1 == state;
  assign T510 = reset ? 3'h0 : T23;
  assign T23 = T64 ? 3'h4 : T24;
  assign T24 = T268 ? 3'h0 : T25;
  assign T25 = T62 ? 3'h0 : T26;
  assign T26 = T54 ? 3'h4 : T27;
  assign T27 = T52 ? 3'h3 : T28;
  assign T28 = T39 ? 3'h3 : T29;
  assign T29 = T38 ? 3'h3 : T30;
  assign T30 = T36 ? 3'h1 : T31;
  assign T31 = T20 ? 3'h2 : T32;
  assign T32 = T34 ? 3'h0 : T33;
  assign T33 = T13 ? 3'h1 : state;
  assign T34 = T266 & T35;
  assign T35 = T14 ^ 1'h1;
  assign T36 = T22 & T37;
  assign T37 = T21 ^ 1'h1;
  assign T38 = 3'h2 == state;
  assign T39 = T45 & T40;
  assign T40 = sindex < 1'h0;
  assign T511 = reset ? 1'h0 : T41;
  assign T41 = T52 ? 1'h0 : T42;
  assign T42 = T39 ? T44 : T43;
  assign T43 = T20 ? 1'h0 : sindex;
  assign T44 = sindex + 1'h1;
  assign T45 = T51 & T46;
  assign T46 = rindex < 5'h18;
  assign T512 = reset ? 5'h19 : T47;
  assign T47 = T268 ? 5'h19 : T48;
  assign T48 = T52 ? T50 : T49;
  assign T49 = T20 ? 5'h0 : rindex;
  assign T50 = rindex + 5'h1;
  assign T51 = 3'h3 == state;
  assign T52 = T45 & T53;
  assign T53 = T40 ^ 1'h1;
  assign T54 = T60 & T55;
  assign T55 = T59 | T56;
  assign T56 = T58 & T57;
  assign T57 = rindex == 5'h18;
  assign T58 = T513 == msg_len;
  assign T513 = {32'h0, hashed};
  assign T59 = msg_len < T514;
  assign T514 = {32'h0, hashed};
  assign T60 = T51 & T61;
  assign T61 = T46 ^ 1'h1;
  assign T62 = T60 & T63;
  assign T63 = T55 ^ 1'h1;
  assign T64 = T93 & T65;
  assign T65 = T66 ^ 1'h1;
  assign T66 = T79 & writes_done_3;
  assign T515 = reset ? 1'h0 : T67;
  assign T67 = T268 ? 1'h0 : T68;
  assign T68 = T69 ? 1'h1 : writes_done_3;
  assign T69 = T75 & T70;
  assign T70 = T71[2'h3:2'h3];
  assign T71 = 1'h1 << T72;
  assign T72 = T516;
  assign T516 = T73[1'h1:1'h0];
  assign T73 = T74 - 5'h11;
  assign T74 = dmem_resp_tag_reg[3'h4:1'h0];
  assign T75 = T78 & T76;
  assign T76 = 5'h11 <= T77;
  assign T77 = dmem_resp_tag_reg[3'h4:1'h0];
  assign T78 = T93 & io_dmem_resp_val;
  assign T79 = T84 & writes_done_2;
  assign T517 = reset ? 1'h0 : T80;
  assign T80 = T268 ? 1'h0 : T81;
  assign T81 = T82 ? 1'h1 : writes_done_2;
  assign T82 = T75 & T83;
  assign T83 = T71[2'h2:2'h2];
  assign T84 = writes_done_0 & writes_done_1;
  assign T518 = reset ? 1'h0 : T85;
  assign T85 = T268 ? 1'h0 : T86;
  assign T86 = T87 ? 1'h1 : writes_done_1;
  assign T87 = T75 & T88;
  assign T88 = T71[1'h1:1'h1];
  assign T519 = reset ? 1'h0 : T89;
  assign T89 = T268 ? 1'h0 : T90;
  assign T90 = T91 ? 1'h1 : writes_done_0;
  assign T91 = T75 & T92;
  assign T92 = T71[1'h0:1'h0];
  assign T93 = 3'h4 == state;
  assign T94 = T265 & buffer_valid;
  assign T520 = reset ? 1'h0 : T95;
  assign T95 = T268 ? 1'h0 : T96;
  assign T96 = T20 ? 1'h0 : T97;
  assign T97 = T259 ? 1'h1 : T98;
  assign T98 = T258 ? 1'h1 : T99;
  assign T99 = T257 ? next_buff_val : T100;
  assign T100 = T255 ? 1'h1 : T101;
  assign T101 = T250 ? 1'h0 : T102;
  assign T102 = T248 ? 1'h0 : T103;
  assign T103 = T245 ? 1'h0 : T104;
  assign T104 = T244 ? 1'h0 : T105;
  assign T105 = T242 ? 1'h0 : T106;
  assign T106 = T107 ? 1'h0 : buffer_valid;
  assign T107 = T239 & T108;
  assign T108 = T238 < T521;
  assign T521 = {32'h0, read};
  assign T522 = reset ? 32'h0 : T109;
  assign T109 = T268 ? 32'h0 : T110;
  assign T110 = T236 ? T235 : T111;
  assign T111 = T233 ? 32'h1 : T112;
  assign T112 = T114 ? T113 : read;
  assign T113 = read + 32'h8;
  assign T114 = T116 & T115;
  assign T115 = io_dmem_req_rdy & io_dmem_req_val;
  assign T116 = T118 & T117;
  assign T117 = state != 3'h4;
  assign T118 = 3'h1 == mem_s;
  assign T523 = reset ? 3'h0 : T119;
  assign T119 = T228 ? 3'h0 : T120;
  assign T120 = T226 ? 3'h3 : T121;
  assign T121 = T220 ? 3'h3 : T122;
  assign T122 = T218 ? 3'h4 : T123;
  assign T123 = T216 ? 3'h0 : T124;
  assign T124 = T255 ? 3'h0 : T125;
  assign T125 = T250 ? 3'h3 : T126;
  assign T126 = T209 ? 3'h1 : T127;
  assign T127 = T248 ? 3'h3 : T128;
  assign T128 = T205 ? 3'h1 : T129;
  assign T129 = T245 ? 3'h3 : T130;
  assign T130 = T201 ? 3'h0 : T131;
  assign T131 = T244 ? 3'h3 : T132;
  assign T132 = T165 ? 3'h1 : T133;
  assign T133 = T242 ? 3'h3 : T134;
  assign T134 = T239 ? 3'h1 : T135;
  assign T135 = T107 ? 3'h3 : T136;
  assign T136 = T163 ? 3'h0 : T137;
  assign T137 = T138 ? 3'h1 : mem_s;
  assign T138 = T162 & T139;
  assign T139 = busy & T140;
  assign T140 = T157 & T141;
  assign T141 = T156 & T142;
  assign T142 = buffer_count == 5'h0;
  assign T524 = reset ? 5'h0 : T143;
  assign T143 = T268 ? 5'h0 : T144;
  assign T144 = T20 ? 5'h0 : T145;
  assign T145 = T153 ? T152 : T146;
  assign T146 = T216 ? 5'h0 : T147;
  assign T147 = T150 ? T149 : T148;
  assign T148 = T138 ? 5'h0 : buffer_count;
  assign T149 = buffer_count + 5'h1;
  assign T150 = T151 & io_dmem_resp_val;
  assign T151 = 3'h2 == mem_s;
  assign T152 = buffer_count + 5'h1;
  assign T153 = io_dmem_resp_val & T154;
  assign T154 = T155 < 5'h11;
  assign T155 = io_dmem_resp_tag[3'h4:1'h0];
  assign T156 = buffer_valid ^ 1'h1;
  assign T157 = T161 | T158;
  assign T158 = T160 & T159;
  assign T159 = msg_len == 64'h0;
  assign T160 = T525 == msg_len;
  assign T525 = {32'h0, read};
  assign T161 = T526 < msg_len;
  assign T526 = {32'h0, read};
  assign T162 = 3'h0 == mem_s;
  assign T163 = T162 & T164;
  assign T164 = T139 ^ 1'h1;
  assign T165 = T198 & T166;
  assign T166 = T169 & T167;
  assign T167 = T168 ^ 1'h1;
  assign T168 = io_dmem_req_rdy & io_dmem_req_val;
  assign T169 = mindex < 5'h11;
  assign T527 = reset ? 5'h0 : T170;
  assign T170 = T216 ? 5'h0 : T171;
  assign T171 = T177 ? 5'h0 : T172;
  assign T172 = T236 ? T176 : T173;
  assign T173 = T114 ? T175 : T174;
  assign T174 = T138 ? 5'h0 : mindex;
  assign T175 = mindex + 5'h1;
  assign T176 = mindex + 5'h1;
  assign T177 = T257 & next_buff_val;
  assign T198 = T118 & T199;
  assign T199 = T200 ^ 1'h1;
  assign T200 = mindex < 5'h10;
  assign T201 = T236 & T202;
  assign T202 = T203 ^ 1'h1;
  assign T203 = msg_len < T528;
  assign T528 = {32'h0, T204};
  assign T204 = read + 32'h8;
  assign T205 = T207 & T206;
  assign T206 = T529 < msg_len;
  assign T529 = {32'h0, read};
  assign T207 = T150 & T208;
  assign T208 = mindex < 5'h10;
  assign T209 = T214 & T210;
  assign T210 = T213 & T211;
  assign T211 = T212 ^ 1'h1;
  assign T212 = io_dmem_req_rdy & io_dmem_req_val;
  assign T213 = mindex < 5'h11;
  assign T214 = T150 & T215;
  assign T215 = T208 ^ 1'h1;
  assign T216 = T177 & areg;
  assign T530 = reset ? 1'h0 : T217;
  assign T217 = T38 ? 1'h0 : T22;
  assign T218 = T177 & T219;
  assign T219 = areg ^ 1'h1;
  assign T220 = T224 & T221;
  assign T221 = T223 & T222;
  assign T222 = buffer_count <= pindex;
  assign T531 = reset ? 5'h0 : T180;
  assign T180 = T190 ? T189 : T181;
  assign T181 = T218 ? 5'h0 : T182;
  assign T182 = T216 ? 5'h0 : T183;
  assign T183 = T250 ? words_filled : T184;
  assign T184 = T248 ? words_filled : T185;
  assign T185 = T245 ? words_filled : T186;
  assign T186 = T244 ? words_filled : T187;
  assign T187 = T242 ? words_filled : T188;
  assign T188 = T107 ? words_filled : pindex;
  assign T189 = pindex + 5'h1;
  assign T190 = T226 & T191;
  assign T191 = wait_for_sram ^ 1'h1;
  assign T532 = reset ? 1'h1 : T192;
  assign T192 = T190 ? 1'h1 : T193;
  assign T193 = T196 ? 1'h0 : T194;
  assign T194 = T218 ? 1'h1 : T195;
  assign T195 = T216 ? 1'h1 : wait_for_sram;
  assign T196 = T226 & wait_for_sram;
  assign T223 = buffer_count < mindex;
  assign T224 = T257 & T225;
  assign T225 = next_buff_val ^ 1'h1;
  assign T226 = T224 & T227;
  assign T227 = T221 ^ 1'h1;
  assign T228 = T258 & T229;
  assign T229 = 5'h10 <= aindex;
  assign T533 = reset ? 5'h0 : T230;
  assign T230 = T20 ? 5'h0 : T231;
  assign T231 = T22 ? T232 : aindex;
  assign T232 = aindex + 5'h1;
  assign T233 = T116 & T234;
  assign T234 = msg_len == 64'h0;
  assign T235 = read + 32'h8;
  assign T236 = T198 & T237;
  assign T237 = T166 ^ 1'h1;
  assign T238 = msg_len + 64'h8;
  assign T239 = T241 & T240;
  assign T240 = T534 < msg_len;
  assign T534 = {32'h0, read};
  assign T241 = T118 & T200;
  assign T242 = T241 & T243;
  assign T243 = T240 ^ 1'h1;
  assign T244 = T236 & T203;
  assign T245 = T205 & T246;
  assign T246 = T247 < T535;
  assign T535 = {32'h0, read};
  assign T247 = msg_len + 64'h8;
  assign T248 = T207 & T249;
  assign T249 = T206 ^ 1'h1;
  assign T250 = T253 & T251;
  assign T251 = msg_len < T536;
  assign T536 = {32'h0, T252};
  assign T252 = read + 32'h8;
  assign T253 = T214 & T254;
  assign T254 = T210 ^ 1'h1;
  assign T255 = T253 & T256;
  assign T256 = T251 ^ 1'h1;
  assign T537 = reset ? 1'h0 : T178;
  assign T178 = T197 & T179;
  assign T179 = 5'h10 <= pindex;
  assign T197 = mindex <= buffer_count;
  assign T257 = 3'h3 == mem_s;
  assign T258 = 3'h4 == mem_s;
  assign T259 = T262 & T260;
  assign T260 = T261 ^ 1'h1;
  assign T261 = msg_len < T538;
  assign T538 = {32'h0, read};
  assign T262 = T264 & T263;
  assign T263 = 5'h11 <= mindex;
  assign T264 = mindex <= buffer_count;
  assign T265 = 5'h18 <= rindex_reg;
  assign T266 = 3'h0 == state;
  assign T267 = 2'h0 == rocc_s;
  assign T539 = reset ? 2'h0 : rocc_s;
  assign T268 = T93 & T66;
  assign words_filled = T270 ? T269 : mindex;
  assign T269 = mindex - 5'h1;
  assign T270 = 5'h0 < mindex;
  assign io_buffer_out = buffer_rdata;
  assign buffer_rdata = T271;
  assign T452 = T434 ? pindex : T453;
  assign T453 = T433 ? pindex : T454;
  assign T454 = T432 ? pindex : T455;
  assign T455 = T431 ? pindex : T456;
  assign T456 = T430 ? pindex : T457;
  assign T457 = T429 ? pindex : T458;
  assign T458 = T428 ? pindex : T459;
  assign T459 = T427 ? pindex : T460;
  assign T460 = T426 ? pindex : aindex;
  assign T426 = T310 & wait_for_sram;
  assign T310 = T312 & T311;
  assign T311 = byte_offset == 4'h7;
  assign T312 = T314 & T313;
  assign T313 = words_filled == 5'h10;
  assign T314 = T299 & T315;
  assign T315 = T317 & T316;
  assign T316 = pindex == 5'h10;
  assign T317 = T296 ^ 1'h1;
  assign T296 = T298 & T297;
  assign T297 = pindex < 5'h10;
  assign T298 = words_filled < pindex;
  assign T299 = T257 & T300;
  assign T300 = T301 ^ 1'h1;
  assign T301 = T303 & T302;
  assign T302 = buffer_count <= pindex;
  assign T303 = buffer_count < mindex;
  assign T427 = T326 & wait_for_sram;
  assign T326 = T320 & T327;
  assign T327 = T319 ^ 1'h1;
  assign T319 = words_filled < 5'h10;
  assign T320 = T314 & T321;
  assign T321 = T313 ^ 1'h1;
  assign T428 = T332 & wait_for_sram;
  assign T332 = T334 & T333;
  assign T333 = byte_offset == 4'h1;
  assign T334 = T336 & T335;
  assign T335 = byte_offset != 4'h0;
  assign T336 = T299 & T337;
  assign T337 = T339 & T338;
  assign T338 = pindex == words_filled;
  assign T339 = T340 ^ 1'h1;
  assign T340 = T296 | T316;
  assign T429 = T345 & wait_for_sram;
  assign T345 = T334 & T346;
  assign T346 = T348 & T347;
  assign T347 = byte_offset == 4'h2;
  assign T348 = T333 ^ 1'h1;
  assign T430 = T353 & wait_for_sram;
  assign T353 = T334 & T354;
  assign T354 = T356 & T355;
  assign T355 = byte_offset == 4'h3;
  assign T356 = T357 ^ 1'h1;
  assign T357 = T333 | T347;
  assign T431 = T362 & wait_for_sram;
  assign T362 = T334 & T363;
  assign T363 = T365 & T364;
  assign T364 = byte_offset == 4'h4;
  assign T365 = T366 ^ 1'h1;
  assign T366 = T357 | T355;
  assign T432 = T371 & wait_for_sram;
  assign T371 = T334 & T372;
  assign T372 = T374 & T373;
  assign T373 = byte_offset == 4'h5;
  assign T374 = T375 ^ 1'h1;
  assign T375 = T366 | T364;
  assign T433 = T380 & wait_for_sram;
  assign T380 = T334 & T381;
  assign T381 = T383 & T382;
  assign T382 = byte_offset == 4'h6;
  assign T383 = T384 ^ 1'h1;
  assign T384 = T375 | T373;
  assign T434 = T389 & wait_for_sram;
  assign T389 = T334 & T390;
  assign T390 = T392 & T391;
  assign T391 = byte_offset == 4'h7;
  assign T392 = T393 ^ 1'h1;
  assign T393 = T384 | T382;
  CtrlModule_buffer_mem buffer_mem (
    .CLK(clk),
    .W0A(T547),
    .W0E(T400),
    .W0I(buffer_wdata),
    .R1A(T452),
    .R1E(1'h1),
    .R1O(T271)
  );
  assign buffer_wdata = T273;
  assign T273 = T153 ? io_dmem_resp_data : T274;
  assign T274 = T394 ? 64'h1 : T275;
  assign T275 = T387 ? T385 : T276;
  assign T276 = T378 ? T545 : T277;
  assign T277 = T369 ? T544 : T278;
  assign T278 = T360 ? T543 : T279;
  assign T279 = T351 ? T542 : T280;
  assign T280 = T343 ? T541 : T281;
  assign T281 = T330 ? T540 : T282;
  assign T282 = T324 ? T322 : T283;
  assign T283 = T318 ? 64'h8000000000000000 : T284;
  assign T284 = T308 ? T306 : T285;
  assign T285 = T304 ? 64'h0 : T286;
  assign T286 = T288 ? 64'h1 : T287;
  assign T287 = T150 ? io_dmem_resp_data : 64'h0;
  assign T288 = T295 & T289;
  assign T289 = T291 & T290;
  assign T290 = 5'h0 < words_filled;
  assign T291 = T294 & T292;
  assign T292 = pindex == T293;
  assign T293 = words_filled + 5'h1;
  assign T294 = byte_offset == 4'h0;
  assign T295 = T299 & T296;
  assign T304 = T295 & T305;
  assign T305 = T289 ^ 1'h1;
  assign T306 = {8'h81, T307};
  assign T307 = buffer_rdata[6'h37:1'h0];
  assign T308 = T310 & T309;
  assign T309 = wait_for_sram ^ 1'h1;
  assign T318 = T320 & T319;
  assign T322 = {8'h80, T323};
  assign T323 = buffer_rdata[6'h37:1'h0];
  assign T324 = T326 & T325;
  assign T325 = wait_for_sram ^ 1'h1;
  assign T540 = {48'h0, T328};
  assign T328 = {8'h1, T329};
  assign T329 = buffer_rdata[3'h7:1'h0];
  assign T330 = T332 & T331;
  assign T331 = wait_for_sram ^ 1'h1;
  assign T541 = {40'h0, T341};
  assign T341 = {8'h1, T342};
  assign T342 = buffer_rdata[4'hf:1'h0];
  assign T343 = T345 & T344;
  assign T344 = wait_for_sram ^ 1'h1;
  assign T542 = {32'h0, T349};
  assign T349 = {8'h1, T350};
  assign T350 = buffer_rdata[5'h17:1'h0];
  assign T351 = T353 & T352;
  assign T352 = wait_for_sram ^ 1'h1;
  assign T543 = {24'h0, T358};
  assign T358 = {8'h1, T359};
  assign T359 = buffer_rdata[5'h1f:1'h0];
  assign T360 = T362 & T361;
  assign T361 = wait_for_sram ^ 1'h1;
  assign T544 = {16'h0, T367};
  assign T367 = {8'h1, T368};
  assign T368 = buffer_rdata[6'h27:1'h0];
  assign T369 = T371 & T370;
  assign T370 = wait_for_sram ^ 1'h1;
  assign T545 = {8'h0, T376};
  assign T376 = {8'h1, T377};
  assign T377 = buffer_rdata[6'h2f:1'h0];
  assign T378 = T380 & T379;
  assign T379 = wait_for_sram ^ 1'h1;
  assign T385 = {8'h1, T386};
  assign T386 = buffer_rdata[6'h37:1'h0];
  assign T387 = T389 & T388;
  assign T388 = wait_for_sram ^ 1'h1;
  assign T394 = T398 & T395;
  assign T395 = T397 & T396;
  assign T396 = byte_offset == 4'h0;
  assign T397 = words_filled == 5'h0;
  assign T398 = T336 & T399;
  assign T399 = T335 ^ 1'h1;
  assign T400 = buffer_wen & T401;
  assign T401 = T402 < 5'h11;
  assign T402 = buffer_waddr[3'h4:1'h0];
  assign buffer_waddr = T546;
  assign T546 = {59'h0, T435};
  assign T435 = T153 ? T451 : T436;
  assign T436 = T394 ? pindex : T437;
  assign T437 = T387 ? pindex : T438;
  assign T438 = T378 ? pindex : T439;
  assign T439 = T369 ? pindex : T440;
  assign T440 = T360 ? pindex : T441;
  assign T441 = T351 ? pindex : T442;
  assign T442 = T343 ? pindex : T443;
  assign T443 = T330 ? pindex : T444;
  assign T444 = T324 ? pindex : T445;
  assign T445 = T318 ? pindex : T446;
  assign T446 = T308 ? pindex : T447;
  assign T447 = T304 ? pindex : T448;
  assign T448 = T288 ? pindex : T449;
  assign T449 = T150 ? T450 : 5'h0;
  assign T450 = mindex - 5'h1;
  assign T451 = io_dmem_resp_tag[3'h4:1'h0];
  assign buffer_wen = T403;
  assign T403 = T153 ? 1'h1 : T404;
  assign T404 = T394 ? 1'h1 : T405;
  assign T405 = T387 ? 1'h1 : T406;
  assign T406 = T434 ? 1'h0 : T407;
  assign T407 = T378 ? 1'h1 : T408;
  assign T408 = T433 ? 1'h0 : T409;
  assign T409 = T369 ? 1'h1 : T410;
  assign T410 = T432 ? 1'h0 : T411;
  assign T411 = T360 ? 1'h1 : T412;
  assign T412 = T431 ? 1'h0 : T413;
  assign T413 = T351 ? 1'h1 : T414;
  assign T414 = T430 ? 1'h0 : T415;
  assign T415 = T343 ? 1'h1 : T416;
  assign T416 = T429 ? 1'h0 : T417;
  assign T417 = T330 ? 1'h1 : T418;
  assign T418 = T428 ? 1'h0 : T419;
  assign T419 = T324 ? 1'h1 : T420;
  assign T420 = T427 ? 1'h0 : T421;
  assign T421 = T318 ? 1'h1 : T422;
  assign T422 = T308 ? 1'h1 : T423;
  assign T423 = T426 ? 1'h0 : T424;
  assign T424 = T304 ? 1'h1 : T425;
  assign T425 = T288 ? 1'h1 : T150;
  assign T547 = buffer_waddr[3'h4:1'h0];
  assign io_windex = windex;
  assign T548 = reset ? 3'h0 : T461;
  assign T461 = T268 ? 3'h4 : T462;
  assign T462 = T465 ? T464 : T463;
  assign T463 = T54 ? 3'h0 : windex;
  assign T464 = windex + 3'h1;
  assign T465 = T93 & io_dmem_req_rdy;
  assign io_write = T466;
  assign T466 = T60 ? 1'h1 : T467;
  assign T467 = T52 ? 1'h0 : T468;
  assign T468 = T39 ? 1'h0 : T469;
  assign T469 = T22 ? T470 : 1'h1;
  assign T470 = areg ^ 1'h1;
  assign io_init = T268;
  assign io_aindex = R471;
  assign io_absorb = areg;
  assign io_stage = T472;
  assign T472 = T39 ? sindex : sindex;
  assign io_round = T473;
  assign T473 = T52 ? rindex : T474;
  assign T474 = T39 ? rindex : rindex;
  assign io_dmem_req_typ = 3'h3;
  assign io_dmem_req_cmd = T475;
  assign T475 = T93 ? 5'h1 : 5'h0;
  assign io_dmem_req_addr = T549;
  assign T549 = T476[5'h1f:1'h0];
  assign T476 = T93 ? T487 : T477;
  assign T477 = T116 ? T478 : 64'h0;
  assign T478 = msg_addr + T550;
  assign T550 = {56'h0, T479};
  assign T479 = mindex << 2'h3;
  assign T551 = reset ? 64'h0 : T480;
  assign T480 = T268 ? 64'h0 : T481;
  assign T481 = T253 ? T486 : T482;
  assign T482 = T236 ? T485 : T483;
  assign T483 = T484 ? io_rocc_rs1 : msg_addr;
  assign T484 = T7 & T6;
  assign T485 = msg_addr + 64'h88;
  assign T486 = msg_addr + 64'h88;
  assign T487 = hash_addr + T552;
  assign T552 = {58'h0, T488};
  assign T488 = windex << 2'h3;
  assign T553 = reset ? 64'h0 : T489;
  assign T489 = T268 ? 64'h0 : T490;
  assign T490 = T484 ? io_rocc_rs2 : hash_addr;
  assign io_dmem_req_tag = T554;
  assign T554 = {2'h0, T491};
  assign T491 = T93 ? T493 : T492;
  assign T492 = T116 ? mindex : rindex;
  assign T493 = 5'h11 + T555;
  assign T555 = {2'h0, windex};
  assign io_dmem_req_val = T494;
  assign T494 = T93 ? T499 : T495;
  assign T495 = T116 ? T496 : 1'h0;
  assign T496 = T498 & T497;
  assign T497 = mindex < 5'h11;
  assign T498 = T556 < msg_len;
  assign T556 = {32'h0, read};
  assign T499 = windex < 3'h4;
  assign io_busy = T500;
  assign T500 = T2 ? 1'h1 : T501;
  assign T501 = T484 ? 1'h1 : busy;
  assign io_rocc_req_rdy = T502;
  assign T502 = T2 ? 1'h1 : T503;
  assign T503 = T484 ? 1'h1 : T504;
  assign T504 = T267 ? T505 : 1'h0;
  assign T505 = busy ^ 1'h1;

  always @(posedge clk) begin
    if(reset) begin
      msg_len <= 64'h0;
    end else if(T268) begin
      msg_len <= 64'h0;
    end else if(T2) begin
      msg_len <= io_rocc_rs1;
    end
    if(reset) begin
      busy <= 1'h0;
    end else if(T268) begin
      busy <= 1'h0;
    end else if(T13) begin
      busy <= 1'h1;
    end else if(T2) begin
      busy <= 1'h1;
    end
    if(reset) begin
      hashed <= 32'h0;
    end else if(T268) begin
      hashed <= 32'h0;
    end else if(T20) begin
      hashed <= T19;
    end
    if(reset) begin
      state <= 3'h0;
    end else if(T64) begin
      state <= 3'h4;
    end else if(T268) begin
      state <= 3'h0;
    end else if(T62) begin
      state <= 3'h0;
    end else if(T54) begin
      state <= 3'h4;
    end else if(T52) begin
      state <= 3'h3;
    end else if(T39) begin
      state <= 3'h3;
    end else if(T38) begin
      state <= 3'h3;
    end else if(T36) begin
      state <= 3'h1;
    end else if(T20) begin
      state <= 3'h2;
    end else if(T34) begin
      state <= 3'h0;
    end else if(T13) begin
      state <= 3'h1;
    end
    if(reset) begin
      sindex <= 1'h0;
    end else if(T52) begin
      sindex <= 1'h0;
    end else if(T39) begin
      sindex <= T44;
    end else if(T20) begin
      sindex <= 1'h0;
    end
    if(reset) begin
      rindex <= 5'h19;
    end else if(T268) begin
      rindex <= 5'h19;
    end else if(T52) begin
      rindex <= T50;
    end else if(T20) begin
      rindex <= 5'h0;
    end
    if(reset) begin
      writes_done_3 <= 1'h0;
    end else if(T268) begin
      writes_done_3 <= 1'h0;
    end else if(T69) begin
      writes_done_3 <= 1'h1;
    end
    dmem_resp_tag_reg <= io_dmem_resp_tag;
    if(reset) begin
      writes_done_2 <= 1'h0;
    end else if(T268) begin
      writes_done_2 <= 1'h0;
    end else if(T82) begin
      writes_done_2 <= 1'h1;
    end
    if(reset) begin
      writes_done_1 <= 1'h0;
    end else if(T268) begin
      writes_done_1 <= 1'h0;
    end else if(T87) begin
      writes_done_1 <= 1'h1;
    end
    if(reset) begin
      writes_done_0 <= 1'h0;
    end else if(T268) begin
      writes_done_0 <= 1'h0;
    end else if(T91) begin
      writes_done_0 <= 1'h1;
    end
    if(reset) begin
      buffer_valid <= 1'h0;
    end else if(T268) begin
      buffer_valid <= 1'h0;
    end else if(T20) begin
      buffer_valid <= 1'h0;
    end else if(T259) begin
      buffer_valid <= 1'h1;
    end else if(T258) begin
      buffer_valid <= 1'h1;
    end else if(T257) begin
      buffer_valid <= next_buff_val;
    end else if(T255) begin
      buffer_valid <= 1'h1;
    end else if(T250) begin
      buffer_valid <= 1'h0;
    end else if(T248) begin
      buffer_valid <= 1'h0;
    end else if(T245) begin
      buffer_valid <= 1'h0;
    end else if(T244) begin
      buffer_valid <= 1'h0;
    end else if(T242) begin
      buffer_valid <= 1'h0;
    end else if(T107) begin
      buffer_valid <= 1'h0;
    end
    if(reset) begin
      read <= 32'h0;
    end else if(T268) begin
      read <= 32'h0;
    end else if(T236) begin
      read <= T235;
    end else if(T233) begin
      read <= 32'h1;
    end else if(T114) begin
      read <= T113;
    end
    if(reset) begin
      mem_s <= 3'h0;
    end else if(T228) begin
      mem_s <= 3'h0;
    end else if(T226) begin
      mem_s <= 3'h3;
    end else if(T220) begin
      mem_s <= 3'h3;
    end else if(T218) begin
      mem_s <= 3'h4;
    end else if(T216) begin
      mem_s <= 3'h0;
    end else if(T255) begin
      mem_s <= 3'h0;
    end else if(T250) begin
      mem_s <= 3'h3;
    end else if(T209) begin
      mem_s <= 3'h1;
    end else if(T248) begin
      mem_s <= 3'h3;
    end else if(T205) begin
      mem_s <= 3'h1;
    end else if(T245) begin
      mem_s <= 3'h3;
    end else if(T201) begin
      mem_s <= 3'h0;
    end else if(T244) begin
      mem_s <= 3'h3;
    end else if(T165) begin
      mem_s <= 3'h1;
    end else if(T242) begin
      mem_s <= 3'h3;
    end else if(T239) begin
      mem_s <= 3'h1;
    end else if(T107) begin
      mem_s <= 3'h3;
    end else if(T163) begin
      mem_s <= 3'h0;
    end else if(T138) begin
      mem_s <= 3'h1;
    end
    if(reset) begin
      buffer_count <= 5'h0;
    end else if(T268) begin
      buffer_count <= 5'h0;
    end else if(T20) begin
      buffer_count <= 5'h0;
    end else if(T153) begin
      buffer_count <= T152;
    end else if(T216) begin
      buffer_count <= 5'h0;
    end else if(T150) begin
      buffer_count <= T149;
    end else if(T138) begin
      buffer_count <= 5'h0;
    end
    if(reset) begin
      mindex <= 5'h0;
    end else if(T216) begin
      mindex <= 5'h0;
    end else if(T177) begin
      mindex <= 5'h0;
    end else if(T236) begin
      mindex <= T176;
    end else if(T114) begin
      mindex <= T175;
    end else if(T138) begin
      mindex <= 5'h0;
    end
    if(reset) begin
      areg <= 1'h0;
    end else if(T38) begin
      areg <= 1'h0;
    end else begin
      areg <= T22;
    end
    if(reset) begin
      pindex <= 5'h0;
    end else if(T190) begin
      pindex <= T189;
    end else if(T218) begin
      pindex <= 5'h0;
    end else if(T216) begin
      pindex <= 5'h0;
    end else if(T250) begin
      pindex <= words_filled;
    end else if(T248) begin
      pindex <= words_filled;
    end else if(T245) begin
      pindex <= words_filled;
    end else if(T244) begin
      pindex <= words_filled;
    end else if(T242) begin
      pindex <= words_filled;
    end else if(T107) begin
      pindex <= words_filled;
    end
    if(reset) begin
      wait_for_sram <= 1'h1;
    end else if(T190) begin
      wait_for_sram <= 1'h1;
    end else if(T196) begin
      wait_for_sram <= 1'h0;
    end else if(T218) begin
      wait_for_sram <= 1'h1;
    end else if(T216) begin
      wait_for_sram <= 1'h1;
    end
    if(reset) begin
      aindex <= 5'h0;
    end else if(T20) begin
      aindex <= 5'h0;
    end else if(T22) begin
      aindex <= T232;
    end
    if(reset) begin
      next_buff_val <= 1'h0;
    end else begin
      next_buff_val <= T178;
    end
    rindex_reg <= rindex;
    if(reset) begin
      rocc_s <= 2'h0;
    end
    if(T434) begin
      buffer_raddr <= pindex;
    end else if(T433) begin
      buffer_raddr <= pindex;
    end else if(T432) begin
      buffer_raddr <= pindex;
    end else if(T431) begin
      buffer_raddr <= pindex;
    end else if(T430) begin
      buffer_raddr <= pindex;
    end else if(T429) begin
      buffer_raddr <= pindex;
    end else if(T428) begin
      buffer_raddr <= pindex;
    end else if(T427) begin
      buffer_raddr <= pindex;
    end else if(T426) begin
      buffer_raddr <= pindex;
    end else begin
      buffer_raddr <= aindex;
    end
    if(reset) begin
      windex <= 3'h0;
    end else if(T268) begin
      windex <= 3'h4;
    end else if(T465) begin
      windex <= T464;
    end else if(T54) begin
      windex <= 3'h0;
    end
    R471 <= aindex;
    if(reset) begin
      msg_addr <= 64'h0;
    end else if(T268) begin
      msg_addr <= 64'h0;
    end else if(T253) begin
      msg_addr <= T486;
    end else if(T236) begin
      msg_addr <= T485;
    end else if(T484) begin
      msg_addr <= io_rocc_rs1;
    end
    if(reset) begin
      hash_addr <= 64'h0;
    end else if(T268) begin
      hash_addr <= 64'h0;
    end else if(T484) begin
      hash_addr <= io_rocc_rs2;
    end
  end
endmodule

module ThetaModule(
    input [63:0] io_state_i_24,
    input [63:0] io_state_i_23,
    input [63:0] io_state_i_22,
    input [63:0] io_state_i_21,
    input [63:0] io_state_i_20,
    input [63:0] io_state_i_19,
    input [63:0] io_state_i_18,
    input [63:0] io_state_i_17,
    input [63:0] io_state_i_16,
    input [63:0] io_state_i_15,
    input [63:0] io_state_i_14,
    input [63:0] io_state_i_13,
    input [63:0] io_state_i_12,
    input [63:0] io_state_i_11,
    input [63:0] io_state_i_10,
    input [63:0] io_state_i_9,
    input [63:0] io_state_i_8,
    input [63:0] io_state_i_7,
    input [63:0] io_state_i_6,
    input [63:0] io_state_i_5,
    input [63:0] io_state_i_4,
    input [63:0] io_state_i_3,
    input [63:0] io_state_i_2,
    input [63:0] io_state_i_1,
    input [63:0] io_state_i_0,
    output[63:0] io_state_o_24,
    output[63:0] io_state_o_23,
    output[63:0] io_state_o_22,
    output[63:0] io_state_o_21,
    output[63:0] io_state_o_20,
    output[63:0] io_state_o_19,
    output[63:0] io_state_o_18,
    output[63:0] io_state_o_17,
    output[63:0] io_state_o_16,
    output[63:0] io_state_o_15,
    output[63:0] io_state_o_14,
    output[63:0] io_state_o_13,
    output[63:0] io_state_o_12,
    output[63:0] io_state_o_11,
    output[63:0] io_state_o_10,
    output[63:0] io_state_o_9,
    output[63:0] io_state_o_8,
    output[63:0] io_state_o_7,
    output[63:0] io_state_o_6,
    output[63:0] io_state_o_5,
    output[63:0] io_state_o_4,
    output[63:0] io_state_o_3,
    output[63:0] io_state_o_2,
    output[63:0] io_state_o_1,
    output[63:0] io_state_o_0
);

  wire[63:0] T0;
  wire[63:0] T1;
  wire[63:0] T70;
  wire[64:0] T2;
  wire[64:0] T3;
  wire[64:0] T71;
  wire T4;
  wire[63:0] bc_1;
  wire[63:0] T5;
  wire[63:0] T6;
  wire[63:0] T7;
  wire[63:0] T8;
  wire[64:0] T9;
  wire[64:0] T72;
  wire[63:0] bc_4;
  wire[63:0] T10;
  wire[63:0] T11;
  wire[63:0] T12;
  wire[63:0] T13;
  wire[63:0] T14;
  wire[63:0] T15;
  wire[63:0] T16;
  wire[63:0] T17;
  wire[63:0] T18;
  wire[63:0] T19;
  wire[63:0] T73;
  wire[64:0] T20;
  wire[64:0] T21;
  wire[64:0] T74;
  wire T22;
  wire[63:0] bc_2;
  wire[63:0] T23;
  wire[63:0] T24;
  wire[63:0] T25;
  wire[63:0] T26;
  wire[64:0] T27;
  wire[64:0] T75;
  wire[63:0] bc_0;
  wire[63:0] T28;
  wire[63:0] T29;
  wire[63:0] T30;
  wire[63:0] T31;
  wire[63:0] T32;
  wire[63:0] T33;
  wire[63:0] T34;
  wire[63:0] T35;
  wire[63:0] T36;
  wire[63:0] T37;
  wire[63:0] T76;
  wire[64:0] T38;
  wire[64:0] T39;
  wire[64:0] T77;
  wire T40;
  wire[63:0] bc_3;
  wire[63:0] T41;
  wire[63:0] T42;
  wire[63:0] T43;
  wire[63:0] T44;
  wire[64:0] T45;
  wire[64:0] T78;
  wire[63:0] T46;
  wire[63:0] T47;
  wire[63:0] T48;
  wire[63:0] T49;
  wire[63:0] T50;
  wire[63:0] T51;
  wire[63:0] T79;
  wire[64:0] T52;
  wire[64:0] T53;
  wire[64:0] T80;
  wire T54;
  wire[64:0] T55;
  wire[64:0] T81;
  wire[63:0] T56;
  wire[63:0] T57;
  wire[63:0] T58;
  wire[63:0] T59;
  wire[63:0] T60;
  wire[63:0] T61;
  wire[63:0] T82;
  wire[64:0] T62;
  wire[64:0] T63;
  wire[64:0] T83;
  wire T64;
  wire[64:0] T65;
  wire[64:0] T84;
  wire[63:0] T66;
  wire[63:0] T67;
  wire[63:0] T68;
  wire[63:0] T69;


  assign io_state_o_0 = T0;
  assign T0 = io_state_i_0 ^ T1;
  assign T1 = T70;
  assign T70 = T2[6'h3f:1'h0];
  assign T2 = T72 ^ T3;
  assign T3 = T9 | T71;
  assign T71 = {64'h0, T4};
  assign T4 = bc_1 >> 7'h3f;
  assign bc_1 = T5;
  assign T5 = T6 ^ io_state_i_9;
  assign T6 = T7 ^ io_state_i_8;
  assign T7 = T8 ^ io_state_i_7;
  assign T8 = io_state_i_5 ^ io_state_i_6;
  assign T9 = bc_1 << 1'h1;
  assign T72 = {1'h0, bc_4};
  assign bc_4 = T10;
  assign T10 = T11 ^ io_state_i_24;
  assign T11 = T12 ^ io_state_i_23;
  assign T12 = T13 ^ io_state_i_22;
  assign T13 = io_state_i_20 ^ io_state_i_21;
  assign io_state_o_1 = T14;
  assign T14 = io_state_i_1 ^ T1;
  assign io_state_o_2 = T15;
  assign T15 = io_state_i_2 ^ T1;
  assign io_state_o_3 = T16;
  assign T16 = io_state_i_3 ^ T1;
  assign io_state_o_4 = T17;
  assign T17 = io_state_i_4 ^ T1;
  assign io_state_o_5 = T18;
  assign T18 = io_state_i_5 ^ T19;
  assign T19 = T73;
  assign T73 = T20[6'h3f:1'h0];
  assign T20 = T75 ^ T21;
  assign T21 = T27 | T74;
  assign T74 = {64'h0, T22};
  assign T22 = bc_2 >> 7'h3f;
  assign bc_2 = T23;
  assign T23 = T24 ^ io_state_i_14;
  assign T24 = T25 ^ io_state_i_13;
  assign T25 = T26 ^ io_state_i_12;
  assign T26 = io_state_i_10 ^ io_state_i_11;
  assign T27 = bc_2 << 1'h1;
  assign T75 = {1'h0, bc_0};
  assign bc_0 = T28;
  assign T28 = T29 ^ io_state_i_4;
  assign T29 = T30 ^ io_state_i_3;
  assign T30 = T31 ^ io_state_i_2;
  assign T31 = io_state_i_0 ^ io_state_i_1;
  assign io_state_o_6 = T32;
  assign T32 = io_state_i_6 ^ T19;
  assign io_state_o_7 = T33;
  assign T33 = io_state_i_7 ^ T19;
  assign io_state_o_8 = T34;
  assign T34 = io_state_i_8 ^ T19;
  assign io_state_o_9 = T35;
  assign T35 = io_state_i_9 ^ T19;
  assign io_state_o_10 = T36;
  assign T36 = io_state_i_10 ^ T37;
  assign T37 = T76;
  assign T76 = T38[6'h3f:1'h0];
  assign T38 = T78 ^ T39;
  assign T39 = T45 | T77;
  assign T77 = {64'h0, T40};
  assign T40 = bc_3 >> 7'h3f;
  assign bc_3 = T41;
  assign T41 = T42 ^ io_state_i_19;
  assign T42 = T43 ^ io_state_i_18;
  assign T43 = T44 ^ io_state_i_17;
  assign T44 = io_state_i_15 ^ io_state_i_16;
  assign T45 = bc_3 << 1'h1;
  assign T78 = {1'h0, bc_1};
  assign io_state_o_11 = T46;
  assign T46 = io_state_i_11 ^ T37;
  assign io_state_o_12 = T47;
  assign T47 = io_state_i_12 ^ T37;
  assign io_state_o_13 = T48;
  assign T48 = io_state_i_13 ^ T37;
  assign io_state_o_14 = T49;
  assign T49 = io_state_i_14 ^ T37;
  assign io_state_o_15 = T50;
  assign T50 = io_state_i_15 ^ T51;
  assign T51 = T79;
  assign T79 = T52[6'h3f:1'h0];
  assign T52 = T81 ^ T53;
  assign T53 = T55 | T80;
  assign T80 = {64'h0, T54};
  assign T54 = bc_4 >> 7'h3f;
  assign T55 = bc_4 << 1'h1;
  assign T81 = {1'h0, bc_2};
  assign io_state_o_16 = T56;
  assign T56 = io_state_i_16 ^ T51;
  assign io_state_o_17 = T57;
  assign T57 = io_state_i_17 ^ T51;
  assign io_state_o_18 = T58;
  assign T58 = io_state_i_18 ^ T51;
  assign io_state_o_19 = T59;
  assign T59 = io_state_i_19 ^ T51;
  assign io_state_o_20 = T60;
  assign T60 = io_state_i_20 ^ T61;
  assign T61 = T82;
  assign T82 = T62[6'h3f:1'h0];
  assign T62 = T84 ^ T63;
  assign T63 = T65 | T83;
  assign T83 = {64'h0, T64};
  assign T64 = bc_0 >> 7'h3f;
  assign T65 = bc_0 << 1'h1;
  assign T84 = {1'h0, bc_3};
  assign io_state_o_21 = T66;
  assign T66 = io_state_i_21 ^ T61;
  assign io_state_o_22 = T67;
  assign T67 = io_state_i_22 ^ T61;
  assign io_state_o_23 = T68;
  assign T68 = io_state_i_23 ^ T61;
  assign io_state_o_24 = T69;
  assign T69 = io_state_i_24 ^ T61;
endmodule

module RhoPiModule(
    input [63:0] io_state_i_24,
    input [63:0] io_state_i_23,
    input [63:0] io_state_i_22,
    input [63:0] io_state_i_21,
    input [63:0] io_state_i_20,
    input [63:0] io_state_i_19,
    input [63:0] io_state_i_18,
    input [63:0] io_state_i_17,
    input [63:0] io_state_i_16,
    input [63:0] io_state_i_15,
    input [63:0] io_state_i_14,
    input [63:0] io_state_i_13,
    input [63:0] io_state_i_12,
    input [63:0] io_state_i_11,
    input [63:0] io_state_i_10,
    input [63:0] io_state_i_9,
    input [63:0] io_state_i_8,
    input [63:0] io_state_i_7,
    input [63:0] io_state_i_6,
    input [63:0] io_state_i_5,
    input [63:0] io_state_i_4,
    input [63:0] io_state_i_3,
    input [63:0] io_state_i_2,
    input [63:0] io_state_i_1,
    input [63:0] io_state_i_0,
    output[63:0] io_state_o_24,
    output[63:0] io_state_o_23,
    output[63:0] io_state_o_22,
    output[63:0] io_state_o_21,
    output[63:0] io_state_o_20,
    output[63:0] io_state_o_19,
    output[63:0] io_state_o_18,
    output[63:0] io_state_o_17,
    output[63:0] io_state_o_16,
    output[63:0] io_state_o_15,
    output[63:0] io_state_o_14,
    output[63:0] io_state_o_13,
    output[63:0] io_state_o_12,
    output[63:0] io_state_o_11,
    output[63:0] io_state_o_10,
    output[63:0] io_state_o_9,
    output[63:0] io_state_o_8,
    output[63:0] io_state_o_7,
    output[63:0] io_state_o_6,
    output[63:0] io_state_o_5,
    output[63:0] io_state_o_4,
    output[63:0] io_state_o_3,
    output[63:0] io_state_o_2,
    output[63:0] io_state_o_1,
    output[63:0] io_state_o_0
);

  wire[63:0] T0;
  wire[63:0] T96;
  wire[64:0] T1;
  wire[64:0] T2;
  wire[27:0] T3;
  wire[36:0] T4;
  wire[63:0] T97;
  wire[64:0] T5;
  wire[64:0] T6;
  wire T7;
  wire[63:0] T98;
  wire[64:0] T8;
  wire[64:0] T9;
  wire[26:0] T10;
  wire[37:0] T11;
  wire[63:0] T99;
  wire[64:0] T12;
  wire[64:0] T13;
  wire[61:0] T14;
  wire[2:0] T15;
  wire[63:0] T100;
  wire[64:0] T16;
  wire[64:0] T17;
  wire[43:0] T18;
  wire[20:0] T19;
  wire[63:0] T101;
  wire[64:0] T20;
  wire[64:0] T21;
  wire[19:0] T22;
  wire[44:0] T23;
  wire[63:0] T102;
  wire[64:0] T24;
  wire[64:0] T25;
  wire[5:0] T26;
  wire[58:0] T27;
  wire[63:0] T103;
  wire[64:0] T28;
  wire[64:0] T29;
  wire[35:0] T30;
  wire[28:0] T31;
  wire[63:0] T104;
  wire[64:0] T32;
  wire[64:0] T33;
  wire[54:0] T34;
  wire[9:0] T35;
  wire[63:0] T105;
  wire[64:0] T36;
  wire[64:0] T37;
  wire[42:0] T38;
  wire[21:0] T39;
  wire[63:0] T106;
  wire[64:0] T40;
  wire[64:0] T41;
  wire[2:0] T42;
  wire[61:0] T43;
  wire[63:0] T107;
  wire[64:0] T44;
  wire[64:0] T45;
  wire[24:0] T46;
  wire[39:0] T47;
  wire[63:0] T108;
  wire[64:0] T48;
  wire[64:0] T49;
  wire[9:0] T50;
  wire[54:0] T51;
  wire[63:0] T109;
  wire[64:0] T52;
  wire[64:0] T53;
  wire[38:0] T54;
  wire[25:0] T55;
  wire[63:0] T110;
  wire[64:0] T56;
  wire[64:0] T57;
  wire[20:0] T58;
  wire[43:0] T59;
  wire[63:0] T111;
  wire[64:0] T60;
  wire[64:0] T61;
  wire[44:0] T62;
  wire[19:0] T63;
  wire[63:0] T112;
  wire[64:0] T64;
  wire[64:0] T65;
  wire[7:0] T66;
  wire[56:0] T67;
  wire[63:0] T113;
  wire[64:0] T68;
  wire[64:0] T69;
  wire[14:0] T70;
  wire[49:0] T71;
  wire[63:0] T114;
  wire[64:0] T72;
  wire[64:0] T73;
  wire[40:0] T74;
  wire[23:0] T75;
  wire[63:0] T115;
  wire[64:0] T76;
  wire[64:0] T77;
  wire[13:0] T78;
  wire[50:0] T79;
  wire[63:0] T116;
  wire[64:0] T80;
  wire[64:0] T81;
  wire[60:0] T82;
  wire[3:0] T83;
  wire[63:0] T117;
  wire[64:0] T84;
  wire[64:0] T85;
  wire[17:0] T86;
  wire[46:0] T87;
  wire[63:0] T118;
  wire[64:0] T88;
  wire[64:0] T89;
  wire[55:0] T90;
  wire[8:0] T91;
  wire[63:0] T119;
  wire[64:0] T92;
  wire[64:0] T93;
  wire[1:0] T94;
  wire[62:0] T95;


  assign io_state_o_0 = T0;
  assign T0 = io_state_i_0;
  assign io_state_o_1 = T96;
  assign T96 = T1[6'h3f:1'h0];
  assign T1 = T2;
  assign T2 = {T4, T3};
  assign T3 = io_state_i_15[6'h3f:6'h24];
  assign T4 = io_state_i_15[6'h24:1'h0];
  assign io_state_o_2 = T97;
  assign T97 = T5[6'h3f:1'h0];
  assign T5 = T6;
  assign T6 = {io_state_i_5, T7};
  assign T7 = io_state_i_5[6'h3f:6'h3f];
  assign io_state_o_3 = T98;
  assign T98 = T8[6'h3f:1'h0];
  assign T8 = T9;
  assign T9 = {T11, T10};
  assign T10 = io_state_i_20[6'h3f:6'h25];
  assign T11 = io_state_i_20[6'h25:1'h0];
  assign io_state_o_4 = T99;
  assign T99 = T12[6'h3f:1'h0];
  assign T12 = T13;
  assign T13 = {T15, T14};
  assign T14 = io_state_i_10[6'h3f:2'h2];
  assign T15 = io_state_i_10[2'h2:1'h0];
  assign io_state_o_5 = T100;
  assign T100 = T16[6'h3f:1'h0];
  assign T16 = T17;
  assign T17 = {T19, T18};
  assign T18 = io_state_i_6[6'h3f:5'h14];
  assign T19 = io_state_i_6[5'h14:1'h0];
  assign io_state_o_6 = T101;
  assign T101 = T20[6'h3f:1'h0];
  assign T20 = T21;
  assign T21 = {T23, T22};
  assign T22 = io_state_i_21[6'h3f:6'h2c];
  assign T23 = io_state_i_21[6'h2c:1'h0];
  assign io_state_o_7 = T102;
  assign T102 = T24[6'h3f:1'h0];
  assign T24 = T25;
  assign T25 = {T27, T26};
  assign T26 = io_state_i_11[6'h3f:6'h3a];
  assign T27 = io_state_i_11[6'h3a:1'h0];
  assign io_state_o_8 = T103;
  assign T103 = T28[6'h3f:1'h0];
  assign T28 = T29;
  assign T29 = {T31, T30};
  assign T30 = io_state_i_1[6'h3f:5'h1c];
  assign T31 = io_state_i_1[5'h1c:1'h0];
  assign io_state_o_9 = T104;
  assign T104 = T32[6'h3f:1'h0];
  assign T32 = T33;
  assign T33 = {T35, T34};
  assign T34 = io_state_i_16[6'h3f:4'h9];
  assign T35 = io_state_i_16[4'h9:1'h0];
  assign io_state_o_10 = T105;
  assign T105 = T36[6'h3f:1'h0];
  assign T36 = T37;
  assign T37 = {T39, T38};
  assign T38 = io_state_i_12[6'h3f:5'h15];
  assign T39 = io_state_i_12[5'h15:1'h0];
  assign io_state_o_11 = T106;
  assign T106 = T40[6'h3f:1'h0];
  assign T40 = T41;
  assign T41 = {T43, T42};
  assign T42 = io_state_i_2[6'h3f:6'h3d];
  assign T43 = io_state_i_2[6'h3d:1'h0];
  assign io_state_o_12 = T107;
  assign T107 = T44[6'h3f:1'h0];
  assign T44 = T45;
  assign T45 = {T47, T46};
  assign T46 = io_state_i_17[6'h3f:6'h27];
  assign T47 = io_state_i_17[6'h27:1'h0];
  assign io_state_o_13 = T108;
  assign T108 = T48[6'h3f:1'h0];
  assign T48 = T49;
  assign T49 = {T51, T50};
  assign T50 = io_state_i_7[6'h3f:6'h36];
  assign T51 = io_state_i_7[6'h36:1'h0];
  assign io_state_o_14 = T109;
  assign T109 = T52[6'h3f:1'h0];
  assign T52 = T53;
  assign T53 = {T55, T54};
  assign T54 = io_state_i_22[6'h3f:5'h19];
  assign T55 = io_state_i_22[5'h19:1'h0];
  assign io_state_o_15 = T110;
  assign T110 = T56[6'h3f:1'h0];
  assign T56 = T57;
  assign T57 = {T59, T58};
  assign T58 = io_state_i_18[6'h3f:6'h2b];
  assign T59 = io_state_i_18[6'h2b:1'h0];
  assign io_state_o_16 = T111;
  assign T111 = T60[6'h3f:1'h0];
  assign T60 = T61;
  assign T61 = {T63, T62};
  assign T62 = io_state_i_8[6'h3f:5'h13];
  assign T63 = io_state_i_8[5'h13:1'h0];
  assign io_state_o_17 = T112;
  assign T112 = T64[6'h3f:1'h0];
  assign T64 = T65;
  assign T65 = {T67, T66};
  assign T66 = io_state_i_23[6'h3f:6'h38];
  assign T67 = io_state_i_23[6'h38:1'h0];
  assign io_state_o_18 = T113;
  assign T113 = T68[6'h3f:1'h0];
  assign T68 = T69;
  assign T69 = {T71, T70};
  assign T70 = io_state_i_13[6'h3f:6'h31];
  assign T71 = io_state_i_13[6'h31:1'h0];
  assign io_state_o_19 = T114;
  assign T114 = T72[6'h3f:1'h0];
  assign T72 = T73;
  assign T73 = {T75, T74};
  assign T74 = io_state_i_3[6'h3f:5'h17];
  assign T75 = io_state_i_3[5'h17:1'h0];
  assign io_state_o_20 = T115;
  assign T115 = T76[6'h3f:1'h0];
  assign T76 = T77;
  assign T77 = {T79, T78};
  assign T78 = io_state_i_24[6'h3f:6'h32];
  assign T79 = io_state_i_24[6'h32:1'h0];
  assign io_state_o_21 = T116;
  assign T116 = T80[6'h3f:1'h0];
  assign T80 = T81;
  assign T81 = {T83, T82};
  assign T82 = io_state_i_14[6'h3f:2'h3];
  assign T83 = io_state_i_14[2'h3:1'h0];
  assign io_state_o_22 = T117;
  assign T117 = T84[6'h3f:1'h0];
  assign T84 = T85;
  assign T85 = {T87, T86};
  assign T86 = io_state_i_4[6'h3f:6'h2e];
  assign T87 = io_state_i_4[6'h2e:1'h0];
  assign io_state_o_23 = T118;
  assign T118 = T88[6'h3f:1'h0];
  assign T88 = T89;
  assign T89 = {T91, T90};
  assign T90 = io_state_i_19[6'h3f:4'h8];
  assign T91 = io_state_i_19[4'h8:1'h0];
  assign io_state_o_24 = T119;
  assign T119 = T92[6'h3f:1'h0];
  assign T92 = T93;
  assign T93 = {T95, T94};
  assign T94 = io_state_i_9[6'h3f:6'h3e];
  assign T95 = io_state_i_9[6'h3e:1'h0];
endmodule

module ChiModule(
    input [63:0] io_state_i_24,
    input [63:0] io_state_i_23,
    input [63:0] io_state_i_22,
    input [63:0] io_state_i_21,
    input [63:0] io_state_i_20,
    input [63:0] io_state_i_19,
    input [63:0] io_state_i_18,
    input [63:0] io_state_i_17,
    input [63:0] io_state_i_16,
    input [63:0] io_state_i_15,
    input [63:0] io_state_i_14,
    input [63:0] io_state_i_13,
    input [63:0] io_state_i_12,
    input [63:0] io_state_i_11,
    input [63:0] io_state_i_10,
    input [63:0] io_state_i_9,
    input [63:0] io_state_i_8,
    input [63:0] io_state_i_7,
    input [63:0] io_state_i_6,
    input [63:0] io_state_i_5,
    input [63:0] io_state_i_4,
    input [63:0] io_state_i_3,
    input [63:0] io_state_i_2,
    input [63:0] io_state_i_1,
    input [63:0] io_state_i_0,
    output[63:0] io_state_o_24,
    output[63:0] io_state_o_23,
    output[63:0] io_state_o_22,
    output[63:0] io_state_o_21,
    output[63:0] io_state_o_20,
    output[63:0] io_state_o_19,
    output[63:0] io_state_o_18,
    output[63:0] io_state_o_17,
    output[63:0] io_state_o_16,
    output[63:0] io_state_o_15,
    output[63:0] io_state_o_14,
    output[63:0] io_state_o_13,
    output[63:0] io_state_o_12,
    output[63:0] io_state_o_11,
    output[63:0] io_state_o_10,
    output[63:0] io_state_o_9,
    output[63:0] io_state_o_8,
    output[63:0] io_state_o_7,
    output[63:0] io_state_o_6,
    output[63:0] io_state_o_5,
    output[63:0] io_state_o_4,
    output[63:0] io_state_o_3,
    output[63:0] io_state_o_2,
    output[63:0] io_state_o_1,
    output[63:0] io_state_o_0
);

  wire[63:0] T0;
  wire[63:0] T1;
  wire[63:0] T2;
  wire[63:0] T3;
  wire[63:0] T4;
  wire[63:0] T5;
  wire[63:0] T6;
  wire[63:0] T7;
  wire[63:0] T8;
  wire[63:0] T9;
  wire[63:0] T10;
  wire[63:0] T11;
  wire[63:0] T12;
  wire[63:0] T13;
  wire[63:0] T14;
  wire[63:0] T15;
  wire[63:0] T16;
  wire[63:0] T17;
  wire[63:0] T18;
  wire[63:0] T19;
  wire[63:0] T20;
  wire[63:0] T21;
  wire[63:0] T22;
  wire[63:0] T23;
  wire[63:0] T24;
  wire[63:0] T25;
  wire[63:0] T26;
  wire[63:0] T27;
  wire[63:0] T28;
  wire[63:0] T29;
  wire[63:0] T30;
  wire[63:0] T31;
  wire[63:0] T32;
  wire[63:0] T33;
  wire[63:0] T34;
  wire[63:0] T35;
  wire[63:0] T36;
  wire[63:0] T37;
  wire[63:0] T38;
  wire[63:0] T39;
  wire[63:0] T40;
  wire[63:0] T41;
  wire[63:0] T42;
  wire[63:0] T43;
  wire[63:0] T44;
  wire[63:0] T45;
  wire[63:0] T46;
  wire[63:0] T47;
  wire[63:0] T48;
  wire[63:0] T49;
  wire[63:0] T50;
  wire[63:0] T51;
  wire[63:0] T52;
  wire[63:0] T53;
  wire[63:0] T54;
  wire[63:0] T55;
  wire[63:0] T56;
  wire[63:0] T57;
  wire[63:0] T58;
  wire[63:0] T59;
  wire[63:0] T60;
  wire[63:0] T61;
  wire[63:0] T62;
  wire[63:0] T63;
  wire[63:0] T64;
  wire[63:0] T65;
  wire[63:0] T66;
  wire[63:0] T67;
  wire[63:0] T68;
  wire[63:0] T69;
  wire[63:0] T70;
  wire[63:0] T71;
  wire[63:0] T72;
  wire[63:0] T73;
  wire[63:0] T74;


  assign io_state_o_0 = T0;
  assign T0 = io_state_i_0 ^ T1;
  assign T1 = T2 & io_state_i_10;
  assign T2 = ~ io_state_i_5;
  assign io_state_o_1 = T3;
  assign T3 = io_state_i_1 ^ T4;
  assign T4 = T5 & io_state_i_11;
  assign T5 = ~ io_state_i_6;
  assign io_state_o_2 = T6;
  assign T6 = io_state_i_2 ^ T7;
  assign T7 = T8 & io_state_i_12;
  assign T8 = ~ io_state_i_7;
  assign io_state_o_3 = T9;
  assign T9 = io_state_i_3 ^ T10;
  assign T10 = T11 & io_state_i_13;
  assign T11 = ~ io_state_i_8;
  assign io_state_o_4 = T12;
  assign T12 = io_state_i_4 ^ T13;
  assign T13 = T14 & io_state_i_14;
  assign T14 = ~ io_state_i_9;
  assign io_state_o_5 = T15;
  assign T15 = io_state_i_5 ^ T16;
  assign T16 = T17 & io_state_i_15;
  assign T17 = ~ io_state_i_10;
  assign io_state_o_6 = T18;
  assign T18 = io_state_i_6 ^ T19;
  assign T19 = T20 & io_state_i_16;
  assign T20 = ~ io_state_i_11;
  assign io_state_o_7 = T21;
  assign T21 = io_state_i_7 ^ T22;
  assign T22 = T23 & io_state_i_17;
  assign T23 = ~ io_state_i_12;
  assign io_state_o_8 = T24;
  assign T24 = io_state_i_8 ^ T25;
  assign T25 = T26 & io_state_i_18;
  assign T26 = ~ io_state_i_13;
  assign io_state_o_9 = T27;
  assign T27 = io_state_i_9 ^ T28;
  assign T28 = T29 & io_state_i_19;
  assign T29 = ~ io_state_i_14;
  assign io_state_o_10 = T30;
  assign T30 = io_state_i_10 ^ T31;
  assign T31 = T32 & io_state_i_20;
  assign T32 = ~ io_state_i_15;
  assign io_state_o_11 = T33;
  assign T33 = io_state_i_11 ^ T34;
  assign T34 = T35 & io_state_i_21;
  assign T35 = ~ io_state_i_16;
  assign io_state_o_12 = T36;
  assign T36 = io_state_i_12 ^ T37;
  assign T37 = T38 & io_state_i_22;
  assign T38 = ~ io_state_i_17;
  assign io_state_o_13 = T39;
  assign T39 = io_state_i_13 ^ T40;
  assign T40 = T41 & io_state_i_23;
  assign T41 = ~ io_state_i_18;
  assign io_state_o_14 = T42;
  assign T42 = io_state_i_14 ^ T43;
  assign T43 = T44 & io_state_i_24;
  assign T44 = ~ io_state_i_19;
  assign io_state_o_15 = T45;
  assign T45 = io_state_i_15 ^ T46;
  assign T46 = T47 & io_state_i_0;
  assign T47 = ~ io_state_i_20;
  assign io_state_o_16 = T48;
  assign T48 = io_state_i_16 ^ T49;
  assign T49 = T50 & io_state_i_1;
  assign T50 = ~ io_state_i_21;
  assign io_state_o_17 = T51;
  assign T51 = io_state_i_17 ^ T52;
  assign T52 = T53 & io_state_i_2;
  assign T53 = ~ io_state_i_22;
  assign io_state_o_18 = T54;
  assign T54 = io_state_i_18 ^ T55;
  assign T55 = T56 & io_state_i_3;
  assign T56 = ~ io_state_i_23;
  assign io_state_o_19 = T57;
  assign T57 = io_state_i_19 ^ T58;
  assign T58 = T59 & io_state_i_4;
  assign T59 = ~ io_state_i_24;
  assign io_state_o_20 = T60;
  assign T60 = io_state_i_20 ^ T61;
  assign T61 = T62 & io_state_i_5;
  assign T62 = ~ io_state_i_0;
  assign io_state_o_21 = T63;
  assign T63 = io_state_i_21 ^ T64;
  assign T64 = T65 & io_state_i_6;
  assign T65 = ~ io_state_i_1;
  assign io_state_o_22 = T66;
  assign T66 = io_state_i_22 ^ T67;
  assign T67 = T68 & io_state_i_7;
  assign T68 = ~ io_state_i_2;
  assign io_state_o_23 = T69;
  assign T69 = io_state_i_23 ^ T70;
  assign T70 = T71 & io_state_i_8;
  assign T71 = ~ io_state_i_3;
  assign io_state_o_24 = T72;
  assign T72 = io_state_i_24 ^ T73;
  assign T73 = T74 & io_state_i_9;
  assign T74 = ~ io_state_i_4;
endmodule

module IotaModule(
    input [63:0] io_state_i_24,
    input [63:0] io_state_i_23,
    input [63:0] io_state_i_22,
    input [63:0] io_state_i_21,
    input [63:0] io_state_i_20,
    input [63:0] io_state_i_19,
    input [63:0] io_state_i_18,
    input [63:0] io_state_i_17,
    input [63:0] io_state_i_16,
    input [63:0] io_state_i_15,
    input [63:0] io_state_i_14,
    input [63:0] io_state_i_13,
    input [63:0] io_state_i_12,
    input [63:0] io_state_i_11,
    input [63:0] io_state_i_10,
    input [63:0] io_state_i_9,
    input [63:0] io_state_i_8,
    input [63:0] io_state_i_7,
    input [63:0] io_state_i_6,
    input [63:0] io_state_i_5,
    input [63:0] io_state_i_4,
    input [63:0] io_state_i_3,
    input [63:0] io_state_i_2,
    input [63:0] io_state_i_1,
    input [63:0] io_state_i_0,
    output[63:0] io_state_o_24,
    output[63:0] io_state_o_23,
    output[63:0] io_state_o_22,
    output[63:0] io_state_o_21,
    output[63:0] io_state_o_20,
    output[63:0] io_state_o_19,
    output[63:0] io_state_o_18,
    output[63:0] io_state_o_17,
    output[63:0] io_state_o_16,
    output[63:0] io_state_o_15,
    output[63:0] io_state_o_14,
    output[63:0] io_state_o_13,
    output[63:0] io_state_o_12,
    output[63:0] io_state_o_11,
    output[63:0] io_state_o_10,
    output[63:0] io_state_o_9,
    output[63:0] io_state_o_8,
    output[63:0] io_state_o_7,
    output[63:0] io_state_o_6,
    output[63:0] io_state_o_5,
    output[63:0] io_state_o_4,
    output[63:0] io_state_o_3,
    output[63:0] io_state_o_2,
    output[63:0] io_state_o_1,
    output[63:0] io_state_o_0,
    input [4:0] io_round
);

  reg [63:0] const;
  wire[63:0] T1;


  always @(*) case (io_round)
    0: const = 64'h1;
    1: const = 64'h8082;
    2: const = 64'h800000000000808a;
    3: const = 64'h8000000080008000;
    4: const = 64'h808b;
    5: const = 64'h80000001;
    6: const = 64'h8000000080008081;
    7: const = 64'h8000000000008009;
    8: const = 64'h8a;
    9: const = 64'h88;
    10: const = 64'h80008009;
    11: const = 64'h8000000a;
    12: const = 64'h8000808b;
    13: const = 64'h800000000000008b;
    14: const = 64'h8000000000008089;
    15: const = 64'h8000000000008003;
    16: const = 64'h8000000000008002;
    17: const = 64'h8000000000000080;
    18: const = 64'h800a;
    19: const = 64'h800000008000000a;
    20: const = 64'h8000000080008081;
    21: const = 64'h8000000000008080;
    22: const = 64'h80000001;
    23: const = 64'h8000000080008008;
    24: const = 64'h0;
    default: begin
      const = 64'bx;
`ifndef SYNTHESIS
// synthesis translate_off
      const = {2{$random}};
// synthesis translate_on
`endif
    end
  endcase
  assign io_state_o_0 = T1;
  assign T1 = io_state_i_0 ^ const;
  assign io_state_o_1 = io_state_i_1;
  assign io_state_o_2 = io_state_i_2;
  assign io_state_o_3 = io_state_i_3;
  assign io_state_o_4 = io_state_i_4;
  assign io_state_o_5 = io_state_i_5;
  assign io_state_o_6 = io_state_i_6;
  assign io_state_o_7 = io_state_i_7;
  assign io_state_o_8 = io_state_i_8;
  assign io_state_o_9 = io_state_i_9;
  assign io_state_o_10 = io_state_i_10;
  assign io_state_o_11 = io_state_i_11;
  assign io_state_o_12 = io_state_i_12;
  assign io_state_o_13 = io_state_i_13;
  assign io_state_o_14 = io_state_i_14;
  assign io_state_o_15 = io_state_i_15;
  assign io_state_o_16 = io_state_i_16;
  assign io_state_o_17 = io_state_i_17;
  assign io_state_o_18 = io_state_i_18;
  assign io_state_o_19 = io_state_i_19;
  assign io_state_o_20 = io_state_i_20;
  assign io_state_o_21 = io_state_i_21;
  assign io_state_o_22 = io_state_i_22;
  assign io_state_o_23 = io_state_i_23;
  assign io_state_o_24 = io_state_i_24;
endmodule

module DpathModule(input clk, input reset,
    input  io_absorb,
    input  io_init,
    input  io_write,
    input [4:0] io_round,
    input  io_stage,
    input [4:0] io_aindex,
    input [63:0] io_message_in,
    output[63:0] io_hash_out_3,
    output[63:0] io_hash_out_2,
    output[63:0] io_hash_out_1,
    output[63:0] io_hash_out_0
);

  reg [63:0] state_0;
  wire[63:0] T263;
  wire[63:0] T0;
  wire[63:0] T1;
  wire[63:0] T2;
  wire[63:0] T3;
  wire[63:0] T4;
  wire[63:0] T5;
  wire T6;
  wire[63:0] T7;
  wire[63:0] T8;
  wire[63:0] T9;
  wire[63:0] T10;
  wire[63:0] T11;
  wire[63:0] T12;
  reg [63:0] state_1;
  wire[63:0] T264;
  wire[63:0] T13;
  wire[63:0] T14;
  wire[63:0] T15;
  wire[63:0] T16;
  wire[63:0] T17;
  wire[63:0] T18;
  wire T19;
  wire T20;
  wire[31:0] T21;
  wire[4:0] T22;
  wire[4:0] T265;
  wire[5:0] T23;
  wire[5:0] T266;
  wire[4:0] T24;
  wire[5:0] T25;
  wire[2:0] T26;
  wire T27;
  wire T28;
  wire T29;
  wire[4:0] T30;
  wire[4:0] T267;
  wire[5:0] T31;
  wire[5:0] T268;
  wire[4:0] T32;
  wire[5:0] T33;
  wire[2:0] T34;
  wire[63:0] T35;
  reg [63:0] state_2;
  wire[63:0] T269;
  wire[63:0] T36;
  wire[63:0] T37;
  wire[63:0] T38;
  wire[63:0] T39;
  wire[63:0] T40;
  wire[63:0] T41;
  wire T42;
  wire T43;
  reg [63:0] state_3;
  wire[63:0] T270;
  wire[63:0] T44;
  wire[63:0] T45;
  wire[63:0] T46;
  wire[63:0] T47;
  wire[63:0] T48;
  wire[63:0] T49;
  wire T50;
  wire T51;
  wire T52;
  wire T53;
  wire[63:0] T54;
  wire[63:0] T55;
  reg [63:0] state_4;
  wire[63:0] T271;
  wire[63:0] T56;
  wire[63:0] T57;
  wire[63:0] T58;
  wire[63:0] T59;
  wire[63:0] T60;
  wire[63:0] T61;
  wire T62;
  wire T63;
  reg [63:0] state_5;
  wire[63:0] T272;
  wire[63:0] T64;
  wire[63:0] T65;
  wire[63:0] T66;
  wire[63:0] T67;
  wire[63:0] T68;
  wire[63:0] T69;
  wire T70;
  wire T71;
  wire T72;
  wire[63:0] T73;
  reg [63:0] state_6;
  wire[63:0] T273;
  wire[63:0] T74;
  wire[63:0] T75;
  wire[63:0] T76;
  wire[63:0] T77;
  wire[63:0] T78;
  wire[63:0] T79;
  wire T80;
  wire T81;
  reg [63:0] state_7;
  wire[63:0] T274;
  wire[63:0] T82;
  wire[63:0] T83;
  wire[63:0] T84;
  wire[63:0] T85;
  wire[63:0] T86;
  wire[63:0] T87;
  wire T88;
  wire T89;
  wire T90;
  wire T91;
  wire T92;
  wire[63:0] T93;
  wire[63:0] T94;
  wire[63:0] T95;
  reg [63:0] state_8;
  wire[63:0] T275;
  wire[63:0] T96;
  wire[63:0] T97;
  wire[63:0] T98;
  wire[63:0] T99;
  wire[63:0] T100;
  wire[63:0] T101;
  wire T102;
  wire T103;
  reg [63:0] state_9;
  wire[63:0] T276;
  wire[63:0] T104;
  wire[63:0] T105;
  wire[63:0] T106;
  wire[63:0] T107;
  wire[63:0] T108;
  wire[63:0] T109;
  wire T110;
  wire T111;
  wire T112;
  wire[63:0] T113;
  reg [63:0] state_10;
  wire[63:0] T277;
  wire[63:0] T114;
  wire[63:0] T115;
  wire[63:0] T116;
  wire[63:0] T117;
  wire[63:0] T118;
  wire[63:0] T119;
  wire T120;
  wire T121;
  reg [63:0] state_11;
  wire[63:0] T278;
  wire[63:0] T122;
  wire[63:0] T123;
  wire[63:0] T124;
  wire[63:0] T125;
  wire[63:0] T126;
  wire[63:0] T127;
  wire T128;
  wire T129;
  wire T130;
  wire T131;
  wire[63:0] T132;
  wire[63:0] T133;
  reg [63:0] state_12;
  wire[63:0] T279;
  wire[63:0] T134;
  wire[63:0] T135;
  wire[63:0] T136;
  wire[63:0] T137;
  wire[63:0] T138;
  wire[63:0] T139;
  wire T140;
  wire T141;
  reg [63:0] state_13;
  wire[63:0] T280;
  wire[63:0] T142;
  wire[63:0] T143;
  wire[63:0] T144;
  wire[63:0] T145;
  wire[63:0] T146;
  wire[63:0] T147;
  wire T148;
  wire T149;
  wire T150;
  wire[63:0] T151;
  reg [63:0] state_14;
  wire[63:0] T281;
  wire[63:0] T152;
  wire[63:0] T153;
  wire[63:0] T154;
  wire[63:0] T155;
  wire[63:0] T156;
  wire[63:0] T157;
  wire T158;
  wire T159;
  reg [63:0] state_15;
  wire[63:0] T282;
  wire[63:0] T160;
  wire[63:0] T161;
  wire[63:0] T162;
  wire[63:0] T163;
  wire[63:0] T164;
  wire[63:0] T165;
  wire T166;
  wire T167;
  wire T168;
  wire T169;
  wire T170;
  wire T171;
  wire[63:0] T172;
  wire[63:0] T173;
  wire[63:0] T174;
  wire[63:0] T175;
  reg [63:0] state_16;
  wire[63:0] T283;
  wire[63:0] T176;
  wire[63:0] T177;
  wire[63:0] T178;
  wire[63:0] T179;
  wire[63:0] T180;
  wire[63:0] T181;
  wire T182;
  wire T183;
  reg [63:0] state_17;
  wire[63:0] T284;
  wire[63:0] T184;
  wire[63:0] T185;
  wire[63:0] T186;
  wire[63:0] T187;
  wire[63:0] T188;
  wire[63:0] T189;
  wire T190;
  wire T191;
  wire T192;
  wire[63:0] T193;
  reg [63:0] state_18;
  wire[63:0] T285;
  wire[63:0] T194;
  wire[63:0] T195;
  wire[63:0] T196;
  wire[63:0] T197;
  wire[63:0] T198;
  wire[63:0] T199;
  wire T200;
  wire T201;
  reg [63:0] state_19;
  wire[63:0] T286;
  wire[63:0] T202;
  wire[63:0] T203;
  wire[63:0] T204;
  wire[63:0] T205;
  wire[63:0] T206;
  wire[63:0] T207;
  wire T208;
  wire T209;
  wire T210;
  wire T211;
  wire[63:0] T212;
  wire[63:0] T213;
  reg [63:0] state_20;
  wire[63:0] T287;
  wire[63:0] T214;
  wire[63:0] T215;
  wire[63:0] T216;
  wire[63:0] T217;
  wire[63:0] T218;
  wire[63:0] T219;
  wire T220;
  wire T221;
  reg [63:0] state_21;
  wire[63:0] T288;
  wire[63:0] T222;
  wire[63:0] T223;
  wire[63:0] T224;
  wire[63:0] T225;
  wire[63:0] T226;
  wire[63:0] T227;
  wire T228;
  wire T229;
  wire T230;
  wire[63:0] T231;
  reg [63:0] state_22;
  wire[63:0] T289;
  wire[63:0] T232;
  wire[63:0] T233;
  wire[63:0] T234;
  wire[63:0] T235;
  wire[63:0] T236;
  wire[63:0] T237;
  wire T238;
  wire T239;
  reg [63:0] state_23;
  wire[63:0] T290;
  wire[63:0] T240;
  wire[63:0] T241;
  wire[63:0] T242;
  wire[63:0] T243;
  wire[63:0] T244;
  wire[63:0] T245;
  wire T246;
  wire T247;
  wire T248;
  wire T249;
  wire T250;
  reg [63:0] state_24;
  wire[63:0] T291;
  wire[63:0] T251;
  wire[63:0] T252;
  wire[63:0] T253;
  wire[63:0] T254;
  wire[63:0] T255;
  wire[63:0] T256;
  wire T257;
  wire T258;
  wire T259;
  wire T260;
  wire T261;
  wire T262;
  wire[63:0] ThetaModule_io_state_o_24;
  wire[63:0] ThetaModule_io_state_o_23;
  wire[63:0] ThetaModule_io_state_o_22;
  wire[63:0] ThetaModule_io_state_o_21;
  wire[63:0] ThetaModule_io_state_o_20;
  wire[63:0] ThetaModule_io_state_o_19;
  wire[63:0] ThetaModule_io_state_o_18;
  wire[63:0] ThetaModule_io_state_o_17;
  wire[63:0] ThetaModule_io_state_o_16;
  wire[63:0] ThetaModule_io_state_o_15;
  wire[63:0] ThetaModule_io_state_o_14;
  wire[63:0] ThetaModule_io_state_o_13;
  wire[63:0] ThetaModule_io_state_o_12;
  wire[63:0] ThetaModule_io_state_o_11;
  wire[63:0] ThetaModule_io_state_o_10;
  wire[63:0] ThetaModule_io_state_o_9;
  wire[63:0] ThetaModule_io_state_o_8;
  wire[63:0] ThetaModule_io_state_o_7;
  wire[63:0] ThetaModule_io_state_o_6;
  wire[63:0] ThetaModule_io_state_o_5;
  wire[63:0] ThetaModule_io_state_o_4;
  wire[63:0] ThetaModule_io_state_o_3;
  wire[63:0] ThetaModule_io_state_o_2;
  wire[63:0] ThetaModule_io_state_o_1;
  wire[63:0] ThetaModule_io_state_o_0;
  wire[63:0] RhoPiModule_io_state_o_24;
  wire[63:0] RhoPiModule_io_state_o_23;
  wire[63:0] RhoPiModule_io_state_o_22;
  wire[63:0] RhoPiModule_io_state_o_21;
  wire[63:0] RhoPiModule_io_state_o_20;
  wire[63:0] RhoPiModule_io_state_o_19;
  wire[63:0] RhoPiModule_io_state_o_18;
  wire[63:0] RhoPiModule_io_state_o_17;
  wire[63:0] RhoPiModule_io_state_o_16;
  wire[63:0] RhoPiModule_io_state_o_15;
  wire[63:0] RhoPiModule_io_state_o_14;
  wire[63:0] RhoPiModule_io_state_o_13;
  wire[63:0] RhoPiModule_io_state_o_12;
  wire[63:0] RhoPiModule_io_state_o_11;
  wire[63:0] RhoPiModule_io_state_o_10;
  wire[63:0] RhoPiModule_io_state_o_9;
  wire[63:0] RhoPiModule_io_state_o_8;
  wire[63:0] RhoPiModule_io_state_o_7;
  wire[63:0] RhoPiModule_io_state_o_6;
  wire[63:0] RhoPiModule_io_state_o_5;
  wire[63:0] RhoPiModule_io_state_o_4;
  wire[63:0] RhoPiModule_io_state_o_3;
  wire[63:0] RhoPiModule_io_state_o_2;
  wire[63:0] RhoPiModule_io_state_o_1;
  wire[63:0] RhoPiModule_io_state_o_0;
  wire[63:0] ChiModule_io_state_o_24;
  wire[63:0] ChiModule_io_state_o_23;
  wire[63:0] ChiModule_io_state_o_22;
  wire[63:0] ChiModule_io_state_o_21;
  wire[63:0] ChiModule_io_state_o_20;
  wire[63:0] ChiModule_io_state_o_19;
  wire[63:0] ChiModule_io_state_o_18;
  wire[63:0] ChiModule_io_state_o_17;
  wire[63:0] ChiModule_io_state_o_16;
  wire[63:0] ChiModule_io_state_o_15;
  wire[63:0] ChiModule_io_state_o_14;
  wire[63:0] ChiModule_io_state_o_13;
  wire[63:0] ChiModule_io_state_o_12;
  wire[63:0] ChiModule_io_state_o_11;
  wire[63:0] ChiModule_io_state_o_10;
  wire[63:0] ChiModule_io_state_o_9;
  wire[63:0] ChiModule_io_state_o_8;
  wire[63:0] ChiModule_io_state_o_7;
  wire[63:0] ChiModule_io_state_o_6;
  wire[63:0] ChiModule_io_state_o_5;
  wire[63:0] ChiModule_io_state_o_4;
  wire[63:0] ChiModule_io_state_o_3;
  wire[63:0] ChiModule_io_state_o_2;
  wire[63:0] ChiModule_io_state_o_1;
  wire[63:0] ChiModule_io_state_o_0;
  wire[63:0] iota_io_state_o_24;
  wire[63:0] iota_io_state_o_23;
  wire[63:0] iota_io_state_o_22;
  wire[63:0] iota_io_state_o_21;
  wire[63:0] iota_io_state_o_20;
  wire[63:0] iota_io_state_o_19;
  wire[63:0] iota_io_state_o_18;
  wire[63:0] iota_io_state_o_17;
  wire[63:0] iota_io_state_o_16;
  wire[63:0] iota_io_state_o_15;
  wire[63:0] iota_io_state_o_14;
  wire[63:0] iota_io_state_o_13;
  wire[63:0] iota_io_state_o_12;
  wire[63:0] iota_io_state_o_11;
  wire[63:0] iota_io_state_o_10;
  wire[63:0] iota_io_state_o_9;
  wire[63:0] iota_io_state_o_8;
  wire[63:0] iota_io_state_o_7;
  wire[63:0] iota_io_state_o_6;
  wire[63:0] iota_io_state_o_5;
  wire[63:0] iota_io_state_o_4;
  wire[63:0] iota_io_state_o_3;
  wire[63:0] iota_io_state_o_2;
  wire[63:0] iota_io_state_o_1;
  wire[63:0] iota_io_state_o_0;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    state_0 = {2{$random}};
    state_1 = {2{$random}};
    state_2 = {2{$random}};
    state_3 = {2{$random}};
    state_4 = {2{$random}};
    state_5 = {2{$random}};
    state_6 = {2{$random}};
    state_7 = {2{$random}};
    state_8 = {2{$random}};
    state_9 = {2{$random}};
    state_10 = {2{$random}};
    state_11 = {2{$random}};
    state_12 = {2{$random}};
    state_13 = {2{$random}};
    state_14 = {2{$random}};
    state_15 = {2{$random}};
    state_16 = {2{$random}};
    state_17 = {2{$random}};
    state_18 = {2{$random}};
    state_19 = {2{$random}};
    state_20 = {2{$random}};
    state_21 = {2{$random}};
    state_22 = {2{$random}};
    state_23 = {2{$random}};
    state_24 = {2{$random}};
  end
// synthesis translate_on
`endif

  assign T263 = reset ? 64'h0 : T0;
  assign T0 = reset ? 64'h0 : T1;
  assign T1 = io_init ? 64'h0 : T2;
  assign T2 = io_write ? state_0 : T3;
  assign T3 = T261 ? T7 : T4;
  assign T4 = io_absorb ? state_0 : T5;
  assign T5 = T6 ? iota_io_state_o_0 : iota_io_state_o_0;
  assign T6 = 1'h0 == io_stage;
  assign T7 = T8 ^ io_message_in;
  assign T8 = T260 ? T172 : T9;
  assign T9 = T171 ? T93 : T10;
  assign T10 = T92 ? T54 : T11;
  assign T11 = T53 ? T35 : T12;
  assign T12 = T29 ? state_1 : state_0;
  assign T264 = reset ? 64'h0 : T13;
  assign T13 = reset ? 64'h0 : T14;
  assign T14 = io_init ? 64'h0 : T15;
  assign T15 = io_write ? state_1 : T16;
  assign T16 = T19 ? T7 : T17;
  assign T17 = io_absorb ? state_1 : T18;
  assign T18 = T6 ? iota_io_state_o_1 : iota_io_state_o_1;
  assign T19 = T27 & T20;
  assign T20 = T21[1'h1:1'h1];
  assign T21 = 1'h1 << T22;
  assign T22 = T265;
  assign T265 = T23[3'h4:1'h0];
  assign T23 = T25 + T266;
  assign T266 = {1'h0, T24};
  assign T24 = io_aindex / 3'h5;
  assign T25 = T26 * 3'h5;
  assign T26 = io_aindex % 3'h5;
  assign T27 = io_absorb & T28;
  assign T28 = io_aindex < 5'h11;
  assign T29 = T30[1'h0:1'h0];
  assign T30 = T267;
  assign T267 = T31[3'h4:1'h0];
  assign T31 = T33 + T268;
  assign T268 = {1'h0, T32};
  assign T32 = io_aindex / 3'h5;
  assign T33 = T34 * 3'h5;
  assign T34 = io_aindex % 3'h5;
  assign T35 = T52 ? state_3 : state_2;
  assign T269 = reset ? 64'h0 : T36;
  assign T36 = reset ? 64'h0 : T37;
  assign T37 = io_init ? 64'h0 : T38;
  assign T38 = io_write ? state_2 : T39;
  assign T39 = T42 ? T7 : T40;
  assign T40 = io_absorb ? state_2 : T41;
  assign T41 = T6 ? iota_io_state_o_2 : iota_io_state_o_2;
  assign T42 = T27 & T43;
  assign T43 = T21[2'h2:2'h2];
  assign T270 = reset ? 64'h0 : T44;
  assign T44 = reset ? 64'h0 : T45;
  assign T45 = io_init ? 64'h0 : T46;
  assign T46 = io_write ? state_3 : T47;
  assign T47 = T50 ? T7 : T48;
  assign T48 = io_absorb ? state_3 : T49;
  assign T49 = T6 ? iota_io_state_o_3 : iota_io_state_o_3;
  assign T50 = T27 & T51;
  assign T51 = T21[2'h3:2'h3];
  assign T52 = T30[1'h0:1'h0];
  assign T53 = T30[1'h1:1'h1];
  assign T54 = T91 ? T73 : T55;
  assign T55 = T72 ? state_5 : state_4;
  assign T271 = reset ? 64'h0 : T56;
  assign T56 = reset ? 64'h0 : T57;
  assign T57 = io_init ? 64'h0 : T58;
  assign T58 = io_write ? state_4 : T59;
  assign T59 = T62 ? T7 : T60;
  assign T60 = io_absorb ? state_4 : T61;
  assign T61 = T6 ? iota_io_state_o_4 : iota_io_state_o_4;
  assign T62 = T27 & T63;
  assign T63 = T21[3'h4:3'h4];
  assign T272 = reset ? 64'h0 : T64;
  assign T64 = reset ? 64'h0 : T65;
  assign T65 = io_init ? 64'h0 : T66;
  assign T66 = io_write ? state_5 : T67;
  assign T67 = T70 ? T7 : T68;
  assign T68 = io_absorb ? state_5 : T69;
  assign T69 = T6 ? iota_io_state_o_5 : iota_io_state_o_5;
  assign T70 = T27 & T71;
  assign T71 = T21[3'h5:3'h5];
  assign T72 = T30[1'h0:1'h0];
  assign T73 = T90 ? state_7 : state_6;
  assign T273 = reset ? 64'h0 : T74;
  assign T74 = reset ? 64'h0 : T75;
  assign T75 = io_init ? 64'h0 : T76;
  assign T76 = io_write ? state_6 : T77;
  assign T77 = T80 ? T7 : T78;
  assign T78 = io_absorb ? state_6 : T79;
  assign T79 = T6 ? iota_io_state_o_6 : iota_io_state_o_6;
  assign T80 = T27 & T81;
  assign T81 = T21[3'h6:3'h6];
  assign T274 = reset ? 64'h0 : T82;
  assign T82 = reset ? 64'h0 : T83;
  assign T83 = io_init ? 64'h0 : T84;
  assign T84 = io_write ? state_7 : T85;
  assign T85 = T88 ? T7 : T86;
  assign T86 = io_absorb ? state_7 : T87;
  assign T87 = T6 ? iota_io_state_o_7 : iota_io_state_o_7;
  assign T88 = T27 & T89;
  assign T89 = T21[3'h7:3'h7];
  assign T90 = T30[1'h0:1'h0];
  assign T91 = T30[1'h1:1'h1];
  assign T92 = T30[2'h2:2'h2];
  assign T93 = T170 ? T132 : T94;
  assign T94 = T131 ? T113 : T95;
  assign T95 = T112 ? state_9 : state_8;
  assign T275 = reset ? 64'h0 : T96;
  assign T96 = reset ? 64'h0 : T97;
  assign T97 = io_init ? 64'h0 : T98;
  assign T98 = io_write ? state_8 : T99;
  assign T99 = T102 ? T7 : T100;
  assign T100 = io_absorb ? state_8 : T101;
  assign T101 = T6 ? iota_io_state_o_8 : iota_io_state_o_8;
  assign T102 = T27 & T103;
  assign T103 = T21[4'h8:4'h8];
  assign T276 = reset ? 64'h0 : T104;
  assign T104 = reset ? 64'h0 : T105;
  assign T105 = io_init ? 64'h0 : T106;
  assign T106 = io_write ? state_9 : T107;
  assign T107 = T110 ? T7 : T108;
  assign T108 = io_absorb ? state_9 : T109;
  assign T109 = T6 ? iota_io_state_o_9 : iota_io_state_o_9;
  assign T110 = T27 & T111;
  assign T111 = T21[4'h9:4'h9];
  assign T112 = T30[1'h0:1'h0];
  assign T113 = T130 ? state_11 : state_10;
  assign T277 = reset ? 64'h0 : T114;
  assign T114 = reset ? 64'h0 : T115;
  assign T115 = io_init ? 64'h0 : T116;
  assign T116 = io_write ? state_10 : T117;
  assign T117 = T120 ? T7 : T118;
  assign T118 = io_absorb ? state_10 : T119;
  assign T119 = T6 ? iota_io_state_o_10 : iota_io_state_o_10;
  assign T120 = T27 & T121;
  assign T121 = T21[4'ha:4'ha];
  assign T278 = reset ? 64'h0 : T122;
  assign T122 = reset ? 64'h0 : T123;
  assign T123 = io_init ? 64'h0 : T124;
  assign T124 = io_write ? state_11 : T125;
  assign T125 = T128 ? T7 : T126;
  assign T126 = io_absorb ? state_11 : T127;
  assign T127 = T6 ? iota_io_state_o_11 : iota_io_state_o_11;
  assign T128 = T27 & T129;
  assign T129 = T21[4'hb:4'hb];
  assign T130 = T30[1'h0:1'h0];
  assign T131 = T30[1'h1:1'h1];
  assign T132 = T169 ? T151 : T133;
  assign T133 = T150 ? state_13 : state_12;
  assign T279 = reset ? 64'h0 : T134;
  assign T134 = reset ? 64'h0 : T135;
  assign T135 = io_init ? 64'h0 : T136;
  assign T136 = io_write ? state_12 : T137;
  assign T137 = T140 ? T7 : T138;
  assign T138 = io_absorb ? state_12 : T139;
  assign T139 = T6 ? iota_io_state_o_12 : iota_io_state_o_12;
  assign T140 = T27 & T141;
  assign T141 = T21[4'hc:4'hc];
  assign T280 = reset ? 64'h0 : T142;
  assign T142 = reset ? 64'h0 : T143;
  assign T143 = io_init ? 64'h0 : T144;
  assign T144 = io_write ? state_13 : T145;
  assign T145 = T148 ? T7 : T146;
  assign T146 = io_absorb ? state_13 : T147;
  assign T147 = T6 ? iota_io_state_o_13 : iota_io_state_o_13;
  assign T148 = T27 & T149;
  assign T149 = T21[4'hd:4'hd];
  assign T150 = T30[1'h0:1'h0];
  assign T151 = T168 ? state_15 : state_14;
  assign T281 = reset ? 64'h0 : T152;
  assign T152 = reset ? 64'h0 : T153;
  assign T153 = io_init ? 64'h0 : T154;
  assign T154 = io_write ? state_14 : T155;
  assign T155 = T158 ? T7 : T156;
  assign T156 = io_absorb ? state_14 : T157;
  assign T157 = T6 ? iota_io_state_o_14 : iota_io_state_o_14;
  assign T158 = T27 & T159;
  assign T159 = T21[4'he:4'he];
  assign T282 = reset ? 64'h0 : T160;
  assign T160 = reset ? 64'h0 : T161;
  assign T161 = io_init ? 64'h0 : T162;
  assign T162 = io_write ? state_15 : T163;
  assign T163 = T166 ? T7 : T164;
  assign T164 = io_absorb ? state_15 : T165;
  assign T165 = T6 ? iota_io_state_o_15 : iota_io_state_o_15;
  assign T166 = T27 & T167;
  assign T167 = T21[4'hf:4'hf];
  assign T168 = T30[1'h0:1'h0];
  assign T169 = T30[1'h1:1'h1];
  assign T170 = T30[2'h2:2'h2];
  assign T171 = T30[2'h3:2'h3];
  assign T172 = T259 ? state_24 : T173;
  assign T173 = T250 ? T212 : T174;
  assign T174 = T211 ? T193 : T175;
  assign T175 = T192 ? state_17 : state_16;
  assign T283 = reset ? 64'h0 : T176;
  assign T176 = reset ? 64'h0 : T177;
  assign T177 = io_init ? 64'h0 : T178;
  assign T178 = io_write ? state_16 : T179;
  assign T179 = T182 ? T7 : T180;
  assign T180 = io_absorb ? state_16 : T181;
  assign T181 = T6 ? iota_io_state_o_16 : iota_io_state_o_16;
  assign T182 = T27 & T183;
  assign T183 = T21[5'h10:5'h10];
  assign T284 = reset ? 64'h0 : T184;
  assign T184 = reset ? 64'h0 : T185;
  assign T185 = io_init ? 64'h0 : T186;
  assign T186 = io_write ? state_17 : T187;
  assign T187 = T190 ? T7 : T188;
  assign T188 = io_absorb ? state_17 : T189;
  assign T189 = T6 ? iota_io_state_o_17 : iota_io_state_o_17;
  assign T190 = T27 & T191;
  assign T191 = T21[5'h11:5'h11];
  assign T192 = T30[1'h0:1'h0];
  assign T193 = T210 ? state_19 : state_18;
  assign T285 = reset ? 64'h0 : T194;
  assign T194 = reset ? 64'h0 : T195;
  assign T195 = io_init ? 64'h0 : T196;
  assign T196 = io_write ? state_18 : T197;
  assign T197 = T200 ? T7 : T198;
  assign T198 = io_absorb ? state_18 : T199;
  assign T199 = T6 ? iota_io_state_o_18 : iota_io_state_o_18;
  assign T200 = T27 & T201;
  assign T201 = T21[5'h12:5'h12];
  assign T286 = reset ? 64'h0 : T202;
  assign T202 = reset ? 64'h0 : T203;
  assign T203 = io_init ? 64'h0 : T204;
  assign T204 = io_write ? state_19 : T205;
  assign T205 = T208 ? T7 : T206;
  assign T206 = io_absorb ? state_19 : T207;
  assign T207 = T6 ? iota_io_state_o_19 : iota_io_state_o_19;
  assign T208 = T27 & T209;
  assign T209 = T21[5'h13:5'h13];
  assign T210 = T30[1'h0:1'h0];
  assign T211 = T30[1'h1:1'h1];
  assign T212 = T249 ? T231 : T213;
  assign T213 = T230 ? state_21 : state_20;
  assign T287 = reset ? 64'h0 : T214;
  assign T214 = reset ? 64'h0 : T215;
  assign T215 = io_init ? 64'h0 : T216;
  assign T216 = io_write ? state_20 : T217;
  assign T217 = T220 ? T7 : T218;
  assign T218 = io_absorb ? state_20 : T219;
  assign T219 = T6 ? iota_io_state_o_20 : iota_io_state_o_20;
  assign T220 = T27 & T221;
  assign T221 = T21[5'h14:5'h14];
  assign T288 = reset ? 64'h0 : T222;
  assign T222 = reset ? 64'h0 : T223;
  assign T223 = io_init ? 64'h0 : T224;
  assign T224 = io_write ? state_21 : T225;
  assign T225 = T228 ? T7 : T226;
  assign T226 = io_absorb ? state_21 : T227;
  assign T227 = T6 ? iota_io_state_o_21 : iota_io_state_o_21;
  assign T228 = T27 & T229;
  assign T229 = T21[5'h15:5'h15];
  assign T230 = T30[1'h0:1'h0];
  assign T231 = T248 ? state_23 : state_22;
  assign T289 = reset ? 64'h0 : T232;
  assign T232 = reset ? 64'h0 : T233;
  assign T233 = io_init ? 64'h0 : T234;
  assign T234 = io_write ? state_22 : T235;
  assign T235 = T238 ? T7 : T236;
  assign T236 = io_absorb ? state_22 : T237;
  assign T237 = T6 ? iota_io_state_o_22 : iota_io_state_o_22;
  assign T238 = T27 & T239;
  assign T239 = T21[5'h16:5'h16];
  assign T290 = reset ? 64'h0 : T240;
  assign T240 = reset ? 64'h0 : T241;
  assign T241 = io_init ? 64'h0 : T242;
  assign T242 = io_write ? state_23 : T243;
  assign T243 = T246 ? T7 : T244;
  assign T244 = io_absorb ? state_23 : T245;
  assign T245 = T6 ? iota_io_state_o_23 : iota_io_state_o_23;
  assign T246 = T27 & T247;
  assign T247 = T21[5'h17:5'h17];
  assign T248 = T30[1'h0:1'h0];
  assign T249 = T30[1'h1:1'h1];
  assign T250 = T30[2'h2:2'h2];
  assign T291 = reset ? 64'h0 : T251;
  assign T251 = reset ? 64'h0 : T252;
  assign T252 = io_init ? 64'h0 : T253;
  assign T253 = io_write ? state_24 : T254;
  assign T254 = T257 ? T7 : T255;
  assign T255 = io_absorb ? state_24 : T256;
  assign T256 = T6 ? iota_io_state_o_24 : iota_io_state_o_24;
  assign T257 = T27 & T258;
  assign T258 = T21[5'h18:5'h18];
  assign T259 = T30[2'h3:2'h3];
  assign T260 = T30[3'h4:3'h4];
  assign T261 = T27 & T262;
  assign T262 = T21[1'h0:1'h0];
  assign io_hash_out_0 = state_0;
  assign io_hash_out_1 = state_5;
  assign io_hash_out_2 = state_10;
  assign io_hash_out_3 = state_15;
  ThetaModule ThetaModule(
       .io_state_i_24( state_24 ),
       .io_state_i_23( state_23 ),
       .io_state_i_22( state_22 ),
       .io_state_i_21( state_21 ),
       .io_state_i_20( state_20 ),
       .io_state_i_19( state_19 ),
       .io_state_i_18( state_18 ),
       .io_state_i_17( state_17 ),
       .io_state_i_16( state_16 ),
       .io_state_i_15( state_15 ),
       .io_state_i_14( state_14 ),
       .io_state_i_13( state_13 ),
       .io_state_i_12( state_12 ),
       .io_state_i_11( state_11 ),
       .io_state_i_10( state_10 ),
       .io_state_i_9( state_9 ),
       .io_state_i_8( state_8 ),
       .io_state_i_7( state_7 ),
       .io_state_i_6( state_6 ),
       .io_state_i_5( state_5 ),
       .io_state_i_4( state_4 ),
       .io_state_i_3( state_3 ),
       .io_state_i_2( state_2 ),
       .io_state_i_1( state_1 ),
       .io_state_i_0( state_0 ),
       .io_state_o_24( ThetaModule_io_state_o_24 ),
       .io_state_o_23( ThetaModule_io_state_o_23 ),
       .io_state_o_22( ThetaModule_io_state_o_22 ),
       .io_state_o_21( ThetaModule_io_state_o_21 ),
       .io_state_o_20( ThetaModule_io_state_o_20 ),
       .io_state_o_19( ThetaModule_io_state_o_19 ),
       .io_state_o_18( ThetaModule_io_state_o_18 ),
       .io_state_o_17( ThetaModule_io_state_o_17 ),
       .io_state_o_16( ThetaModule_io_state_o_16 ),
       .io_state_o_15( ThetaModule_io_state_o_15 ),
       .io_state_o_14( ThetaModule_io_state_o_14 ),
       .io_state_o_13( ThetaModule_io_state_o_13 ),
       .io_state_o_12( ThetaModule_io_state_o_12 ),
       .io_state_o_11( ThetaModule_io_state_o_11 ),
       .io_state_o_10( ThetaModule_io_state_o_10 ),
       .io_state_o_9( ThetaModule_io_state_o_9 ),
       .io_state_o_8( ThetaModule_io_state_o_8 ),
       .io_state_o_7( ThetaModule_io_state_o_7 ),
       .io_state_o_6( ThetaModule_io_state_o_6 ),
       .io_state_o_5( ThetaModule_io_state_o_5 ),
       .io_state_o_4( ThetaModule_io_state_o_4 ),
       .io_state_o_3( ThetaModule_io_state_o_3 ),
       .io_state_o_2( ThetaModule_io_state_o_2 ),
       .io_state_o_1( ThetaModule_io_state_o_1 ),
       .io_state_o_0( ThetaModule_io_state_o_0 )
  );
  RhoPiModule RhoPiModule(
       .io_state_i_24( ThetaModule_io_state_o_24 ),
       .io_state_i_23( ThetaModule_io_state_o_23 ),
       .io_state_i_22( ThetaModule_io_state_o_22 ),
       .io_state_i_21( ThetaModule_io_state_o_21 ),
       .io_state_i_20( ThetaModule_io_state_o_20 ),
       .io_state_i_19( ThetaModule_io_state_o_19 ),
       .io_state_i_18( ThetaModule_io_state_o_18 ),
       .io_state_i_17( ThetaModule_io_state_o_17 ),
       .io_state_i_16( ThetaModule_io_state_o_16 ),
       .io_state_i_15( ThetaModule_io_state_o_15 ),
       .io_state_i_14( ThetaModule_io_state_o_14 ),
       .io_state_i_13( ThetaModule_io_state_o_13 ),
       .io_state_i_12( ThetaModule_io_state_o_12 ),
       .io_state_i_11( ThetaModule_io_state_o_11 ),
       .io_state_i_10( ThetaModule_io_state_o_10 ),
       .io_state_i_9( ThetaModule_io_state_o_9 ),
       .io_state_i_8( ThetaModule_io_state_o_8 ),
       .io_state_i_7( ThetaModule_io_state_o_7 ),
       .io_state_i_6( ThetaModule_io_state_o_6 ),
       .io_state_i_5( ThetaModule_io_state_o_5 ),
       .io_state_i_4( ThetaModule_io_state_o_4 ),
       .io_state_i_3( ThetaModule_io_state_o_3 ),
       .io_state_i_2( ThetaModule_io_state_o_2 ),
       .io_state_i_1( ThetaModule_io_state_o_1 ),
       .io_state_i_0( ThetaModule_io_state_o_0 ),
       .io_state_o_24( RhoPiModule_io_state_o_24 ),
       .io_state_o_23( RhoPiModule_io_state_o_23 ),
       .io_state_o_22( RhoPiModule_io_state_o_22 ),
       .io_state_o_21( RhoPiModule_io_state_o_21 ),
       .io_state_o_20( RhoPiModule_io_state_o_20 ),
       .io_state_o_19( RhoPiModule_io_state_o_19 ),
       .io_state_o_18( RhoPiModule_io_state_o_18 ),
       .io_state_o_17( RhoPiModule_io_state_o_17 ),
       .io_state_o_16( RhoPiModule_io_state_o_16 ),
       .io_state_o_15( RhoPiModule_io_state_o_15 ),
       .io_state_o_14( RhoPiModule_io_state_o_14 ),
       .io_state_o_13( RhoPiModule_io_state_o_13 ),
       .io_state_o_12( RhoPiModule_io_state_o_12 ),
       .io_state_o_11( RhoPiModule_io_state_o_11 ),
       .io_state_o_10( RhoPiModule_io_state_o_10 ),
       .io_state_o_9( RhoPiModule_io_state_o_9 ),
       .io_state_o_8( RhoPiModule_io_state_o_8 ),
       .io_state_o_7( RhoPiModule_io_state_o_7 ),
       .io_state_o_6( RhoPiModule_io_state_o_6 ),
       .io_state_o_5( RhoPiModule_io_state_o_5 ),
       .io_state_o_4( RhoPiModule_io_state_o_4 ),
       .io_state_o_3( RhoPiModule_io_state_o_3 ),
       .io_state_o_2( RhoPiModule_io_state_o_2 ),
       .io_state_o_1( RhoPiModule_io_state_o_1 ),
       .io_state_o_0( RhoPiModule_io_state_o_0 )
  );
  ChiModule ChiModule(
       .io_state_i_24( RhoPiModule_io_state_o_24 ),
       .io_state_i_23( RhoPiModule_io_state_o_23 ),
       .io_state_i_22( RhoPiModule_io_state_o_22 ),
       .io_state_i_21( RhoPiModule_io_state_o_21 ),
       .io_state_i_20( RhoPiModule_io_state_o_20 ),
       .io_state_i_19( RhoPiModule_io_state_o_19 ),
       .io_state_i_18( RhoPiModule_io_state_o_18 ),
       .io_state_i_17( RhoPiModule_io_state_o_17 ),
       .io_state_i_16( RhoPiModule_io_state_o_16 ),
       .io_state_i_15( RhoPiModule_io_state_o_15 ),
       .io_state_i_14( RhoPiModule_io_state_o_14 ),
       .io_state_i_13( RhoPiModule_io_state_o_13 ),
       .io_state_i_12( RhoPiModule_io_state_o_12 ),
       .io_state_i_11( RhoPiModule_io_state_o_11 ),
       .io_state_i_10( RhoPiModule_io_state_o_10 ),
       .io_state_i_9( RhoPiModule_io_state_o_9 ),
       .io_state_i_8( RhoPiModule_io_state_o_8 ),
       .io_state_i_7( RhoPiModule_io_state_o_7 ),
       .io_state_i_6( RhoPiModule_io_state_o_6 ),
       .io_state_i_5( RhoPiModule_io_state_o_5 ),
       .io_state_i_4( RhoPiModule_io_state_o_4 ),
       .io_state_i_3( RhoPiModule_io_state_o_3 ),
       .io_state_i_2( RhoPiModule_io_state_o_2 ),
       .io_state_i_1( RhoPiModule_io_state_o_1 ),
       .io_state_i_0( RhoPiModule_io_state_o_0 ),
       .io_state_o_24( ChiModule_io_state_o_24 ),
       .io_state_o_23( ChiModule_io_state_o_23 ),
       .io_state_o_22( ChiModule_io_state_o_22 ),
       .io_state_o_21( ChiModule_io_state_o_21 ),
       .io_state_o_20( ChiModule_io_state_o_20 ),
       .io_state_o_19( ChiModule_io_state_o_19 ),
       .io_state_o_18( ChiModule_io_state_o_18 ),
       .io_state_o_17( ChiModule_io_state_o_17 ),
       .io_state_o_16( ChiModule_io_state_o_16 ),
       .io_state_o_15( ChiModule_io_state_o_15 ),
       .io_state_o_14( ChiModule_io_state_o_14 ),
       .io_state_o_13( ChiModule_io_state_o_13 ),
       .io_state_o_12( ChiModule_io_state_o_12 ),
       .io_state_o_11( ChiModule_io_state_o_11 ),
       .io_state_o_10( ChiModule_io_state_o_10 ),
       .io_state_o_9( ChiModule_io_state_o_9 ),
       .io_state_o_8( ChiModule_io_state_o_8 ),
       .io_state_o_7( ChiModule_io_state_o_7 ),
       .io_state_o_6( ChiModule_io_state_o_6 ),
       .io_state_o_5( ChiModule_io_state_o_5 ),
       .io_state_o_4( ChiModule_io_state_o_4 ),
       .io_state_o_3( ChiModule_io_state_o_3 ),
       .io_state_o_2( ChiModule_io_state_o_2 ),
       .io_state_o_1( ChiModule_io_state_o_1 ),
       .io_state_o_0( ChiModule_io_state_o_0 )
  );
  IotaModule iota(
       .io_state_i_24( ChiModule_io_state_o_24 ),
       .io_state_i_23( ChiModule_io_state_o_23 ),
       .io_state_i_22( ChiModule_io_state_o_22 ),
       .io_state_i_21( ChiModule_io_state_o_21 ),
       .io_state_i_20( ChiModule_io_state_o_20 ),
       .io_state_i_19( ChiModule_io_state_o_19 ),
       .io_state_i_18( ChiModule_io_state_o_18 ),
       .io_state_i_17( ChiModule_io_state_o_17 ),
       .io_state_i_16( ChiModule_io_state_o_16 ),
       .io_state_i_15( ChiModule_io_state_o_15 ),
       .io_state_i_14( ChiModule_io_state_o_14 ),
       .io_state_i_13( ChiModule_io_state_o_13 ),
       .io_state_i_12( ChiModule_io_state_o_12 ),
       .io_state_i_11( ChiModule_io_state_o_11 ),
       .io_state_i_10( ChiModule_io_state_o_10 ),
       .io_state_i_9( ChiModule_io_state_o_9 ),
       .io_state_i_8( ChiModule_io_state_o_8 ),
       .io_state_i_7( ChiModule_io_state_o_7 ),
       .io_state_i_6( ChiModule_io_state_o_6 ),
       .io_state_i_5( ChiModule_io_state_o_5 ),
       .io_state_i_4( ChiModule_io_state_o_4 ),
       .io_state_i_3( ChiModule_io_state_o_3 ),
       .io_state_i_2( ChiModule_io_state_o_2 ),
       .io_state_i_1( ChiModule_io_state_o_1 ),
       .io_state_i_0( ChiModule_io_state_o_0 ),
       .io_state_o_24( iota_io_state_o_24 ),
       .io_state_o_23( iota_io_state_o_23 ),
       .io_state_o_22( iota_io_state_o_22 ),
       .io_state_o_21( iota_io_state_o_21 ),
       .io_state_o_20( iota_io_state_o_20 ),
       .io_state_o_19( iota_io_state_o_19 ),
       .io_state_o_18( iota_io_state_o_18 ),
       .io_state_o_17( iota_io_state_o_17 ),
       .io_state_o_16( iota_io_state_o_16 ),
       .io_state_o_15( iota_io_state_o_15 ),
       .io_state_o_14( iota_io_state_o_14 ),
       .io_state_o_13( iota_io_state_o_13 ),
       .io_state_o_12( iota_io_state_o_12 ),
       .io_state_o_11( iota_io_state_o_11 ),
       .io_state_o_10( iota_io_state_o_10 ),
       .io_state_o_9( iota_io_state_o_9 ),
       .io_state_o_8( iota_io_state_o_8 ),
       .io_state_o_7( iota_io_state_o_7 ),
       .io_state_o_6( iota_io_state_o_6 ),
       .io_state_o_5( iota_io_state_o_5 ),
       .io_state_o_4( iota_io_state_o_4 ),
       .io_state_o_3( iota_io_state_o_3 ),
       .io_state_o_2( iota_io_state_o_2 ),
       .io_state_o_1( iota_io_state_o_1 ),
       .io_state_o_0( iota_io_state_o_0 ),
       .io_round( io_round )
  );

  always @(posedge clk) begin
    if(reset) begin
      state_0 <= 64'h0;
    end else if(reset) begin
      state_0 <= 64'h0;
    end else if(io_init) begin
      state_0 <= 64'h0;
    end else if(io_write) begin
      state_0 <= state_0;
    end else if(T261) begin
      state_0 <= T7;
    end else if(io_absorb) begin
      state_0 <= state_0;
    end else if(T6) begin
      state_0 <= iota_io_state_o_0;
    end else begin
      state_0 <= iota_io_state_o_0;
    end
    if(reset) begin
      state_1 <= 64'h0;
    end else if(reset) begin
      state_1 <= 64'h0;
    end else if(io_init) begin
      state_1 <= 64'h0;
    end else if(io_write) begin
      state_1 <= state_1;
    end else if(T19) begin
      state_1 <= T7;
    end else if(io_absorb) begin
      state_1 <= state_1;
    end else if(T6) begin
      state_1 <= iota_io_state_o_1;
    end else begin
      state_1 <= iota_io_state_o_1;
    end
    if(reset) begin
      state_2 <= 64'h0;
    end else if(reset) begin
      state_2 <= 64'h0;
    end else if(io_init) begin
      state_2 <= 64'h0;
    end else if(io_write) begin
      state_2 <= state_2;
    end else if(T42) begin
      state_2 <= T7;
    end else if(io_absorb) begin
      state_2 <= state_2;
    end else if(T6) begin
      state_2 <= iota_io_state_o_2;
    end else begin
      state_2 <= iota_io_state_o_2;
    end
    if(reset) begin
      state_3 <= 64'h0;
    end else if(reset) begin
      state_3 <= 64'h0;
    end else if(io_init) begin
      state_3 <= 64'h0;
    end else if(io_write) begin
      state_3 <= state_3;
    end else if(T50) begin
      state_3 <= T7;
    end else if(io_absorb) begin
      state_3 <= state_3;
    end else if(T6) begin
      state_3 <= iota_io_state_o_3;
    end else begin
      state_3 <= iota_io_state_o_3;
    end
    if(reset) begin
      state_4 <= 64'h0;
    end else if(reset) begin
      state_4 <= 64'h0;
    end else if(io_init) begin
      state_4 <= 64'h0;
    end else if(io_write) begin
      state_4 <= state_4;
    end else if(T62) begin
      state_4 <= T7;
    end else if(io_absorb) begin
      state_4 <= state_4;
    end else if(T6) begin
      state_4 <= iota_io_state_o_4;
    end else begin
      state_4 <= iota_io_state_o_4;
    end
    if(reset) begin
      state_5 <= 64'h0;
    end else if(reset) begin
      state_5 <= 64'h0;
    end else if(io_init) begin
      state_5 <= 64'h0;
    end else if(io_write) begin
      state_5 <= state_5;
    end else if(T70) begin
      state_5 <= T7;
    end else if(io_absorb) begin
      state_5 <= state_5;
    end else if(T6) begin
      state_5 <= iota_io_state_o_5;
    end else begin
      state_5 <= iota_io_state_o_5;
    end
    if(reset) begin
      state_6 <= 64'h0;
    end else if(reset) begin
      state_6 <= 64'h0;
    end else if(io_init) begin
      state_6 <= 64'h0;
    end else if(io_write) begin
      state_6 <= state_6;
    end else if(T80) begin
      state_6 <= T7;
    end else if(io_absorb) begin
      state_6 <= state_6;
    end else if(T6) begin
      state_6 <= iota_io_state_o_6;
    end else begin
      state_6 <= iota_io_state_o_6;
    end
    if(reset) begin
      state_7 <= 64'h0;
    end else if(reset) begin
      state_7 <= 64'h0;
    end else if(io_init) begin
      state_7 <= 64'h0;
    end else if(io_write) begin
      state_7 <= state_7;
    end else if(T88) begin
      state_7 <= T7;
    end else if(io_absorb) begin
      state_7 <= state_7;
    end else if(T6) begin
      state_7 <= iota_io_state_o_7;
    end else begin
      state_7 <= iota_io_state_o_7;
    end
    if(reset) begin
      state_8 <= 64'h0;
    end else if(reset) begin
      state_8 <= 64'h0;
    end else if(io_init) begin
      state_8 <= 64'h0;
    end else if(io_write) begin
      state_8 <= state_8;
    end else if(T102) begin
      state_8 <= T7;
    end else if(io_absorb) begin
      state_8 <= state_8;
    end else if(T6) begin
      state_8 <= iota_io_state_o_8;
    end else begin
      state_8 <= iota_io_state_o_8;
    end
    if(reset) begin
      state_9 <= 64'h0;
    end else if(reset) begin
      state_9 <= 64'h0;
    end else if(io_init) begin
      state_9 <= 64'h0;
    end else if(io_write) begin
      state_9 <= state_9;
    end else if(T110) begin
      state_9 <= T7;
    end else if(io_absorb) begin
      state_9 <= state_9;
    end else if(T6) begin
      state_9 <= iota_io_state_o_9;
    end else begin
      state_9 <= iota_io_state_o_9;
    end
    if(reset) begin
      state_10 <= 64'h0;
    end else if(reset) begin
      state_10 <= 64'h0;
    end else if(io_init) begin
      state_10 <= 64'h0;
    end else if(io_write) begin
      state_10 <= state_10;
    end else if(T120) begin
      state_10 <= T7;
    end else if(io_absorb) begin
      state_10 <= state_10;
    end else if(T6) begin
      state_10 <= iota_io_state_o_10;
    end else begin
      state_10 <= iota_io_state_o_10;
    end
    if(reset) begin
      state_11 <= 64'h0;
    end else if(reset) begin
      state_11 <= 64'h0;
    end else if(io_init) begin
      state_11 <= 64'h0;
    end else if(io_write) begin
      state_11 <= state_11;
    end else if(T128) begin
      state_11 <= T7;
    end else if(io_absorb) begin
      state_11 <= state_11;
    end else if(T6) begin
      state_11 <= iota_io_state_o_11;
    end else begin
      state_11 <= iota_io_state_o_11;
    end
    if(reset) begin
      state_12 <= 64'h0;
    end else if(reset) begin
      state_12 <= 64'h0;
    end else if(io_init) begin
      state_12 <= 64'h0;
    end else if(io_write) begin
      state_12 <= state_12;
    end else if(T140) begin
      state_12 <= T7;
    end else if(io_absorb) begin
      state_12 <= state_12;
    end else if(T6) begin
      state_12 <= iota_io_state_o_12;
    end else begin
      state_12 <= iota_io_state_o_12;
    end
    if(reset) begin
      state_13 <= 64'h0;
    end else if(reset) begin
      state_13 <= 64'h0;
    end else if(io_init) begin
      state_13 <= 64'h0;
    end else if(io_write) begin
      state_13 <= state_13;
    end else if(T148) begin
      state_13 <= T7;
    end else if(io_absorb) begin
      state_13 <= state_13;
    end else if(T6) begin
      state_13 <= iota_io_state_o_13;
    end else begin
      state_13 <= iota_io_state_o_13;
    end
    if(reset) begin
      state_14 <= 64'h0;
    end else if(reset) begin
      state_14 <= 64'h0;
    end else if(io_init) begin
      state_14 <= 64'h0;
    end else if(io_write) begin
      state_14 <= state_14;
    end else if(T158) begin
      state_14 <= T7;
    end else if(io_absorb) begin
      state_14 <= state_14;
    end else if(T6) begin
      state_14 <= iota_io_state_o_14;
    end else begin
      state_14 <= iota_io_state_o_14;
    end
    if(reset) begin
      state_15 <= 64'h0;
    end else if(reset) begin
      state_15 <= 64'h0;
    end else if(io_init) begin
      state_15 <= 64'h0;
    end else if(io_write) begin
      state_15 <= state_15;
    end else if(T166) begin
      state_15 <= T7;
    end else if(io_absorb) begin
      state_15 <= state_15;
    end else if(T6) begin
      state_15 <= iota_io_state_o_15;
    end else begin
      state_15 <= iota_io_state_o_15;
    end
    if(reset) begin
      state_16 <= 64'h0;
    end else if(reset) begin
      state_16 <= 64'h0;
    end else if(io_init) begin
      state_16 <= 64'h0;
    end else if(io_write) begin
      state_16 <= state_16;
    end else if(T182) begin
      state_16 <= T7;
    end else if(io_absorb) begin
      state_16 <= state_16;
    end else if(T6) begin
      state_16 <= iota_io_state_o_16;
    end else begin
      state_16 <= iota_io_state_o_16;
    end
    if(reset) begin
      state_17 <= 64'h0;
    end else if(reset) begin
      state_17 <= 64'h0;
    end else if(io_init) begin
      state_17 <= 64'h0;
    end else if(io_write) begin
      state_17 <= state_17;
    end else if(T190) begin
      state_17 <= T7;
    end else if(io_absorb) begin
      state_17 <= state_17;
    end else if(T6) begin
      state_17 <= iota_io_state_o_17;
    end else begin
      state_17 <= iota_io_state_o_17;
    end
    if(reset) begin
      state_18 <= 64'h0;
    end else if(reset) begin
      state_18 <= 64'h0;
    end else if(io_init) begin
      state_18 <= 64'h0;
    end else if(io_write) begin
      state_18 <= state_18;
    end else if(T200) begin
      state_18 <= T7;
    end else if(io_absorb) begin
      state_18 <= state_18;
    end else if(T6) begin
      state_18 <= iota_io_state_o_18;
    end else begin
      state_18 <= iota_io_state_o_18;
    end
    if(reset) begin
      state_19 <= 64'h0;
    end else if(reset) begin
      state_19 <= 64'h0;
    end else if(io_init) begin
      state_19 <= 64'h0;
    end else if(io_write) begin
      state_19 <= state_19;
    end else if(T208) begin
      state_19 <= T7;
    end else if(io_absorb) begin
      state_19 <= state_19;
    end else if(T6) begin
      state_19 <= iota_io_state_o_19;
    end else begin
      state_19 <= iota_io_state_o_19;
    end
    if(reset) begin
      state_20 <= 64'h0;
    end else if(reset) begin
      state_20 <= 64'h0;
    end else if(io_init) begin
      state_20 <= 64'h0;
    end else if(io_write) begin
      state_20 <= state_20;
    end else if(T220) begin
      state_20 <= T7;
    end else if(io_absorb) begin
      state_20 <= state_20;
    end else if(T6) begin
      state_20 <= iota_io_state_o_20;
    end else begin
      state_20 <= iota_io_state_o_20;
    end
    if(reset) begin
      state_21 <= 64'h0;
    end else if(reset) begin
      state_21 <= 64'h0;
    end else if(io_init) begin
      state_21 <= 64'h0;
    end else if(io_write) begin
      state_21 <= state_21;
    end else if(T228) begin
      state_21 <= T7;
    end else if(io_absorb) begin
      state_21 <= state_21;
    end else if(T6) begin
      state_21 <= iota_io_state_o_21;
    end else begin
      state_21 <= iota_io_state_o_21;
    end
    if(reset) begin
      state_22 <= 64'h0;
    end else if(reset) begin
      state_22 <= 64'h0;
    end else if(io_init) begin
      state_22 <= 64'h0;
    end else if(io_write) begin
      state_22 <= state_22;
    end else if(T238) begin
      state_22 <= T7;
    end else if(io_absorb) begin
      state_22 <= state_22;
    end else if(T6) begin
      state_22 <= iota_io_state_o_22;
    end else begin
      state_22 <= iota_io_state_o_22;
    end
    if(reset) begin
      state_23 <= 64'h0;
    end else if(reset) begin
      state_23 <= 64'h0;
    end else if(io_init) begin
      state_23 <= 64'h0;
    end else if(io_write) begin
      state_23 <= state_23;
    end else if(T246) begin
      state_23 <= T7;
    end else if(io_absorb) begin
      state_23 <= state_23;
    end else if(T6) begin
      state_23 <= iota_io_state_o_23;
    end else begin
      state_23 <= iota_io_state_o_23;
    end
    if(reset) begin
      state_24 <= 64'h0;
    end else if(reset) begin
      state_24 <= 64'h0;
    end else if(io_init) begin
      state_24 <= 64'h0;
    end else if(io_write) begin
      state_24 <= state_24;
    end else if(T257) begin
      state_24 <= T7;
    end else if(io_absorb) begin
      state_24 <= state_24;
    end else if(T6) begin
      state_24 <= iota_io_state_o_24;
    end else begin
      state_24 <= iota_io_state_o_24;
    end
  end
endmodule

module Sha3Accel(input clk, input reset,
    output io_cmd_ready,
    input  io_cmd_valid,
    input [6:0] io_cmd_bits_inst_funct,
    input [4:0] io_cmd_bits_inst_rs2,
    input [4:0] io_cmd_bits_inst_rs1,
    input  io_cmd_bits_inst_xd,
    input  io_cmd_bits_inst_xs1,
    input  io_cmd_bits_inst_xs2,
    input [4:0] io_cmd_bits_inst_rd,
    input [6:0] io_cmd_bits_inst_opcode,
    input [63:0] io_cmd_bits_rs1,
    input [63:0] io_cmd_bits_rs2,
    input  io_resp_ready,
    output io_resp_valid,
    output[4:0] io_resp_bits_rd,
    output[63:0] io_resp_bits_data,
    input  io_mem_req_ready,
    output io_mem_req_valid,
    output io_mem_req_bits_kill,
    output[2:0] io_mem_req_bits_typ,
    output io_mem_req_bits_phys,
    output[42:0] io_mem_req_bits_addr,
    output[63:0] io_mem_req_bits_data,
    output[8:0] io_mem_req_bits_tag,
    output[4:0] io_mem_req_bits_cmd,
    input  io_mem_resp_valid,
    input  io_mem_resp_bits_nack,
    input  io_mem_resp_bits_replay,
    input [2:0] io_mem_resp_bits_typ,
    input  io_mem_resp_bits_has_data,
    input [63:0] io_mem_resp_bits_data,
    input [63:0] io_mem_resp_bits_data_subword,
    input [8:0] io_mem_resp_bits_tag,
    input [3:0] io_mem_resp_bits_cmd,
    input [42:0] io_mem_resp_bits_addr,
    input [63:0] io_mem_resp_bits_store_data,
    input  io_mem_replay_next_valid,
    input [8:0] io_mem_replay_next_bits,
    input  io_mem_xcpt_ma_ld,
    input  io_mem_xcpt_ma_st,
    input  io_mem_xcpt_pf_ld,
    input  io_mem_xcpt_pf_st,
    output io_mem_ptw_req_ready,
    input  io_mem_ptw_req_valid,
    input [29:0] io_mem_ptw_req_bits,
    output io_mem_ptw_resp_valid,
    output io_mem_ptw_resp_bits_error,
    output[18:0] io_mem_ptw_resp_bits_ppn,
    output[5:0] io_mem_ptw_resp_bits_perm,
    output[7:0] io_mem_ptw_status_ip,
    output[7:0] io_mem_ptw_status_im,
    output[6:0] io_mem_ptw_status_zero,
    output io_mem_ptw_status_er,
    output io_mem_ptw_status_vm,
    output io_mem_ptw_status_s64,
    output io_mem_ptw_status_u64,
    output io_mem_ptw_status_ef,
    output io_mem_ptw_status_pei,
    output io_mem_ptw_status_ei,
    output io_mem_ptw_status_ps,
    output io_mem_ptw_status_s,
    output io_mem_ptw_invalidate,
    output io_mem_ptw_sret,
    input  io_mem_ordered,
    output io_busy,
    input  io_s,
    output io_interrupt,
    input  io_imem_acquire_ready,
    output io_imem_acquire_valid,
    output[1:0] io_imem_acquire_bits_header_src,
    output[1:0] io_imem_acquire_bits_header_dst,
    output[25:0] io_imem_acquire_bits_payload_addr,
    output[2:0] io_imem_acquire_bits_payload_client_xact_id,
    output[511:0] io_imem_acquire_bits_payload_data,
    output[9:0] io_imem_acquire_bits_payload_a_type,
    output[5:0] io_imem_acquire_bits_payload_write_mask,
    output[2:0] io_imem_acquire_bits_payload_subword_addr,
    output[3:0] io_imem_acquire_bits_payload_atomic_opcode,
    output io_imem_grant_ready,
    input  io_imem_grant_valid,
    input [1:0] io_imem_grant_bits_header_src,
    input [1:0] io_imem_grant_bits_header_dst,
    input [511:0] io_imem_grant_bits_payload_data,
    input [2:0] io_imem_grant_bits_payload_client_xact_id,
    input [2:0] io_imem_grant_bits_payload_master_xact_id,
    input [4:0] io_imem_grant_bits_payload_g_type,
    input  io_imem_finish_ready,
    output io_imem_finish_valid,
    output[1:0] io_imem_finish_bits_header_src,
    output[1:0] io_imem_finish_bits_header_dst,
    output[2:0] io_imem_finish_bits_payload_master_xact_id,
    input  io_iptw_req_ready,
    output io_iptw_req_valid,
    output[29:0] io_iptw_req_bits,
    input  io_iptw_resp_valid,
    input  io_iptw_resp_bits_error,
    input [18:0] io_iptw_resp_bits_ppn,
    input [5:0] io_iptw_resp_bits_perm,
    input [7:0] io_iptw_status_ip,
    input [7:0] io_iptw_status_im,
    input [6:0] io_iptw_status_zero,
    input  io_iptw_status_er,
    input  io_iptw_status_vm,
    input  io_iptw_status_s64,
    input  io_iptw_status_u64,
    input  io_iptw_status_ef,
    input  io_iptw_status_pei,
    input  io_iptw_status_ei,
    input  io_iptw_status_ps,
    input  io_iptw_status_s,
    input  io_iptw_invalidate,
    input  io_iptw_sret,
    input  io_dptw_req_ready,
    output io_dptw_req_valid,
    output[29:0] io_dptw_req_bits,
    input  io_dptw_resp_valid,
    input  io_dptw_resp_bits_error,
    input [18:0] io_dptw_resp_bits_ppn,
    input [5:0] io_dptw_resp_bits_perm,
    input [7:0] io_dptw_status_ip,
    input [7:0] io_dptw_status_im,
    input [6:0] io_dptw_status_zero,
    input  io_dptw_status_er,
    input  io_dptw_status_vm,
    input  io_dptw_status_s64,
    input  io_dptw_status_u64,
    input  io_dptw_status_ef,
    input  io_dptw_status_pei,
    input  io_dptw_status_ei,
    input  io_dptw_status_ps,
    input  io_dptw_status_s,
    input  io_dptw_invalidate,
    input  io_dptw_sret,
    input  io_pptw_req_ready,
    output io_pptw_req_valid,
    output[29:0] io_pptw_req_bits,
    input  io_pptw_resp_valid,
    input  io_pptw_resp_bits_error,
    input [18:0] io_pptw_resp_bits_ppn,
    input [5:0] io_pptw_resp_bits_perm,
    input [7:0] io_pptw_status_ip,
    input [7:0] io_pptw_status_im,
    input [6:0] io_pptw_status_zero,
    input  io_pptw_status_er,
    input  io_pptw_status_vm,
    input  io_pptw_status_s64,
    input  io_pptw_status_u64,
    input  io_pptw_status_ef,
    input  io_pptw_status_pei,
    input  io_pptw_status_ei,
    input  io_pptw_status_ps,
    input  io_pptw_status_s,
    input  io_pptw_invalidate,
    input  io_pptw_sret,
    input  io_exception
);

  wire[6:0] T7;
  wire[1:0] T8;
  wire[8:0] T9;
  wire[63:0] T0;
  wire[63:0] T1;
  wire T2;
  wire[1:0] T3;
  wire[1:0] T10;
  wire[63:0] T4;
  wire T5;
  wire T6;
  wire[42:0] T11;
  wire ctrl_io_rocc_req_rdy;
  wire ctrl_io_busy;
  wire ctrl_io_dmem_req_val;
  wire[6:0] ctrl_io_dmem_req_tag;
  wire[31:0] ctrl_io_dmem_req_addr;
  wire[4:0] ctrl_io_dmem_req_cmd;
  wire[2:0] ctrl_io_dmem_req_typ;
  wire[4:0] ctrl_io_round;
  wire ctrl_io_stage;
  wire ctrl_io_absorb;
  wire[4:0] ctrl_io_aindex;
  wire ctrl_io_init;
  wire ctrl_io_write;
  wire[2:0] ctrl_io_windex;
  wire[63:0] ctrl_io_buffer_out;
  wire[63:0] dpath_io_hash_out_3;
  wire[63:0] dpath_io_hash_out_2;
  wire[63:0] dpath_io_hash_out_1;
  wire[63:0] dpath_io_hash_out_0;


`ifndef SYNTHESIS
// synthesis translate_off
//  assign io_pptw_req_bits = {1{$random}};
//  assign io_dptw_req_bits = {1{$random}};
//  assign io_iptw_req_bits = {1{$random}};
//  assign io_imem_finish_bits_payload_master_xact_id = {1{$random}};
//  assign io_imem_finish_bits_header_dst = {1{$random}};
//  assign io_imem_finish_bits_header_src = {1{$random}};
//  assign io_imem_acquire_bits_payload_atomic_opcode = {1{$random}};
//  assign io_imem_acquire_bits_payload_subword_addr = {1{$random}};
//  assign io_imem_acquire_bits_payload_write_mask = {1{$random}};
//  assign io_imem_acquire_bits_payload_a_type = {1{$random}};
//  assign io_imem_acquire_bits_payload_data = {16{$random}};
//  assign io_imem_acquire_bits_payload_client_xact_id = {1{$random}};
//  assign io_imem_acquire_bits_payload_addr = {1{$random}};
//  assign io_imem_acquire_bits_header_dst = {1{$random}};
//  assign io_imem_acquire_bits_header_src = {1{$random}};
//  assign io_mem_ptw_sret = {1{$random}};
//  assign io_mem_ptw_invalidate = {1{$random}};
//  assign io_mem_ptw_status_s = {1{$random}};
//  assign io_mem_ptw_status_ps = {1{$random}};
//  assign io_mem_ptw_status_ei = {1{$random}};
//  assign io_mem_ptw_status_pei = {1{$random}};
//  assign io_mem_ptw_status_ef = {1{$random}};
//  assign io_mem_ptw_status_u64 = {1{$random}};
//  assign io_mem_ptw_status_s64 = {1{$random}};
//  assign io_mem_ptw_status_vm = {1{$random}};
//  assign io_mem_ptw_status_er = {1{$random}};
//  assign io_mem_ptw_status_zero = {1{$random}};
//  assign io_mem_ptw_status_im = {1{$random}};
//  assign io_mem_ptw_status_ip = {1{$random}};
//  assign io_mem_ptw_resp_bits_perm = {1{$random}};
//  assign io_mem_ptw_resp_bits_ppn = {1{$random}};
//  assign io_mem_ptw_resp_bits_error = {1{$random}};
//  assign io_mem_ptw_resp_valid = {1{$random}};
//  assign io_mem_ptw_req_ready = {1{$random}};
//  assign io_mem_req_bits_kill = {1{$random}};
//  assign io_resp_bits_data = {2{$random}};
//  assign io_resp_bits_rd = {1{$random}};
// synthesis translate_on
`endif
  assign T7 = io_mem_resp_bits_tag[3'h6:1'h0];
  assign T8 = io_cmd_bits_inst_funct[1'h1:1'h0];
  assign io_pptw_req_valid = 1'h0;
  assign io_dptw_req_valid = 1'h0;
  assign io_iptw_req_valid = 1'h0;
  assign io_imem_finish_valid = 1'h0;
  assign io_imem_grant_ready = 1'h0;
  assign io_imem_acquire_valid = 1'h0;
  assign io_interrupt = 1'h0;
  assign io_busy = ctrl_io_busy;
  assign io_mem_req_bits_cmd = ctrl_io_dmem_req_cmd;
  assign io_mem_req_bits_tag = T9;
  assign T9 = {2'h0, ctrl_io_dmem_req_tag};
  assign io_mem_req_bits_data = T0;
  assign T0 = T6 ? T4 : T1;
  assign T1 = T2 ? dpath_io_hash_out_1 : dpath_io_hash_out_0;
  assign T2 = T3[1'h0:1'h0];
  assign T3 = T10;
  assign T10 = ctrl_io_windex[1'h1:1'h0];
  assign T4 = T5 ? dpath_io_hash_out_3 : dpath_io_hash_out_2;
  assign T5 = T3[1'h0:1'h0];
  assign T6 = T3[1'h1:1'h1];
  assign io_mem_req_bits_addr = T11;
  assign T11 = {11'h0, ctrl_io_dmem_req_addr};
  assign io_mem_req_bits_phys = 1'h1;
  assign io_mem_req_bits_typ = ctrl_io_dmem_req_typ;
  assign io_mem_req_valid = ctrl_io_dmem_req_val;
  assign io_resp_valid = 1'h0;
  assign io_cmd_ready = ctrl_io_rocc_req_rdy;
  CtrlModule ctrl(.clk(clk), .reset(reset),
       .io_rocc_req_val( io_cmd_valid ),
       .io_rocc_req_rdy( ctrl_io_rocc_req_rdy ),
       .io_rocc_funct( T8 ),
       .io_rocc_rs1( io_cmd_bits_rs1 ),
       .io_rocc_rs2( io_cmd_bits_rs2 ),
       .io_rocc_rd( io_cmd_bits_inst_rd ),
       .io_busy( ctrl_io_busy ),
       .io_dmem_req_val( ctrl_io_dmem_req_val ),
       .io_dmem_req_rdy( io_mem_req_ready ),
       .io_dmem_req_tag( ctrl_io_dmem_req_tag ),
       .io_dmem_req_addr( ctrl_io_dmem_req_addr ),
       .io_dmem_req_cmd( ctrl_io_dmem_req_cmd ),
       .io_dmem_req_typ( ctrl_io_dmem_req_typ ),
       .io_dmem_resp_val( io_mem_resp_valid ),
       .io_dmem_resp_tag( T7 ),
       .io_dmem_resp_data( io_mem_resp_bits_data ),
       .io_round( ctrl_io_round ),
       .io_stage( ctrl_io_stage ),
       .io_absorb( ctrl_io_absorb ),
       .io_aindex( ctrl_io_aindex ),
       .io_init( ctrl_io_init ),
       .io_write( ctrl_io_write ),
       .io_windex( ctrl_io_windex ),
       .io_buffer_out( ctrl_io_buffer_out )
  );
  DpathModule dpath(.clk(clk), .reset(reset),
       .io_absorb( ctrl_io_absorb ),
       .io_init( ctrl_io_init ),
       .io_write( ctrl_io_write ),
       .io_round( ctrl_io_round ),
       .io_stage( ctrl_io_stage ),
       .io_aindex( ctrl_io_aindex ),
       .io_message_in( ctrl_io_buffer_out ),
       .io_hash_out_3( dpath_io_hash_out_3 ),
       .io_hash_out_2( dpath_io_hash_out_2 ),
       .io_hash_out_1( dpath_io_hash_out_1 ),
       .io_hash_out_0( dpath_io_hash_out_0 )
  );
endmodule

module CtrlModule_buffer_mem(
  input CLK,
  input RST,
  input init,
  input [4:0] W0A,
  input W0E,
  input [63:0] W0I,
  input [4:0] R1A,
  input R1E,
  output [63:0] R1O
);


  sram8t17x64 sram(
    .CE1(CLK),
    .CSB1(~R1E),
    .OEB1(1'b0),
    .A1(R1A),
    .O1({R1O[63:0]}),
    .CE2(CLK),
    .CSB2(~W0E),
    .WEB2(1'b0),
    .A2(W0A),
    .I2({W0I[63:0]})
  );

endmodule

