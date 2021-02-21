import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/data/models/design_pattern_category.dart';
import 'package:flutter_design_patterns/pages/category/widgets/design_pattern_card.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_back_button.dart';

class CategoryPage extends StatefulWidget {
  static const String route = '/category';

  final DesignPatternCategory category;

  const CategoryPage({
    @required this.category,
    Key key,
  })  : assert(category != null),
        super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  final double _preferredAppBarHeight = 56.0;

  AnimationController _fadeSlideAnimationController;
  ScrollController _scrollController;
  double _appBarElevation = 0.0;
  double _appBarTitleOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _fadeSlideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _appBarElevation =
              _scrollController.offset > _scrollController.initialScrollOffset
                  ? 4.0
                  : 0.0;
          _appBarTitleOpacity = _scrollController.offset >
                  _scrollController.initialScrollOffset +
                      _preferredAppBarHeight / 2
              ? 1.0
              : 0.0;
        });
      });
  }

  @override
  void dispose() {
    _fadeSlideAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(widget.category.color),
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _appBarTitleOpacity,
          duration: const Duration(milliseconds: 250),
          child: Text(widget.category.title),
        ),
        backgroundColor: Color(widget.category.color),
        elevation: _appBarElevation,
        leading: const PlatformBackButton(
          color: Colors.white,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(
            paddingL,
            paddingZero,
            paddingL,
            paddingL,
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.category.title,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 32.0,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: spaceL),
              for (var i = 0; i < widget.category.patterns.length; i++)
                Container(
                  margin: const EdgeInsets.only(top: marginL),
                  child: DesignPatternCard(
                    designPattern: widget.category.patterns[i],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
