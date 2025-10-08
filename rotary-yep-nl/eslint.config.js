// https://docs.expo.dev/guides/using-eslint/
const { defineConfig, globalIgnores } = require('eslint/config');
const expoConfig = require('eslint-config-expo/flat');
const eslintPluginPrettierRecommended = require('eslint-plugin-prettier/recommended');

module.exports = defineConfig([
  {
    ignores: ['node_modules/**', 'android/**', 'ios/**', 'build/**', 'dist/**'],
  },
  globalIgnores(['dist/*']),
  ...expoConfig,
  eslintPluginPrettierRecommended,
  {
    files: ['**/*.{js,jsx,ts,tsx}'],
    rules: {
      'prettier/prettier': [
        'error',
        {
          singleQuote: true,
        },
      ],
      // Performance optimizations
      'react-hooks/exhaustive-deps': 'error',
      'react/jsx-no-bind': ['warn', {
        ignoreRefs: true,
        allowArrowFunctions: true,
        allowFunctions: true,
        allowBind: true
      }],
      'react/jsx-no-useless-fragment': 'error',
      '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    },
  },
]);
