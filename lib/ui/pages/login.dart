import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          if (state.isLoading) CircularProgressIndicator(),
          if (state.error.isNotEmpty)
            Text(state.error, style: TextStyle(color: Colors.red)),
          if (state.isAuthenticated)
            Text('Bienvenido, ${state.usuario.nombre}'),
          if (!state.isAuthenticated) Text('Por favor, ingresa tu información'),
          ElevatedButton(
            onPressed: () => controller.login("user@example.com", "password"),
            child: Text('Ingresar'),
          ),
        ],
      ),
    );
  }
}
