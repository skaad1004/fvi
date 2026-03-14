import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/utils/responsive.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/organisms/form_login.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: isMobile ? const _MobileLayout() : const _DesktopLayout(),
    );
  }
}

// ─── DESKTOP: panel izquierdo + formulario derecho ───────
class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Panel izquierdo (logo / branding)
        Expanded(
          flex: 2,
          child: ColoredBox(
            color: AppColors.primary, // azul BTG
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.account_balance, size: 80, color: Colors.white),
                  const SizedBox(height: 16),
                  FPVText(text: 'BTG Pactual').color(Colors.white).s24().bold(),
                  const SizedBox(height: 8),
                  FPVText(
                    text: 'Bienvenido al sistema de gestión de clientes',
                  ).color(AppColors.textSecondary).s16(),
                ],
              ),
            ),
          ),
        ),
        // Formulario derecho
        Expanded(
          flex: 3,
          child: Center(child: SizedBox(width: 420, child: const LoginForm())),
        ),
      ],
    );
  }
}

// ─── MOBILE: logo arriba + formulario abajo ──────────────
class _MobileLayout extends StatelessWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo arriba
        ColoredBox(
          color: AppColors.primary,
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance, size: 50, color: Colors.white),
                const SizedBox(height: 8),
                FPVText(text: 'BTG Pactual').color(Colors.white).s20().bold(),
              ],
            ),
          ),
        ),
        // Formulario abajo con scroll
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: const LoginForm(),
          ),
        ),
      ],
    );
  }
}
