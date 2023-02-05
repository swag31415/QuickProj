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
    try: return parseInt(choice) - 1
    except ValueError: choice = ask("Please enter a number between 1 and $#" % [$options.len()])

proc write_template*(dest, tmp: string; nd: proc (s: string): string) =
  let txt = nd(readFile(getAppDir() / "templates" / tmp))
  writeFile(dest, txt)

proc make_format*(name, desc: string): proc (s: string): string =
  return proc (s: string): string = s.multiReplace({"{name}":name, "{desc}":desc})

proc add_and_commit*(commit_msg: string) =
  run("git add .")
  run(&"git commit -m \"{commit_msg}\"")

# Waits the provided number of milliseconds (defualt 500) and exits the program
proc wait_and_exit*(milsecs = 500) =
  sleep(milsecs)
  quit(QuitSuccess)