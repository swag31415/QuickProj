## QuickNim

import os
import strutils

import ../utils
import files

proc run*(name, desc: string) =
  # Make the .nimble file
  let nimble_data = gen_nimble("0.1", "swag31415", desc, name.toLower(), "cpp")
  writeFile(name.toLower() & ".nimble", nimble_data)
  
  # Make the src dir
  createDir("src")
  
  # Make the "main" nim file
  let nim_data = gen_nim(name)
  writeFile("src\\" & name.toLower() & ".nim", nim_data)
  
  # Create git repo
  run("git init")
  
  # Add and commit changes
  run("git add .")
  run("git commit -m \"Empty Nim Repo\"")
  
  # Add a readme
  writeFile("readme.md", gen_readme(name, name.toLower(), desc))
  
  # Commit the readme
  run("git add .")
  run("git commit -m \"Added a readme\"")
  
  # Add a .gitignore
  writeFile(".gitignore", gitignore)
  
  # Commit the .gitignore
  run("git add .")
  run("git commit -m \"Added gitignore\"")