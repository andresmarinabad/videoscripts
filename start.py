#!/usr/bin/env python3

import tkinter as tk
import subprocess
from tkinter import messagebox
from tkinter import ttk

def call_script_import():
    output = subprocess.run(["bash", "1.Import.sh"], check=True)
    messagebox.showinfo("Import Completed", "Videos transfered")

def call_script_process():
    output = subprocess.run(["bash", "2.Process.sh"], check=True)
    messagebox.showinfo("Process Completed", "Process videos finished.")

def call_script_concat():
    output = subprocess.run(["bash", "3.Concat.sh"], check=True)
    messagebox.showinfo("Concat Completed", "Videos appended to current year video")

def call_script_backup():
    output = subprocess.run(["bash", "4.Backup.sh"], check=True)
    messagebox.showinfo("Backup Completed", "Videos copied to the external drive.")


gui = tk.Tk()
gui.title('Video Scripts')
gui.geometry("250x240")
gui.resizable(False, False)
gui.eval('tk::PlaceWindow . center')

toolbar = tk.Frame(gui)
toolbar.pack(side="top", fill="y", padx=5, pady=5)


button_import = tk.Button(
    toolbar,
    text="1. Import", 
    width = 15,
    command=call_script_import
)

sep = ttk.Separator(toolbar)

button_process = tk.Button(
    toolbar,
    text="2. Process", 
    width = 15,
    command=call_script_process
)

button_concat = tk.Button(
    toolbar,
    text="3. Concat", 
    width = 15,
    command=call_script_concat
)

button_backup = tk.Button(
    toolbar,
    text="4. Backup", 
    width = 15,
    command=call_script_backup
)

button_exit = tk.Button(
    toolbar,
    text="Exit", 
    width = 15,
    command=gui.destroy
)

button_import.pack(pady=5)
button_process.pack(pady=5)
button_concat.pack(pady=5)
button_backup.pack(pady=5)
sep.pack(side="top", fill="x", padx=12, pady=5)
button_exit.pack(pady=5)


gui.mainloop()
