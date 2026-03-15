import 'package:flutter/material.dart';
import 'package:fpv_fic/ui/router/app_router.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/atoms/version_app.dart';
import 'package:go_router/go_router.dart';

class LayoutWeb extends StatelessWidget {
  const LayoutWeb({
    super.key,
    required this.sidebarOpen,
    required this.content,
  });
  final bool sidebarOpen;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: sidebarOpen ? 260 : 0,
          child: sidebarOpen
              ? ClipRect(
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minWidth: 260,
                    maxWidth: 260,
                    child: const _SidebarContent(),
                  ),
                )
              : const SizedBox.shrink(),
        ),

        // Divisor solo cuando está abierto
        if (sidebarOpen) VerticalDivider(width: 1, color: Colors.grey.shade200),

        Expanded(child: content),
      ],
    );
  }
}

class _SidebarContent extends StatelessWidget {
  const _SidebarContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          FPVText(text: 'Menú de navegación').s18().bold(),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              context.goIfNotCurrent('/home');
            },
            child: FPVText(text: '• Fondos FPV/FIC').s14(),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              // context.goNamed('transactions');
              context.goIfNotCurrent('/home/transactions');
            },
            child: FPVText(text: '• Transacciones').s14(),
          ),
          const SizedBox(height: 8),
          FPVText(text: '• Configuración').s14(),
          Spacer(),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '© 2026 BTG Pactual',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              AboutWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
