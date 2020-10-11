import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/logger_base.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/services/external_logging_service.dart';

class InfoLogger extends LoggerBase {
  final LogBloc logBloc;
  ExternalLoggingService externalLoggingService;

  InfoLogger(this.logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Info, nextLogger) {
    externalLoggingService = ExternalLoggingService(logBloc);
  }

  @override
  void log(String message) {
    externalLoggingService.logMessage(logLevel, message);
  }
}
