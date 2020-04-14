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

proc gen_readme*(name, prog_name, desc: string): string =
  return "# " + name + "\n" +
         "" + desc + "\n" +
         "\n" +
         "## Usage\n" +
         "Run with nimble\n" +
         "\n" +
         "```bash\n" +
         "nimble run " + prog_name + "\n" +
         "```\n" +
         "\n" +
         "## Program Requirements\n" +
         "[Nim](https://nim-lang.org/) version 1.0.6 or greater\n" +
         "[Nimble](https://github.com/nim-lang/nimble)\n" +
         "\n" +
         "## License\n" +
         "[MIT](https://choosealicense.com/licenses/mit/)"