import '../log_bloc.dart';
import '../log_level.dart';
import '../logger_base.dart';
import '../services/external_logging_service.dart';

class InfoLogger extends LoggerBase {
  late ExternalLoggingService externalLoggingService;

  InfoLogger(
    LogBloc logBloc, {
    super.nextLogger,
  })  : externalLoggingService = ExternalLoggingService(logBloc),
        super(logLevel: LogLevel.Info);

  @override
  void log(String message) {
    externalLoggingService.logMessage(logLevel, message);
  }
}
