## Utils

import os

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

# Waits the provided number of milliseconds (defualt 500) and exits the program
proc wait_and_exit*(milsecs = 500) =
  sleep(milsecs)
  quit(QuitSuccess)

proc run*(command: string) =
  discard execShellCmd(command)

proc `+`*(a, b: string): string =
  var ab = ""
  ab.add(a)
  ab.add(b)
  return ab