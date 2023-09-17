/*

.---------------------------------------------------------------------------------------------.
|                         Floating-Point Control and Status Registers                         |
.--------.------------.----------.------------------------------------------------------------.
| Number | Privilege  | Name     | Description                                                |
|--------+------------+----------+------------------------------------------------------------|
| 0x001  | Read/write | fflags   | Floating-Point Accrued Exceptions.                         |
| 0x002  | Read/write | frm      | Floating-Point Dynamic Rounding Mode.                      |
| 0x003  | Read/write | fcsr     | Floating-Point Control and Status Register (frm + fflags). |
'--------'------------'----------'------------------------------------------------------------'

.---------------------------------------------------------------------------------------------.
|                                     Counters and Timers                                     |
|--------.------------.----------.------------------------------------------------------------|
| Number | Privilege  | Name     | Description                                                |
|--------+------------+----------+------------------------------------------------------------|
| 0xC00  | Read-only  | cycle    | Cycle counter for RDCYCLE instruction.                     |
| 0xC01  | Read-only  | time     | Timer for RDTIME instruction.                              |
| 0xC02  | Read-only  | instret  | Instructions-retired counter for RDINSTRET instruction.    |
| 0xC80  | Read-only  | cycleh   | Upper 32 bits of cycle, RV32I only.                        |
| 0xC81  | Read-only  | timeh    | Upper 32 bits of time, RV32I only.                         |
| 0xC82  | Read-only  | instreth | Upper 32 bits of instret, RV32I only.                      |
'--------'------------'----------'------------------------------------------------------------'

Table 24.3: RISC-V control and status register (CSR) address map.

*/

module tb_func_decode;

  initial begin
    $display("\033[7;38m####################### TEST STARTED #######################\033[0m");
    $timeformat(-6, 3, "us");
    repeat (1000) repeat (1000) repeat (1000) #1000;
    $display("\033[1;31m[FATAL][TIMEOUT]\033[0m");
    $finish;
  end

  final begin
    $display("\033[7;38m######################## TEST ENDED ########################\033[0m");
  end

  riscv_model model = new();

  initial begin
    $display("%p", model.decode('h10000517));
    $display("%p", model.decode('h00052503));
    $display("%p", model.decode('h01c000ef));
    $display("%p", model.decode('h00050593));
    $display("%p", model.decode('h10000517));
    $display("%p", model.decode('hff052503));
    $display("%p", model.decode('h04c000ef));
    $display("%p", model.decode('h00a00893));
    $display("%p", model.decode('h00000073));
    $display("%p", model.decode('hff010113));
    $display("%p", model.decode('h00112423));
    $display("%p", model.decode('h00a12023));
    $display("%p", model.decode('hfff50293));
    $display("%p", model.decode('h0002d863));
    $display("%p", model.decode('h00100513));
    $display("%p", model.decode('h01010113));
    $display("%p", model.decode('h00008067));
    $display("%p", model.decode('hfff50513));
    $display("%p", model.decode('hfddff0ef));
    $display("%p", model.decode('h00050313));
    $display("%p", model.decode('h00012503));
    $display("%p", model.decode('h00812083));
    $display("%p", model.decode('h01010113));
    $display("%p", model.decode('h02650533));
    $display("%p", model.decode('h00008067));
    $display("%p", model.decode('h00050293));
    $display("%p", model.decode('h00058313));
    $display("%p", model.decode('h10000517));
    $display("%p", model.decode('hf9850513));
    $display("%p", model.decode('h00400893));
    $display("%p", model.decode('h00000073));
    $display("%p", model.decode('h00028513));
    $display("%p", model.decode('h00100893));
    $display("%p", model.decode('h00000073));
    $display("%p", model.decode('h10000517));
    $display("%p", model.decode('hf9050513));
    $display("%p", model.decode('h00400893));
    $display("%p", model.decode('h00000073));
    $display("%p", model.decode('h00030513));
    $display("%p", model.decode('h00100893));
    $display("%p", model.decode('h00000073));
    $display("%p", model.decode('h00008067));
    $finish;
  end

endmodule
