GHDL=ghdl
GHDLFLAGS= --ieee=synopsys

SOURCES=or2/tb_or2.vhdl or2/or2.vhdl \
        or3/tb_or3.vhdl or3/or3.vhdl \
        and2/tb_and2.vhdl and2/and2.vhdl \
        ha/tb_ha.vhdl ha/ha.vhdl \
        fa/tb_fa.vhdl fa/fa.vhdl \
        mux21/tb_mux21.vhdl mux21/mux21.vhdl \
        mux21/tb_mux21_1bit.vhdl mux21/mux21_1bit.vhdl \
        rca/tb_rca.vhdl rca/rca.vhdl


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

tb_rca:  tb_rca.o rca.o
	$(GHDL) -e $(GHDLFLAGS) $@


# Run target
run: tb_or2 tb_or3 tb_and2 tb_ha tb_fa tb_mux21 tb_mux21_1bit tb_rca
	$(GHDL) -r tb_or2 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_or3 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_and2 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_ha $(GHDLRUNFLAGS)
	$(GHDL) -r tb_fa $(GHDLRUNFLAGS)
	$(GHDL) -r tb_mux21 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_mux21_1bit $(GHDLRUNFLAGS)
	$(GHDL) -r tb_rca $(GHDLRUNFLAGS)


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


# Check target
check:
	$(GHDL) -s $(GHDLFLAGS) $(SOURCES)

clean:
	-rm -rf *.o
	-rm -rf tb_or2 tb_or3 tb_and2 tb_ha tb_fa tb_mux21 tb_mux21_1bit tb_rca
	-rm -rf work-obj93.cf
