import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'log_level.dart';

class LogMessage {
  final LogLevel logLevel;
  final String message;

  const LogMessage({
    @required this.logLevel,
    @required this.message,
  })  : assert(logLevel != null),
        assert(message != null);

  String get _logLevelString =>
      logLevel.toString().split('.').last.toUpperCase();

  Color _getLogEntryColor() {
    switch (logLevel) {
      case LogLevel.Debug:
        return Colors.grey;
      case LogLevel.Info:
        return Colors.blue;
      case LogLevel.Error:
        return Colors.red;
      default:
        throw Exception("Log level '$logLevel' is not supported.");
    }
  }

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
