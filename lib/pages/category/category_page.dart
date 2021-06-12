import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../data/models/design_pattern_category.dart';
import '../../widgets/platform_specific/platform_back_button.dart';
import 'widgets/design_pattern_card.dart';

class CategoryPage extends StatefulWidget {
  static const String route = '/category';

  final DesignPatternCategory category;

  const CategoryPage({
    required this.category,
  });

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeSlideAnimationController;
  late final ScrollController _scrollController;

  var _appBarElevation = 0.0;

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
        title: Text(widget.category.title),
        backgroundColor: Color(widget.category.color),
        elevation: _appBarElevation,
        leading: const PlatformBackButton(
          color: Colors.white,
        ),
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(
            LayoutConstants.paddingL,
            LayoutConstants.paddingZero,
            LayoutConstants.paddingL,
            LayoutConstants.paddingXL,
          ),
          itemBuilder: (_, i) => Container(
            margin: const EdgeInsets.only(top: LayoutConstants.marginL),
            child: DesignPatternCard(
              designPattern: widget.category.patterns[i],
            ),
          ),
          itemCount: widget.category.patterns.length,
        ),
      ),
    );
  }
}
