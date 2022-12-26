// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_repository.dart';

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

String _$markdownRepositoryHash() =>
    r'96c291a6f43aeeed5e97a22959991d4137c10138';

/// See also [markdownRepository].
final markdownRepositoryProvider = AutoDisposeProvider<MarkdownRepository>(
  markdownRepository,
  name: r'markdownRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$markdownRepositoryHash,
);
typedef MarkdownRepositoryRef = AutoDisposeProviderRef<MarkdownRepository>;
String _$markdownHash() => r'805f6990bbb5c342a781a60e6f758dcdf7b09ac1';

/// See also [markdown].
class MarkdownProvider extends AutoDisposeFutureProvider<String> {
  MarkdownProvider(
    this.id,
  ) : super(
          (ref) => markdown(
            ref,
            id,
          ),
          from: markdownProvider,
          name: r'markdownProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$markdownHash,
        );

  final String id;

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

typedef MarkdownRef = AutoDisposeFutureProviderRef<String>;

/// See also [markdown].
final markdownProvider = MarkdownFamily();

class MarkdownFamily extends Family<AsyncValue<String>> {
  MarkdownFamily();

  MarkdownProvider call(
    String id,
  ) {
    return MarkdownProvider(
      id,
    );
  }

  @override
  AutoDisposeFutureProvider<String> getProviderOverride(
    covariant MarkdownProvider provider,
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
  String? get name => r'markdownProvider';
}
