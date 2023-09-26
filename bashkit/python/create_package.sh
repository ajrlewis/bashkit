#!/usr/bin/env bash

package="$1"

package_class="$(tr '_' ' ' <<< "$package" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1' | tr -d ' ')"

mkdir $package/

touch $package/README.md
touch $package/LICENCE
touch $package/pyproject.toml
touch $package/requirements.txt
touch $package/.env
touch $package/.gitignore

mkdir $package/$package/
touch $package/$package/__init__.py
touch $package/$package/$package.py
mkdir $package/images/
mkdir $package/tests/
touch $package/tests/__init__.py
touch $package/tests/test_$package.py

cat << EOF > "$package/pyproject.toml"
[project]
name = "$package"
version = "0.1.0"
description = ""
readme = "README.md"
requires-python = ">=3.11"
authors = [
    { name = "ajrlewis", email = "hello@ajrlewis.com" }
]
dependencies = [
]
license = "MIT"

[tool.setuptools]
packages = ["$package"]
EOF

cat << EOF > "$package/tests/test_$package.py"
import unittest
from $package import $package


class Test$package_class(unittest.TestCase):
    def setUp(self):
        pass


if __name__ == "__main__":
    unittest.main()
EOF

cat << EOF > "$package/LICENCE"
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

cat << EOF > "$package/README.md"
# $package

![My Package Logo](images/logo.png)

## Installation

Install via pip:

\`\`\`bash
pip install git+https://github.com/ajrlewis/$package.git
\`\`\`

## License

This package is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
EOF

cat << EOF > "$package/.gitignore"
# Python
*.env
*.pyc
__pycache__/
venv
EOF
