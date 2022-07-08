# int integer ganze Zahlen
# float float Fließkommazahlen
# str string Zeichenketten (Einzelne Buchstaben, Wörter, Sätze oder Texte)
# bool boolean Boolesche Variablen / Wahrheitswerte


def what_is_isinstance():

    numbers = [1, 2, 3, 4, 2, 5]

    # check if numbers is instance of list
    result = isinstance(numbers, list)

    print(result)

    # Output: True
    
    # The syntax of isinstance() is:
        # isinstance(object, classinfo)
        # isinstance() Parameters
        # isinstance() takes two parameters:
            # object - object to be checked
            # classinfo - class, type, or tuple of classes and types
        # isinstance Return Value
        # isinstance() returns:
            # True if the object is an instance or subclass of a class or any element of the tuple
            # False otherwise
        # If classinfo is not a type or tuple of types, a TypeError exception is raised.
    
    
    numbers = [1, 2, 3]

    result = isinstance(numbers, list)

    print(numbers,'instance of list?', result)

    result = isinstance(numbers, dict)
    print(numbers,'instance of dict?', result)

    result = isinstance(numbers, (dict, list))
    print(numbers,'instance of dict or list?', result)

    number = 5

    result = isinstance(number, list)

    print(number,'instance of list?', result)

    result = isinstance(number, int)
    print(number,'instance of int?', result)
    
    

def main():
    
    
    
    example_stuff()
    
    # https://userpage.fu-berlin.de/~ram/pub/pub_jf47ht81Ht/eval_python#:~:text=Die%20Funktion%20%C2%BBeval%C2%AB%20wertet%20einen,2%20%2B%203%C2%AB%E2%80%9C).
    # eval_input()
    eval_fixedstrings()
    
    list = ["VW", "Golf", 2011, 5000]
    print ("Datentyp Variable list: ",type(list))

    print(list)
    
    list = a_list(list)
    
    
    print('returned modified list', list)
    
    sub_dictionary = a_dict()
    print('returned sub_dictionary', sub_dictionary)


def example_stuff():
    
    text = "hallo"
    upercasetext = text.upper()
    print("text ", text, "upercasetext ", upercasetext)
    
    a = 3
    print ("Datentyp Variable a: ",type(a))
    b = 3.563467
    print ("Datentyp Variable b: ",type(b))
    c = True
    print ("Datentyp Variable c: ",type(c))
    d = "Hallo"
    print ("Datentyp Variable d: ",type(d))
    e = (2, 4)
    print ("Datentyp Variable e: ",type(e))

    return

def eval_input():
    
    x = eval(input("Geben Sie die erste Zahl ein: "))
    y = eval(input("Geben Sie die zweite Zahl ein: "))
    print ("Summe x+y: ", x+y)
    
    inhalt = eval(input("gebe etwas zum typisieren ein: "))
    print ("Inhalt is: ", type(inhalt))
    
    
    return
    
def eval_fixedstrings():
    
    x = eval(str(66))
    y = eval(str(22))
    print ("Summe x+y: ", x+y)
    
    inhalt = True
    print ("Inhalt is: ", type(inhalt))
    
    return


# ff
def a_list(fahrzeug1):
    # echo specific items from list
    print (fahrzeug1)
    print (fahrzeug1[0])
    print (fahrzeug1[2])
    print (fahrzeug1[-1])
    print (fahrzeug1[-2])
    print (fahrzeug1[0:2])
    print (fahrzeug1[1:3])
    print (fahrzeug1[:3])
    print (fahrzeug1[2:])
    print (fahrzeug1[:])
    
    # add another list
    fahrzeug2 = ["Renault", "Clio", 2013, 6000]
    # echo  list and another list
    print (fahrzeug1 + fahrzeug2)
    # echo  
    print (fahrzeug1 * 3)
    # echo  
    print (fahrzeug1 + fahrzeug2 * 2)
    # echo  new list by listitems of list
    neueListe = fahrzeug1[1:3]
    print (neueListe)
    
    # add item to list of fahrzeug1
    fahrzeug1 = fahrzeug1 + ["blau"]
    print (fahrzeug1)
    
    
    fahrzeug1 = ["VW", "Golf", 2011, 5000]
    fahrzeug2 = ["Renault", "Clio", 2013, 6000]
    fahrzeug3 = ["Porsche", "Panamera", 2014, 25000]
    
    listeFahrzeuge = [fahrzeug1, fahrzeug2, fahrzeug3]
    print (listeFahrzeuge)
    print (listeFahrzeuge[0][0])
    print (listeFahrzeuge[1][3])
    print (listeFahrzeuge[0][1:3])
    print (listeFahrzeuge[1])
    
    a_list = listeFahrzeuge
    print (a_list)
    return a_list
    
   # method to go with when call script within kodi ?
def a_dict():
    another_string = 'variable is used'
    # dict methods '\n\n',
    # a
    dict_2 = {"string": "fixedstring", "variable": another_string, "integer": 2012, "float": 50.99}
    print (dict_2)
    # b
    dict_2 = dict ([("string", "fixedstring"), ("variable", another_string), ("integer", 2012), ("float", 50.99)])
    print ('\n\n',dict_2)
    # c 
    dict_2 = dict (string="fixedstring", variable=another_string, integer=2012, float=50.99)
    print ('\n\n',dict_2,'\n\n')
    
    
    dict_1 = {"action": "checkexist", "container": "50", "property": "local_trailer"}
    print (dict_1)
    dict_2 = {"string": "string_value", "integer": 123, "float": 123.987, "bool": True, "type": type(dict_1)}
    print (dict_2)
    
    print ('value of key named action ',dict_1["action"])
    
    # add
    dict_2["added_dictitem"] = "added_dictitem_value"
    print (dict_2)
    
    # del
    del dict_2["added_dictitem"]
    print(dict_2)
    
    # dictionary_sub = list(dict_1.keys())
    # print (dictionary_sub)
    
    print ('list dict 1 keys ',list(dict_1.keys()))
    print ('list sorted dict 1 keys ',sorted(dict_1.keys()))
    print ('list dict 1 values ',list(dict_1.values()))
    print ('list sorted dict 1 values ',sorted(dict_1.values()))
    
    # return dictionary_sub
    
def a_tuple():
    #  ...
    a_tuple = "VW", "Golf", 2011, 50.00
    print ("Datentyp a_tuple ist: ",type(a_tuple))

    return a_tuple
    
    
main()
# a_dict()
# what_is_isinstance()