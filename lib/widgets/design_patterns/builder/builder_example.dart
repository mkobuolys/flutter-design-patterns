import 'package:flutter/material.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/design_patterns/builder/burger.dart';
import 'package:flutter_design_patterns/design_patterns/builder/burger_builder.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/builder/burger_information/burger_information_column.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/builder/burger_menu_item.dart';

class BuilderExample extends StatefulWidget {
  @override
  _BuilderExampleState createState() => _BuilderExampleState();
}

class _BuilderExampleState extends State<BuilderExample> {
  final BurgerBuilder _burgerBuilder = BurgerBuilder();
  final List<BurgerMenuItem> _burgerMenuItems = [];

  BurgerMenuItem _selectedBurgerMenuItem;
  Burger _selectedBurger;

  @override
  void initState() {
    super.initState();

    _burgerMenuItems.addAll([
      BurgerMenuItem(
        label: 'Hamburger',
        prepareBurger: _burgerBuilder.prepareHamburger,
      ),
      BurgerMenuItem(
        label: 'Cheeseburger',
        prepareBurger: _burgerBuilder.prepareCheeseburger,
      ),
      BurgerMenuItem(
        label: 'Big Mac\u00AE',
        prepareBurger: _burgerBuilder.prepareBigMac,
      ),
      BurgerMenuItem(
        label: 'McChicken\u00AE',
        prepareBurger: _burgerBuilder.prepareMcChicken,
      )
    ]);

    _selectedBurgerMenuItem = _burgerMenuItems[0];
    _selectedBurger = _selectedBurgerMenuItem.prepareBurger();
  }

  void _onBurgerMenuItemChanged(BurgerMenuItem selectedItem) {
    setState(() {
      _selectedBurgerMenuItem = selectedItem;
      _selectedBurger = selectedItem.prepareBurger();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollBehavior(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Select menu item:',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            DropdownButton(
              value: _selectedBurgerMenuItem,
              items: _burgerMenuItems
                  .map<DropdownMenuItem<BurgerMenuItem>>(
                    (BurgerMenuItem item) => DropdownMenuItem(
                      value: item,
                      child: Text(item.label),
                    ),
                  )
                  .toList(),
              onChanged: _onBurgerMenuItemChanged,
            ),
            SizedBox(height: spaceL),
            Row(
              children: <Widget>[
                Text(
                  'Information:',
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
            SizedBox(height: spaceM),
            BurgerInformationColumn(burger: _selectedBurger),
          ],
        ),
      ),
    );
  }
}
