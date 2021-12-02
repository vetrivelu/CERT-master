module.exports = {
  "root": true,
  "env": {
    es6: true,
    node: true,
  },
  "extends": [
    "eslint:recommended",
    "google",
  ],
  "rules": {
    "quotes": ["error", "double"],
    "max-len": ["error", {"code": 150}],
    "require-jsdoc": 0,
    "indent": "off",
  },
  "parserOptions": {
    "ecmaVersion": 2018,
  },
};
