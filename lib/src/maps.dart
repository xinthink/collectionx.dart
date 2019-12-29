import 'package:tuple/tuple.dart';

import 'iterables.dart';

export 'types.dart';

part 'map_factories.dart';

/// Extensions to [Map]s
extension MapExt<K, V> on Map<K, V> {
  /// Returns `true` if at least one entry matches the given predicate [test].
  bool any(EntryPredicate<K, V> test) => entries.any((e) => test(e.key, e.value));

  /// Returns `true` if all entries match the given predicate [test].
  bool all(EntryPredicate<K, V> test) => entries.all((e) => test(e.key, e.value));

  /// Returns `true` if **no** entries match the given predicate [test].
  bool none(EntryPredicate<K, V> test) => entries.none((e) => test(e.key, e.value));

  /// Returns a new lazy [Iterable] with all entries that satisfy the predicate [test],
  /// providing sequential index of the element.
  Iterable<MapEntry<K, V>> where(EntryPredicate<K, V> test) =>
    entries.where((e) => test(e.key, e.value));

  /// Returns a new lazy [Iterable] with all entries that do **NOT** satisfy the predicate [test].
  Iterable<MapEntry<K, V>> whereNot(EntryPredicate<K, V> test) =>
    where((k, v) => !test(k, v));

  /// Transforms each entry to object of type [T], by applying the transformer [f].
  Iterable<T> mapEntries<T>(EntryTransform<K, V, T> f) =>
    entries.map((e) => f(e.key, e.value));

  /// Transforms entries to objects of type [T] with the transformer [f],
  /// and appends the result to the given [destination].
  List<T> mapToList<T>(List<T> destination, EntryTransform<K, V, T> f) {
    mapEntries(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Transforms entries to objects of type [T] with the transformer [f],
  /// and appends the result to the given [destination].
  Set<T> mapToSet<T>(Set<T> destination, EntryTransform<K, V, T> f) {
    mapEntries(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Return a new lazy [Iterable] of all elements yielded from results of transform [f] function
  /// being invoked on each element of original entries.
  Iterable<T> flatMap<T>(EntryTransform<K, V, Iterable<T>> f) =>
    entries.flatMap((e) => f(e.key, e.value));

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original entries.
  List<T> flatMapToList<T>(List<T> destination, EntryTransform<K, V, Iterable<T>> f) {
    flatMap(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original entries.
  Set<T> flatMapToSet<T>(Set<T> destination, EntryTransform<K, V, Iterable<T>> f) {
    flatMap(f).forEach((e) => destination.add(e));
    return destination;
  }
}
