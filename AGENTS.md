# Orientações para o Codex — Gaspar Saúde Território

Objetivo: construir aplicativo Flutter Android para ACS e backend FastAPI, começando por demonstração integralmente fictícia.

- Nunca incluir CPFs reais, dados de cidadãos, senhas, tokens, URLs internas ou credenciais do PEC no código, testes ou Git.
- Não conectar ao PEC de produção nem escrever diretamente no seu banco de dados.
- Não presumir que a API LEDI de envio fornece leitura ou sincronização bidirecional.
- Priorizar testes automatizados, acessibilidade, gestão de erros e documentação.
- Comunicação HTTP e configurações permissivas só no emulador e ambiente local; exigir HTTPS e dados criptografados em produção.
- A integração real deverá ser autorizada e homologada, com logs sem dados sensíveis, controle de acesso por ACS e tratamento de duplicidades.
- A pasta Flutter contém código-base; gere o restante da plataforma Android com `flutter create --platforms=android --project-name gaspar_saude_territorio .`.
