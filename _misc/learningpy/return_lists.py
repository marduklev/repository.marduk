def defineAList():
    local_list = ['1','2','3']
    print("For checking purposes: in defineAList, list is", local_list)
    return local_list 

def useTheList(passed_list):
    print("For checking purposes: in useTheList, list is", passed_list)

def main():
    # returned list is ignored
    returned_list = defineAList()   

    # passed_list inside useTheList is set to what is returned from defineAList
    useTheList(returned_list) 

# the same shortened
# def main():
    # # passed_list inside useTheList is set to what is returned from defineAList
    # useTheList(defineAList())


    # https://stackoverflow.com/questions/16043797/python-passing-variables-between-functions
    
main()