// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'design_pattern_categories_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(designPatternCategoriesRepository)
final designPatternCategoriesRepositoryProvider = DesignPatternCategoriesRepositoryProvider._();

final class DesignPatternCategoriesRepositoryProvider
    extends
        $FunctionalProvider<
          DesignPatternCategoriesRepository,
          DesignPatternCategoriesRepository,
          DesignPatternCategoriesRepository
        >
    with $Provider<DesignPatternCategoriesRepository> {
  DesignPatternCategoriesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'designPatternCategoriesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$designPatternCategoriesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DesignPatternCategoriesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DesignPatternCategoriesRepository create(Ref ref) {
    return designPatternCategoriesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DesignPatternCategoriesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DesignPatternCategoriesRepository>(value),
    );
  }
}

String _$designPatternCategoriesRepositoryHash() => r'551eabf96adbc84871ba6b4ac1212c1fa4bf6c86';

@ProviderFor(designPatternCategories)
final designPatternCategoriesProvider = DesignPatternCategoriesProvider._();

final class DesignPatternCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DesignPatternCategory>>,
          List<DesignPatternCategory>,
          FutureOr<List<DesignPatternCategory>>
        >
    with $FutureModifier<List<DesignPatternCategory>>, $FutureProvider<List<DesignPatternCategory>> {
  DesignPatternCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'designPatternCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$designPatternCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<DesignPatternCategory>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<DesignPatternCategory>> create(Ref ref) {
    return designPatternCategories(ref);
  }
}

String _$designPatternCategoriesHash() => r'64eb21aa9b8a453d7935dc056ac5b831acd68963';

@ProviderFor(designPattern)
final designPatternProvider = DesignPatternFamily._();

final class DesignPatternProvider
    extends $FunctionalProvider<AsyncValue<DesignPattern>, DesignPattern, FutureOr<DesignPattern>>
    with $FutureModifier<DesignPattern>, $FutureProvider<DesignPattern> {
  DesignPatternProvider._({required DesignPatternFamily super.from, required String super.argument})
    : super(
        retry: null,
        name: r'designPatternProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$designPatternHash();

  @override
  String toString() {
    return r'designPatternProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<DesignPattern> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<DesignPattern> create(Ref ref) {
    final argument = this.argument as String;
    return designPattern(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is DesignPatternProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$designPatternHash() => r'6850de04d434e12ead1948cca345849187431451';

final class DesignPatternFamily extends $Family with $FunctionalFamilyOverride<FutureOr<DesignPattern>, String> {
  DesignPatternFamily._()
    : super(
        retry: null,
        name: r'designPatternProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DesignPatternProvider call(String id) => DesignPatternProvider._(argument: id, from: this);

  @override
  String toString() => r'designPatternProvider';
}
