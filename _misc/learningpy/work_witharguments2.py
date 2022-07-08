import sys

def get_type(syntax_type):
    
    print(syntax_type)
    print ('type is','\n',type(syntax_type),'\n\n')
    
    print ('sys args', sys.argv[0])
    return 'END'
    
def main(argument1=None,argument2=None):
    
    
    print ('arg1',argument1,'arg2', argument1,'\n\n')
    
    # RunScript([ADDON_ID], [KEYWORD which function should be called]=[KEYVALUE which paramter should be aplied to FUNCTION CALL], ?ADDITIONAL PARAM_1 KEYWORD??=ADDITIONAL PARAM1 KEYVALUE, [ADDITIONAL PARAM_2 KEYWORD?]=ADDITIONAL PARAM2 KEYVALUE?)
    
    runscript_syntax = get_type('"RunScript(script.swan.helper, action=checkforfile, fileorpath=something/hh/hhh/, property=extraslocation)"')
    runscript_syntax = get_type(["RunScript(script.swan.helper, action=checkforfile, fileorpath=something/hh/hhh/, property=extraslocation)"])
    runscript_syntax = get_type({"RunScript(script.swan.helper, action=checkforfile, fileorpath=something/hh/hhh/, property=extraslocation)"})
    
    print (runscript_syntax)
    
    
    # return new arguments
    var1 = 'argument1=test1'
    var2 = 'test2'
    return var1,var2
    
if __name__ == '__main__':
    # call with args 
    # main(first_arg_,second_arg_)
    # call without args main()
    # main()
    
    returned_values = main()
    # call with va arguments
    main(returned_values)
    