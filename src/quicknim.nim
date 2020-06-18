## Main 

import os
import strutils

import utils
import files

# Get name of project (no spaces) and project description
var name = ask("Enter Nim Project Name").replace(' ', '_')
let desc = ask("Enter Project Desc")

# Make a no-caps version of name
let lname = name.toLower()

# Sets path to project on desktop
let dir = expandTilde("~\\Desktop\\" & name)

# Creates project directory
if existsOrCreateDir(dir): 
  # Exits if project directory already exists
  echo name, " already exists"
  wait_and_exit()

# Sets the current directory to the project directory
setCurrentDir(dir)

# Make the .nimble file
let nimble_data = gen_nimble("0.1", "swag31415", desc, lname, "cpp")
writeFile(lname & ".nimble", nimble_data)

# Make the src dir
createDir("src")

# Make the "main" nim file
let nim_data = gen_nim(name)
writeFile("src\\" & lname & ".nim", nim_data)

# Create git repo
run("git init")

# Add and commit changes
run("git add .")
run("git commit -m \"Empty Nim Repo\"")

# Add a readme
writeFile("readme.md", gen_readme(name, lname, desc))

# Commit the readme
run("git add .")
run("git commit -m \"Added a readme\"")

# Add a .gitignore
writeFile(".gitignore", gitignore)

# Commit the .gitignore
run("git add .")
run("git commit -m \"Added gitignore\"")

# Open VS Code
run("code -n .")

# All done!
wait_and_exit()