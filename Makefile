GHDL=ghdl
GHDLFLAGS= --ieee=synopsys
GHDLRUNFLAGS= --stop-time=20ns

SOURCES=or2/or2.vhdl or2/tb_or2.vhdl \
        or3/or3.vhdl or3/tb_or3.vhdl \
        and2/and2.vhdl and2/tb_and2.vhdl \
        ha/ha.vhdl ha/tb_ha.vhdl \
        fa/fa.vhdl fa/tb_fa.vhdl \
        mux21/mux21.vhdl mux21/tb_mux21.vhdl \
        mux21/mux21_1bit.vhdl mux21/tb_mux21_1bit.vhdl \
        rca/rca.vhdl rca/tb_rca.vhdl \
        comparator/comparator.vhdl comparator/tb_comparator.vhdl \
        fd/fd.vhdl fd/tb_fd.vhdl \
        ft/ft.vhdl ft/tb_ft.vhdl \
        reg/reg.vhdl reg/tb_reg.vhdl \
        counter/counter.vhdl counter/tb_counter.vhdl \
        accumulator/accumulator.vhdl accumulator/tb_accumulator.vhdl


# Default target
all: run

# Elaboration target
tb_or2: or2.o tb_or2.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_or3: or3.o tb_or3.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_and2: and2.o tb_and2.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_ha: ha.o tb_ha.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_fa: fa.o tb_fa.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_mux21: mux21.o tb_mux21.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_mux21_1bit: mux21_1bit.o tb_mux21_1bit.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_comparator: comparator.o fa.o tb_comparator.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_rca: rca.o fa.o tb_rca.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_fd: fd.o tb_fd.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_ft: ft.o tb_ft.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_reg: fd.o reg.o tb_reg.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_counter: ha.o fd.o counter.o tb_counter.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_accumulator: fa.o fd.o mux21.o rca.o reg.o accumulator.o tb_accumulator.o
	$(GHDL) -e $(GHDLFLAGS) $@


# Run target
run: tb_or2 tb_or3 tb_and2 tb_ha tb_fa tb_mux21 tb_mux21_1bit tb_comparator tb_rca tb_fd tb_ft tb_reg tb_counter tb_accumulator
	for i in $^; do echo $$i; $(GHDL) -r $$i $(GHDLRUNFLAGS); done


# Targets to analyze files
%.o: */%.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

# Check target
check:
	$(GHDL) -s $(GHDLFLAGS) $(SOURCES)

clean:
	-ghdl --remove
