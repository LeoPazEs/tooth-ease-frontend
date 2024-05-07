import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tooth_ease_frontend/app/modules/shared/app_themes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Tooth Ease Kids',
      theme: ThemeData(
          primarySwatch: Colors.blue, appBarTheme: AppTheme.appBarTheme),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
