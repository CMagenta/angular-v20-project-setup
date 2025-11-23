# Angular V20 Project Setup

Install and configure Tailwind, Husky, Pre-commit hooks along with the folder structure.

## Usage

Create your Angular project with `ng new`, specifying CSS as the styling. Then move into the newly created folder.

Run the script with either one of the options:
1. Copy raw contents of the [main.sh](/main.sh) script. Paste it into your command line, then run it.
2. Download the script and run it with `source ./main.sh`.

## Result

### Folder Structure

```
├── public
└── src
    ├── app
    │   ├── components
    │   ├── pages
    │   ├── pipes
    │   ├── services
    │   └── shared
    └── styles
```

### Pre-commit hooks

- [Staged lint](https://www.npmjs.com/package/lint-staged)
    - [Prettier](https://www.npmjs.com/package/prettier)
    - [Angular ESLint](https://www.npmjs.com/package/angular-eslint)
- [Conventional commits](https://www.npmjs.com/package/@commitlint/config-conventional)
