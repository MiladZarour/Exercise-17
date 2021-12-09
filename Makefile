# compiler
CC := gcc

# compiler flags
CFLAGS := -Wall -Wextra -Wpedantic -Werror $(CFLG)

# folders
LIB_DIR := lib
SRC_DIR := src
TEST_DIR := test
BUILD_DIR := build

# programs
MAIN_EXE := main.exe
TEST_STACK_EXE := test_stack.exe
TEST_EXPR_EXE := test_expr.exe

# parameter for the main program
EXPR := 2*(3+4)

# include flag for compiler
INCLUDES := $(wildcard $(LIB_DIR)/*) $(wildcard $(SRC_DIR)/*)
INCLUDES := $(addprefix -I./, $(INCLUDES))

# objects for main program
# OBJECTS_MAIN := $(notdir $(wildcard $(LIB_DIR)/*/*.c) $(wildcard $(SRC_DIR)/*/*.c) $(wildcard $(SRC_DIR)/*.c))
# OBJECTS_MAIN := $(addprefix $(BUILD_DIR)/,$(OBJECTS_MAIN:.c=.o))
OBJECTS_MAIN := build/stack.o build/expression.o build/main.o

# objects for test expressio
OBJECTS_EXPR := $(notdir $(wildcard $(LIB_DIR)/*/*.c $(wildcard $(SRC_DIR)/*/*.c)) $(TEST_DIR)/expression_test.c)
OBJECTS_EXPR := $(addprefix $(BUILD_DIR)/,$(OBJECTS_EXPR:.c=.o))

# objects for test stack
OBJECTS_STACK := $(notdir $(wildcard $(LIB_DIR)/*/*.c) $(TEST_DIR)/stack_test.c)
OBJECTS_STACK := $(addprefix $(BUILD_DIR)/,$(OBJECTS_STACK:.c=.o))

all:
	@clear
	@echo "***************** The Targets **********************"
	@echo "** make clean : to clean                          **"
	@echo "** make run EXPR='2*(3+4)' : to run the program   **"
	@echo "** make test_expr : to test the expression module **"
	@echo "** make test_stack : to test the stack module     **"
	@echo "****************************************************"

run: .mkbuild $(MAIN_EXE)
	@echo ""
	@echo "**************************************"
	@echo "** Run main programm     *************"
	@echo "**************************************"
	@echo ""
	@./$(BUILD_DIR)/$(MAIN_EXE) '$(EXPR)'

test_expr: .mkbuild $(TEST_EXPR_EXE)
	@echo ""
	@echo "**************************************"
	@echo "** Run Test: Expression  *************"
	@echo "**************************************"
	@echo ""
	@./$(BUILD_DIR)/$(TEST_EXPR_EXE)

test_stack: .mkbuild $(TEST_STACK_EXE)
	@echo ""
	@echo "**************************************"
	@echo "** Run Test: Stack       *************"
	@echo "**************************************"
	@echo ""
	@./$(BUILD_DIR)/$(TEST_STACK_EXE)

# program
$(MAIN_EXE): $(OBJECTS_MAIN)
	$(CC) $^ -o $(BUILD_DIR)/$@

# test satck
$(TEST_STACK_EXE): $(OBJECTS_STACK)
	$(CC) $^ -o $(BUILD_DIR)/$@

# test expr
$(TEST_EXPR_EXE): $(OBJECTS_EXPR)
	$(CC) $^ -o $(BUILD_DIR)/$@

# objects in lib/*
$(BUILD_DIR)/%.o: $(LIB_DIR)/*/%.c
	$(CC) -MMD $(CFLAGS) -o $@ -c $<

# objects in src/*
$(BUILD_DIR)/%.o: $(SRC_DIR)/*/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

# objects in src
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

# objects in test
$(BUILD_DIR)/%.o : $(TEST_DIR)/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

# Include automatically generated dependencies
-include $(OBJECTS:.o=.d)

.PHONY: clean mkbuild all run test_expr test_stack

clean:
	@rm -rf $(BUILD_DIR)

.mkbuild:
	@mkdir -p $(BUILD_DIR)
