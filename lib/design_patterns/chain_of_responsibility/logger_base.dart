import 'package:flutter/foundation.dart';

import 'log_level.dart';

abstract class LoggerBase {
  @protected
  final LogLevel logLevel;
  final LoggerBase? _nextLogger;

  const LoggerBase(this.logLevel, [this._nextLogger]);

  void logMessage(LogLevel level, String message) {
    if (logLevel <= level) {
      log(message);
    }

    _nextLogger?.logMessage(level, message);
  }

  void logDebug(String message) => logMessage(LogLevel.Debug, message);
  void logInfo(String message) => logMessage(LogLevel.Info, message);
  void logError(String message) => logMessage(LogLevel.Error, message);

  void log(String message);
}
