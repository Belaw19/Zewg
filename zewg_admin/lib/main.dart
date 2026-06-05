import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/database/app_database.dart';
import 'core/database/database_initializer.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDatabaseFactory();
  await AppDatabase.instance();
  runApp(const ProviderScope(child: ZewgApp()));
}

class ZewgApp extends ConsumerWidget {
  const ZewgApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Zewg Admin',
      theme: ZewgTheme.theme,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
