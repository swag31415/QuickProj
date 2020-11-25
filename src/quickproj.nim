## Main

import os
import strutils
import strformat

import utils

proc py_run*(name, desc: string) =
  run("git init")
  write_template("readme.md", "python/readme.md", name, desc)
  add_and_commit("Added readme")
  write_template(".gitignore", "python/.gitignore", name, desc)
  add_and_commit("Added gitignore")
  write_template(&"{name}.py", "python/tmp.py", name, desc)
  add_and_commit("Added blank python file")
  echo "This takes a second don't panic"
  run("python -m venv env")

proc nim_run(name, desc: string) =
  run("git init")
  write_template("readme.md", "nim/readme.md", name, desc)
  add_and_commit("Added readme")
  write_template(".gitignore", "nim/.gitignore", name, desc)
  add_and_commit("Added gitignore")
  createDir("src")
  write_template(&"src/{name}.nim", "nim/tmp.nim", name, desc)
  write_template(&"{name}.nimble", "nim/tmp.nimble", name, desc)
  add_and_commit("Set up empty nim repo")

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
case choose("What kind of project do you want to generate?", ["Nim", "Python"]):
  of 1: nim_run(name, desc)
  of 2: py_run(name, desc)
  else: discard

# Open VS Code
run("code -n .")
  
# All done!
wait_and_exit()