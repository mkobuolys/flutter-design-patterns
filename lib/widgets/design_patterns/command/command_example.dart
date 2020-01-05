import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/command/command_history.dart';
import 'package:flutter_design_patterns/design_patterns/command/commands/change_color_command.dart';
import 'package:flutter_design_patterns/design_patterns/command/commands/change_height_command.dart';
import 'package:flutter_design_patterns/design_patterns/command/commands/change_width_command.dart';
import 'package:flutter_design_patterns/design_patterns/command/shape.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/command/command_history_column.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/command/shape_container.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class CommandExample extends StatefulWidget {
  @override
  _CommandExampleState createState() => _CommandExampleState();
}

class _CommandExampleState extends State<CommandExample> {
  final CommandHistory _commandHistory = CommandHistory();
  final Shape _shape = Shape.initial();

  void _changeColor() {
    var command = ChangeColorCommand(_shape);

    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _changeHeight() {
    var command = ChangeHeightCommand(_shape);

    setState(() {
      command.execute();
      _commandHistory.add(command);
    });
  }

  void _changeWidth() {
    var command = ChangeWidthCommand(_shape);

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
              child: Text("Undo"),
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
