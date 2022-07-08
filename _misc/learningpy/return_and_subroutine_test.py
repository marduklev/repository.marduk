# -*- coding: utf-8 -*-
# import 'module_name'
 
def main():
    value_z = b()
    print('value of subrourine', value_z)


def b():
    b = 1
    print('b', b)
    
    if b == int(3):
        return b
    
    else:
        print('exception go to sub of b')
        b = return_b1()
        
        print('coming back from return_b1,', b)
        
        if b > int(666):
            print('coming back from return_b2,', b2)
            return b
        
        else:
            c = 'exception_b1' 
            return c
        
        
def return_b1():
    b = 666
    return b

def return_b2():
    b = 'some text'
    return b

main()