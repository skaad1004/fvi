import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/utils/dialogs.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class ListTransaction extends ConsumerStatefulWidget {
  const ListTransaction({super.key, required this.transactions});
  final List<TransaccionModel> transactions;

  @override
  ConsumerState<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends ConsumerState<ListTransaction> {
  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? Center(
            child: FPVText(text: 'No hay transacciones').color(Colors.grey),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: widget.transactions.length,
            itemBuilder: (context, index) {
              final transaction = widget.transactions[index];
              return Container(
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  title: FPVText(text: transaction.categoriaFondo.displayName),
                  subtitle:
                      FPVText(
                        text: MoneyUtils.formatMoney(transaction.monto, 'COP'),
                      ).color(
                        transaction.tipo == TipoTransaccion.suscripcion
                            ? Colors.green
                            : Colors.grey,
                      ),
                  leading: Icon(
                    transaction.tipo == TipoTransaccion.suscripcion
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                    color: transaction.tipo == TipoTransaccion.suscripcion
                        ? Colors.green
                        : Colors.grey,
                  ),

                  trailing: transaction.tipo == TipoTransaccion.cancelacion
                      ? null
                      : IconButton(
                          onPressed: () => _confirmDelete(context, transaction),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.grey,
                          ),
                        ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    TransaccionModel transaction,
  ) async {
    DialogsInfo.confirmDialog(
      context,
      title: '¿Eliminar transacción?',
      message:
          '¿Estás seguro de que deseas eliminar esta transacción? Esta acción no se puede deshacer.',
      confirmText: 'Eliminar',
      cancelText: 'Cancelar',
      onConfirm: () {
        DialogsInfo.show(
          context: context,
          process: ref
              .read(foundsControllerProvider.notifier)
              .unsubscribeFondo(transaction.id),
        );
      },
    );
  }
}
