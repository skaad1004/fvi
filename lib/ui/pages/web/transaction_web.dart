import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/widgets/molecules/list_transaction.dart';

class TransactionWebLayout extends ConsumerWidget {
  const TransactionWebLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(foundsControllerProvider);

    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListTransaction(transactions: state.historial);
  }
}
