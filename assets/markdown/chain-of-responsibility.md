## Class diagram

![Chain of Responsibility Class Diagram](resource:assets/images/chain_of_responsibility/chain_of_responsibility.png)

## Implementation

### Class diagram

The class diagram below shows the implementation of the **Chain of Responsibility** design pattern:

![Chain of Responsibility Implementation Class Diagram](resource:assets/images/chain_of_responsibility/chain_of_responsibility_implementation.png)

The _LogLevel_ is an enumerator class defining possible log levels - Debug, Info and Error.

_LogMessage_ class is used to store information about the log message: its log level and the message text. It also provides a public _getFormattedMessage()_ method to format the log entry as a Widget object (for that, a private helper method _getLogEntryColor()_ and a getter _logLevelString_ are used).

_LoggerBase_ is an abstract class which is used as a base class for all the specific loggers:

- _logMessage()_ - logs message using the _log()_ method and passes the request along the chain;
- _logDebug()_ - logs the message with a log level of Debug;
- _logInfo()_ - logs the message with a log level of Info;
- _logError()_ - logs the message with a log level of Error;
- _log()_ - an abstract method to log the message (must be implemented by specific logger).

Also, the _LoggerBase_ contains a reference to the next logger (_nextLogger_) and logger's log level (_logLevel_).

_DebugLogger_, _InfoLogger_ and _ErrorLogger_ are concrete logger classes which extend the _LoggerBase_ class and implement the abstract _log()_ method. _InfoLogger_ uses the _ExternalLoggingService_ to log messages, _ErrorLogger_ - the _MailService_.

All the specific loggers use or inject the _LogBloc_ class to mock the actual logging and provide log entries to the UI.

_LogBloc_ stores a list of logs and exposes them through the stream - _outLogStream_. Also, it defines the _log()_ method to add a new log to the list and notify _outLogStream_ subscribers with an updated log entries list.

_ChainOfResponsibilityExample_ creates a chain of loggers and uses public methods defined in _LoggerBase_ to log messages. It also initialises and contains the _LogBloc_ instance to store log entries and later show them in the UI.

### LogLevel

A special kind of class - _enumeration_ - to define different log levels. Also, there is a _LogLevelExtensions_ defined where the operator **<=** is overridden to compare whether one log level is lower or equal to the other.

```
enum LogLevel { Debug, Info, Error }

extension LogLevelExtensions on LogLevel {
  bool operator <=(LogLevel logLevel) => this.index <= logLevel.index;
}
```

### LogMessage

A simple class to store information about the log entry: log level and message. Also, this class defines a private getter _logLevelString_ to return the text representation of a specific log level and a private method _getLogEntryColor()_ to return the log entry color based on the log level. The _getFormattedMessage()_ method returns the formatted log entry as a _Text_ widget which is used in the UI.

```
class LogMessage {
  final LogLevel logLevel;
  final String message;

  const LogMessage({
    @required this.logLevel,
    @required this.message,
  })  : assert(logLevel != null),
        assert(message != null);

  String get _logLevelString =>
      logLevel.toString().split('.').last.toUpperCase();

  Color _getLogEntryColor() {
    switch (logLevel) {
      case LogLevel.Debug:
        return Colors.grey;
      case LogLevel.Info:
        return Colors.blue;
      case LogLevel.Error:
        return Colors.red;
      default:
        throw Exception("Log level '$logLevel' is not supported.");
    }
  }

  Widget getFormattedMessage() {
    return Text(
      '$_logLevelString: $message',
      style: TextStyle(
        color: _getLogEntryColor(),
      ),
      textAlign: TextAlign.justify,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
```

### LogBloc

A Business Logic component (BLoC) class to store log messages and provide them to the UI through a public stream. New log entries are added to the logs list via the _log()_ method while all the logs could be accessed through the public _outLogStream_.

```
class LogBloc {
  final List<LogMessage> _logs = List<LogMessage>();
  final StreamController<List<LogMessage>> _logStream =
      StreamController<List<LogMessage>>();

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

A simple class that represents the actual external logging service. Instead of sending the log message to some kind of 3rd party logging service (which, in fact, could be called in the _logMessage()_ method), it just logs the message to UI through the _LogBloc_.

```
class ExternalLoggingService {
  final LogBloc logBloc;

  ExternalLoggingService(this.logBloc);

  void logMessage(LogLevel logLevel, String message) {
    var logMessage = LogMessage(logLevel: logLevel, message: message);

    // Send log message to the external logging service

    // Log message
    logBloc.log(logMessage);
  }
}
```

### MailService

A simple class that represents the actual mail logging service. Instead of sending the log message as an email to the user, it just logs the message to UI through the _LogBloc_.

```
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
```

### LoggerBase

An abstract class for the base logger implementation. It stores the log level and a reference (successor) to the next logger in the chain. Also, the class implements a common _logMessage()_ method that logs the message if its log level is lower than the current logger's and then forwards the message to the successor (if there is one). The abstract _log()_ method must be implemented by specific loggers extending the _LoggerBase_ class.

```
abstract class LoggerBase {
  @protected
  final LogLevel logLevel;
  final LoggerBase _nextLogger;

  const LoggerBase(this.logLevel, [this._nextLogger]);

  void logMessage(LogLevel level, String message) {
    if (logLevel <= level) {
      log(message);
    }

    if (_nextLogger != null) {
      _nextLogger.logMessage(level, message);
    }
  }

  void logDebug(String message) => logMessage(LogLevel.Debug, message);
  void logInfo(String message) => logMessage(LogLevel.Info, message);
  void logError(String message) => logMessage(LogLevel.Error, message);

  void log(String message);
}
```

### Concrete loggers

- _DebugLogger_ - a specific implementation of the logger that sets the log level to _Debug_ and simply logs the message to UI through the _LogBloc_.

```
class DebugLogger extends LoggerBase {
  final LogBloc logBloc;

  const DebugLogger(this.logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Debug, nextLogger);

  @override
  void log(String message) {
    var logMessage = LogMessage(logLevel: logLevel, message: message);

    logBloc.log(logMessage);
  }
}
```

- _InfoLogger_ - a specific implementation of the logger that sets the log level to _Info_ and uses the _ExternalLoggingService_ to log the message.

```
class InfoLogger extends LoggerBase {
  ExternalLoggingService externalLoggingService;

  InfoLogger(LogBloc logBloc, [LoggerBase nextLogger])
      : super(LogLevel.Info, nextLogger) {
    externalLoggingService = ExternalLoggingService(logBloc);
  }

  @override
  void log(String message) {
    externalLoggingService.logMessage(logLevel, message);
  }
}
```

- _ErrorLogger_ - a specific implementation of the logger that sets the log level to _Error_ and uses the _MailService_ to log the message.

```
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
```

### Example

The _ChainOfResponsibilityExample_ widget initialises and contains the loggers' chain object (see the _initState()_ method). Also, for demonstration purposes, the _LogBloc_ object is initialised there, too, and used to send logs and retrieve a list of them through the stream - _outLogStream_.

By creating a chain of loggers, the client - _ChainOfResponsibilityExample_ widget - does not care about the details on which specific logger should handle the log entry, it just passes (logs) the message to a chain of loggers. This way, the sender (client) and receiver (logger) are decoupled, the loggers' chain itself could be built at run-time in any order or structure e.g. you can skip the Debug logger for non-local environments and only use the Info -> Error chain.

```
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
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            PlatformButton(
              child: Text('Log debug'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logDebug(randomLog),
            ),
            PlatformButton(
              child: Text('Log info'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logInfo(randomLog),
            ),
            PlatformButton(
              child: Text('Log error'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: () => logger.logError(randomLog),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder<List<LogMessage>>(
                    initialData: [],
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
```
