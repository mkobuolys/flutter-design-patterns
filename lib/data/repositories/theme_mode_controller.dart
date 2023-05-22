import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../helpers/enum_extension.dart';
import 'storage_controller.dart';

abstract class ThemeModeBase extends AutoDisposeNotifier<ThemeMode> {
  /// ### the implementation of `ThemeModeCtrl` provider
  static final provider = AutoDisposeNotifierProvider<ThemeModeBase, ThemeMode>(
    name: ThemeModeBase.key,
    _ThemeModeCtrl.new,
  );

  /// ### `ThemeModeBase` key for storage and provider name
  static const key = 'themeModeProvider';

  /// ### the initial value for `ThemeModeBase` if exists in storage
  @override
  ThemeMode build();

  /// ### set light theme mode and save to storage
  void setLight();

  /// ### set dark theme mode and save to storage
  void setDark();

  /// ### set system theme mode and save to storage
  void setSystem();

  /// ### check if the current theme mode is dark or not
  bool get isDark;
}

class _ThemeModeCtrl extends ThemeModeBase {
  @override
  ThemeMode build() {
    final value = StorageBase.provider.read(ThemeModeBase.key);
    return value != null ? value.toEnum(ThemeMode.values) : ThemeMode.system;
  }

  @override
  void setLight() {
    StorageBase.provider.write(ThemeModeBase.key, ThemeMode.light.name);
    state = ThemeMode.light;
  }

  @override
  void setDark() {
    StorageBase.provider.write(ThemeModeBase.key, ThemeMode.dark.name);
    state = ThemeMode.dark;
  }

  @override
  void setSystem() {
    StorageBase.provider.write(ThemeModeBase.key, ThemeMode.system.name);
    state = ThemeMode.system;
  }

  @override
  bool get isDark => state == ThemeMode.dark;
}
