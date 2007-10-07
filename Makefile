GHDL=ghdl
GHDLFLAGS= --ieee=synopsys
GHDLRUNFLAGS=

TESTBENCHES=tb_or2_logic		\
	    tb_or2_logic_transport	\
	    tb_or2_behavioral		\
	    tb_or3			\
	    tb_and2			\
	    tb_nand2_logic		\
	    tb_nand2_logic_transport	\
	    tb_nand2_behavioral		\
	    tb_iv_behavioral		\
	    tb_iv_behavioral_delay	\
	    tb_exor_logic		\
	    tb_exor_behavioral		\
	    tb_ha			\
	    tb_fa_logic			\
	    tb_fa_behavioral		\
	    tb_rca_structural		\
	    tb_rca_behavioral		\
	    tb_mux21_1bit_behavioral	\
	    tb_mux21_1bit_structural	\
	    tb_mux21_behavioral		\
	    tb_mux21_structural		\
	    tb_mux41			\
	    tb_mux41_1bit		\
	    tb_comparator		\
	    tb_multiplier_behavioral	\
	    tb_multiplier_structural	\
	    tb_fd_en			\
	    tb_fd_behavioral_async	\
	    tb_fd_behavioral_sync	\
	    tb_ft_behavioral_async	\
	    tb_ft_behavioral_sync	\
	    tb_fjk_behavioral_async	\
	    tb_fjk_behavioral_sync	\
	    tb_reg_behavioral		\
	    tb_reg_structural		\
	    tb_ld			\
	    tb_ld_en			\
	    tb_latch			\
	    tb_string_recognizer	\
	    tb_counter			\
	    tb_accumulator_behavioral	\
	    tb_accumulator_structural

# Default target
all: run

# Testbenches dependencies
tb_or2_logic: tb_or2.o
tb_or2_logic_transport: tb_or2.o
tb_or2_behavioral: tb_or2.o
tb_or2.o: or2.o
tb_or3: or3.o tb_or3.o
tb_and2: and2.o tb_and2.o
tb_nand2_logic: tb_nand2.o
tb_nand2_logic_transport: tb_nand2.o
tb_nand2_behavioral: tb_nand2.o
tb_nand2.o: nand2.o
tb_iv_behavioral: tb_iv.o
tb_iv_behavioral_delay: tb_iv.o
tb_iv.o: iv.o
tb_exor_logic: tb_exor.o
tb_exor_behavioral: tb_exor.o
tb_exor.o: exor.o
tb_ha: ha.o tb_ha.o
tb_fa_logic: tb_fa.o
tb_fa_behavioral: tb_fa.o
tb_fa.o: fa.o
tb_mux21_1bit_behavioral: tb_mux21_1bit.o
tb_mux21_1bit_structural: tb_mux21_1bit.o
tb_mux21_1bit.o: mux21_1bit.o
tb_mux21_behavioral: tb_mux21.o
tb_mux21_structural: tb_mux21.o
tb_mux21.o: mux21.o
tb_mux41: mux41.o tb_mux41.o
tb_mux41_1bit: mux41_1bit.o tb_mux41_1bit.o
tb_comparator: comparator.o tb_comparator.o
tb_multiplier_behavioral: tb_multiplier.o
tb_multiplier_structural: tb_multiplier.o
tb_multiplier.o: multiplier.o
tb_rca_structural: tb_rca.o
tb_rca_behavioral: tb_rca.o
tb_rca.o: rca.o
tb_fd_en: fd_en.o tb_fd_en.o
tb_fd_behavioral_async: tb_fd.o
tb_fd_behavioral_sync: tb_fd.o
tb_fd.o: fd.o
tb_ft_behavioral_async: tb_ft.o
tb_ft_behavioral_sync: tb_ft.o
tb_ft.o: ft.o
tb_fjk_behavioral_async: tb_fjk.o
tb_fjk_behavioral_sync: tb_fjk.o
tb_fjk.o: fjk.o
tb_reg_behavioral: tb_reg.o
tb_reg_structural: tb_reg.o
tb_reg.o: reg.o
tb_ld: ld.o tb_ld.o
tb_ld_en: ld_en.o tb_ld_en.o
tb_latch: latch.o tb_latch.o
tb_string_recognizer: string_recognizer.o tb_string_recognizer.o
tb_counter: counter.o tb_counter.o
tb_accumulator_behavioral: tb_accumulator.o
tb_accumulator_structural: tb_accumulator.o
tb_accumulator.o: accumulator.o

comparator.o: fa.o
rca.o: fa.o
multiplier.o: and2.o ha.o fa.o
reg.o: fd_en.o
latch.o: ld_en.o
counter.o: ha.o fd_en.o
accumulator.o: mux21.o rca.o reg.o
mux21.o: mux21_1bit.o

# Elaboration target
$(TESTBENCHES):
	$(GHDL) -e $(GHDLFLAGS) $@

# Targets to analyze files
%.o: */%.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

# Syntax check target
check:
	$(GHDL) -s $(GHDLFLAGS) */*.vhdl

# Run target
run: $(TESTBENCHES) 
	for i in $^; do echo $$i; $(GHDL) -r $$i --vcd=$${i}.vcd $(GHDLRUNFLAGS); done

# Clean target
clean:
	-ghdl --remove
	-rm -f *.vcd
