import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/pages/mobil/login_mobil.dart';
import 'package:fpv_fic/ui/pages/web/login_web.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: isMobile ? const LoginMobileLayout() : const LoginDesktopLayout(),
    );
  }
}
