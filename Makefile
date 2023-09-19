.PHONY: vivado
vivado: clean
	@xvlog -sv riscv_model.sv riscv_model_tb.sv
	@xelab riscv_model_tb -s top
	@xsim top -runall

.PHONY: clean
clean:
	@rm -rf *.log *.pb *.jou xsim.dir

.PHONY: update_hex_list
update_hex_list:
	@rm -rf prebuilt_hex
	@git submodule deinit ./sub/RISC-V-TESTS
	@git submodule update --init ./sub/RISC-V-TESTS
	@cd sub/RISC-V-TESTS; make all
	@mkdir prebuilt_hex
	@$(foreach file, $(shell find sub/RISC-V-TESTS/build/ -name "*.hex"), cp $(file) prebuilt_hex/;)
	@cp sub/RISC-V-TESTS/linker.x prebuilt_hex/
	@cd sub/RISC-V-TESTS; make clean
