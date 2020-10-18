import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_message.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/logger_base.dart';

class DebugLogger extends LoggerBase {
  final LogBloc logBloc;

  const DebugLogger(this.logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Debug, nextLogger);

  @override
  void log(String message) {
    var logMessage = LogMessage(logLevel: logLevel, message: message);

    logBloc.log(logMessage);
  }
}
