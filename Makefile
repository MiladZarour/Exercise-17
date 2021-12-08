# The Makefile to build test and main and run the test

CC := gcc
CFLAGS := -Wall

LIB_DIR := lib
SRC_DIR := src
TEST_DIR := test
BUILD_DIR := build

EXPRESSION_EXE := expression_test
STACK_EXE := stack_test
MAIN_EXE := main

INCLUDES := $(addprefix -I./,$(wildcard $(LIB_DIR)/*)) -I./src/expression

TEST_OBJS := $(notdir $(wildcard $(LIB_DIR)/*/*.c) $(wildcard $(TEST_DIR)/*.c))
TEST_OBJS := $(addprefix $(BUILD_DIR)/,$(TEST_OBJS:.c=.o))

PROG_OBJS := $(notdir $(wildcard $(LIB_DIR)/*/*.c) $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*/*.c))
PROG_OBJS := $(addprefix $(BUILD_DIR)/,$(PROG_OBJS:.c=.o))

all: .mkbuild $(MAIN_EXE) $(TEST_EXE)
	@echo "************ The Targets ************"
	@echo "** clean: to clean"
	@echo "** check_expression: to run the check_expression"
	@echo "** check_stack: to run the check_stack"
#	@echo "** run NUM=xxx: to run the program"
	@echo "*************************************"

$(MAIN_EXE): build/expression.o build/main.o build/stack.o    
	$(CC) $^ -o $(BUILD_DIR)/$@

$(STACK_EXE): bukd
	$(CC) $^ -o $(BUILD_DIR)/$@

$(EXPRESSION_EXE): $(TEST_OBJS)
	$(CC) $^ -o $(BUILD_DIR)/$@

LIB_SRC := $(LIB_DIR)/*
$(BUILD_DIR)/%.o: $(LIB_SRC)/%.c
	$(CC) -MMD $(CFLAGS) -o $@  -c $<

SRC_SRC := $(SRC_DIR)/*
$(BUILD_DIR)/%.o: $(SRC_SRC)/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

$(BUILD_DIR)/%.o : $(TEST_DIR)/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

$(BUILD_DIR)/%.o : $(SRC_DIR)/%.c
	$(CC) -MMD $(CFLAGS) -o $@ $(INCLUDES) -c $<

# run: .mkbuild $(MAIN_EXE)
# 	@echo ""
# 	@echo "**************************************"
# 	@echo "********* Run The Program ************"
# 	@echo "**************************************"
# 	@echo ""
# 	@./$(BUILD_DIR)/$(MAIN_EXE) $(NUM)

check_expression: .mkbuild $(EXPRESSION_EXE)
	@echo ""
	@echo "**************************************"
	@echo "********** Run The Test Expression**************"
	@echo "**************************************"
	@echo ""
	@./$(BUILD_DIR)/$(EXPRESSION_EXE)
	
check_stack: .mkbuild $(STACK_EXE)
	@echo ""
	@echo "**************************************"
	@echo "********** Run The Test Stack**************"
	@echo "**************************************"
	@echo ""
	@./$(BUILD_DIR)/$(STACK_EXE)
	

# Include automatically generated dependencies
-include $(OBJECTS:.o=.d)

.PHONY: clean .mkbuild check all

clean:
	@rm -rf $(BUILD_DIR)

.mkbuild:
	@mkdir -p $(BUILD_DIR)
