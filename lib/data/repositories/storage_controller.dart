import 'package:shared_preferences/shared_preferences.dart';

/// ## the base class for all storage actions and provider
abstract interface class StorageBase<T> {
  /// ### Assigning `Storage().instance` IS A MUST otherwise it will throw an error
  static final StorageBase<SharedPreferences> provider = Storage();

  /// ### where the external 3rd party storage instance is assigned
  late final T instance;

  /// ### Read value from storage
  String? read(String key);

  /// ### Delete value from storage
  Future<bool> delete(String key);

  /// ### Write value to storage
  Future<bool> write(String key, String value);

  /// ### Clear all values from storage
  Future<bool> clear();

  /// ### Check if key exists in storage
  bool containsKey(String key);
}

base class Storage implements StorageBase<SharedPreferences> {
  @override
  String? read(String key) => instance.getString(key);

  @override
  Future<bool> delete(String key) async => instance.remove(key);

  @override
  Future<bool> write(String key, String value) async =>
      instance.setString(key, value);

  @override
  Future<bool> clear() async => instance.clear();

  @override
  bool containsKey(String key) => instance.containsKey(key);

  @override
  late final SharedPreferences instance;
}
