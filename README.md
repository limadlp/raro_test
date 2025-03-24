<img src="demo.gif" alt="Demonstração" style="width: 25%;" />

# ✅ Teste Técnico - Desenvolvedor Flutter (Resolvido por Dangeles Lima)

## Objetivo

O objetivo deste teste técnico é avaliar suas habilidades no desenvolvimento de interfaces em Flutter, seguindo boas práticas de código, organização do projeto e implementação de testes. Você deverá dar sequência à base do projeto fornecido, reproduzindo a tela conforme o protótipo no [Figma](https://www.figma.com/design/QWC5IksyTx2k65ZzkPz3r1/Processo-seletivo---Dev-flutter?node-id=1-4313&t=WNNCW8T4MMI6Z9M8-1).

**_Alguns packages já foram incluídos no projeto, fique à vontade para substituí-los ou propor melhorias na arquitetura atual._**

---

## ✅ Requisitos

| Tarefa                                                           | Status |
| ---------------------------------------------------------------- | ------ |
| Implementar uma tela com lista de transactions e schedules       | ✅     |
| Implementar um BottomSheet para ocultar/exibir dados de schedule | ✅     |
| Seguir as diretrizes do protótipo no Figma                       | ✅     |
| Escrever testes unitários e testes de widget                     | ✅     |
| Utilizar o BLoC como gerenciamento de estado                     | ✅     |
| Exibir shimmer em estado de loading                              | ✅     |
| Scroll único sem scrolls aninhados                               | ✅     |

---

## ✅ Boas Práticas

| Prática                                                             | Status |
| ------------------------------------------------------------------- | ------ |
| Responsividade                                                      | ✅     |
| Componentização                                                     | ✅     |
| Acessibilidade _(parcial com tooltip e semantic em alguns widgets)_ | ✅     |
| Manutenção com código limpo                                         | ✅     |
| Tratamento de erros nos blocos                                      | ✅     |
| Seguir a arquitetura do projeto                                     | ✅     |

---

## ✅ Testes

| Tipo                             | Status |
| -------------------------------- | ------ |
| Testes unitários                 | ✅     |
| Testes de widget                 | ✅     |
| Testes de integração _(parcial)_ | ✅     |

> Para rodar os testes:

```bash
flutter test
flutter test integration_test
```

---

## ✅ Pacotes utilizados

Além dos que já estavam presentes, os seguintes pacotes foram adicionados:

```yaml
flutter_modular: ^6.3.4 # Modularização do app
flutter_bloc: ^9.1.0 # Gerenciamento de estado com BLoC
shimmer: ^3.0.0 # Efeito shimmer durante o loading
google_fonts: ^6.2.1 # Fonte Lato utilizada em toda a aplicação
mocktail: ^1.0.4 # Mocking para testes
bloc_test: ^10.0.0 # Testes específicos para blocos
```

---

## ✅ Estilo e Temas

- Adicionado um arquivo de **theme** separado para centralizar o tema da aplicação.
- Criados **tokens de cores e tipografia** utilizando a fonte **Lato** via `GoogleFonts`.

---

## ✅ Estrutura do Projeto (atualizada)

```
lib/
└── src/
  ├── core/
  │   ├── base/
  │   │   ├── constants/
  │   │   ├── errors/
  │   │   ├── interfaces/
  │   │   └── base.dart
  │   ├── utils/
  │   └── core.dart
  ├── modules/
  │   ├── payments/
  │   │   ├── data/
  │   │   │   ├── datasource/
  │   │   │   ├── model/
  │   │   │   └── repository/
  │   │   ├── domain/
  │   │   │   ├── entity/
  │   │   │   ├── repository/
  │   │   │   └── usecase/
  │   │   ├── infra/
  │   │   │   ├── datasource/
  │   │   │   └── mock/
  │   │   ├── presentation/ 🔵 *(adicionado)*
  │   │   │   ├── bloc/ 🔵
  │   │   │   │   ├── payments/
  │   │   │   │   ├── tab/
  │   │   │   │   └── transactions_filter/
  │   │   │   ├── page/ 🔵
  │   │   │   │   ├── payments_page.dart
  │   │   │   │   └── widgets/
  │   │   │   └── payments_module.dart
  ├── app_module.dart
  └── app_widget.dart
main.dart
```

---

## ✅ Considerações Finais

O projeto foi desenvolvido respeitando a arquitetura fornecida e seguindo as melhores práticas de desenvolvimento Flutter. Toda a lógica de filtragem, exibição e estados está controlada com BLoC, com separação clara de responsabilidades e uso de temas globais.
