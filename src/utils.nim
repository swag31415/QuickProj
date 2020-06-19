## Utils

import os
import strutils

# Shows the prompt and gets user input
proc ask*(prompt: string): string =
  echo prompt
  return readLine(stdin)

# Gets y/n input
proc yes*(question: string): bool =
  echo question, " (y/n)"
  while true:
    case readLine(stdin)
    of "y", "Y", "yes", "Yes": return true
    of "n", "N", "no", "No": return false
    else: echo "Please be clear: yes or no"

# Gets a choice between a list of options
proc choose*(prompt: string; options: openArray[string]): int =
  assert(options.len() > 1)
  echo prompt, "\n"
  for i, option in options:
    echo i + 1, ": ", option
  var choice = ask("\nEnter a number between 1 and $# (Default is 1):" % [$options.len()])
  while true:
    try: return parseInt(choice)
    except ValueError: choice = ask("Please enter a number between 1 and $#" % [$options.len()])

# Waits the provided number of milliseconds (defualt 500) and exits the program
proc wait_and_exit*(milsecs = 500) =
  sleep(milsecs)
  quit(QuitSuccess)

proc run*(command: string) =
  discard execShellCmd(command)