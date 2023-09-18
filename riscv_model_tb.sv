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

  `define EXE(__HEX__)                  \
    model.execute('h``__HEX__``, 1);    \

  localparam int XLEN = 64;
  initial begin

    `EXE(04600513)
    `EXE(10a00023)
    `EXE(04f00513)
    `EXE(10a000a3)
    `EXE(04500513)
    `EXE(10a00123)
    `EXE(05a00513)
    `EXE(10a001a3)
    `EXE(10000513)
    `EXE(00400893)
    `EXE(00000073)
    `EXE(00a00893)
    `EXE(00000073)


    $display("\n");
    $display("%s", model.int_reg_to_string());
    $display("\n");

    $finish;
  end

endmodule
