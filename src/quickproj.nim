## Main

import os
import strutils

import utils
import nim/quicknim

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

quicknim.run(name, desc)

# Open VS Code
run("code -n .")
  
# All done!
wait_and_exit()