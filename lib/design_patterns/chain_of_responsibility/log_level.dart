// ignore_for_file: constant_identifier_names

enum LogLevel {
  Debug,
  Info,
  Error,
}

extension LogLevelExtensions on LogLevel {
  bool operator <=(LogLevel logLevel) => index <= logLevel.index;
}
