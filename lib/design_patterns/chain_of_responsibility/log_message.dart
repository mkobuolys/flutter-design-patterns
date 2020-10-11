import 'package:meta/meta.dart';

import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';

class LogMessage {
  final LogLevel logLevel;
  final String message;

  const LogMessage({
    @required this.logLevel,
    @required this.message,
  })  : assert(logLevel != null),
        assert(message != null);

  String get logLevelString =>
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
      '$logLevelString: $message',
      style: TextStyle(
        color: _getLogEntryColor(),
      ),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
