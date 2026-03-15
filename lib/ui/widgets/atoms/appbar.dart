import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/providers/ui_providers.dart';
import 'package:fpv_fic/ui/utils/dialogs.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class AppBarCustom extends ConsumerWidget implements PreferredSizeWidget {
  const AppBarCustom({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);
    final state = ref.watch(authControllerProvider);
    return AppBar(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.account_balance),
        tooltip: isMobile ? 'Menú' : 'Colapsar menú',
        onPressed: () {
          if (isMobile) {
            Scaffold.of(context).openDrawer();
          } else {
            ref.read(sidebarOpenProvider.notifier).state = !ref.read(
              sidebarOpenProvider,
            );
          }
        },
      ),
      title: Text(
        isMobile ? 'BTG' : 'BTG Pactual - Fondos FPV/FIC',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: isMobile
          ? null
          : [
              FPVText(
                text: MoneyUtils.formatMoney(state.usuario.saldo, 'COP'),
              ).color(Colors.white).s16().bold(),
              const SizedBox(width: 16),
              FPVText(
                text: state.usuario.nombre,
              ).color(Colors.white).s16().bold(),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Cerrar sesión',
                onPressed: () => _logout(context, ref),
              ),
              const SizedBox(width: 8),
            ],
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) {
    return DialogsInfo.confirmDialog(
      context,
      title: '¿Cerrar sesión?',
      message: '¿Estás seguro de que quieres cerrar sesión?',
      confirmText: 'Cerrar sesión',
      onConfirm: () {
        ref.read(authControllerProvider.notifier).logout();
      },
    );
  }
}
