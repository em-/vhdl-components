GHDL=ghdl
GHDLFLAGS= --ieee=synopsys

SOURCES=or2/tb_or2.vhdl or2/or2.vhdl


# Default target
all: run

# Elaboration target
tb_or2:  tb_or2.o or2.o
	$(GHDL) -e $(GHDLFLAGS) $@


# Run target
run: tb_or2
	$(GHDL) -r tb_or2 $(GHDLRUNFLAGS)


# Targets to analyze files
tb_or2.o: or2/tb_or2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<
or2.o: or2/or2.vhdl
	$(GHDL) -a $(GHDLFLAGS) $<


# Check target
check:
	$(GHDL) -s $(GHDLFLAGS) $(SOURCES)

clean:
	-rm -rf *.o
	-rm -rf tb_or2
	-rm -rf work-obj93.cf
