import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_message.dart';

class ExternalLoggingService {
  final LogBloc logBloc;

  ExternalLoggingService(this.logBloc);

  void logMessage(LogLevel logLevel, String message) {
    final logMessage = LogMessage(logLevel: logLevel, message: message);

    // Send log message to the external logging service

    // Log message
    logBloc.log(logMessage);
  }
}
