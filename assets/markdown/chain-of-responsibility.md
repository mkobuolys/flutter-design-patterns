## Class diagram

![Chain of Responsibility Class Diagram](resource:assets/images/chain_of_responsibility/chain_of_responsibility.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Chain of Responsibility** design pattern:

![Chain of Responsibility Implementation Class Diagram](resource:assets/images/chain_of_responsibility/chain_of_responsibility_implementation.png)

The `LogLevel` is an enumerator class defining possible log levels - Debug, Info and Error.

`LogMessage` class is used to store information about the log message: its log level and the message text. It also provides a public `getFormattedMessage()` method to format the log entry as a Widget object (for that, a private helper method `getLogEntryColor()` and a getter `logLevelString` are used).

`LoggerBase` is an abstract class which is used as a base class for all the specific loggers:

- `logMessage()` - logs message using the `log()` method and passes the request along the chain;
- `logDebug()` - logs the message with a log level of Debug;
- `logInfo()` - logs the message with a log level of Info;
- `logError()` - logs the message with a log level of Error;
- `log()` - an abstract method to log the message (must be implemented by specific logger).

Also, the `LoggerBase` contains a reference to the next logger (`nextLogger`) and logger's log level (`logLevel`).

`DebugLogger`, `InfoLogger` and `ErrorLogger` are concrete logger classes which extend the `LoggerBase` class and implement the abstract `log()` method. `InfoLogger` uses the `ExternalLoggingService` to log messages, `ErrorLogger` - the `MailService`.

All the specific loggers use or inject the `LogBloc` class to mock the actual logging and provide log entries to the UI.

`LogBloc` stores a list of logs and exposes them through the stream - `outLogStream`. Also, it defines the `log()` method to add a new log to the list and notify `outLogStream` subscribers with an updated log entries list.

`ChainOfResponsibilityExample` creates a chain of loggers and uses public methods defined in `LoggerBase` to log messages. It also initialises and contains the `LogBloc` instance to store log entries and later show them in the UI.

### LogLevel

A special kind of class - `enumeration` - to define different log levels. Also, the `<=` operator is overridden to compare whether one log level is lower or equal to the other.

```dart
enum LogLevel {
  debug,
  info,
  error;

  bool operator <=(LogLevel logLevel) => index <= logLevel.index;
}
```

### LogMessage

A simple class to store information about the log entry: log level and message. Also, this class defines a private getter `logLevelString` to return the text representation of a specific log level and a private method `getLogEntryColor()` to return the log entry color based on the log level. The `getFormattedMessage()` method returns the formatted log entry as a `Text` widget which is used in the UI.

```dart
class LogMessage {
  const LogMessage({
    required this.logLevel,
    required this.message,
  });

  final LogLevel logLevel;
  final String message;

  String get _logLevelString =>
      logLevel.toString().split('.').last.toUpperCase();

  Color _getLogEntryColor() => switch (logLevel) {
        LogLevel.debug => Colors.grey,
        LogLevel.info => Colors.blue,
        LogLevel.error => Colors.red,
      };

  Widget getFormattedMessage() => Text(
        '$_logLevelString: $message',
        style: TextStyle(color: _getLogEntryColor()),
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      );
}
```

### LogBloc

A Business Logic component (BLoC) class to store log messages and provide them to the UI through a public stream. New log entries are added to the logs list via the `log()` method while all the logs could be accessed through the public `outLogStream`.

```dart
class LogBloc {
  final List<LogMessage> _logs = [];
  final _logStream = StreamController<List<LogMessage>>();

  StreamSink<List<LogMessage>> get _inLogStream => _logStream.sink;
  Stream<List<LogMessage>> get outLogStream => _logStream.stream;

  void log(LogMessage logMessage) {
    _logs.add(logMessage);
    _inLogStream.add(UnmodifiableListView(_logs));
  }

  void dispose() {
    _logStream.close();
  }
}
```

### ExternalLoggingService

A simple class that represents the actual external logging service. Instead of sending the log message to some kind of 3rd party logging service (which, in fact, could be called in the `logMessage()` method), it just logs the message to UI through the `LogBloc`.

```dart
class ExternalLoggingService {
  const ExternalLoggingService(this.logBloc);

  final LogBloc logBloc;

  void logMessage(LogLevel logLevel, String message) {
    final logMessage = LogMessage(logLevel: logLevel, message: message);

    // Send log message to the external logging service

    // Log message
    logBloc.log(logMessage);
  }
}
```

### MailService

A simple class that represents the actual mail logging service. Instead of sending the log message as an email to the user, it just logs the message to UI through the `LogBloc`.

```dart
class MailService {
  const MailService(this.logBloc);

  final LogBloc logBloc;

  void sendErrorMail(LogLevel logLevel, String message) {
    final logMessage = LogMessage(logLevel: logLevel, message: message);

    // Send error mail

    // Log message
    logBloc.log(logMessage);
  }
}
```

### LoggerBase

An abstract class for the base logger implementation. It stores the log level and a reference (successor) to the next logger in the chain. Also, the class implements a common `logMessage()` method that logs the message if its log level is lower than the current logger's and then forwards the message to the successor (if there is one). The abstract `log()` method must be implemented by specific loggers extending the `LoggerBase` class.

```dart
abstract class LoggerBase {
  const LoggerBase({
    required this.logLevel,
    LoggerBase? nextLogger,
  }) : _nextLogger = nextLogger;

  @protected
  final LogLevel logLevel;
  final LoggerBase? _nextLogger;

  void logMessage(LogLevel level, String message) {
    if (logLevel <= level) log(message);

    _nextLogger?.logMessage(level, message);
  }

  void logDebug(String message) => logMessage(LogLevel.debug, message);
  void logInfo(String message) => logMessage(LogLevel.info, message);
  void logError(String message) => logMessage(LogLevel.error, message);

  void log(String message);
}
```

### Concrete loggers

- `DebugLogger` - a specific implementation of the logger that sets the log level to `Debug` and simply logs the message to UI through the `LogBloc`.

```dart
class DebugLogger extends LoggerBase {
  const DebugLogger(
    this.logBloc, {
    super.nextLogger,
  }) : super(logLevel: LogLevel.debug);

  final LogBloc logBloc;

  @override
  void log(String message) {
    final logMessage = LogMessage(logLevel: logLevel, message: message);

    logBloc.log(logMessage);
  }
}
```

- `InfoLogger` - a specific implementation of the logger that sets the log level to `Info` and uses the `ExternalLoggingService` to log the message.

```dart
class InfoLogger extends LoggerBase {
  InfoLogger(
    LogBloc logBloc, {
    super.nextLogger,
  })  : externalLoggingService = ExternalLoggingService(logBloc),
        super(logLevel: LogLevel.info);

  final ExternalLoggingService externalLoggingService;

  @override
  void log(String message) {
    externalLoggingService.logMessage(logLevel, message);
  }
}
```

- `ErrorLogger` - a specific implementation of the logger that sets the log level to `Error` and uses the `MailService` to log the message.

```dart
class ErrorLogger extends LoggerBase {
  ErrorLogger(
    LogBloc logBloc, {
    super.nextLogger,
  })  : mailService = MailService(logBloc),
        super(logLevel: LogLevel.error);

  final MailService mailService;

  @override
  void log(String message) {
    mailService.sendErrorMail(logLevel, message);
  }
}
```

### Example

The `ChainOfResponsibilityExample` widget initialises and contains the loggers' chain object (see the `initState()` method). Also, for demonstration purposes, the `LogBloc` object is initialised there, too, and used to send logs and retrieve a list of them through the stream - `outLogStream`.

By creating a chain of loggers, the client - `ChainOfResponsibilityExample` widget - does not care about the details on which specific logger should handle the log entry, it just passes (logs) the message to a chain of loggers. This way, the sender (client) and receiver (logger) are decoupled, the loggers' chain itself could be built at run-time in any order or structure e.g. you can skip the Debug logger for non-local environments and only use the Info -> Error chain.

```dart
class ChainOfResponsibilityExample extends StatefulWidget {
  const ChainOfResponsibilityExample();

  @override
  _ChainOfResponsibilityExampleState createState() =>
      _ChainOfResponsibilityExampleState();
}

class _ChainOfResponsibilityExampleState
    extends State<ChainOfResponsibilityExample> {
  final logBloc = LogBloc();

  late final LoggerBase logger;

  @override
  void initState() {
    super.initState();

    logger = DebugLogger(
      logBloc,
      nextLogger: InfoLogger(
        logBloc,
        nextLogger: ErrorLogger(logBloc),
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
        padding: const EdgeInsets.symmetric(
          horizontal: LayoutConstants.paddingL,
        ),
        child: Column(
          children: <Widget>[
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logDebug(randomLog),
              text: 'Log debug',
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logInfo(randomLog),
              text: 'Log info',
            ),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logError(randomLog),
              text: 'Log error',
            ),
            const Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<List<LogMessage>>(
                    initialData: const [],
                    stream: logBloc.outLogStream,
                    builder: (context, snapshot) =>
                        LogMessagesColumn(logMessages: snapshot.data!),
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
```
