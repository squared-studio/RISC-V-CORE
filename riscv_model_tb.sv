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

`define EXE(__HEX__)                                                                    \
  if (!model.execute('h``__HEX__``)) $display(`"FAILED TO EXEECUTE ``__HEX__`` `");   \

  initial begin

    `EXE(00100093)
    `EXE(02009093)
    `EXE(00200113)
    `EXE(402081b3)
    `EXE(4020823b)

    $display("\n");
    $display("%s", model.rf_x_to_string());
    $display("\n");

    $finish;
  end

endmodule
