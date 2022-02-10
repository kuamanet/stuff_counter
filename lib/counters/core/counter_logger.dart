import 'package:logger/logger.dart';

class CounterLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message);
  }
}
