import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/ui/main/theme.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/router/app_router.dart';

final sessionRestoredProvider = FutureProvider<bool>((ref) async {
  logger.log('🚀 sessionRestoredProvider iniciado');
  await ref.read(authControllerProvider.notifier).restoreSession();
  return true;
});

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
    final restored = ref.watch(sessionRestoredProvider);

    return restored.when(
      loading: () => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) {
        logger.logError('❌ Error restaurando sesión: $e', e);
        return const MaterialApp(
          home: Scaffold(body: Center(child: Text('Error al iniciar'))),
        );
      },
      data: (_) {
        final router = ref.watch(appRouterProvider);
        return MaterialApp.router(
          title: 'FPV FIC - BTG',
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          routerConfig: router,
        );
      },
    );
  }
}
