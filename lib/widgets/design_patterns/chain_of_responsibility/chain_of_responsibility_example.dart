import 'package:faker/faker.dart';

import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_bloc.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/log_message.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/logger_base.dart';
import 'package:flutter_design_patterns/design_patterns/chain_of_responsibility/loggers/index.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/chain_of_responsibility/log_messages_column.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class ChainOfResponsibilityExample extends StatefulWidget {
  @override
  _ChainOfResponsibilityExampleState createState() =>
      _ChainOfResponsibilityExampleState();
}

class _ChainOfResponsibilityExampleState
    extends State<ChainOfResponsibilityExample> {
  final LogBloc logBloc = LogBloc();

  LoggerBase logger;

  @override
  void initState() {
    super.initState();

    logger = DebugLogger(
      logBloc,
      InfoLogger(
        logBloc,
        ErrorLogger(
          logBloc,
        ),
      ),
    );
  }

  @override
  void dispose() {
    logBloc.dispose();
    super.dispose();
  }

  String get randomLog => faker.lorem.sentence();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logDebug(randomLog),
              child: const Text('Log debug'),
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logInfo(randomLog),
              child: const Text('Log info'),
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logError(randomLog),
              child: const Text('Log error'),
            ),
            const Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<List<LogMessage>>(
                    initialData: const [],
                    stream: logBloc.outLogStream,
                    builder: (_, AsyncSnapshot<List<LogMessage>> snapshot) =>
                        LogMessagesColumn(logMessages: snapshot.data),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
