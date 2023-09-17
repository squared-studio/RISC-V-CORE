.PHONY: vivado
vivado: clean
	@xvlog -sv riscv_model.sv riscv_model_tb.sv
	@xelab riscv_model_tb -s top
	@xsim top -runall

.PHONY: clean
clean:
	@rm -rf *.log *.pb *.jou xsim.dir
