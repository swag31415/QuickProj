## Main

import os
import strutils

import utils
import nim/quicknim
import html/quickhtml

# Get name of project (no spaces) and project description
let name = ask("Enter Project Name").replace(' ', '_')
let desc = ask("Enter Project Desc")

# Gets path to project on desktop
let dir = expandTilde("~\\Desktop\\" & name)

# Creates project directory
if existsOrCreateDir(dir): 
  # Exits if project directory already exists
  echo name, " already exists"
  wait_and_exit()

# Sets the current directory to the project directory
setCurrentDir(dir)

# Choose language and generate accordingly
case choose("What kind of project do you want to generate?", ["Nim", "HTML"]):
  of 1: quicknim.run(name, desc)
  of 2: quickhtml.run(name, desc)
  else: discard

# Open VS Code
run("code -n .")
  
# All done!
wait_and_exit()