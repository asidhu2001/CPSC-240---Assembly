
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


$(BIN):	heron.o get_sides.o compute_area.o show_results.o triangle.o
	@echo
	@echo "Linking: $@"
	$(LINKER) $(LINKER_FLAGS) *.o *.so -o $@
	@echo "Done Linking"


heron.o:	heron.cpp
	@echo
	@echo "Building: $@"
	$(CPP) $(CPP_FLAGS) heron.cpp -o $@

triangle.o:	triangle.asm
	@echo
	@echo "Building: $@"
	$(ASM) $(ASM_FLAGS) triangle.asm -o $@


show_results.o:	show_results.cpp
	@echo
	@echo "Building: $@"
	$(CPP) $(CPP_FLAGS) show_results.cpp -o $@


compute_area.o:	compute_area.asm
	@echo
	@echo "Building: $@"
	$(ASM) $(ASM_FLAGS) compute_area.asm -o $@


get_sides.o:	get_sides.c
	@echo
	@echo "Building: $@"
	$(CC) $(CC_FLAGS) get_sides.c -o $@
