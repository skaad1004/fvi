import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/pages/mobil/home_mobil.dart';
import 'package:fpv_fic/ui/pages/web/home_web.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/utils/dialogs.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/organisms/drawer_web.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _sidebarOpen = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      ref.read(foundsControllerProvider.notifier).loadFounds();
      logger.log(
        'FoundsController: loadFounds() llamado desde HomePage initState',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.account_balance),
          tooltip: isMobile ? 'Menú' : 'Colapsar menú',
          onPressed: () {
            if (isMobile) {
              Scaffold.of(context).openDrawer();
            } else {
              setState(() => _sidebarOpen = !_sidebarOpen);
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
                  onPressed: () => _logout(context),
                ),
                const SizedBox(width: 8),
              ],
      ),
      body: isMobile
          ? const HomeMobileLayout()
          : HomeWebLayout(sidebarOpen: _sidebarOpen),
      drawer: isMobile ? const DrawerWeb() : null,
    );
  }

  Future<void> _logout(BuildContext context) {
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
