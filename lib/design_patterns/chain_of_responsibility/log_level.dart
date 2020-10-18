enum LogLevel { Debug, Info, Error }

extension LogLevelExtensions on LogLevel {
  bool operator <=(LogLevel logLevel) => this.index <= logLevel.index;
}
