# header 

# import 'module_name'

def main():
    echo = print # test
    float_value = 3.6
    
    var_formatting_usage_py_3 = f'Using string f interpolation Usage if py => v3.6: "type": {float_value}'
    
    if float_value:
        print('test print:')
        float_value = 1.0
        var_usage_py_global = print('Using string percent interpolation usage: "type": %s' % float_value)
        
        # del float_value
    
    if float_value != 3.6:
        echo('another sting is NOT deleted')
        if float_value == 1.0:
            echo(1.0)
        else:
            echo(var_formatting_usage_py_3)
    else:
        echo('another sting is deleted')
    # exit()

if __name__ == '__main__':
    main()