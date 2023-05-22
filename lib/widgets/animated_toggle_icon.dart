import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedToggleIcon<T> extends StatelessWidget {
  const AnimatedToggleIcon({
    super.key = const ValueKey('AnimatedToggleIcon'),
    this.duration = const Duration(milliseconds: 250),
    required this.child,
    required this.action,
    required this.state,
  });
  final Duration duration;
  final Widget Function(T state) child;
  final T Function(WidgetRef ref) state;
  final void Function(T state, WidgetRef ref) action;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return IconButton(
          splashRadius: 20.0,
          iconSize: 20,
          onPressed: () => action(state(ref), ref),
          icon: AnimatedSwitcher(
            duration: duration,
            child: SizedBox(
              key: ValueKey(state(ref)),
              child: this.child(state(ref)),
            ),
            transitionBuilder: (child, animation) {
              return RotationTransition(
                turns: child.key == this.child(state(ref)).key
                    ? Tween<double>(begin: animation.value, end: 0)
                        .animate(animation)
                    : Tween<double>(begin: animation.value, end: 1)
                        .animate(animation),
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
