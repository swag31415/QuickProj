## QuickHTML

import os
import strutils

import ../utils

const index = """<!doctype html>
<html>

<body>
</body>

<head>
  <title>$#</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

</html>
"""

const readme = """# $#
$#

## License
[MIT](https://choosealicense.com/licenses/mit/)
"""

proc run*(name, desc: string) =
  # Create the index.html
  writeFile("index.html", index % [name])

  # Generate folders
  createDir("resources")
  createDir("resources\\css")
  createDir("resources\\js")
  createDir("resources\\images")
  createDir("resources\\data")
  createDir("vendors")

  # Initialize a Git repository
  run("git init")

  # Add and commit changes
  run("git add .")
  run("git commit -m \"Empty HTML Repo\"")

  # Create Readme
  writeFile("readme.md", readme % [name, desc])

  # Add and commit readme
  run("git add .")
  run("git commit -m \"Added Readme\"")