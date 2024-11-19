// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$topicContentHash() => r'01db9071dad420fab08b4d2af8031a52f25e1922';

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

/// See also [topicContent].
@ProviderFor(topicContent)
const topicContentProvider = TopicContentFamily();

/// See also [topicContent].
class TopicContentFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [topicContent].
  const TopicContentFamily();

  /// See also [topicContent].
  TopicContentProvider call(
    String category,
  ) {
    return TopicContentProvider(
      category,
    );
  }

  @override
  TopicContentProvider getProviderOverride(
    covariant TopicContentProvider provider,
  ) {
    return call(
      provider.category,
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
  String? get name => r'topicContentProvider';
}

/// See also [topicContent].
class TopicContentProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [topicContent].
  TopicContentProvider(
    String category,
  ) : this._internal(
          (ref) => topicContent(
            ref as TopicContentRef,
            category,
          ),
          from: topicContentProvider,
          name: r'topicContentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$topicContentHash,
          dependencies: TopicContentFamily._dependencies,
          allTransitiveDependencies:
              TopicContentFamily._allTransitiveDependencies,
          category: category,
        );

  TopicContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(TopicContentRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TopicContentProvider._internal(
        (ref) => create(ref as TopicContentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _TopicContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TopicContentProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TopicContentRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _TopicContentProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with TopicContentRef {
  _TopicContentProviderElement(super.provider);

  @override
  String get category => (origin as TopicContentProvider).category;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
