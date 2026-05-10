import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';

void main() {
  runApp(const ZewgApp());
}

class ZewgApp extends StatelessWidget {
  const ZewgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zewg Admin',
      theme: ZewgTheme.theme,
      routerConfig: AppRouter.router,
    );
  }
}
