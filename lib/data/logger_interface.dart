import 'package:logger/logger.dart';

LoggerInterface get logger => LoggerInterface();

class LoggerInterface {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 10,
      errorMethodCount: 10,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  final _loggerNoStack = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  final _loggerScreenNoStack = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  void log(String message) {
    _loggerNoStack.i(message);
  }

  void logScreen(String message) {
    _loggerScreenNoStack.i(message);
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
