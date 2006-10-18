GHDL=ghdl
GHDLFLAGS= --ieee=synopsys
GHDLRUNFLAGS= --stop-time=15ns

SOURCES=or2/tb_or2.vhdl or2/or2.vhdl \
        or3/tb_or3.vhdl or3/or3.vhdl \
        and2/tb_and2.vhdl and2/and2.vhdl \
        ha/tb_ha.vhdl ha/ha.vhdl \
        fa/tb_fa.vhdl fa/fa.vhdl \
        mux21/tb_mux21.vhdl mux21/mux21.vhdl \
        mux21/tb_mux21_1bit.vhdl mux21/mux21_1bit.vhdl \
        rca/tb_rca.vhdl rca/rca.vhdl \
        fd/tb_fd.vhdl fd/fd.vhdl \
        ft/tb_ft.vhdl ft/ft.vhdl \
        reg/tb_reg.vhdl reg/reg.vhdl


# Default target
all: run

# Elaboration target
tb_or2:  tb_or2.o or2.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_or3:  tb_or3.o or3.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_and2:  tb_and2.o and2.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_ha:  tb_ha.o ha.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_fa:  tb_fa.o fa.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_mux21:  tb_mux21.o mux21.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_mux21_1bit:  tb_mux21_1bit.o mux21_1bit.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_rca:  tb_rca.o rca.o fa.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_fd:  tb_fd.o fd.o fa.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_ft:  tb_ft.o ft.o fa.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_reg: reg.o tb_reg.o
	$(GHDL) -e $(GHDLFLAGS) $@


# Run target
run: tb_or2 tb_or3 tb_and2 tb_ha tb_fa tb_mux21 tb_mux21_1bit tb_rca tb_fd tb_ft tb_reg
	$(GHDL) -r tb_or2 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_or3 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_and2 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_ha $(GHDLRUNFLAGS)
	$(GHDL) -r tb_fa $(GHDLRUNFLAGS)
	$(GHDL) -r tb_mux21 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_mux21_1bit $(GHDLRUNFLAGS)
	$(GHDL) -r tb_rca $(GHDLRUNFLAGS)
	$(GHDL) -r tb_fd $(GHDLRUNFLAGS)
	$(GHDL) -r tb_ft $(GHDLRUNFLAGS)
	$(GHDL) -r tb_reg $(GHDLRUNFLAGS)


# Targets to analyze files
tb_or2.o: or2/tb_or2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
or2.o: or2/or2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_or3.o: or3/tb_or3.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
or3.o: or3/or3.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_and2.o: and2/tb_and2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
and2.o: and2/and2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_ha.o: ha/tb_ha.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
ha.o: ha/ha.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_fa.o: fa/tb_fa.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
fa.o: fa/fa.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_mux21.o: mux21/tb_mux21.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
mux21.o: mux21/mux21.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_mux21_1bit.o: mux21/tb_mux21_1bit.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
mux21_1bit.o: mux21/mux21_1bit.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_rca.o: rca/tb_rca.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
rca.o: rca/rca.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_fd.o: fd/tb_fd.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
fd.o: fd/fd.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_ft.o: ft/tb_ft.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
ft.o: ft/ft.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<

tb_reg.o: reg/tb_reg.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
reg.o: reg/reg.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<


# Check target
check:
	$(GHDL) -s $(GHDLFLAGS) $(SOURCES)

clean:
	-rm -rf *.o
	-rm -rf tb_or2 tb_or3 tb_and2 tb_ha tb_fa tb_mux21 tb_mux21_1bit tb_rca tb_fd tb_ft tb_reg
	-rm -rf work-obj93.cf
