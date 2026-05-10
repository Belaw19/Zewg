import 'package:flutter/material.dart';

import 'package:zewg/core/routing/app_router.dart';
import 'package:zewg/core/theme/app_theme.dart';

void main() {
  runApp(const ZewgApp());
}

class ZewgApp extends StatelessWidget {
  const ZewgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
    );
  }
}
