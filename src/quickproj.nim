## Main

import os
import strutils
import strformat

import utils

const conf_file = "quickproj.conf"
const rarrow = " -> "

# proc py_run*(name, desc: string) =
#   run("git init")
#   write_template("readme.md", "python/readme.md", name, desc)
#   add_and_commit("Added readme")
#   write_template(".gitignore", "python/.gitignore", name, desc)
#   add_and_commit("Added gitignore")
#   write_template(&"{name}.py", "python/tmp.py", name, desc)
#   add_and_commit("Added blank python file")
#   echo "This takes a second don't panic"
#   run("python -m venv env")

# proc nim_run(name, desc: string) =
#   run("git init")
#   write_template("readme.md", "nim/readme.md", name, desc)
#   add_and_commit("Added readme")
#   write_template(".gitignore", "nim/.gitignore", name, desc)
#   add_and_commit("Added gitignore")
#   createDir("src")
#   write_template(&"src/{name}.nim", "nim/tmp.nim", name, desc)
#   write_template(&"{name}.nimble", "nim/tmp.nimble", name, desc)
#   add_and_commit("Set up empty nim repo")

# proc ejs_run(name, desc: string) =
#   run("git init")
#   write_template("readme.md", "expressjs/readme.md", name, desc)
#   add_and_commit("Added readme")
#   write_template(".gitignore", "expressjs/.gitignore", name, desc)
#   add_and_commit("Added gitignore")
#   write_template("app.js", "expressjs/app.js", name, desc)
#   createDir("views")
#   write_template("views/index.ejs", "expressjs/index.ejs", name, desc)
#   run("npm init --yes")
#   run("npm install express")
#   run("npm install ejs")
#   add_and_commit("Set up basic ExpressJS repo")

# proc html_run(name, desc: string) =
#   run("git init")
#   write_template("readme.md", "html/readme.md", name, desc)
#   add_and_commit("Added readme")
#   write_template(".gitignore", "html/.gitignore", name, desc)
#   add_and_commit("Added gitignore")
#   write_template("index.html", "html/index.html", name, desc)
#   createDir("js")
#   write_template("js/main.js", "html/js/main.js", name, desc)
#   createDir("css")
#   write_template("css/main.css", "html/css/main.css", name, desc)
#   add_and_commit("Set up basic HTML repo")

# proc swag_site_run(name, desc: string) =
#   run("git init")
#   write_template("readme.md", "html/readme-swag-site.md", name, desc)
#   add_and_commit("Added readme")
#   write_template(".gitignore", "html/.gitignore", name, desc)
#   add_and_commit("Added gitignore")
#   write_template("index.html", "html/index-swag-site.html", name, desc)
#   createDir("js")
#   write_template("js/main.js", "html/js/main.js", name, desc)
#   createDir("css")
#   write_template("css/main.css", "html/css/main.css", name, desc)
#   write_template("desc.json", "html/desc-swag-site.json", name, desc)
#   add_and_commit("Set up a swag-site repo")

# Get name of project (no spaces) and project description
let name = ask("Enter Project Name").replace(' ', '_')
let desc = ask("Enter Project Desc")
let nd = make_format(name, desc)

# Get templates
let template_dir = absolutePath("templates")
var templates: seq[string]
for d in walkDirs(template_dir / "*"):
  if fileExists(d / conf_file):
    templates.add(lastPathPart(d))

# Gets path to project on desktop
let dir = expandTilde("~\\Desktop\\" & name)

# Creates project directory
if existsOrCreateDir(dir): 
  # Exits if project directory already exists
  echo name, " already exists"
  wait_and_exit()

# Sets the current directory to the project directory
setCurrentDir(dir)

# Choose language and get the script
let k = choose("What kind of project do you want to generate?", templates)
let script = nd(readFile(template_dir / templates[k] / conf_file))

# Run the Script
for line in script.splitLines():
  let
    ins = line.splitWhiteSpace(1)
    cmd = ins[0]
    params = ins[1]
  assert ins.len == 2
  case cmd:
    of "run": run(params)
    of "write":
      if rarrow in params:
        let tems = params.split(rarrow, 1)
        write_template(tems[1], templates[k] / tems[0], nd)
      else:
        write_template(params, templates[k] / params, nd)
    of "commit": add_and_commit(params)
    of "echo": echo params
    of "md": createDir(params)
    else:
      echo &"unsupported instruction \"{ins[0]}\", continuing..."
      discard

# Open VS Code
run("code -n .")

# All done!
wait_and_exit()