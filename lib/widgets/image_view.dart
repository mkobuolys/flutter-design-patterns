import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_back_button.dart';

class ImageView extends StatefulWidget {
  final Uri uri;

  const ImageView({
    Key key,
    @required this.uri,
  }) : super(key: key);

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  TransformationController _controller;
  Animation<Matrix4> _animationReset;
  AnimationController _controllerReset;
  Offset _tapPosition = Offset.zero;

  bool get isInitial => _controller.value == Matrix4.identity();

  @override
  void initState() {
    super.initState();
    _controllerReset = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controller = TransformationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerReset.dispose();
    super.dispose();
  }

  void _onAnimateReset() {
    _controller.value = _animationReset.value;
    if (!_controllerReset.isAnimating) {
      _animationReset?.removeListener(_onAnimateReset);
      _animationReset = null;
      _controllerReset.reset();
    }
  }

  void _onDoubleTap() {
    if (isInitial) {
      _animateScaleIn();
    } else {
      _animateScaleOut();
    }
  }

  // little hack as there is no way to get onTapDown triggered
  // when onDoubleTap is registered
  // track issue: (https://github.com/flutter/flutter/issues/10048)
  //
  // unfortunetaly this solution doesn't work too
  // possible solution is to use positioned_tap_detector(https://pub.dev/packages/positioned_tap_detector)
  // but it is DISCONTINUED
  void _onTapDown(TapDownDetails details) {
    if (_tapPosition != Offset.zero &&
        (details.globalPosition.dx - _tapPosition.dx < 20 &&
            details.globalPosition.dy - _tapPosition.dy < 20)) {
    } else {
      _tapPosition = details.globalPosition;
    }
    Timer(Duration(milliseconds: 500), () {
      _tapPosition = Offset.zero;
    });
  }

  void _animateScaleIn() {
    var offset = Offset(-MediaQuery.of(context).size.width / 4,
        -MediaQuery.of(context).size.height / 4);
    _animateResetInitialize(_controller.value.clone()
      ..scale(2.5)
      ..translate(offset.dx, offset.dy));
  }

  void _animateScaleOut() {
    _animateResetInitialize(Matrix4.identity());
  }

  void _animateResetInitialize(end) {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _controller.value,
      end: end,
    ).animate(_controllerReset);
    _animationReset.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  void _animateResetStop() {
    _controllerReset.stop();
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }

  void _onInteractionStart(ScaleStartDetails details) {
    // If the user tries to cause a transformation while the reset animation is
    // running, cancel the reset animation.
    if (_controllerReset.status == AnimationStatus.forward) {
      _animateResetStop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: lightBackgroundColor,
        leading: PlatformBackButton(
          color: Colors.black,
        ),
      ),
      body: InteractiveViewer(
        onInteractionStart: _onInteractionStart,
        transformationController: _controller,
        minScale: 0.7,
        maxScale: 3,
        child: Center(
          child: GestureDetector(
            onTapDown: _onTapDown,
            onDoubleTap: _onDoubleTap,
            child: Hero(
              tag: widget.uri,
              child: Image.asset(
                widget.uri.path,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
