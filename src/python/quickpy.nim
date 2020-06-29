## QuickNim

import strformat

import ../utils

proc run*(name, desc: string) =
  # Pick Python version
  var py_ver = ask("What version of python would you like? (leave blank for newest)")
  if py_ver.len() > 0: py_ver.insert("=") # need the equals sign at the beginning

  # Creating local conda environment with python and pip
  run(&"conda create --prefix ./env -y python{py_ver} pip")

  # avtivate the environment
  run("conda activate env")

  # Install any starter pip packages
  var packs = ask("What pip packages would you like to install?\n(seperate package names by space) (leave blank for none)")
  if packs.len() > 0: run("pip install " & packs)

  # Create the main python file
  writeFile(name & ".py", &"""
## {name}
## {desc}

""")