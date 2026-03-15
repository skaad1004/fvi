import 'package:money_formatter/money_formatter.dart';

class MoneyUtils {
  MoneyUtils._();

  static MoneyFormatter _moneyFormatter(String symbol, int fractionDigits) =>
      MoneyFormatter(
        amount: 0,
        settings: MoneyFormatterSettings(
          symbol: symbol,
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: fractionDigits,
        ),
      );

  static String formatMoney(
    double amount,
    String symbol, {
    int fractionDigits = 0,
  }) {
    try {
      if (symbol == 'COP') {
        symbol = r'$';
      } else if (symbol == 'PEN') {
        symbol = 'S/';
      } else if (symbol == 'ARS') {
        symbol = r'$';
      }

      // Validar valores especiales
      if (amount.isNaN || amount.isInfinite) return '$symbol 0';

      // Determinar si es negativo y obtener valor absoluto
      final isNegative = amount < 0;
      final absoluteValue = amount.abs();

      // Detectar si el valor tiene decimales
      final hasDecimals = absoluteValue % 1 != 0;
      final fractionDigits = hasDecimals ? 2 : 0;

      final formatted = _moneyFormatter(
        symbol,
        fractionDigits,
      ).copyWith(amount: absoluteValue).output.symbolOnLeft;

      return isNegative ? '-$formatted' : formatted;
    } catch (e) {
      // Si hay cualquier error, retornar valor por defecto
      return '$symbol 0';
    }
  }
}
