import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command_history.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/commands/change_color_command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/commands/change_height_command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/commands/change_width_command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/shape.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/memento/command_history_column.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/memento/shape_container.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class MementoExample extends StatefulWidget {
  @override
  _MementoExampleState createState() => _MementoExampleState();
}

class _MementoExampleState extends State<MementoExample> {
  final CommandHistory _commandHistory = CommandHistory();
  final Shape _shape = Shape.initial();

  void _changeColor() {
    var command = ChangeColorCommand(_shape);
    _executeCommand(command);
  }

  void _changeHeight() {
    var command = ChangeHeightCommand(_shape);
    _executeCommand(command);
  }

  void _changeWidth() {
    var command = ChangeWidthCommand(_shape);
    _executeCommand(command);
  }

  void _executeCommand(Command command) {
    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _undo() {
    setState(() {
      _commandHistory.undo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            ShapeContainer(
              shape: _shape,
            ),
            const SizedBox(height: spaceM),
            PlatformButton(
              child: Text('Change color'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeColor,
            ),
            PlatformButton(
              child: Text('Change height'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeHeight,
            ),
            PlatformButton(
              child: Text('Change width'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _changeWidth,
            ),
            Divider(),
            PlatformButton(
              child: Text('Undo'),
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
            ),
            const SizedBox(height: spaceM),
            Row(
              children: <Widget>[
                CommandHistoryColumn(
                  commandList: _commandHistory.commandHistoryList,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
