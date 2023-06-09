import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageView extends StatefulWidget {
  const ImageView({
    required this.uri,
    super.key,
  });

  final Uri uri;

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  late Animation<Matrix4>? _animationReset;
  late AnimationController _controllerReset;

  var _tapPosition = Offset.zero;

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

  // little hack as there is no way to get onTapDown triggered
  // when onDoubleTap is registered
  // track issue: (https://github.com/flutter/flutter/issues/10048)
  void _onTapDown(TapDownDetails details) {
    if (_tapPosition == Offset.zero &&
        !(details.globalPosition.dx - _tapPosition.dx < 20 &&
            details.globalPosition.dy - _tapPosition.dy < 20)) {
      _tapPosition = details.globalPosition;
    }

    Timer(const Duration(milliseconds: 500), () => _tapPosition = Offset.zero);
  }

  void _onDoubleTap() => _controller.value == Matrix4.identity()
      ? _animateScaleIn()
      : _animateScaleOut();

  void _animateScaleIn() {
    final size = MediaQuery.of(context).size;
    final offset = Offset(-size.width / 4, -size.height / 4);

    _animateResetInitialize(
      _controller.value.clone()
        ..scale(2.5)
        ..translate(offset.dx, offset.dy),
    );
  }

  void _animateScaleOut() => _animateResetInitialize(Matrix4.identity());

  void _animateResetInitialize(Matrix4 end) {
    _controllerReset.reset();
    _animationReset = Matrix4Tween(
      begin: _controller.value,
      end: end,
    ).animate(_controllerReset);

    _animationReset?.addListener(_onAnimateReset);
    _controllerReset.forward();
  }

  void _resetAndRemoveListener() {
    _animationReset?.removeListener(_onAnimateReset);
    _animationReset = null;
    _controllerReset.reset();
  }

  void _onAnimateReset() {
    _controller.value = _animationReset!.value;

    if (_controllerReset.isAnimating) return;

    _resetAndRemoveListener();
  }

  /// If the user tries to cause a transformation while the reset animation is
  /// running, cancel the reset animation.
  void _onInteractionStart(ScaleStartDetails details) {
    if (_controllerReset.status != AnimationStatus.forward) return;

    _animateResetStop();
  }

  void _animateResetStop() {
    _controllerReset.stop();

    _resetAndRemoveListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: const CloseButton(color: Colors.black),
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
