import 'package:flutter/material.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/organisms/form_login.dart';

// ─── MOBILE: logo arriba + formulario abajo ──────────────
class LoginMobileLayout extends StatelessWidget {
  const LoginMobileLayout({super.key});

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
