#!/bin/bash

set -e

# Folder structure
mkdir -p src/styles
mkdir -p src/app/pages
mkdir -p src/app/pipes
mkdir -p src/app/components
mkdir -p src/app/services
mkdir -p src/app/shared

# Tailwind
npm install tailwindcss @tailwindcss/postcss postcss --force

rm src/styles.css

cat <<EOT > .postcssrc.json
{
  "plugins": {
    "@tailwindcss/postcss": {}
  }
}
EOT

cat <<EOT > src/styles/base.css
@layer base
{ }
EOT

cat <<EOT > src/styles/components.css
@layer components
{ }
EOT

cat <<EOT > src/styles/themes.css
@layer theme
{
  @theme
  { }
}
EOT

cat <<EOT > src/styles/utilities.css
@layer utilities
{ }
EOT

cat <<EOT > src/styles/index.css
@import 'tailwindcss';

@import './base.css';
@import './components.css';
@import './themes.css';
@import './utilities.css';
EOT

tmpfile=$(mktemp)
jq '(.projects[]?.architect.build.options.styles, .projects[]?.architect.test.options.styles) |= ["src/styles/index.css"]' angular.json > "$tmpfile"
mv "$tmpfile" angular.json

# Lint
ng add @angular-eslint/schematics <<EOF
y
EOF

npm install -D prettier

cat <<EOT > .prettierrc
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "always",
  "endOfLine": "lf"
}
EOT

# Husky
npm install -D husky @commitlint/cli @commitlint/config-conventional lint-staged
npx husky init

cat <<EOT > commitlint.config.js
module.exports = { extends: ['@commitlint/config-conventional'] };
EOT

cat <<EOT > .husky/pre-commit
npx lint-staged
EOT

cat <<EOT > .husky/commit-msg
npx --no -- commitlint --edit
EOT

cat <<EOT > package.json
$(jq '. + {
  "lint-staged": {
    "*.{ts,js,css,scss,html}": [
      "prettier --write",
      "eslint --fix"
    ]
  }
}' package.json)
EOT

# Commit
git add .
git commit --amend -m "chore: set up project"
