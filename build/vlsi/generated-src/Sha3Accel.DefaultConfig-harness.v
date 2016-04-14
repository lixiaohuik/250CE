module test;
  reg[0:0] io_cmd_valid = 0;
  reg[6:0] io_cmd_bits_inst_funct = 0;
  reg[4:0] io_cmd_bits_inst_rs2 = 0;
  reg[4:0] io_cmd_bits_inst_rs1 = 0;
  reg[0:0] io_cmd_bits_inst_xd = 0;
  reg[0:0] io_cmd_bits_inst_xs1 = 0;
  reg[0:0] io_cmd_bits_inst_xs2 = 0;
  reg[4:0] io_cmd_bits_inst_rd = 0;
  reg[6:0] io_cmd_bits_inst_opcode = 0;
  reg[63:0] io_cmd_bits_rs1 = 0;
  reg[63:0] io_cmd_bits_rs2 = 0;
  reg[0:0] io_resp_ready = 0;
  reg[0:0] io_mem_req_ready = 0;
  reg[0:0] io_mem_resp_valid = 0;
  reg[0:0] io_mem_resp_bits_nack = 0;
  reg[0:0] io_mem_resp_bits_replay = 0;
  reg[2:0] io_mem_resp_bits_typ = 0;
  reg[0:0] io_mem_resp_bits_has_data = 0;
  reg[63:0] io_mem_resp_bits_data = 0;
  reg[63:0] io_mem_resp_bits_data_subword = 0;
  reg[8:0] io_mem_resp_bits_tag = 0;
  reg[3:0] io_mem_resp_bits_cmd = 0;
  reg[42:0] io_mem_resp_bits_addr = 0;
  reg[63:0] io_mem_resp_bits_store_data = 0;
  reg[0:0] io_mem_replay_next_valid = 0;
  reg[8:0] io_mem_replay_next_bits = 0;
  reg[0:0] io_mem_xcpt_ma_ld = 0;
  reg[0:0] io_mem_xcpt_ma_st = 0;
  reg[0:0] io_mem_xcpt_pf_ld = 0;
  reg[0:0] io_mem_xcpt_pf_st = 0;
  reg[0:0] io_mem_ptw_req_valid = 0;
  reg[29:0] io_mem_ptw_req_bits = 0;
  reg[0:0] io_mem_ordered = 0;
  reg[0:0] io_s = 0;
  reg[0:0] io_imem_acquire_ready = 0;
  reg[0:0] io_imem_grant_valid = 0;
  reg[1:0] io_imem_grant_bits_header_src = 0;
  reg[1:0] io_imem_grant_bits_header_dst = 0;
  reg[511:0] io_imem_grant_bits_payload_data = 0;
  reg[2:0] io_imem_grant_bits_payload_client_xact_id = 0;
  reg[2:0] io_imem_grant_bits_payload_master_xact_id = 0;
  reg[4:0] io_imem_grant_bits_payload_g_type = 0;
  reg[0:0] io_imem_finish_ready = 0;
  reg[0:0] io_iptw_req_ready = 0;
  reg[0:0] io_iptw_resp_valid = 0;
  reg[0:0] io_iptw_resp_bits_error = 0;
  reg[18:0] io_iptw_resp_bits_ppn = 0;
  reg[5:0] io_iptw_resp_bits_perm = 0;
  reg[7:0] io_iptw_status_ip = 0;
  reg[7:0] io_iptw_status_im = 0;
  reg[6:0] io_iptw_status_zero = 0;
  reg[0:0] io_iptw_status_er = 0;
  reg[0:0] io_iptw_status_vm = 0;
  reg[0:0] io_iptw_status_s64 = 0;
  reg[0:0] io_iptw_status_u64 = 0;
  reg[0:0] io_iptw_status_ef = 0;
  reg[0:0] io_iptw_status_pei = 0;
  reg[0:0] io_iptw_status_ei = 0;
  reg[0:0] io_iptw_status_ps = 0;
  reg[0:0] io_iptw_status_s = 0;
  reg[0:0] io_iptw_invalidate = 0;
  reg[0:0] io_iptw_sret = 0;
  reg[0:0] io_dptw_req_ready = 0;
  reg[0:0] io_dptw_resp_valid = 0;
  reg[0:0] io_dptw_resp_bits_error = 0;
  reg[18:0] io_dptw_resp_bits_ppn = 0;
  reg[5:0] io_dptw_resp_bits_perm = 0;
  reg[7:0] io_dptw_status_ip = 0;
  reg[7:0] io_dptw_status_im = 0;
  reg[6:0] io_dptw_status_zero = 0;
  reg[0:0] io_dptw_status_er = 0;
  reg[0:0] io_dptw_status_vm = 0;
  reg[0:0] io_dptw_status_s64 = 0;
  reg[0:0] io_dptw_status_u64 = 0;
  reg[0:0] io_dptw_status_ef = 0;
  reg[0:0] io_dptw_status_pei = 0;
  reg[0:0] io_dptw_status_ei = 0;
  reg[0:0] io_dptw_status_ps = 0;
  reg[0:0] io_dptw_status_s = 0;
  reg[0:0] io_dptw_invalidate = 0;
  reg[0:0] io_dptw_sret = 0;
  reg[0:0] io_pptw_req_ready = 0;
  reg[0:0] io_pptw_resp_valid = 0;
  reg[0:0] io_pptw_resp_bits_error = 0;
  reg[18:0] io_pptw_resp_bits_ppn = 0;
  reg[5:0] io_pptw_resp_bits_perm = 0;
  reg[7:0] io_pptw_status_ip = 0;
  reg[7:0] io_pptw_status_im = 0;
  reg[6:0] io_pptw_status_zero = 0;
  reg[0:0] io_pptw_status_er = 0;
  reg[0:0] io_pptw_status_vm = 0;
  reg[0:0] io_pptw_status_s64 = 0;
  reg[0:0] io_pptw_status_u64 = 0;
  reg[0:0] io_pptw_status_ef = 0;
  reg[0:0] io_pptw_status_pei = 0;
  reg[0:0] io_pptw_status_ei = 0;
  reg[0:0] io_pptw_status_ps = 0;
  reg[0:0] io_pptw_status_s = 0;
  reg[0:0] io_pptw_invalidate = 0;
  reg[0:0] io_pptw_sret = 0;
  reg[0:0] io_exception = 0;
  wire[0:0] io_cmd_ready;
  wire[0:0] io_resp_valid;
  wire[4:0] io_resp_bits_rd;
  wire[63:0] io_resp_bits_data;
  wire[0:0] io_mem_req_valid;
  wire[0:0] io_mem_req_bits_kill;
  wire[2:0] io_mem_req_bits_typ;
  wire[0:0] io_mem_req_bits_phys;
  wire[42:0] io_mem_req_bits_addr;
  wire[63:0] io_mem_req_bits_data;
  wire[8:0] io_mem_req_bits_tag;
  wire[4:0] io_mem_req_bits_cmd;
  wire[0:0] io_mem_ptw_req_ready;
  wire[0:0] io_mem_ptw_resp_valid;
  wire[0:0] io_mem_ptw_resp_bits_error;
  wire[18:0] io_mem_ptw_resp_bits_ppn;
  wire[5:0] io_mem_ptw_resp_bits_perm;
  wire[7:0] io_mem_ptw_status_ip;
  wire[7:0] io_mem_ptw_status_im;
  wire[6:0] io_mem_ptw_status_zero;
  wire[0:0] io_mem_ptw_status_er;
  wire[0:0] io_mem_ptw_status_vm;
  wire[0:0] io_mem_ptw_status_s64;
  wire[0:0] io_mem_ptw_status_u64;
  wire[0:0] io_mem_ptw_status_ef;
  wire[0:0] io_mem_ptw_status_pei;
  wire[0:0] io_mem_ptw_status_ei;
  wire[0:0] io_mem_ptw_status_ps;
  wire[0:0] io_mem_ptw_status_s;
  wire[0:0] io_mem_ptw_invalidate;
  wire[0:0] io_mem_ptw_sret;
  wire[0:0] io_busy;
  wire[0:0] io_interrupt;
  wire[0:0] io_imem_acquire_valid;
  wire[1:0] io_imem_acquire_bits_header_src;
  wire[1:0] io_imem_acquire_bits_header_dst;
  wire[25:0] io_imem_acquire_bits_payload_addr;
  wire[2:0] io_imem_acquire_bits_payload_client_xact_id;
  wire[511:0] io_imem_acquire_bits_payload_data;
  wire[9:0] io_imem_acquire_bits_payload_a_type;
  wire[5:0] io_imem_acquire_bits_payload_write_mask;
  wire[2:0] io_imem_acquire_bits_payload_subword_addr;
  wire[3:0] io_imem_acquire_bits_payload_atomic_opcode;
  wire[0:0] io_imem_grant_ready;
  wire[0:0] io_imem_finish_valid;
  wire[1:0] io_imem_finish_bits_header_src;
  wire[1:0] io_imem_finish_bits_header_dst;
  wire[2:0] io_imem_finish_bits_payload_master_xact_id;
  wire[0:0] io_iptw_req_valid;
  wire[29:0] io_iptw_req_bits;
  wire[0:0] io_dptw_req_valid;
  wire[29:0] io_dptw_req_bits;
  wire[0:0] io_pptw_req_valid;
  wire[29:0] io_pptw_req_bits;
  reg clk = 0;
  reg reset = 1;
  integer clk_len;
  always #clk_len clk = ~clk;
  reg vcdon = 0;
  reg [1023:0] vcdfile = 0;
  reg [1023:0] vpdfile = 0;

  /*** DUT instantiation ***/
  Sha3Accel Sha3Accel(
    .clk(clk),
    .reset(reset),
    .io_cmd_valid(io_cmd_valid),
    .io_cmd_bits_inst_funct(io_cmd_bits_inst_funct),
    .io_cmd_bits_inst_rs2(io_cmd_bits_inst_rs2),
    .io_cmd_bits_inst_rs1(io_cmd_bits_inst_rs1),
    .io_cmd_bits_inst_xd(io_cmd_bits_inst_xd),
    .io_cmd_bits_inst_xs1(io_cmd_bits_inst_xs1),
    .io_cmd_bits_inst_xs2(io_cmd_bits_inst_xs2),
    .io_cmd_bits_inst_rd(io_cmd_bits_inst_rd),
    .io_cmd_bits_inst_opcode(io_cmd_bits_inst_opcode),
    .io_cmd_bits_rs1(io_cmd_bits_rs1),
    .io_cmd_bits_rs2(io_cmd_bits_rs2),
    .io_resp_ready(io_resp_ready),
    .io_mem_req_ready(io_mem_req_ready),
    .io_mem_resp_valid(io_mem_resp_valid),
    .io_mem_resp_bits_nack(io_mem_resp_bits_nack),
    .io_mem_resp_bits_replay(io_mem_resp_bits_replay),
    .io_mem_resp_bits_typ(io_mem_resp_bits_typ),
    .io_mem_resp_bits_has_data(io_mem_resp_bits_has_data),
    .io_mem_resp_bits_data(io_mem_resp_bits_data),
    .io_mem_resp_bits_data_subword(io_mem_resp_bits_data_subword),
    .io_mem_resp_bits_tag(io_mem_resp_bits_tag),
    .io_mem_resp_bits_cmd(io_mem_resp_bits_cmd),
    .io_mem_resp_bits_addr(io_mem_resp_bits_addr),
    .io_mem_resp_bits_store_data(io_mem_resp_bits_store_data),
    .io_mem_replay_next_valid(io_mem_replay_next_valid),
    .io_mem_replay_next_bits(io_mem_replay_next_bits),
    .io_mem_xcpt_ma_ld(io_mem_xcpt_ma_ld),
    .io_mem_xcpt_ma_st(io_mem_xcpt_ma_st),
    .io_mem_xcpt_pf_ld(io_mem_xcpt_pf_ld),
    .io_mem_xcpt_pf_st(io_mem_xcpt_pf_st),
    .io_mem_ptw_req_valid(io_mem_ptw_req_valid),
    .io_mem_ptw_req_bits(io_mem_ptw_req_bits),
    .io_mem_ordered(io_mem_ordered),
    .io_s(io_s),
    .io_imem_acquire_ready(io_imem_acquire_ready),
    .io_imem_grant_valid(io_imem_grant_valid),
    .io_imem_grant_bits_header_src(io_imem_grant_bits_header_src),
    .io_imem_grant_bits_header_dst(io_imem_grant_bits_header_dst),
    .io_imem_grant_bits_payload_data(io_imem_grant_bits_payload_data),
    .io_imem_grant_bits_payload_client_xact_id(io_imem_grant_bits_payload_client_xact_id),
    .io_imem_grant_bits_payload_master_xact_id(io_imem_grant_bits_payload_master_xact_id),
    .io_imem_grant_bits_payload_g_type(io_imem_grant_bits_payload_g_type),
    .io_imem_finish_ready(io_imem_finish_ready),
    .io_iptw_req_ready(io_iptw_req_ready),
    .io_iptw_resp_valid(io_iptw_resp_valid),
    .io_iptw_resp_bits_error(io_iptw_resp_bits_error),
    .io_iptw_resp_bits_ppn(io_iptw_resp_bits_ppn),
    .io_iptw_resp_bits_perm(io_iptw_resp_bits_perm),
    .io_iptw_status_ip(io_iptw_status_ip),
    .io_iptw_status_im(io_iptw_status_im),
    .io_iptw_status_zero(io_iptw_status_zero),
    .io_iptw_status_er(io_iptw_status_er),
    .io_iptw_status_vm(io_iptw_status_vm),
    .io_iptw_status_s64(io_iptw_status_s64),
    .io_iptw_status_u64(io_iptw_status_u64),
    .io_iptw_status_ef(io_iptw_status_ef),
    .io_iptw_status_pei(io_iptw_status_pei),
    .io_iptw_status_ei(io_iptw_status_ei),
    .io_iptw_status_ps(io_iptw_status_ps),
    .io_iptw_status_s(io_iptw_status_s),
    .io_iptw_invalidate(io_iptw_invalidate),
    .io_iptw_sret(io_iptw_sret),
    .io_dptw_req_ready(io_dptw_req_ready),
    .io_dptw_resp_valid(io_dptw_resp_valid),
    .io_dptw_resp_bits_error(io_dptw_resp_bits_error),
    .io_dptw_resp_bits_ppn(io_dptw_resp_bits_ppn),
    .io_dptw_resp_bits_perm(io_dptw_resp_bits_perm),
    .io_dptw_status_ip(io_dptw_status_ip),
    .io_dptw_status_im(io_dptw_status_im),
    .io_dptw_status_zero(io_dptw_status_zero),
    .io_dptw_status_er(io_dptw_status_er),
    .io_dptw_status_vm(io_dptw_status_vm),
    .io_dptw_status_s64(io_dptw_status_s64),
    .io_dptw_status_u64(io_dptw_status_u64),
    .io_dptw_status_ef(io_dptw_status_ef),
    .io_dptw_status_pei(io_dptw_status_pei),
    .io_dptw_status_ei(io_dptw_status_ei),
    .io_dptw_status_ps(io_dptw_status_ps),
    .io_dptw_status_s(io_dptw_status_s),
    .io_dptw_invalidate(io_dptw_invalidate),
    .io_dptw_sret(io_dptw_sret),
    .io_pptw_req_ready(io_pptw_req_ready),
    .io_pptw_resp_valid(io_pptw_resp_valid),
    .io_pptw_resp_bits_error(io_pptw_resp_bits_error),
    .io_pptw_resp_bits_ppn(io_pptw_resp_bits_ppn),
    .io_pptw_resp_bits_perm(io_pptw_resp_bits_perm),
    .io_pptw_status_ip(io_pptw_status_ip),
    .io_pptw_status_im(io_pptw_status_im),
    .io_pptw_status_zero(io_pptw_status_zero),
    .io_pptw_status_er(io_pptw_status_er),
    .io_pptw_status_vm(io_pptw_status_vm),
    .io_pptw_status_s64(io_pptw_status_s64),
    .io_pptw_status_u64(io_pptw_status_u64),
    .io_pptw_status_ef(io_pptw_status_ef),
    .io_pptw_status_pei(io_pptw_status_pei),
    .io_pptw_status_ei(io_pptw_status_ei),
    .io_pptw_status_ps(io_pptw_status_ps),
    .io_pptw_status_s(io_pptw_status_s),
    .io_pptw_invalidate(io_pptw_invalidate),
    .io_pptw_sret(io_pptw_sret),
    .io_exception(io_exception),
    .io_cmd_ready(io_cmd_ready),
    .io_resp_valid(io_resp_valid),
    .io_resp_bits_rd(io_resp_bits_rd),
    .io_resp_bits_data(io_resp_bits_data),
    .io_mem_req_valid(io_mem_req_valid),
    .io_mem_req_bits_kill(io_mem_req_bits_kill),
    .io_mem_req_bits_typ(io_mem_req_bits_typ),
    .io_mem_req_bits_phys(io_mem_req_bits_phys),
    .io_mem_req_bits_addr(io_mem_req_bits_addr),
    .io_mem_req_bits_data(io_mem_req_bits_data),
    .io_mem_req_bits_tag(io_mem_req_bits_tag),
    .io_mem_req_bits_cmd(io_mem_req_bits_cmd),
    .io_mem_ptw_req_ready(io_mem_ptw_req_ready),
    .io_mem_ptw_resp_valid(io_mem_ptw_resp_valid),
    .io_mem_ptw_resp_bits_error(io_mem_ptw_resp_bits_error),
    .io_mem_ptw_resp_bits_ppn(io_mem_ptw_resp_bits_ppn),
    .io_mem_ptw_resp_bits_perm(io_mem_ptw_resp_bits_perm),
    .io_mem_ptw_status_ip(io_mem_ptw_status_ip),
    .io_mem_ptw_status_im(io_mem_ptw_status_im),
    .io_mem_ptw_status_zero(io_mem_ptw_status_zero),
    .io_mem_ptw_status_er(io_mem_ptw_status_er),
    .io_mem_ptw_status_vm(io_mem_ptw_status_vm),
    .io_mem_ptw_status_s64(io_mem_ptw_status_s64),
    .io_mem_ptw_status_u64(io_mem_ptw_status_u64),
    .io_mem_ptw_status_ef(io_mem_ptw_status_ef),
    .io_mem_ptw_status_pei(io_mem_ptw_status_pei),
    .io_mem_ptw_status_ei(io_mem_ptw_status_ei),
    .io_mem_ptw_status_ps(io_mem_ptw_status_ps),
    .io_mem_ptw_status_s(io_mem_ptw_status_s),
    .io_mem_ptw_invalidate(io_mem_ptw_invalidate),
    .io_mem_ptw_sret(io_mem_ptw_sret),
    .io_busy(io_busy),
    .io_interrupt(io_interrupt),
    .io_imem_acquire_valid(io_imem_acquire_valid),
    .io_imem_acquire_bits_header_src(io_imem_acquire_bits_header_src),
    .io_imem_acquire_bits_header_dst(io_imem_acquire_bits_header_dst),
    .io_imem_acquire_bits_payload_addr(io_imem_acquire_bits_payload_addr),
    .io_imem_acquire_bits_payload_client_xact_id(io_imem_acquire_bits_payload_client_xact_id),
    .io_imem_acquire_bits_payload_data(io_imem_acquire_bits_payload_data),
    .io_imem_acquire_bits_payload_a_type(io_imem_acquire_bits_payload_a_type),
    .io_imem_acquire_bits_payload_write_mask(io_imem_acquire_bits_payload_write_mask),
    .io_imem_acquire_bits_payload_subword_addr(io_imem_acquire_bits_payload_subword_addr),
    .io_imem_acquire_bits_payload_atomic_opcode(io_imem_acquire_bits_payload_atomic_opcode),
    .io_imem_grant_ready(io_imem_grant_ready),
    .io_imem_finish_valid(io_imem_finish_valid),
    .io_imem_finish_bits_header_src(io_imem_finish_bits_header_src),
    .io_imem_finish_bits_header_dst(io_imem_finish_bits_header_dst),
    .io_imem_finish_bits_payload_master_xact_id(io_imem_finish_bits_payload_master_xact_id),
    .io_iptw_req_valid(io_iptw_req_valid),
    .io_iptw_req_bits(io_iptw_req_bits),
    .io_dptw_req_valid(io_dptw_req_valid),
    .io_dptw_req_bits(io_dptw_req_bits),
    .io_pptw_req_valid(io_pptw_req_valid),
    .io_pptw_req_bits(io_pptw_req_bits));

  initial begin
    clk_len = `CLOCK_PERIOD;
    $init_clks(clk_len);
    $init_rsts(reset);
    $init_ins(io_cmd_valid, io_cmd_bits_inst_funct, io_cmd_bits_inst_rs2, io_cmd_bits_inst_rs1, io_cmd_bits_inst_xd, io_cmd_bits_inst_xs1, io_cmd_bits_inst_xs2, io_cmd_bits_inst_rd, io_cmd_bits_inst_opcode, io_cmd_bits_rs1, io_cmd_bits_rs2, io_resp_ready, io_mem_req_ready, io_mem_resp_valid, io_mem_resp_bits_nack, io_mem_resp_bits_replay, io_mem_resp_bits_typ, io_mem_resp_bits_has_data, io_mem_resp_bits_data, io_mem_resp_bits_data_subword, io_mem_resp_bits_tag, io_mem_resp_bits_cmd, io_mem_resp_bits_addr, io_mem_resp_bits_store_data, io_mem_replay_next_valid, io_mem_replay_next_bits, io_mem_xcpt_ma_ld, io_mem_xcpt_ma_st, io_mem_xcpt_pf_ld, io_mem_xcpt_pf_st, io_mem_ptw_req_valid, io_mem_ptw_req_bits, io_mem_ordered, io_s, io_imem_acquire_ready, io_imem_grant_valid, io_imem_grant_bits_header_src, io_imem_grant_bits_header_dst, io_imem_grant_bits_payload_data, io_imem_grant_bits_payload_client_xact_id, io_imem_grant_bits_payload_master_xact_id, io_imem_grant_bits_payload_g_type, io_imem_finish_ready, io_iptw_req_ready, io_iptw_resp_valid, io_iptw_resp_bits_error, io_iptw_resp_bits_ppn, io_iptw_resp_bits_perm, io_iptw_status_ip, io_iptw_status_im, io_iptw_status_zero, io_iptw_status_er, io_iptw_status_vm, io_iptw_status_s64, io_iptw_status_u64, io_iptw_status_ef, io_iptw_status_pei, io_iptw_status_ei, io_iptw_status_ps, io_iptw_status_s, io_iptw_invalidate, io_iptw_sret, io_dptw_req_ready, io_dptw_resp_valid, io_dptw_resp_bits_error, io_dptw_resp_bits_ppn, io_dptw_resp_bits_perm, io_dptw_status_ip, io_dptw_status_im, io_dptw_status_zero, io_dptw_status_er, io_dptw_status_vm, io_dptw_status_s64, io_dptw_status_u64, io_dptw_status_ef, io_dptw_status_pei, io_dptw_status_ei, io_dptw_status_ps, io_dptw_status_s, io_dptw_invalidate, io_dptw_sret, io_pptw_req_ready, io_pptw_resp_valid, io_pptw_resp_bits_error, io_pptw_resp_bits_ppn, io_pptw_resp_bits_perm, io_pptw_status_ip, io_pptw_status_im, io_pptw_status_zero, io_pptw_status_er, io_pptw_status_vm, io_pptw_status_s64, io_pptw_status_u64, io_pptw_status_ef, io_pptw_status_pei, io_pptw_status_ei, io_pptw_status_ps, io_pptw_status_s, io_pptw_invalidate, io_pptw_sret, io_exception);
    $init_outs(io_cmd_ready, io_resp_valid, io_resp_bits_rd, io_resp_bits_data, io_mem_req_valid, io_mem_req_bits_kill, io_mem_req_bits_typ, io_mem_req_bits_phys, io_mem_req_bits_addr, io_mem_req_bits_data, io_mem_req_bits_tag, io_mem_req_bits_cmd, io_mem_ptw_req_ready, io_mem_ptw_resp_valid, io_mem_ptw_resp_bits_error, io_mem_ptw_resp_bits_ppn, io_mem_ptw_resp_bits_perm, io_mem_ptw_status_ip, io_mem_ptw_status_im, io_mem_ptw_status_zero, io_mem_ptw_status_er, io_mem_ptw_status_vm, io_mem_ptw_status_s64, io_mem_ptw_status_u64, io_mem_ptw_status_ef, io_mem_ptw_status_pei, io_mem_ptw_status_ei, io_mem_ptw_status_ps, io_mem_ptw_status_s, io_mem_ptw_invalidate, io_mem_ptw_sret, io_busy, io_interrupt, io_imem_acquire_valid, io_imem_acquire_bits_header_src, io_imem_acquire_bits_header_dst, io_imem_acquire_bits_payload_addr, io_imem_acquire_bits_payload_client_xact_id, io_imem_acquire_bits_payload_data, io_imem_acquire_bits_payload_a_type, io_imem_acquire_bits_payload_write_mask, io_imem_acquire_bits_payload_subword_addr, io_imem_acquire_bits_payload_atomic_opcode, io_imem_grant_ready, io_imem_finish_valid, io_imem_finish_bits_header_src, io_imem_finish_bits_header_dst, io_imem_finish_bits_payload_master_xact_id, io_iptw_req_valid, io_iptw_req_bits, io_dptw_req_valid, io_dptw_req_bits, io_pptw_req_valid, io_pptw_req_bits);
    $init_sigs(Sha3Accel);
    /*** VCD & VPD dump ***/
    if ($value$plusargs("vcdfile=%s", vcdfile)) begin
      $dumpfile(vcdfile);
      $dumpvars(0, Sha3Accel);
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
