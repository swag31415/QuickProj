## files

import utils

const gitignore* = "## .gitignore\n" +
                   "\n" +
                   "# Windows executables\n" +
                   "*.exe\n" +
                   "*.dll\n" +
                   "\n" +
                   "# Editors and IDEs project files and folders\n" +
                   ".vscode"

proc gen_nimble*(version, author, desc, name, backend: string): string =
  return "## Package\n" +
         "\n" +
         "version       = \"" + version + "\"\n" +
         "author        = \"" + author + "\"\n" +
         "description   = \"" + desc + "\"\n" +
         "license       = \"MIT\"\n" +
         "srcDir        = \"src\"\n" +
         "bin           = @[\"" + name + "\"]\n" +
         "\n" +
         "backend       = \"" + backend + "\"\n" +
         "\n" +
         "# Dependencies\n" +
         "\n" +
         "requires \"nim >= 1.0.6\"\n"

proc gen_nim*(name: string): string =
  return "## " + name +
         "\n" +
         "\n"