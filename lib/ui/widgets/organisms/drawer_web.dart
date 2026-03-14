import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class DrawerWeb extends ConsumerWidget {
  const DrawerWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          // Header con info del usuario
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.primary.withAlpha(200)),
            accountName: FPVText(text: state.usuario.nombre),
            accountEmail: FPVText(text: state.usuario.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                state.usuario.nombre[0].toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF003087),
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),

          // Saldo
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Saldo disponible'),
            subtitle: FPVText(
              text: 'COP \$${state.usuario.saldo.toStringAsFixed(0)}',
            ).color(AppColors.primary).bold(),
          ),
          const Divider(),

          // Navegación
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Fondos'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Historial'),
            onTap: () => Navigator.pop(context),
          ),
          const Spacer(),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              Navigator.pop(context);
              // _confirmLogout(context, controller);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
