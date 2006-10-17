GHDL=ghdl
GHDLFLAGS= --ieee=synopsys

SOURCES=or2/tb_or2.vhdl or2/or2.vhdl \
        or3/tb_or3.vhdl or3/or3.vhdl \
        and2/tb_and2.vhdl and2/and2.vhdl


# Default target
all: run

# Elaboration target
tb_or2:  tb_or2.o or2.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_or3:  tb_or3.o or3.o
	$(GHDL) -e $(GHDLFLAGS) $@

tb_and2:  tb_and2.o and2.o
	$(GHDL) -e $(GHDLFLAGS) $@


# Run target
run: tb_or2 tb_or3 tb_and2
	$(GHDL) -r tb_or2 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_or3 $(GHDLRUNFLAGS)
	$(GHDL) -r tb_and2 $(GHDLRUNFLAGS)


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


# Check target
check:
	$(GHDL) -s $(GHDLFLAGS) $(SOURCES)

clean:
	-rm -rf *.o
	-rm -rf tb_or2 tb_or3 tb_and2
	-rm -rf work-obj93.cf
