/*
Write a markdown documentation for this systemverilog module:
Author : Foez Ahmed (foez.official@gmail.com)
*/

`include "rv64g_pkg.sv"

module instruction_decoder
  import rv64g_pkg::*;
(
    input logic [31:0] code_i,

    output decoded_instr_t cmd_o
);

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-SIGNALS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  decoded_instr_t decoder[10];

  decoded_instr_t decoder_B;
  decoded_instr_t decoder_I;
  decoded_instr_t decoder_J;
  decoded_instr_t decoder_R;
  decoded_instr_t decoder_R4;
  decoded_instr_t decoder_S;
  decoded_instr_t decoder_U;
  decoded_instr_t decoder_X;
  decoded_instr_t decoder_A;
  decoded_instr_t decoder_F;

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-ASSIGNMENTS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  assign decoder[0] = decoder_B;
  assign decoder[1] = decoder_I;
  assign decoder[2] = decoder_J;
  assign decoder[3] = decoder_R;
  assign decoder[4] = decoder_R4;
  assign decoder[5] = decoder_S;
  assign decoder[6] = decoder_U;
  assign decoder[7] = decoder_X;
  assign decoder[8] = decoder_A;
  assign decoder[9] = decoder_F;

  always_comb begin  // decoder_B
    decoder_B           = '0;
    decoder_B.imm       = code_i[31] ? '1 : '0;
    decoder_B.imm[12]   = code_i[31];
    decoder_B.imm[11]   = code_i[7];
    decoder_B.imm[10:5] = code_i[30:25];
    decoder_B.imm[4:1]  = code_i[11:8];
    decoder_B.imm[0]    = '0;
    decoder_B.rs1       = code_i[19:15];
    decoder_B.rs2       = code_i[24:20];
    case (code_i[14:12])
      3'd0: decoder_B.funct = BEQ;
      3'd1: decoder_B.funct = BNE;
      3'd4: decoder_B.funct = BLT;
      3'd5: decoder_B.funct = BGE;
      3'd6: decoder_B.funct = BLTU;
      3'd7: decoder_B.funct = BGEU;
      default decoder_B.funct = INVALID;
    endcase
    if (decoder_B.funct == INVALID) decoder_B = '0;
  end

  always_comb begin  // decoder_I
    decoder_I           = '0;
    decoder_I.imm       = code_i[31] ? '1 : '0;
    decoder_I.imm[11:0] = code_i[31:20];
    decoder_I.rd        = code_i[11:7];
    decoder_I.rs1       = code_i[19:15];
    decoder_I.rs2       = code_i[24:20];
    case ({
      code_i[14:12], code_i[6:0]
    })
      'b000_1100111: decoder_I.funct = JALR;
      'b010_0000111: decoder_I.funct = FLW;
      'b011_0000111: decoder_I.funct = FLD;
      'b001_0000111: decoder_I.funct = FLH;
      'b000_0000011: decoder_I.funct = LB;
      'b001_0000011: decoder_I.funct = LH;
      'b010_0000011: decoder_I.funct = LW;
      'b100_0000011: decoder_I.funct = LBU;
      'b101_0000011: decoder_I.funct = LHU;
      'b110_0000011: decoder_I.funct = LWU;
      'b011_0000011: decoder_I.funct = LD;
      'b000_0010011: decoder_I.funct = ADDI;
      'b010_0010011: decoder_I.funct = SLTI;
      'b011_0010011: decoder_I.funct = SLTIU;
      'b100_0010011: decoder_I.funct = XORI;
      'b110_0010011: decoder_I.funct = ORI;
      'b111_0010011: decoder_I.funct = ANDI;
      'b001_0010011: decoder_I.funct = SLLI;
      'b101_0010011: decoder_I.funct = code_i[30] ? SRLI : SRAI;
      'b000_0011011: decoder_I.funct = ADDIW;
      'b001_0011011: decoder_I.funct = SLLIW;
      'b101_0011011: decoder_I.funct = code_i[30] ? SRLIW : SRAIW;
      default: begin
        case (code_i[31:0])
          'b1000_0011_0011_00000_000_00000_0001111: decoder_I.funct = FENCE_TSO;
          'b0000_0001_0000_00000_000_00000_0001111: decoder_I.funct = PAUSE;
          default: begin
            case (code_i[6:0])
              'b0001111: decoder_I.funct = FENCE;
              default:   decoder_I.funct = INVALID;
            endcase
          end
        endcase
      end
    endcase
    if (decoder_I.funct == INVALID) decoder_I = '0;
  end

  always_comb begin  // decoder_J
    decoder_J            = '0;
    decoder_J.imm        = code_i[31] ? '1 : '0;
    decoder_J.imm[20]    = code_i[31];
    decoder_J.imm[10:1]  = code_i[30:21];
    decoder_J.imm[11]    = code_i[20];
    decoder_J.imm[19:12] = code_i[19:12];
    decoder_J.imm[0]     = 0;
    decoder_J.rd         = code_i[11:7];
    decoder_J.funct      = JAL;
    if (decoder_J.funct == INVALID) decoder_J = '0;
  end

  always_comb begin  // decoder_R
    decoder_R     = '0;
    decoder_R.rd  = code_i[11:7];
    decoder_R.rs1 = code_i[19:15];
    decoder_R.rs2 = code_i[24:20];
    case ({
      code_i[31:25], code_i[14:12], code_i[6:0]
    })
      'b0000000_000_0110011: decoder_R.funct = ADD;
      'b0100000_000_0110011: decoder_R.funct = SUB;
      'b0000000_001_0110011: decoder_R.funct = SLL;
      'b0000000_010_0110011: decoder_R.funct = SLT;
      'b0000000_011_0110011: decoder_R.funct = SLTU;
      'b0000000_100_0110011: decoder_R.funct = XOR;
      'b0000000_101_0110011: decoder_R.funct = SRL;
      'b0100000_101_0110011: decoder_R.funct = SRA;
      'b0000000_110_0110011: decoder_R.funct = OR;
      'b0000000_111_0110011: decoder_R.funct = AND;
      'b0000000_000_0111011: decoder_R.funct = ADDW;
      'b0100000_000_0111011: decoder_R.funct = SUBW;
      'b0000000_001_0111011: decoder_R.funct = SLLW;
      'b0000000_101_0111011: decoder_R.funct = SRLW;
      'b0100000_101_0111011: decoder_R.funct = SRAW;
      default: decoder_R.funct = INVALID;
    endcase
    if (decoder_R.funct == INVALID) decoder_R = '0;
  end

  always_comb begin  // decoder_R4
    decoder_R4     = '0;
    decoder_R4.rm  = rm_t'(code_i[14:12]);
    decoder_R4.rd  = code_i[11:7];
    decoder_R4.rs1 = code_i[19:15];
    decoder_R4.rs2 = code_i[24:20];
    decoder_R4.imm = code_i[31:27];
    case ({
      code_i[26:25], code_i[6:0]
    })
      'b00_1000011: decoder_R4.funct = FMADD_S;
      'b00_1000111: decoder_R4.funct = FMSUB_S;
      'b00_1001011: decoder_R4.funct = FNMSUB_S;
      'b00_1001111: decoder_R4.funct = FNMADD_S;
      'b01_1001111: decoder_R4.funct = FNMADD_D;
      'b10_1000011: decoder_R4.funct = FMADD_H;
      'b10_1000111: decoder_R4.funct = FMSUB_H;
      'b10_1001011: decoder_R4.funct = FNMSUB_H;
      'b10_1001111: decoder_R4.funct = FNMADD_H;
      default: decoder_R4.funct = INVALID;
    endcase
    if (decoder_R4.funct == INVALID) decoder_R4 = '0;
  end

  always_comb begin  // decoder_S
    decoder_S           = '0;
    decoder_S.imm       = code_i[31] ? '1 : '0;
    decoder_S.imm[11:5] = code_i[31:25];
    decoder_S.imm[4:0]  = code_i[11:7];
    decoder_S.rs1       = code_i[19:15];
    decoder_S.rs2       = code_i[24:20];
    case ({
      code_i[14:12], code_i[6:0]
    })
      'b000_0100011: decoder_S.funct = SB;
      'b001_0100011: decoder_S.funct = SH;
      'b010_0100011: decoder_S.funct = SW;
      'b011_0100011: decoder_S.funct = SD;
      'b001_0100111: decoder_S.funct = FSH;
      'b010_0100111: decoder_S.funct = FSW;
      'b011_0100111: decoder_S.funct = FSD;
      default: decoder_S.funct = INVALID;
    endcase
    if (decoder_S.funct == INVALID) decoder_S = '0;
  end

  always_comb begin  // decoder_U
    decoder_U            = '0;
    decoder_U.imm[31:12] = code_i[31:12];
    decoder_U.rd         = code_i[11:7];
    case (code_i[6:0])
      'b0010111: decoder_U.funct = AUIPC;
      'b0110111: decoder_U.funct = LUI;
      default:   decoder_U.funct = INVALID;
    endcase
    if (decoder_U.funct == INVALID) decoder_U = '0;
  end

  always_comb begin  // decoder_X
    decoder_X     = '0;
    decoder_X.csr = code_i[31:20];
    decoder_X.rd  = code_i[11:7];
    decoder_X.rs1 = code_i[19:15];
    decoder_X.imm = code_i[19:15];
    case (code_i[14:12])
      1: decoder_X.funct = CSRRW;
      2: decoder_X.funct = CSRRS;
      3: decoder_X.funct = CSRRC;
      5: decoder_X.funct = CSRRWI;
      6: decoder_X.funct = CSRRSI;
      7: decoder_X.funct = CSRRCI;
      default: begin
        case (code_i[31:7])
          25'h0000000: decoder_X.funct = ECALL;
          25'h0002000: decoder_X.funct = EBREAK;
          default decoder_X.funct = INVALID;
        endcase
      end
    endcase
    if (decoder_X.funct == INVALID) decoder_X = '0;
  end

  always_comb begin  // decoder_A
    decoder_A = '0;
    // TODO Sakib vai
    if (decoder_A.funct == INVALID) decoder_A = '0;
  end

  always_comb begin  // decoder_F
    decoder_F           = '0;
    decoder_F.rs1       = code_i[19:15];
    decoder_F.rs2       = code_i[24:20];
    decoder_F.rs3       = code_i[31:27];
    decoder_F.rm        = rm_t'(code_i[14:12]);
    decoder_F.rd        = code_i[11:7];
    decoder_F.imm[11:0] = code_i[31:20];
    decoder_F.imm[4:0]  = code_i[11:7];
    decoder_F.imm[11:5] = code_i[31:25];
    case (code_i[6:0])
      7'b0000111: decoder_F.funct = FLW;
      7'b0100111: decoder_F.funct = FSW;
      7'b1000011: decoder_F.funct = FMADD_S;
      7'b1000111: decoder_F.funct = FMSUB_S;
      7'b1001011: decoder_F.funct = FNMSUB_S;
      7'b1001111: decoder_F.funct = FNMADD_S;
      7'b1010011:
      begin
        case(code_i[31:25])
          7'b0000000: decoder_F.funct = FADD_S;
          7'b0000100: decoder_F.funct = FSUB_S;
          7'b0001000: decoder_F.funct = FMUL_S;
          7'b0011000: decoder_F.funct = FDIV_S;
          7'b0101100: decoder_F.funct = FSQRT_S;
          7'b0010000:
          begin
            case (code_i[14:12])
              3'b000:  decoder_F.funct  = FSGNJ_S;
              3'b001:  decoder_F.funct  = FSGNJN_S;
              3'b010:  decoder_F.funct  = FSGNJX_S;
              default: decoder_F.funct  = INVALID;
            endcase
          end
          7'b0010100:
          begin
            case(code_i[14:12])
              3'b000:  decoder_F.funct  = FMIN_S;
              3'b001:  decoder_F.funct  = FMAX_S;
              default: decoder_F.funct  = INVALID;
            endcase
          end
          7'b1100000:
          begin
            case(code_i[24:20])
              5'b00000: decoder_F.funct = FCVT_W_S;
              5'b00001: decoder_F.funct = FCVT_WU_S;
              default:  decoder_F.funct = INVALID;
            endcase
          end
          7'b1110000:
          begin
            decoder_F.rs2 = 5'b00000;
            case(code_i[14:12])
              3'b000:  decoder_F.funct  = FMV_X_W;
              3'b001:  decoder_F.funct  = FCLASS_S;
              default: decoder_F.funct  = INVALID;
            endcase
          end
          7'b1010000:
          begin
            case(code_i[14:12])
              3'b000:  decoder_F.funct   = FLE_S;
              3'b001:  decoder_F.funct   = FLT_S;
              3'b010:  decoder_F.funct   = FEQ_S;
              default: decoder_F.funct   = INVALID;
            endcase
          end
          7'b1101000:
          begin
            case(code_i[24:20])
              5'b00000: decoder_F.funct = FCVT_S_W;
              5'b00001: decoder_F.funct = FCVT_S_WU;
              default:  decoder_F.funct = INVALID;
            endcase
          end
          7'b1111000:
          begin
            decoder_F.funct = FMV_W_X;
            decoder_F.rs2   = 5'b00000;
            decoder_F.rm    = rm_t'(3'b000);
          end
          default: decoder_F.funct = INVALID;
        endcase
      end
      default: decoder_F.funct = INVALID;
    endcase
    if (decoder_F.funct == INVALID) decoder_F = '0;
  end

  //////////////////////////////////////////////////////////////////////////////////////////////////
  //-RTLS
  //////////////////////////////////////////////////////////////////////////////////////////////////

  decoder_reduction_or #(
      .NUM_INPUTS(10)
  ) u_decoder_reduction_or (
      .wire_i(decoder),
      .wire_o(cmd_o)
  );

endmodule
