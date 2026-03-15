import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/main/app_colors.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

// ─── FORMULARIO (compartido entre mobile y desktop) ──────
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    final controller = ref.read(authControllerProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          FPVText(text: 'Iniciar sesión').s14().bold(),
          const SizedBox(height: 8),
          FPVText(
            text: 'Ingresa tus credenciales para continuar',
          ).color(AppColors.textSecondary).s14(),
          const SizedBox(height: 32),

          // Email
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (v) =>
                v == null || !v.contains('@') ? 'Email inválido' : null,
          ),
          const SizedBox(height: 16),

          // Password
          TextFormField(
            controller: _passwordController,
            obscureText: !_showPassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                child: Icon(
                  _showPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onTap: () => setState(() => _showPassword = !_showPassword),
              ),
            ),
            validator: (v) =>
                v == null || v.isEmpty ? 'Ingresa tu contraseña' : null,
          ),
          const SizedBox(height: 8),

          // Error
          if (state.error.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FPVText(text: state.error).color(AppColors.error).s12(),
            ),
          const SizedBox(height: 16),

          // Botón
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        controller.login(
                          _emailController.text.trim(),
                          _passwordController.text.trim(),
                        );
                      }
                    },
              child: state.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : FPVText(text: 'Ingresar').s16().bold(),
            ),
          ),
        ],
      ),
    );
  }
}
