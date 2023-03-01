import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/models/design_pattern.dart';
import '../../../../themes.dart';
import '../widgets/widgets.dart';

class TabsLayout extends StatefulWidget {
  const TabsLayout({
    required this.designPattern,
  });

  final DesignPattern designPattern;

  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _onBottomNavigationBarItemTap(int index) {
    setState(() {
      _controller.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailsAppBar(designPattern: widget.designPattern),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _controller.index,
        backgroundColor: lightBackgroundColor,
        selectedIconTheme: const IconThemeData(size: 20.0),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(size: 20.0),
        unselectedItemColor: Colors.black45,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: 'Description',
            icon: Icon(FontAwesomeIcons.fileLines),
          ),
          BottomNavigationBarItem(
            label: 'Example',
            icon: Icon(FontAwesomeIcons.lightbulb),
          ),
        ],
        onTap: _onBottomNavigationBarItemTap,
      ),
      body: TabBarView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          MarkdownView(designPattern: widget.designPattern),
          ExampleView(designPatternId: widget.designPattern.id),
        ],
      ),
    );
  }
}
