# -*- coding: utf-8 -*-
import urllib.parse
import webbrowser
import clipboard


def main():
    
    user_input = input("encode or decode:")
    
    
    #encode
    if user_input == 'encode':
        source = input("Copy Paste decoded URL here:")
        # example source =  {"rules":{"and":[{"field":"artist","operator":"is","value":["Smashing Pumpkins"]}]},"type":"Albums"}
        #                   {"rules":{"and":[{"field":"type","operator":"is","value":["soundtrack"]}]},"type":"albums"}
        #                   {"rules":{"and":[{"field":"title","operator":"contains","value":["bad"]},{"field":"rating","operator":"isnot","value":["7"]}]},"type":"tvshows"}
        result = urllib.parse.quote(source.encode())
    
    # decode, default
    elif user_input == 'decode':
        source = input("Copy Paste encoded URL here:")
        # videodb://movies/titles/?xsp=%7B%22rules%22%3A%7B%22and%22%3A%5B%7B%22field%22%3A%22actor%22%2C%22operator%22%3A%22contains%22%2C%22value%22%3A%5B%22INFOLABELINTEGER%22%5D%7D%2C%7B%22field%22%3A%22title%22%2C%22operator%22%3A%22isnot%22%2C%22value%22%3A%5B%22INFOLABEL%22%5D%7D%5D%7D%2C%22type%22%3A%22movies%22%7D
        # example source = '%7B%22rules%22%3A%7B%22and%22%3A%5B%7B%22field%22%3A%22actor%22%2C%22operator%22%3A%22is%22%2C%22value%22%3A%5B%22christian%20bale%22%5D%7D%5D%7D%2C%22type%22%3A%22movies%22%7D'
        result = urllib.parse.unquote(source)
        
    print(' source: \n',source,'\n\n result: \n', result)    
    
    lines = ['source:', source, 'result :', result]
    with open('urlencode_decode_kodi_xsp_.txt', 'w') as f:
        for line in lines:
            f.write(line)
            f.write('\n')
    
    
    webbrowser.open("urlencode_decode_kodi_xsp_.txt")
    
    clipboard.copy(result)   # Copy to the clipboard.
    clipboard.paste()   # Copy from the clipboard.
    
    user_input = input("run again:")
    if user_input == 'y':
        main()
    else:
        pass
    
if __name__ == '__main__':
    main()