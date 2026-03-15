import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class TransactionWebLayout extends ConsumerWidget {
  const TransactionWebLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(foundsControllerProvider);

    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: state.historial.length,
            itemBuilder: (context, index) {
              final found = state.historial[index];
              return ListTile(
                title: FPVText(text: found.categoriaFondo.displayName),
                subtitle: FPVText(
                  text: MoneyUtils.formatMoney(found.monto, 'COP'),
                ),
              );
            },
          );
  }
}
