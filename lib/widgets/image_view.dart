import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../themes.dart';
import 'platform_specific/platform_back_button.dart';

class ImageView extends StatefulWidget {
  const ImageView({required this.uri, super.key});

  final Uri uri;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late Animation<Matrix4>? _animationReset;
  late AnimationController _controllerReset;
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
    _controller.value = _animationReset!.value;
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
  void _onTapDown(TapDownDetails details) {
    if (_tapPosition != Offset.zero &&
        (details.globalPosition.dx - _tapPosition.dx < 20 &&
            details.globalPosition.dy - _tapPosition.dy < 20)) {
    } else {
      _tapPosition = details.globalPosition;
    }
    Timer(const Duration(milliseconds: 500), () {
      _tapPosition = Offset.zero;
    });
  }

  void _animateScaleIn() {
    final offset = Offset(
      -MediaQuery.of(context).size.width / 4,
      -MediaQuery.of(context).size.height / 4,
    );
    _animateResetInitialize(
      _controller.value.clone()
        ..scale(2.5)
        ..translate(offset.dx, offset.dy),
    );
  }

  void _animateScaleOut() {
    _animateResetInitialize(Matrix4.identity());
  }

  void _animateResetInitialize(Matrix4 end) {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _controller.value,
      end: end,
    ).animate(_controllerReset);
    _animationReset?.addListener(_onAnimateReset);
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
        leading: const PlatformBackButton(color: Colors.black),
      ),
      body: GestureDetector(
        onTap: context.pop,
        child: InteractiveViewer(
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
                child: Image.asset(widget.uri.path),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
