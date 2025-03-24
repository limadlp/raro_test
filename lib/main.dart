import 'package:base_project/src/app_module.dart';
import 'package:base_project/src/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// TODO: Retestar testes
// TODO: Adicionar acessibilidade Semantics nos cards etc.
// TODO: Screenshots do app funcionando em diversas telas com tamanhos diferentes
void main() {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
