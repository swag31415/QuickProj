## Utils

import os
import strutils
import terminal
import strformat

proc run*(command: string) =
  discard execShellCmd(command)

# Shows the prompt and gets user input
proc ask*(prompt: string): string =
  echo prompt
  return readLine(stdin)

# Gets y/n input
proc yes*(question: string): bool =
  echo question, " (y/n)"
  while true:
    case getch():
    of 'y', 'Y': return true
    of 'n', 'N': return false
    else: discard

# Gets a choice between a list of options
proc choose*(prompt: string; options: openArray[string]): int =
  assert(options.len() > 1)
  echo prompt, "\n"
  for i, option in options:
    echo i + 1, ": ", option
  var choice = ask("\nEnter a number between 1 and $#:" % [$options.len()])
  while true:
    try: return parseInt(choice)
    except ValueError: choice = ask("Please enter a number between 1 and $#" % [$options.len()])

proc write_template*(dest, tmp, proj_name, proj_desc: string) =
  let txt = readFile(getAppDir() / "templates" / tmp).multiReplace({"{name}":proj_name, "{desc}":proj_desc})
  writeFile(dest, txt)

proc add_and_commit*(commit_msg: string) =
  run("git add .")
  run(&"git commit -m \"{commit_msg}\"")

# Waits the provided number of milliseconds (defualt 500) and exits the program
proc wait_and_exit*(milsecs = 500) =
  sleep(milsecs)
  quit(QuitSuccess)