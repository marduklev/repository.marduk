# -*- coding: utf-8 -*-

# https://www.w3schools.com/python/python_functions.asp
# definition
def definition(arg1,arg2='arg 2 is not called'):
  print(arg1 + " arg passed" + arg2)

# call, do
definition("type", "argument 2")
definition("match")
definition("field")
definition("field_value")
definition("operator")


# 

# From a function's perspective:
# A parameter is the variable listed inside the parentheses in the function definition.
# An argument is the value that is sent to the function when it is called.

# Default Parameter Value
# The following example shows how to use a default parameter value.
# If we call the function without argument, it uses the default value
def use_params(country = "Norway"):
  print("I am from " + country)

use_params("Sweden")
use_params("India")
use_params()
use_params("Brazil") 


# Passing a List as an Argument
# You can send any data types of argument to a function (string, number, list, dictionary etc.), and it will be treated as the same data type inside the function.
# E.g. if you send a List as an argument, it will still be a List when it reaches the function:

def definition(argument):
  for something in argument:
    print('loop_start')
    print(something)
    print('loop_end')

#main
list_dict = ["apple", "banana", "cherry"]
print(list_dict)
definition(list_dict)


# string append methods
seperator = ','

name = "Millie"
lastname = "Bobby"
name += seperator
name += lastname
# print result
print("The     concatenated string is: " + str(name),'end')
print("The non concatenated string is: ", str(name),'end')



rule1 = '{"field":"actor","operator":"contains","value":["$VAR[videoinfo_cast_container_id]"]}'
rule2 = '{"field":"genre","operator":"is","value":["Action"]}'
rules = rule1 + seperator + rule2

print("The     concatenated string is: "+ str(rules) + 'end')
print("The non concatenated string is: ", str(rules), 'end')
    