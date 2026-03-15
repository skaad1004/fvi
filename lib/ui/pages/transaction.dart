import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/pages/mobil/home_mobil.dart';
import 'package:fpv_fic/ui/pages/web/layout_web.dart';
import 'package:fpv_fic/ui/pages/web/transaction_web.dart';
import 'package:fpv_fic/ui/providers/ui_providers.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/atoms/appbar.dart';
import 'package:fpv_fic/ui/widgets/organisms/drawer_web.dart';

class TransactionPage extends ConsumerStatefulWidget {
  const TransactionPage({super.key});

  @override
  ConsumerState<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends ConsumerState<TransactionPage> {
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
              content: const TransactionWebLayout(),
            ),
      drawer: isMobile ? const DrawerWeb() : null,
    );
  }
}
