import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/ui/controllers/founds_controller.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';
import 'package:fpv_fic/ui/widgets/atoms/version_app.dart';

class HomeWebLayout extends ConsumerWidget {
  const HomeWebLayout({super.key, required this.sidebarOpen});
  final bool sidebarOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(foundsControllerProvider);
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
        Expanded(child: _buildContent(state, ref)),
      ],
    );
  }

  Widget _buildContent(FoundsState state, WidgetRef ref) {
    // Loading
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Error
    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            Text(state.error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              onPressed: () =>
                  ref.read(foundsControllerProvider.notifier).loadFounds(),
            ),
          ],
        ),
      );
    }

    // Vacío
    if (state.fondos.isEmpty) {
      return const Center(child: Text('No hay fondos disponibles'));
    }

    // Lista ✅
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: state.fondos.length,
      itemBuilder: (_, index) => FondoCard(fondo: state.fondos[index]),
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

class FondoCard extends StatelessWidget {
  const FondoCard({super.key, required this.fondo});

  final FondoModel fondo;

  //   FondoModel(
  //   id: 1,
  //   nombre: 'FPV_BTG_PACTUAL_RECAUDADORA',
  //   montoMinimo: 75000,
  //   categoria: 'FPV',
  // ),

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fondo.nombre, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Categoría: ${fondo.categoria}'),
            Text('Monto mínimo: \$${fondo.montoMinimo.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
