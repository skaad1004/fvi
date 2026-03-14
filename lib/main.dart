import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/ui/pages/login.dart';
import 'package:fpv_fic/ui/router/app_router.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      final host = Uri.base.host;
      final port = Uri.base.port;
      logger.log('App corriendo en: http://$host:$port');
      runApp(ProviderScope(child: const AppFPV()));
    },
    (error, stackTrace) {
      logger.logError('Uncaught error: $error', error, stackTrace);
    },
  );
}

class AppFPV extends ConsumerWidget {
  const AppFPV({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'FPV FIC - BTG',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF003087)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
