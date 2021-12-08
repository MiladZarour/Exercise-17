#include "stack.h"
#include "unity.h"

void setUp() {}
void tearDown() {}


#define STACK_SIZE 100

void test_stack()
{
    // start with an empty stack
    stack_clear();

    // make it full
    for(int i=0; i<STACK_SIZE; i++)
    {
        // it shall be possible to push while not full
        TEST_ASSERT_TRUE(stack_push(i));
    }

    // it shall NOT be possible to push if is full
    TEST_ASSERT_FALSE(stack_push(1));

    // make it empty
    for(int i=STACK_SIZE-1; i>=0; i--)
    {
        // it shall be possible to pop while not empty
        // and the popped value shall be in FILO order
        TEST_ASSERT_EQUAL_CHAR(i, stack_pop());
    }
}

int main(void)
{
    UNITY_BEGIN();
    RUN_TEST(test_stack);
    return UNITY_END();
}
