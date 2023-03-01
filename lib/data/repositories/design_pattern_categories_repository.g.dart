// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_pattern_categories_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$designPatternCategoriesRepositoryHash() =>
    r'8559a7606a5389938e681acc834e06c7232d95a6';

/// See also [designPatternCategoriesRepository].
@ProviderFor(designPatternCategoriesRepository)
final designPatternCategoriesRepositoryProvider =
    AutoDisposeProvider<DesignPatternCategoriesRepository>.internal(
  designPatternCategoriesRepository,
  name: r'designPatternCategoriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designPatternCategoriesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DesignPatternCategoriesRepositoryRef
    = AutoDisposeProviderRef<DesignPatternCategoriesRepository>;
String _$designPatternCategoriesHash() =>
    r'7e5ef69bc420e15f5241981f102ee7afd974ab6e';

/// See also [designPatternCategories].
@ProviderFor(designPatternCategories)
final designPatternCategoriesProvider =
    AutoDisposeFutureProvider<List<DesignPatternCategory>>.internal(
  designPatternCategories,
  name: r'designPatternCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designPatternCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DesignPatternCategoriesRef
    = AutoDisposeFutureProviderRef<List<DesignPatternCategory>>;
String _$designPatternHash() => r'80372c1c21e1e99f398455df68519f3943028830';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef DesignPatternRef = AutoDisposeFutureProviderRef<DesignPattern>;

/// See also [designPattern].
@ProviderFor(designPattern)
const designPatternProvider = DesignPatternFamily();

/// See also [designPattern].
class DesignPatternFamily extends Family<AsyncValue<DesignPattern>> {
  /// See also [designPattern].
  const DesignPatternFamily();

  /// See also [designPattern].
  DesignPatternProvider call(
    String id,
  ) {
    return DesignPatternProvider(
      id,
    );
  }

  @override
  DesignPatternProvider getProviderOverride(
    covariant DesignPatternProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'designPatternProvider';
}

/// See also [designPattern].
class DesignPatternProvider extends AutoDisposeFutureProvider<DesignPattern> {
  /// See also [designPattern].
  DesignPatternProvider(
    this.id,
  ) : super.internal(
          (ref) => designPattern(
            ref,
            id,
          ),
          from: designPatternProvider,
          name: r'designPatternProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$designPatternHash,
          dependencies: DesignPatternFamily._dependencies,
          allTransitiveDependencies:
              DesignPatternFamily._allTransitiveDependencies,
        );

  final String id;

  @override
  bool operator ==(Object other) {
    return other is DesignPatternProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
