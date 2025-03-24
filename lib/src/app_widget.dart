import 'package:base_project/src/core/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: 'BMG Money',
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
