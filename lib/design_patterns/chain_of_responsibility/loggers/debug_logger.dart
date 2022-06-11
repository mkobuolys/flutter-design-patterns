import '../log_bloc.dart';
import '../log_level.dart';
import '../log_message.dart';
import '../logger_base.dart';

class DebugLogger extends LoggerBase {
  final LogBloc logBloc;

  const DebugLogger(
    this.logBloc, {
    super.nextLogger,
  }) : super(logLevel: LogLevel.Debug);

  @override
  void log(String message) {
    final logMessage = LogMessage(logLevel: logLevel, message: message);

    logBloc.log(logMessage);
  }
}
