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

module riscv_model_tb;

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

  function automatic void print_int_reg_file();
    for (int i = 0; i < 32; i++) begin
      $display("%2d:0x%h", i, model.read_int_reg(i));
    end
  endfunction

  initial begin
    $display("\n\n\n\n");
    print_int_reg_file();
    $display("\n\n\n\n");

    model.execute('h00100013);
    model.execute('h00100093);
    model.execute('h00108113);
    model.execute('h00110193);
    model.execute('h00118213);
    model.execute('h00120293);
    model.execute('h00128313);
    model.execute('h00130393);
    model.execute('h00138413);
    model.execute('h00140493);
    model.execute('h00148513);
    model.execute('h00150593);
    model.execute('h00158613);
    model.execute('h00160693);
    model.execute('h00168713);
    model.execute('h00170793);
    model.execute('h00178813);
    model.execute('h00180893);
    model.execute('h00188913);
    model.execute('h00190993);
    model.execute('h00198a13);
    model.execute('h001a0a93);
    model.execute('h001a8b13);
    model.execute('h001b0b93);
    model.execute('h001b8c13);
    model.execute('h001c0c93);
    model.execute('h001c8d13);
    model.execute('h001d0d93);
    model.execute('h001d8e13);
    model.execute('h001e0e93);
    model.execute('h001e8f13);
    model.execute('h001f0f93);

    $display("\n\n\n\n");
    print_int_reg_file();
    $display("\n\n\n\n");

    $finish;
  end

endmodule
