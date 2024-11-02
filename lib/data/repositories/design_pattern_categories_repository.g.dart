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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DesignPatternCategoriesRepositoryRef
    = AutoDisposeProviderRef<DesignPatternCategoriesRepository>;
String _$designPatternCategoriesHash() =>
    r'64eb21aa9b8a453d7935dc056ac5b831acd68963';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DesignPatternCategoriesRef
    = AutoDisposeFutureProviderRef<List<DesignPatternCategory>>;
String _$designPatternHash() => r'6850de04d434e12ead1948cca345849187431451';

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
    String id,
  ) : this._internal(
          (ref) => designPattern(
            ref as DesignPatternRef,
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
          id: id,
        );

  DesignPatternProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<DesignPattern> Function(DesignPatternRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DesignPatternProvider._internal(
        (ref) => create(ref as DesignPatternRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DesignPattern> createElement() {
    return _DesignPatternProviderElement(this);
  }

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DesignPatternRef on AutoDisposeFutureProviderRef<DesignPattern> {
  /// The parameter `id` of this provider.
  String get id;
}

class _DesignPatternProviderElement
    extends AutoDisposeFutureProviderElement<DesignPattern>
    with DesignPatternRef {
  _DesignPatternProviderElement(super.provider);

  @override
  String get id => (origin as DesignPatternProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
