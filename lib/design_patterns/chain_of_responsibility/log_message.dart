import 'package:flutter/material.dart';

import 'log_level.dart';

class LogMessage {
  final LogLevel logLevel;
  final String message;

  const LogMessage({
    required this.logLevel,
    required this.message,
  });

  String get _logLevelString =>
      logLevel.toString().split('.').last.toUpperCase();

  Color _getLogEntryColor() => switch (logLevel) {
        LogLevel.Debug => Colors.grey,
        LogLevel.Info => Colors.blue,
        LogLevel.Error => Colors.red,
      };

  Widget getFormattedMessage() {
    return Text(
      '$_logLevelString: $message',
      style: TextStyle(
        color: _getLogEntryColor(),
      ),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
