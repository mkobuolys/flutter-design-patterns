// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(markdownRepository)
final markdownRepositoryProvider = MarkdownRepositoryProvider._();

final class MarkdownRepositoryProvider
    extends $FunctionalProvider<MarkdownRepository, MarkdownRepository, MarkdownRepository>
    with $Provider<MarkdownRepository> {
  MarkdownRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'markdownRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markdownRepositoryHash();

  @$internal
  @override
  $ProviderElement<MarkdownRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  MarkdownRepository create(Ref ref) {
    return markdownRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MarkdownRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<MarkdownRepository>(value));
  }
}

String _$markdownRepositoryHash() => r'99c276646d289a596d3df35524c722ddc029028b';

@ProviderFor(markdown)
final markdownProvider = MarkdownFamily._();

final class MarkdownProvider extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  MarkdownProvider._({required MarkdownFamily super.from, required String super.argument})
    : super(
        retry: null,
        name: r'markdownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$markdownHash();

  @override
  String toString() {
    return r'markdownProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return markdown(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkdownProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$markdownHash() => r'2796d0b1e0771c1c7d491f96d27d3e2681d75100';

final class MarkdownFamily extends $Family with $FunctionalFamilyOverride<FutureOr<String>, String> {
  MarkdownFamily._()
    : super(
        retry: null,
        name: r'markdownProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MarkdownProvider call(String id) => MarkdownProvider._(argument: id, from: this);

  @override
  String toString() => r'markdownProvider';
}
