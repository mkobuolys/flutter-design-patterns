// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_pattern_categories_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$designPatternCategoriesRepositoryHash() =>
    r'8559a7606a5389938e681acc834e06c7232d95a6';

/// See also [designPatternCategoriesRepository].
final designPatternCategoriesRepositoryProvider =
    AutoDisposeProvider<DesignPatternCategoriesRepository>(
  designPatternCategoriesRepository,
  name: r'designPatternCategoriesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designPatternCategoriesRepositoryHash,
);
typedef DesignPatternCategoriesRepositoryRef
    = AutoDisposeProviderRef<DesignPatternCategoriesRepository>;
String _$designPatternCategoriesHash() =>
    r'7e5ef69bc420e15f5241981f102ee7afd974ab6e';

/// See also [designPatternCategories].
final designPatternCategoriesProvider =
    AutoDisposeFutureProvider<List<DesignPatternCategory>>(
  designPatternCategories,
  name: r'designPatternCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$designPatternCategoriesHash,
);
typedef DesignPatternCategoriesRef
    = AutoDisposeFutureProviderRef<List<DesignPatternCategory>>;
String _$designPatternHash() => r'80372c1c21e1e99f398455df68519f3943028830';

/// See also [designPattern].
class DesignPatternProvider extends AutoDisposeFutureProvider<DesignPattern> {
  DesignPatternProvider(
    this.id,
  ) : super(
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

typedef DesignPatternRef = AutoDisposeFutureProviderRef<DesignPattern>;

/// See also [designPattern].
final designPatternProvider = DesignPatternFamily();

class DesignPatternFamily extends Family<AsyncValue<DesignPattern>> {
  DesignPatternFamily();

  DesignPatternProvider call(
    String id,
  ) {
    return DesignPatternProvider(
      id,
    );
  }

  @override
  AutoDisposeFutureProvider<DesignPattern> getProviderOverride(
    covariant DesignPatternProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'designPatternProvider';
}
