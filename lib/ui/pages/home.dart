import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/pages/mobil/home_mobil.dart';
import 'package:fpv_fic/ui/pages/web/home_web.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/organisms/drawer_web.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _sidebarOpen = true;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        // 👇 reemplaza el leading por defecto
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
                Text(
                  state.usuario.nombre,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Cerrar sesión',
                  onPressed: () => controller.logout(),
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
}
