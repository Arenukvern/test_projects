module.exports = {
  root: true,
  env: {
    node: true,
    browser: true,
    es6: true,
  },
  extends: [
    'plugin:vue/essential',
    'eslint:recommended',
    '@vue/typescript/recommended',
    '@vue/prettier',
    '@vue/prettier/@typescript-eslint',
  ],
  rules: {
    'no-console': process.env.NODE_ENV === 'production' ? 'off' : 'off',
    'no-debugger': process.env.NODE_ENV === 'production' ? 'off' : 'off',
    'no-case-declarations': 'off',
    'no-inner-declarations': 'off',
    'no-fallthrough': 'off',
    'no-prototype-builtins': 'off',
    'no-unused-vars': 'off',
    indent: [2, 2, { SwitchCase: 1 }],
    quotes: ['error', 'single'],
    // we want to force semicolons
    semi: ['error', 'never'],
  },
  parserOptions: {
    ecmaVersion: 2020,
    parser: '@typescript-eslint/parser',
  },
  overrides: [
    {
      files: [
        '**/__tests__/*.{j,t}s?(x)',
        '**/tests/unit/**/*.spec.{j,t}s?(x)',
      ],
      env: {
        jest: true,
      },
    },
  ],
}
