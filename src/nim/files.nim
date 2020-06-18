## files

import strutils

const gitignore* = """## .gitignore

# Windows executables
*.exe
*.dll

# Editors and IDEs project files and folders
.vscode
"""

const nimble = """## Package

version       = "$#"
author        = "$#"
description   = "$#"
license       = "MIT"
srcDir        = "src"
bin           = @["$#"]

backend       = "$#"

# Dependencies

requires "nim >= 1.0.6"
"""

const nim = "## $#\n\n"

const readme = """# $#
$#

## Usage
Run with nimble

```bash
nimble run $#
```

## Program Requirements
[Nim](https://nim-lang.org/) version 1.0.6 or greater
[Nimble](https://github.com/nim-lang/nimble)

## License
[MIT](https://choosealicense.com/licenses/mit/)
"""

proc gen_nimble*(version, author, desc, name, backend: string): string =
  return nimble % [version, author, desc, name, backend]

proc gen_nim*(name: string): string =
  return nim % [name]

proc gen_readme*(name, prog_name, desc: string): string =
  return readme % [name, desc, prog_name]