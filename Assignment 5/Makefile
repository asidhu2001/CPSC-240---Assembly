
ASM := yasm
ASM_FLAGS := -gdwarf2 -f elf64

#
CC := gcc
CC_FLAGS:= -Wall -m64 -gdwarf-2 -c

#
CPP := g++
CPP_FLAGS := -Wall -std=c++17 -m64 -gdwarf-2 -c

#
LINKER := g++ -std=c++17
LINKER_FLAGS := -m64 -gdwarf-2 -no-pie

# executable must be named my-program
BIN_NAME := my-program
BIN := ./$(BIN_NAME)


default:	build


clean:
	-rm *.o
	-rm $(BIN)
.PHONY: clean


run:	build
	@echo "Running: $(BIN)"
	$(BIN)
.PHONY: run


debug:	build
	@echo
	@echo "Debugging: $(BIN)"
	gdb $(BIN) -x gdb-commands.txt
.PHONY: debug


build:	$(BIN)
	@echo "Done building"
.PHONY: build


$(BIN):	ohm.o resistance.o compute_resistance.o show_resistance.o get_resistance.o
	@echo
	@echo "Linking: $@"
	$(LINKER) $(LINKER_FLAGS) *.o *.so -o $@
	@echo "Done Linking"


ohm.o:	ohm.cpp
	@echo
	@echo "Building: $@"
	$(CPP) $(CPP_FLAGS) ohm.cpp -o $@

resistance.o:	resistance.asm
	@echo
	@echo "Building: $@"
	$(ASM) $(ASM_FLAGS) resistance.asm -o $@


show_resistance.o:	show_resistance.cpp
	@echo
	@echo "Building: $@"
	$(CPP) $(CPP_FLAGS) show_resistance.cpp -o $@


compute_resistance.o:	compute_resistance.cpp
	@echo
	@echo "Building: $@"
	$(CPP) $(CPP_FLAGS) compute_resistance.cpp -o $@


get_resistance.o:	get_resistance.c
	@echo
	@echo "Building: $@"
	$(CC) $(CC_FLAGS) get_resistance.c -o $@
	$(CC) $(CC_FLAGS) get_resistance.c -o $@
