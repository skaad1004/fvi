import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/atoms/version_app.dart';

class HomeWebLayout extends ConsumerWidget {
  const HomeWebLayout({super.key, required this.sidebarOpen});
  final bool sidebarOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

        // Contenido principal siempre ocupa el resto
        const Expanded(child: Center(child: Text('Lista de fondos aquí'))),
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
          FPVText(text: '• Dashboard').s14(),
          const SizedBox(height: 8),
          FPVText(text: '• Fondos FPV/FIC').s14(),
          const SizedBox(height: 8),
          FPVText(text: '• Reportes').s14(),
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
