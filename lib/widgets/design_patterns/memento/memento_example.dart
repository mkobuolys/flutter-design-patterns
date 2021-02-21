import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/icommand.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/command_history.dart';
import 'package:flutter_design_patterns/design_patterns/memento/command_design_pattern/commands/randomise_properties_command.dart';
import 'package:flutter_design_patterns/design_patterns/memento/originator.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/memento/shape_container.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class MementoExample extends StatefulWidget {
  @override
  _MementoExampleState createState() => _MementoExampleState();
}

class _MementoExampleState extends State<MementoExample> {
  final CommandHistory _commandHistory = CommandHistory();
  final Originator _originator = Originator();

  void _randomiseProperties() {
    final command = RandomisePropertiesCommand(_originator);
    _executeCommand(command);
  }

  void _executeCommand(ICommand command) {
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
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          children: <Widget>[
            ShapeContainer(
              shape: _originator.state,
            ),
            const SizedBox(height: spaceM),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _randomiseProperties,
              child: const Text('Randomise properties'),
            ),
            const Divider(),
            PlatformButton(
              materialColor: Colors.black,
              materialTextColor: Colors.white,
              onPressed: _commandHistory.isEmpty ? null : _undo,
              child: const Text('Undo'),
            ),
            const SizedBox(height: spaceM),
          ],
        ),
      ),
    );
  }
}
