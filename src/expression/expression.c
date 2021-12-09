#include "stack.h"
#include "expression.h"

bool expression_check(const char *exp)
{
    bool status = false;

    if(exp)
    {
        status = true;
        stack_clear();

        while(*exp)
        {
            if(*exp==')')
            {
                status = stack_pop() == '(';
            }
            else
            if(*exp=='(')
            {
                status = false;
                (void)stack_push('(');
            }

            exp++;
        }

        if(status)
            status = stack_pop() == 0;
    }
    
    return status;
}
