import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/logger_base.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/services/mail_service.dart';

class ErrorLogger extends LoggerBase {
  final LogBloc logBloc;
  MailService mailService;

  ErrorLogger(this.logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Error, nextLogger) {
    mailService = MailService(logBloc);
  }

  @override
  void log(String message) {
    mailService.sendErrorMail(logLevel, message);
  }
}
