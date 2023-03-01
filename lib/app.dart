import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation/router.dart';
import 'themes.dart';

class App extends ConsumerWidget {
  const App();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Design Patterns',
      routerConfig: router,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
