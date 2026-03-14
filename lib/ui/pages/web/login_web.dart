import 'package:flutter/material.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/organisms/form_login.dart';

// ─── DESKTOP: panel izquierdo + formulario derecho ───────
class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

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
