import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/controllers/founds_controller.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/widgets/atoms/found_card.dart';

class ListFounds extends StatelessWidget {
  const ListFounds({super.key, required this.state, required this.ref});
  final FoundsState state;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
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
