# -*- coding: utf-8 -*-
# import 'module_name'
# https://wiki.python.org/moin/TkInter
# https://docs.python.org/3/library/tkinter.html
from tkinter import *

def main():
    # Example (Hello, World):
    import tkinter #in python 3.x: tkinter wird kleingeschrieben

    tk = tkinter.Tk()
    frame = tkinter.Frame(tk, relief="ridge", borderwidth=2)
    frame.pack(fill="both",expand=1)
    label = tkinter.Label(frame, text="Hallo Welt!")
    label.pack(expand=1)
    button = tkinter.Button(frame,text="OK",command=tk.destroy)
    button.pack(side="bottom")

    tk.mainloop()

# Select all the text in textbox
# def main():
    # textbox.tag_add(SEL, "1.0", END)
    # textbox.mark_set(INSERT, "1.0")
    # textbox.see(INSERT)
    # return 'break'

# # Open a window
# mainwin = Tk()

# # Create a text widget
# textbox = Text(mainwin, width=200, height=30)
# textbox.pack()

# # Add some text
# textbox.insert(INSERT, "Select some text then right click in this window")

# # Add the binding
# textbox.bind("<Control-Key-a>", main)
# textbox.bind("<Control-Key-A>", main) # just in case caps lock is on

# # Start the program
# mainwin.mainloop()

if __name__ == '__main__':
   main()
