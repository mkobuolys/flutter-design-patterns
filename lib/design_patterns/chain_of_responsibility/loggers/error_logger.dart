import '../log_bloc.dart';
import '../log_level.dart';
import '../logger_base.dart';
import '../services/mail_service.dart';

class ErrorLogger extends LoggerBase {
  MailService mailService;

  ErrorLogger(LogBloc logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Error, nextLogger) {
    mailService = MailService(logBloc);
  }

  @override
  void log(String message) {
    mailService.sendErrorMail(logLevel, message);
  }
}
