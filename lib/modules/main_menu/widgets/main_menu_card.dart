import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';
import '../../../../data/models/design_pattern.dart';
import '../../../../data/models/design_pattern_category.dart';
import '../../../helpers/helpers.dart';
import '../../../navigation/router.dart';

class MainMenuCard extends StatelessWidget {
  const MainMenuCard({
    required this.category,
    required this.isDesktop,
  });

  final DesignPatternCategory category;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.zero,
      color: Color(category.color),
      elevation: 8.0,
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: isDesktop
            ? _CategoryPatternsScrollableView(category: category)
            : _CategoryPatternsExpandableView(category: category),
      ),
    );
  }
}

class _CategoryPatternsScrollableView extends StatelessWidget {
  const _CategoryPatternsScrollableView({
    required this.category,
  });

  final DesignPatternCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingL,
            vertical: LayoutConstants.paddingM,
          ),
          child: _CategoryTitle(
            title: category.title,
            itemsCount: category.patterns.length,
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return _DesignPatternTile(
                designPattern: category.patterns[index],
              );
            },
            itemCount: category.patterns.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: LayoutConstants.spaceXS);
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryPatternsExpandableView extends StatelessWidget {
  const _CategoryPatternsExpandableView({
    required this.category,
  });

  final DesignPatternCategory category;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(
        horizontal: LayoutConstants.paddingL,
        vertical: LayoutConstants.paddingM,
      ),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      title: _CategoryTitle(
        title: category.title,
        itemsCount: category.patterns.length,
      ),
      children: category.patterns
          .map<Widget>(
            (designPattern) => _DesignPatternTile(designPattern: designPattern),
          )
          .toList()
          .addBetween(const SizedBox(height: LayoutConstants.spaceXS)),
    );
  }
}

class _CategoryTitle extends StatelessWidget {
  const _CategoryTitle({
    required this.title,
    required this.itemsCount,
  });

  final String title;
  final int itemsCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 26.0,
                color: Colors.white,
              ),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: LayoutConstants.spaceL),
        Text(
          itemsCount == 1 ? '$itemsCount pattern' : '$itemsCount patterns',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}

class _DesignPatternTile extends StatelessWidget {
  const _DesignPatternTile({
    required this.designPattern,
  });

  final DesignPattern designPattern;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => DesignPatternDetailsRoute(designPattern.id).go(context),
        child: Padding(
          padding: const EdgeInsets.only(
            top: LayoutConstants.paddingM,
            left: LayoutConstants.paddingL,
            right: LayoutConstants.paddingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                designPattern.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: LayoutConstants.spaceM),
              Text(
                designPattern.description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: LayoutConstants.spaceM),
            ],
          ),
        ),
      ),
    );
  }
}
