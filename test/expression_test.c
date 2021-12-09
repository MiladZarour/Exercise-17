#include "unity.h"
#include "expression.h"

void setUp() {}
void tearDown() {}

int main(void)
{
    UNITY_BEGIN();

    TEST_ASSERT_TRUE(expression_check('('));
    TEST_ASSERT_TRUE(expression_check(')'));
    TEST_ASSERT_TRUE(expression_check('\0'));
    TEST_ASSERT_TRUE(expression_check(' '));
    return UNITY_END();
}
