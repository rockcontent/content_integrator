# Content Integrator library
[![CircleCI](https://circleci.com/gh/rockcontent/content_integrator/tree/master.svg?style=shield&circle-token=cd5e9c6303c0bbbf1fab3aed6a7225a938242c88)](https://circleci.com/gh/rockcontent/content_integrator/tree/master)


## Como rodar?

### Docker way

1. Faça o build da imagem:
```bash
docker-compose up
```
2. Pronto, para rodar algum comando basta você seguir o exemplo
```bash
docker-compose run --rm gem [COMANDO]
```

Alguns comandos:

**Console**
```bash
docker-compose run --rm gem irb
```

**RSpec**
```bash
# Run all specs
docker-compose run --rm gem rspec

# Run specific spec
docker-compose run --rm gem rspec spec/lib/content_integrator/connector_spec.rb
```
