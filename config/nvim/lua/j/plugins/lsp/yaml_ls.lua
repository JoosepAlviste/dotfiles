-- https://github.com/redhat-developer/yaml-language-server
require('lspconfig').yamlls.setup{
  on_attach = require('j.plugins.lsp').on_attach,
  settings = {
    yaml = {
      schemas = {
        ['http://json.schemastore.org/gitlab-ci'] = '.gitlab-ci.yml',
        ['http://json.schemastore.org/composer'] = 'composer.yaml',
        ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
        ['https://raw.githubusercontent.com/kamilkisiela/graphql-config/v3.0.3/config-schema.json'] = '.graphqlrc*',
      },
    },
  },
}
