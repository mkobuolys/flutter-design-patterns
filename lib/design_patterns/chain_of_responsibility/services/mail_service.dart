import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_level.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_message.dart';

class MailService {
  final LogBloc logBloc;

  MailService(this.logBloc);

  void sendErrorMail(LogLevel logLevel, String message) {
    var logMessage = LogMessage(logLevel: logLevel, message: message);

    // Send error mail

    // Log message
    logBloc.log(logMessage);
  }
}
