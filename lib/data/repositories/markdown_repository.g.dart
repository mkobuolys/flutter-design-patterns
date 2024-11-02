// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$markdownRepositoryHash() =>
    r'96c291a6f43aeeed5e97a22959991d4137c10138';

/// See also [markdownRepository].
@ProviderFor(markdownRepository)
final markdownRepositoryProvider =
    AutoDisposeProvider<MarkdownRepository>.internal(
  markdownRepository,
  name: r'markdownRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$markdownRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MarkdownRepositoryRef = AutoDisposeProviderRef<MarkdownRepository>;
String _$markdownHash() => r'2796d0b1e0771c1c7d491f96d27d3e2681d75100';

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

/// See also [markdown].
@ProviderFor(markdown)
const markdownProvider = MarkdownFamily();

/// See also [markdown].
class MarkdownFamily extends Family<AsyncValue<String>> {
  /// See also [markdown].
  const MarkdownFamily();

  /// See also [markdown].
  MarkdownProvider call(
    String id,
  ) {
    return MarkdownProvider(
      id,
    );
  }

  @override
  MarkdownProvider getProviderOverride(
    covariant MarkdownProvider provider,
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
  String? get name => r'markdownProvider';
}

/// See also [markdown].
class MarkdownProvider extends AutoDisposeFutureProvider<String> {
  /// See also [markdown].
  MarkdownProvider(
    String id,
  ) : this._internal(
          (ref) => markdown(
            ref as MarkdownRef,
            id,
          ),
          from: markdownProvider,
          name: r'markdownProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$markdownHash,
          dependencies: MarkdownFamily._dependencies,
          allTransitiveDependencies: MarkdownFamily._allTransitiveDependencies,
          id: id,
        );

  MarkdownProvider._internal(
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
    FutureOr<String> Function(MarkdownRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MarkdownProvider._internal(
        (ref) => create(ref as MarkdownRef),
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
  AutoDisposeFutureProviderElement<String> createElement() {
    return _MarkdownProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkdownProvider && other.id == id;
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
mixin MarkdownRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `id` of this provider.
  String get id;
}

class _MarkdownProviderElement extends AutoDisposeFutureProviderElement<String>
    with MarkdownRef {
  _MarkdownProviderElement(super.provider);

  @override
  String get id => (origin as MarkdownProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
