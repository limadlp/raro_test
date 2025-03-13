# Teste Técnico - Desenvolvedor Flutter

## Objetivo
O objetivo deste teste técnico é avaliar suas habilidades no desenvolvimento de interfaces em Flutter, seguindo boas práticas de código, organização do projeto e implementação de testes. Você deverá dar sequência à base do projeto fornecido, reproduzindo a tela conforme o protótipo no [Figma](https://www.figma.com/design/QWC5IksyTx2k65ZzkPz3r1/Processo-seletivo---Dev-flutter?node-id=1-4313&t=WNNCW8T4MMI6Z9M8-1).

***Alguns packages já foram incluídos no projeto, fique a vontade para substitui-los, propor melhorias na arquitetura atual.***

## Requisitos
- Implementar uma tela onde o usuário poderá visualizar uma **lista de informações** sobre **transactions** e **schedules**.
- Implementar um **BottomSheet** que permitirá ocultar ou exibir dados sobre os itens do **schedule**.
- Seguir as diretrizes do **protótipo no Figma**.
- Escrever **testes unitários** e **testes de widget**.
- Utilizar o BLoC como gerenciamento de estado.
- Comportamentos esperados para a tela:
  - Em estado de loading os widgets devem exibir um shimmer no lugar dos dados;
  - A tela deve ter um scroll único de forma geral, não sendo permitido a existência de scrolls aninhados;

## Boas Práticas
Para garantir um código bem estruturado e manutenível, siga as seguintes diretrizes:

- **Responsividade:** Certifique-se de que a tela funcione corretamente em diferentes tamanhos de dispositivos.
- **Componentização:** Separe os widgets reutilizáveis para facilitar a organização do código.
- **Acessibilidade:** Considere a acessibilidade ao desenvolver os componentes visuais.
- **Manutenção:** Nomeie variáveis, métodos e classes de forma clara e significativa.
- **Tratamento de Erros:** Implemente tratamento de erros para melhorar a experiência do usuário.
- **Seguir a Arquitetura do Projeto:** Mantenha o código organizado e dentro da estrutura já existente no projeto base.

## Testes
- É **obrigatório** implementar **testes unitários** para as regras de negócio, validações e/ou camadas que julgar necessário.
- **Opcional:** Implementação de **testes de integração** para garantir a funcionalidade correta da interface e interação do usuário.

## Entrega
1. Faça um fork ou clone do repositório base fornecido.
2. Desenvolva as funcionalidades seguindo os requisitos.
3. Submeta o código em um repositório público ou envie um link para o repositório privado.

Boa sorte! 🚀

## Informações adicionais
- Versão do Flutter utilizado para criação do projeto base: 3.29.0;
- As telas do Figma estão em protótipo, então é possível navegar para entender melhor o comportamento das telas;
- Estrutura base do Projeto
  ```
  lib/
  └── src/
      ├── core/
      │   ├── base/
      │   │   ├── constants/           # Constantes globais do projeto
      │   │   ├── errors/              # Definições de erros e exceções
      │   │   ├── interfaces/          # Interfaces para abstração
      │   │   ├── base.dart
      │   ├── utils/                   # Funções auxiliares e extensões
      │   ├── core.dart                 # Arquivo principal do core
      ├── modules/
      │   ├── payments/                 # Módulo de pagamentos
      │   │   ├── data/                 # Camada de dados
      │   │   │   ├── datasource/
      │   │   │   ├── model/
      │   │   │   ├── repository/
      │   │   ├── domain/               # Camada de domínio
      │   │   │   ├── entity/
      │   │   │   ├── repository/
      │   │   │   ├── usecase/
      │   │   ├── infra/                # Infraestrutura
      │   │   │   ├── datasource/
      │   │   │   ├── mock/
      │   │   ├── presentation/         # Camada de apresentação
      │   │   │   ├── bloc/
      │   │   │   ├── page/
      ├── app_widget.dart               # Widget principal do app
      ├── main.dart                      # Ponto de entrada do app
  test/                                  # Testes unitários
  ```