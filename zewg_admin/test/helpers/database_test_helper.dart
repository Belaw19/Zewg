import 'dart:io' show Platform;

import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zewg_admin/core/database/app_database.dart';

/// Prepares sqflite for widget/unit tests on desktop hosts.
///
/// Flutter's test binding reports [defaultTargetPlatform] as Android even when
/// tests run on Windows, so [initializeDatabaseFactory] skips FFI setup.
/// Tests run on the Dart VM (not web), so `dart:io` [Platform] is safe here.
Future<void> setUpTestDatabase() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  await AppDatabase.instance();
}
