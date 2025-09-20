-- https://github.com/redhat-developer/yaml-language-server
vim.lsp.config('yamlls', {
  capabilities = require 'j.plugins.lsp.capabilities',
  settings = {
    yaml = {
      schemas = {
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '.gitlab-ci.yml',
        ['http://json.schemastore.org/composer'] = 'composer.yaml',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
        ['https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json'] = '.graphqlrc*',
        ['https://json.schemastore.org/github-workflow.json'] = '.github/workflow/*.yml',
      },
    },
  },
})
