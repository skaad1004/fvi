import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/data/logger_interface.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/pages/mobil/home_mobil.dart';
import 'package:fpv_fic/ui/pages/web/home_web.dart';
import 'package:fpv_fic/ui/pages/web/layout_web.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/providers/ui_providers.dart';
import 'package:fpv_fic/ui/utils/dialogs.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/atoms/appbar.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/organisms/drawer_web.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final bool _sidebarOpen = true;

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
    final stateSidebar = ref.watch(sidebarOpenProvider);
    return Scaffold(
      appBar: AppBarCustom(),
      body: isMobile
          ? const HomeMobileLayout()
          : LayoutWeb(
              sidebarOpen: stateSidebar,
              content: const HomeWebLayout(),
            ),
      drawer: isMobile ? const DrawerWeb() : null,
    );
  }
}
