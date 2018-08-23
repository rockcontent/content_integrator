# Content Integrator library
[![CircleCI](https://circleci.com/gh/rockcontent/content_integrator/tree/master.svg?style=shield&circle-token=cd5e9c6303c0bbbf1fab3aed6a7225a938242c88)](https://circleci.com/gh/rockcontent/content_integrator/tree/master)


## Como rodar?

### Docker way

1. Faça o build da imagem:
```bash
docker build -t rockcontent/content_integrator .
```
2. Pronto, para rodar algum comando basta você seguir o exemplo
```bash
docker run -it rockcontent/content_integrator [COMANDO]
```

Você pode rodar em um comando oneliner também:
```bash
docker build -t rockcontent/content_integrator . && docker run -it rockcontent/content_integrator
```

Alguns comandos:

**Console**
```bash
docker run -it rockcontent/content_integrator

## ou

docker run -it rockcontent/content_integrator irb
```

**RSpec**
```bash
# Run all specs
docker run -it rockcontent/content_integrator rspec

# Run specific spec
docker run -it rockcontent/content_integrator rspec spec/lib/content_integrator/connector_spec.rb
```
