class instruction_generator;

  typedef enum int {  //{{{
    INVALID_inst,
    ADD,
    ADDI,
    ADDIW,
    ADDW,
    AMOADD_D,
    AMOADD_W,
    AMOAND_D,
    AMOAND_W,
    AMOMAX_D,
    AMOMAX_W,
    AMOMAXU_D,
    AMOMAXU_W,
    AMOMIN_D,
    AMOMIN_W,
    AMOMINU_D,
    AMOMINU_W,
    AMOOR_D,
    AMOOR_W,
    AMOSWAP_D,
    AMOSWAP_W,
    AMOXOR_D,
    AMOXOR_W,
    AND,
    ANDI,
    AUIPC,
    BEQ,
    BGE,
    BGEU,
    BLT,
    BLTU,
    BNE,
    CSRRC,
    CSRRCI,
    CSRRS,
    CSRRSI,
    CSRRW,
    CSRRWI,
    DIV,
    DIVU,
    DIVUW,
    DIVW,
    EBREAK,
    ECALL,
    FADD_D,
    FADD_Q,
    FADD_S,
    FCLASS_D,
    FCLASS_Q,
    FCLASS_S,
    FCVT_D_L,
    FCVT_D_LU,
    FCVT_D_Q,
    FCVT_D_S,
    FCVT_D_W,
    FCVT_D_WU,
    FCVT_L_D,
    FCVT_L_Q,
    FCVT_L_S,
    FCVT_LU_D,
    FCVT_LU_Q,
    FCVT_LU_S,
    FCVT_Q_D,
    FCVT_Q_L,
    FCVT_Q_LU,
    FCVT_Q_S,
    FCVT_Q_W,
    FCVT_Q_WU,
    FCVT_S_D,
    FCVT_S_L,
    FCVT_S_LU,
    FCVT_S_Q,
    FCVT_S_W,
    FCVT_S_WU,
    FCVT_W_D,
    FCVT_W_Q,
    FCVT_W_S,
    FCVT_WU_D,
    FCVT_WU_Q,
    FCVT_WU_S,
    FDIV_D,
    FDIV_Q,
    FDIV_S,
    FENCE_I,
    FENCE,
    FEQ_D,
    FEQ_Q,
    FEQ_S,
    FLD,
    FLE_D,
    FLE_Q,
    FLE_S,
    FLQ,
    FLT_D,
    FLT_Q,
    FLT_S,
    FLW,
    FMADD_D,
    FMADD_Q,
    FMADD_S,
    FMAX_D,
    FMAX_Q,
    FMAX_S,
    FMIN_D,
    FMIN_Q,
    FMIN_S,
    FMSUB_D,
    FMSUB_Q,
    FMSUB_S,
    FMUL_D,
    FMUL_Q,
    FMUL_S,
    FMV_D_X,
    FMV_W_X,
    FMV_X_D,
    FMV_X_W,
    FNMADD_D,
    FNMADD_Q,
    FNMADD_S,
    FNMSUB_D,
    FNMSUB_Q,
    FNMSUB_S,
    FSD,
    FSGNJ_D,
    FSGNJ_Q,
    FSGNJ_S,
    FSGNJN_D,
    FSGNJN_Q,
    FSGNJN_S,
    FSGNJX_D,
    FSGNJX_Q,
    FSGNJX_S,
    FSQ,
    FSQRT_D,
    FSQRT_Q,
    FSQRT_S,
    FSUB_D,
    FSUB_Q,
    FSUB_S,
    FSW,
    JAL,
    JALR,
    LB,
    LBU,
    LD,
    LH,
    LHU,
    LR_D,
    LR_W,
    LUI,
    LW,
    LWU,
    MUL,
    MULH,
    MULHSU,
    MULHU,
    MULW,
    OR,
    ORI,
    REM,
    REMU,
    REMUW,
    REMW,
    SB,
    SC_D,
    SC_W,
    SD,
    SH,
    SLL,
    SLLI,
    SLLIW,
    SLLW,
    SLT,
    SLTI,
    SLTIU,
    SLTU,
    SRA,
    SRAI,
    SRAIW,
    SRAW,
    SRL,
    SRLI,
    SRLIW,
    SRLW,
    SUB,
    SUBW,
    SW,
    XOR,
    XORI
  } func_t;  //}}}

  typedef enum logic [2:0] {  //{{{
    RNE      = 3'd0,
    RTZ      = 3'd1,
    RDN      = 3'd2,
    RUP      = 3'd3,
    RMM      = 3'd4,
    RM_RES_5 = 3'd5,
    RM_RES_6 = 3'd6,
    DYN      = 3'd7
  } rm_t;  //}}}

  rand func_t        func;
  rand logic  [ 4:0] rs1;
  rand logic  [ 4:0] rs2;
  rand logic  [ 4:0] rs3;
  rand logic  [ 4:0] rd;
  rand logic  [31:0] imm;
  rand logic  [ 5:0] shamt;
  rand logic  [ 3:0] fm;
  rand logic  [ 3:0] pred;
  rand logic  [ 3:0] succ;
  rand logic         aq;
  rand logic         rl;
  rand rm_t          rm;
  rand logic  [31:0] uimm;
  rand logic  [11:0] csr;

  logic       [31:0] inst;

  function void post_randomization();
    inst = '0;
    case (func)
      ADD: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      ADDI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      ADDIW: begin
        inst[06:00] = 7'b0011011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      ADDW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      AMOADD_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00000;
      end
      AMOADD_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00000;
      end
      AMOAND_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b01100;
      end
      AMOAND_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b01100;
      end
      AMOMAX_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b10100;
      end
      AMOMAX_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b10100;
      end
      AMOMAXU_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b11100;
      end
      AMOMAXU_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b11100;
      end
      AMOMIN_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b10000;
      end
      AMOMIN_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b10000;
      end
      AMOMINU_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b11000;
      end
      AMOMINU_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b11000;
      end
      AMOOR_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b01000;
      end
      AMOOR_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b01000;
      end
      AMOSWAP_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00001;
      end
      AMOSWAP_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00001;
      end
      AMOXOR_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00100;
      end
      AMOXOR_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25] = rl;
        inst[26] = aq;
        inst[31:27] = 5'b00100;
      end
      AND: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b111;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      ANDI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b111;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      AUIPC: begin
        inst[06:00] = 7'b0010111;
        inst[11:07] = rd;
        inst[31:12] = imm;
      end
      BEQ: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      BGE: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      BGEU: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b111;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      BLT: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      BLTU: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      BNE: begin
        inst[06:00] = 7'b1100011;
        inst[07] = imm[11];
        inst[11:08] = imm[4:1];
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[30:25] = imm[10:0];
        inst[31] = imm[12];
      end
      CSRRC: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[31:20] = csr;
      end
      CSRRCI: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b111;
        inst[19:15] = uimm;
        inst[31:20] = csr;
      end
      CSRRS: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[31:20] = csr;
      end
      CSRRSI: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = uimm;
        inst[31:20] = csr;
      end
      CSRRW: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[31:20] = csr;
      end
      CSRRWI: begin
        inst[06:00] = 7'b1110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = uimm;
        inst[31:20] = csr;
      end
      DIV: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      DIVU: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      DIVUW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      DIVW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      EBREAK: begin
        inst[06:00] = 7'b1110011;
        inst[20]    = 1'b1;
      end
      ECALL: begin
        inst[06:00] = 7'b1110011;
      end
      FADD_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      FADD_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000011;
      end
      FADD_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      FCLASS_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1110001;
      end
      FCLASS_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1110011;
      end
      FCLASS_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1110000;
      end
      FCVT_D_L: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1101001;
      end
      FCVT_D_LU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1101001;
      end
      FCVT_D_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b0100000;
      end
      FCVT_D_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b0100001;
      end
      FCVT_D_W: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1101001;
      end
      FCVT_D_WU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b1101001;
      end
      FCVT_L_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1100001;
      end
      FCVT_L_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1100011;
      end
      FCVT_L_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1100000;
      end
      FCVT_LU_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1100001;
      end
      FCVT_LU_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1100011;
      end
      FCVT_LU_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1100000;
      end
      FCVT_Q_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b0100011;
      end
      FCVT_Q_L: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1101011;
      end
      FCVT_Q_LU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1101011;
      end
      FCVT_Q_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b0100011;
      end
      FCVT_Q_W: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b01101011;
      end
      FCVT_Q_WU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b01101011;
      end
      FCVT_S_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b0100000;
      end
      FCVT_S_L: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00010;
        inst[31:25] = 7'b1101000;
      end
      FCVT_S_LU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b1101000;
      end
      FCVT_S_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00011;
        inst[31:25] = 7'b0100000;
      end
      FCVT_S_W: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1101000;
      end
      FCVT_S_WU: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b1101000;
      end
      FCVT_W_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1100001;
      end
      FCVT_W_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1100011;
      end
      FCVT_W_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1100000;
      end
      FCVT_WU_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b1100001;
      end
      FCVT_WU_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b1100011;
      end
      FCVT_WU_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00001;
        inst[31:25] = 7'b1100000;
      end
      FDIV_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001101;
      end
      FDIV_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001111;
      end
      FDIV_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001100;
      end
      FENCE_I: begin
        inst[06:00] = 7'b0001111;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      FENCE: begin
        inst[06:00] = 7'b0001111;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[23:20] = succ;
        inst[27:24] = pred;
        inst[31:28] = fm;
      end
      FEQ_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010001;
      end
      FEQ_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010011;
      end
      FEQ_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010000;
      end
      FLD: begin
        inst[06:00] = 7'b0000111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      FLE_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010001;
      end
      FLE_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010011;
      end
      FLE_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010000;
      end
      FLQ: begin
        inst[06:00] = 7'b0000111;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      FLT_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010001;
      end
      FLT_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010011;
      end
      FLT_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b1010000;
      end
      FLW: begin
        inst[06:00] = 7'b0000111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      FMADD_D: begin
        inst[06:00] = 7'b1000011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b01;
        inst[31:27] = rs3;
      end
      FMADD_Q: begin
        inst[06:00] = 7'b1000011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b11;
        inst[31:27] = rs3;
      end
      FMADD_S: begin
        inst[06:00] = 7'b1000011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b00;
        inst[31:27] = rs3;
      end
      FMAX_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010101;
      end
      FMAX_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010111;
      end
      FMAX_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010100;
      end
      FMIN_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010111;
      end
      FMIN_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010101;
      end
      FMIN_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010100;
      end
      FMSUB_D: begin
        inst[06:00] = 7'b1000111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b01;
        inst[31:27] = rs3;
      end
      FMSUB_Q: begin
        inst[06:00] = 7'b1000111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b11;
        inst[31:27] = rs3;
      end
      FMSUB_S: begin
        inst[06:00] = 7'b1000111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b00;
        inst[31:27] = rs3;
      end
      FMUL_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001001;
      end
      FMUL_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001011;
      end
      FMUL_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0001000;
      end
      FMV_D_X: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1111001;
      end
      FMV_W_X: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1111000;
      end
      FMV_X_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1110001;
      end
      FMV_X_W: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b1110000;
      end
      FNMADD_D: begin
        inst[06:00] = 7'b1001111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b01;
        inst[31:27] = rs3;
      end
      FNMADD_Q: begin
        inst[06:00] = 7'b1001111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b11;
        inst[31:27] = rs3;
      end
      FNMADD_S: begin
        inst[06:00] = 7'b1001111;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b00;
        inst[31:27] = rs3;
      end
      FNMSUB_D: begin
        inst[06:00] = 7'b1001011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b01;
        inst[31:27] = rs3;
      end
      FNMSUB_Q: begin
        inst[06:00] = 7'b1001011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b11;
        inst[31:27] = rs3;
      end
      FNMSUB_S: begin
        inst[06:00] = 7'b1001011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[26:25] = 2'b00;
        inst[31:27] = rs3;
      end
      FSD: begin
        inst[06:00] = 7'b0100111;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = imm[11:5];
      end
      FSGNJ_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010001;
      end
      FSGNJ_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010011;
      end
      FSGNJ_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010000;
      end
      FSGNJN_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010001;
      end
      FSGNJN_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010011;
      end
      FSGNJN_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010000;
      end
      FSGNJX_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010001;
      end
      FSGNJX_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010011;
      end
      FSGNJX_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0010000;
      end
      FSQ: begin
        inst[06:00] = 7'b0100111;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = imm[11:5];
      end
      FSQRT_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b0101101;
      end
      FSQRT_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b0101111;
      end
      FSQRT_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = 5'b00000;
        inst[31:25] = 7'b0101100;
      end
      FSUB_D: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000101;
      end
      FSUB_Q: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000111;
      end
      FSUB_S: begin
        inst[06:00] = 7'b1010011;
        inst[11:07] = rd;
        inst[14:12] = rm;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000100;
      end
      FSW: begin
        inst[06:00] = 7'b0100011;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = imm[11:5];
      end
      JAL: begin
        inst[06:00] = 7'b1101111;
        inst[11:07] = rd;
        inst[19:12] = imm[19:12];
        inst[20]    = imm[11];
        inst[30:21] = imm[10:1];
        inst[31]    = imm[20];
      end
      JALR: begin
        inst[06:00] = 7'b1100111;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LB: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LBU: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LD: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LH: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LHU: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LR_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = '0;
        inst[25]    = rl;
        inst[26]    = aq;
        inst[31:27] = 5'b00010;
      end
      LR_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = '0;
        inst[25]    = rl;
        inst[26]    = aq;
        inst[31:27] = 5'b00010;
      end
      LUI: begin
        inst[06:00] = 7'b0110111;
        inst[11:07] = rd;
        inst[31:12] = imm;
      end
      LW: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      LWU: begin
        inst[06:00] = 7'b0000011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[31:20] = imm;
      end
      MUL: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      MULH: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      MULHSU: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      MULHU: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      MULW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      OR: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      ORI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      REM: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      REMU: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b111;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      REMUW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b111;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      REMW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b110;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000001;
      end
      SB: begin
        inst[06:00] = 7'b0100011;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs1;
        inst[31:25] = imm[11:5];
      end
      SC_D: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25]    = rl;
        inst[26]    = aq;
        inst[31:27] = 5'b00011;
      end
      SC_W: begin
        inst[06:00] = 7'b0101111;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[25]    = rl;
        inst[26]    = aq;
        inst[31:27] = 5'b00011;
      end
      SD: begin
        inst[06:00] = 7'b0100011;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = imm[11:5];
      end
      SH: begin
        inst[06:00] = 7'b0100011;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = imm[11:5];
      end
      SLL: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SLLI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0000000;
      end
      SLLIW: begin
        inst[06:00] = 7'b0011011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0000000;
      end
      SLLW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b001;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SLT: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SLTI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      SLTIU: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      SLTU: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b011;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SRA: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0100000;
      end
      SRAI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0100000;
      end
      SRAIW: begin
        inst[06:00] = 7'b0011011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0100000;
      end
      SRAW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0100000;
      end
      SRL: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SRLI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0000000;
      end
      SRLIW: begin
        inst[06:00] = 7'b0011011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = shamt;
        inst[31:25] = 7'b0000000;
      end
      SRLW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b101;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      SUB: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0100000;
      end
      SUBW: begin
        inst[06:00] = 7'b0111011;
        inst[11:07] = rd;
        inst[14:12] = 3'b000;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0100000;
      end
      SW: begin
        inst[06:00] = 7'b0100011;
        inst[11:07] = imm[4:0];
        inst[14:12] = 3'b010;
        inst[19:15] = rs1;
        inst[24:20] = rs1;
        inst[31:25] = imm[11:5];
      end
      XOR: begin
        inst[06:00] = 7'b0110011;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[24:20] = rs2;
        inst[31:25] = 7'b0000000;
      end
      XORI: begin
        inst[06:00] = 7'b0010011;
        inst[11:07] = rd;
        inst[14:12] = 3'b100;
        inst[19:15] = rs1;
        inst[31:20] = imm[11:0];
      end
      default: inst = '0;
    endcase
  endfunction

endclass
