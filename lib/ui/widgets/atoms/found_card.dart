import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/domain/enity/transaction.dart';
import 'package:fpv_fic/ui/providers/auth_providers.dart';
import 'package:fpv_fic/ui/providers/founds_providers.dart';
import 'package:fpv_fic/ui/utils/dialogs.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class FondoCard extends ConsumerStatefulWidget {
  const FondoCard({super.key, required this.fondo});

  final FondoModel fondo;

  @override
  ConsumerState<FondoCard> createState() => _FondoCardState();
}

class _FondoCardState extends ConsumerState<FondoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showFondoDetails,
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FPVText(text: widget.fondo.nombre).s18().w700(),
              const SizedBox(height: 8),
              FPVText(text: 'Categoría: ${widget.fondo.categoria}').s14(),
              FPVText(
                text:
                    'Monto mínimo: ${MoneyUtils.formatMoney(widget.fondo.montoMinimo, 'COP', fractionDigits: 2)}',
              ).s14().w700(),
            ],
          ),
        ),
      ),
    );
  }

  // MARK: - Detalles del fondo y suscripción
  void _showFondoDetails() {
    final rootContext = context;
    showDialog(
      context: rootContext,
      builder: (context) {
        double? montoSeleccionado;
        bool? nextEnabled;
        String? errorMonto;
        MetodoNotificacion? metodoNotificacionSeleccionado;
        final TextEditingController montoController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: FPVText(text: widget.fondo.nombre).s18().w700(),
              content: nextEnabled != true
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FPVText(
                          text: 'Categoría: ${widget.fondo.categoria}',
                        ).s14(),
                        FPVText(
                          text:
                              'Monto mínimo: ${MoneyUtils.formatMoney(widget.fondo.montoMinimo, 'COP', fractionDigits: 2)}',
                        ).s14().w700(),

                        const SizedBox(height: 12),
                        FPVText(
                          text: 'Selecciona el monto a invertir:',
                        ).s14().w700(),

                        RadioGroup<double>(
                          groupValue: montoSeleccionado,
                          onChanged: (value) {
                            setDialogState(() {
                              montoSeleccionado = value;
                              errorMonto = null;
                            });
                          },
                          child: Column(
                            children: [
                              RadioListTile<double>(
                                title: Text(
                                  'Monto mínimo (${MoneyUtils.formatMoney(widget.fondo.montoMinimo, 'COP', fractionDigits: 2)})',
                                ),
                                value: widget.fondo.montoMinimo,
                              ),
                              RadioListTile<double>(
                                title: const Text('Monto personalizado'),
                                value: -1,
                              ),
                            ],
                          ),
                        ),

                        if (montoSeleccionado == -1) ...[
                          const SizedBox(height: 8),
                          TextField(
                            controller: montoController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Ingresa el monto (COP)',
                              border: const OutlineInputBorder(),
                              prefixText: '\$ ',
                              hintText: '300.000',
                            ),
                          ),
                          if (errorMonto != null) ...[
                            const SizedBox(height: 8),
                            FPVText(text: errorMonto!).s12().color(Colors.red),
                          ],
                        ],
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FPVText(
                          text:
                              'Como deceas revibir la notificación de tu suscripción?',
                        ).s16().w700(),
                        const SizedBox(height: 12),
                        RadioGroup<MetodoNotificacion>(
                          groupValue: metodoNotificacionSeleccionado,
                          onChanged: (value) {
                            setDialogState(() {
                              metodoNotificacionSeleccionado = value;
                            });
                          },
                          child: Column(
                            children: [
                              RadioListTile<MetodoNotificacion>(
                                title: const Text('Email'),
                                value: MetodoNotificacion.email,
                              ),
                              RadioListTile<MetodoNotificacion>(
                                title: const Text('SMS'),
                                value: MetodoNotificacion.sms,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),

                if (nextEnabled == true)
                  ElevatedButton(
                    onPressed: metodoNotificacionSeleccionado == null
                        ? null
                        : () async {
                            final monto = montoSeleccionado == -1
                                ? double.tryParse(montoController.text) ?? 0
                                : montoSeleccionado!;
                            final metodo = metodoNotificacionSeleccionado!;

                            Navigator.pop(context);

                            _suscribeFondo(
                              widget.fondo.id.toString(),
                              metodo,
                              monto,
                            );
                          },
                    child: const Text('Confirmar'),
                  )
                else
                  ElevatedButton(
                    onPressed: montoSeleccionado == null
                        ? null
                        : () {
                            final saldo = ref
                                .read(authControllerProvider)
                                .usuario
                                .saldo;
                            final monto = montoSeleccionado == -1
                                ? double.tryParse(montoController.text) ?? 0
                                : montoSeleccionado!;

                            if (monto <= 0) {
                              setDialogState(() {
                                errorMonto = 'Ingresa un monto válido';
                              });
                              return;
                            }

                            if (monto > saldo) {
                              setDialogState(() {
                                errorMonto =
                                    'No tienes suficiente saldo para esta inversión';
                              });
                              return;
                            }
                            if (monto < widget.fondo.montoMinimo) {
                              setDialogState(() {
                                errorMonto =
                                    'El monto debe ser al menos ${MoneyUtils.formatMoney(widget.fondo.montoMinimo, 'COP', fractionDigits: 2)}';
                              });
                              return;
                            }
                            setDialogState(() {
                              nextEnabled = true;
                            });
                          },
                    child: const Text('Siguiente'),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _suscribeFondo(
    String fondoId,
    MetodoNotificacion metodo,
    double monto,
  ) async {
    DialogsInfo.show(
      context: context,
      process: ref
          .read(foundsControllerProvider.notifier)
          .suscribeFondo(fondoId, metodo, monto),
      callback: (_) {},
    );
  }
}
