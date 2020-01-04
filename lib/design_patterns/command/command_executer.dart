import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:flutter_design_patterns/design_patterns/command/command.dart';

class CommandExecuter extends ChangeNotifier {
  final ListQueue<Command> _commandList = ListQueue<Command>();

  bool get isUndoable => _commandList.isNotEmpty;

  void add(Command command) {
    _commandList.add(command);
  }

  void undo() {
    if (_commandList.isNotEmpty) {
      var command = _commandList.removeLast();
      command.undo();
      notifyListeners();
    }
  }

  Future execute() async {
    for (var command in _commandList) {
      command.execute();
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  List<String> getCommandTitles() {
    return _commandList.map((c) => c.getTitle()).toList();
  }
}
