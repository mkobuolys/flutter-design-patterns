import 'dart:collection';

import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command.dart';

class CommandHistory {
  final ListQueue<Command> _commandList = ListQueue<Command>();

  bool get isEmpty => _commandList.isEmpty;

  void add(Command command) {
    _commandList.add(command);
  }

  void undo() {
    if (_commandList.isNotEmpty) {
      var command = _commandList.removeLast();
      command.undo();
    }
  }
}
