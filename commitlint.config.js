/**
 * Commitlint Configuration for test-commitlint
 *
 * This matches the configuration from h-hooks repository
 * to test local validation behavior.
 */

module.exports = {
  extends: ['@commitlint/config-conventional'],

  rules: {
    'header-max-length': [2, 'always', 100],
    'subject-max-length': [2, 'always', 72],
    'type-case': [2, 'always', 'lower-case'],
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'perf',
        'test',
        'build',
        'ci',
        'chore',
        'revert'
      ]
    ],
    'subject-empty': [2, 'never'],
    'subject-full-stop': [2, 'never', '.'],
    'subject-case': [2, 'always', 'lower-case'],
    'type-empty': [2, 'never'],
    'body-leading-blank': [2, 'always'],
    'footer-leading-blank': [2, 'always'],
    'scope-empty': [0],
    'scope-case': [2, 'always', 'lower-case']
  },

  parserPreset: {
    parserOpts: {
      headerPattern: /^(?:HYPERFLEET-\d+\s+-\s+)?(\w+)(?:\(([^)]*)\))?:\s+(.+)$/,
      headerCorrespondence: ['type', 'scope', 'subject']
    }
  },

  ignores: [
    (commit) => commit.startsWith('Merge branch'),
    (commit) => commit.startsWith('Merge pull request'),
    (commit) => commit.startsWith('Revert "')
  ],

  helpUrl: 'https://github.com/openshift-hyperfleet/architecture/blob/main/hyperfleet/standards/commit-standard.md'
};
