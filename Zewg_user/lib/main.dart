import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:zewg/core/database/app_database.dart';
import 'package:zewg/core/database/database_initializer.dart';
import 'package:zewg/core/routing/app_router.dart';
import 'package:zewg/core/theme/app_theme.dart';

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
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
    );
  }
}
