import 'package:flutter/material.dart';

class HeartbeatAnimation extends StatefulWidget {
  final Widget child;

  const HeartbeatAnimation({
    required this.child,
  });

  @override
  _HeartbeatAnimationState createState() => _HeartbeatAnimationState();
}

class _HeartbeatAnimationState extends State<HeartbeatAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: _HearbeatCurve()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}

class _HearbeatCurve extends Curve {
  final double _multiplier = 5.0;

  @override
  double transformInternal(double t) {
    if (t > 0.0 && t < 0.25) {
      return t * _multiplier;
    } else if (t >= 0.25 && t < 0.45) {
      return 1.0 - ((t - 0.25) * _multiplier);
    } else if (t >= 0.45 && t < 0.5) {
      return 0.0;
    } else if (t >= 0.5 && t < 0.75) {
      return (t - 0.5) * _multiplier / 2;
    } else if (t >= 0.75 && t < 0.95) {
      return 0.5 - ((t - 0.75) * _multiplier / 2);
    } else {
      return 0.0;
    }
  }
}
