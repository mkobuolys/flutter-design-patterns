import 'package:meta/meta.dart';

import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';

abstract class LoggerBase {
  @protected
  final LogLevel logLevel;
  @protected
  final LoggerBase nextLogger;

  const LoggerBase(this.logLevel, [this.nextLogger]);

  void logMessage(LogLevel level, String message) {
    if (logLevel <= level) {
      log(message);
    }

    if (nextLogger != null) {
      nextLogger.logMessage(level, message);
    }
  }

  void logDebug(String message) => logMessage(LogLevel.Debug, message);
  void logInfo(String message) => logMessage(LogLevel.Info, message);
  void logError(String message) => logMessage(LogLevel.Error, message);

  void log(String message);
}
