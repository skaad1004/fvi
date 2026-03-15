import 'package:flutter/material.dart';
import 'package:fpv_fic/domain/enity/fondo.dart';
import 'package:fpv_fic/ui/utils/money_formater.dart';
import 'package:fpv_fic/ui/widgets/atoms/fpv_text.dart';

class FondoCard extends StatelessWidget {
  const FondoCard({super.key, required this.fondo});

  final FondoModel fondo;
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
            FPVText(text: 'Categoría: ${fondo.categoria}').s14(),
            FPVText(
              text:
                  'Monto mínimo: ${MoneyUtils.formatMoney(fondo.montoMinimo, 'COP', fractionDigits: 2)}',
            ).s14().w700(),
          ],
        ),
      ),
    );
  }
}
