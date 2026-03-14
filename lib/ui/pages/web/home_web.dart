import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              ? const _SidebarContent()
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Menú de navegación',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('• Dashboard'),
          SizedBox(height: 8),
          Text('• Fondos FPV/FIC'),
          SizedBox(height: 8),
          Text('• Reportes'),
          SizedBox(height: 8),
          Text('• Configuración'),
          Spacer(),
          Row(
            children: [
              Text(
                '© 2026 BTG Pactual',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
