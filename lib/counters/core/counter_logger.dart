import 'package:logger/logger.dart';

class CounterLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(printTime: true),
  );

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message);
  }

  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message);
  }
}
