import '../log_bloc.dart';
import '../log_level.dart';
import '../logger_base.dart';
import '../services/mail_service.dart';

class ErrorLogger extends LoggerBase {
  late MailService mailService;

  ErrorLogger(
    LogBloc logBloc, {
    super.nextLogger,
  })  : mailService = MailService(logBloc),
        super(logLevel: LogLevel.Error);

  @override
  void log(String message) {
    mailService.sendErrorMail(logLevel, message);
  }
}
