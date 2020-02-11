import 'package:tuple/tuple.dart';
import 'dart:math' as math;

import 'num_functions.dart';
import 'types.dart';

part 'num_iterables.dart';
part '_internal/_chunked_iterable.dart';
part '_internal/_mapped_iterable.dart';
part '_internal/_where_iterable.dart';

/// Extensions to [Iterable]s
extension IterableExt<E> on Iterable<E> {
  /// Returns a new lazy [Iterable] with all `non-null` elements.
  ///
  /// See [Iterable.where]
  Iterable<E> get nonNull => where((e) => e != null);

  /// Creates a fixed-length [List] containing the elements of this [Iterable],
  /// equivalent to `toList(growable: false)`.
  ///
  /// See [Iterable.toList]
  List<E> asList() => toList(growable: false);

  /// Returns `true` if all elements match the given predicate [test].
  bool all(Predicate<E> test) {
    for (var element in this) {
      if (!test(element)) return false;
    }
    return true;
  }

  /// Returns `true` if **no** elements match the given predicate [test].
  bool none(Predicate<E> test) {
    for (var element in this) {
      if (test(element)) return false;
    }
    return true;
  }

  /// Returns a new lazy [Iterable] with all elements that satisfy the predicate [test],
  /// providing sequential index of the element.
  Iterable<E> whereIndexed(IndexedPredicate<E> test) => _IndexedWhereIterable(this, test);

  /// Returns a new lazy [Iterable] with all elements that does **NOT** satisfy the predicate [test].
  Iterable<E> whereNot(Predicate<E> test) => where((e) => !test(e));

  /// Returns a new lazy [Iterable] with all elements that does **NOT** satisfy the predicate [test],
  /// providing sequential index of the element.
  Iterable<E> whereNotIndexed(IndexedPredicate<E> test) => whereIndexed((i, e) => !test(i, e));

  /// Applies the action [f] on each element, providing sequential index of the element.
  void forEachIndexed(IndexedAction<E> f) {
    var i = 0;
    forEach((e) => f(i++, e));
  }

  /// Accumulates a collection to a single value of type [S], which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f], providing sequential index of the element.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 5, 8].foldIndexed(0, (i, acc, x) => acc + (i % 2 * x)) // => 0 + 0 + 2 + 0 + 8 => 10
  /// ```
  S foldIndexed<S>(S initial, IndexedAccumulate<S, E> f) {
    var i = 0;
    return fold(initial, (acc, e) => f(i++, acc, e));
  }

  /// Accumulates a collection to a single value of type [S], which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f] in a reversed order.
  ///
  /// Please notice that the arguments' order of the combinator [f] is `(element, acc)`,
  /// which is **reversed** to the one for `fold`. For example:
  ///
  /// ```dart
  /// [1, 2, 3, 4].foldRight(0, (x, acc) => x - acc) // => (1 - (2 - (3 - (4 - 0)))) => -2
  /// ```
  ///
  /// **Caution**: to reverse an [Iterable] may cause performance issue, see [sdk#26928](https://is.gd/lXPlJI)
  ///
  /// See also: [List.reversed]
  S foldRight<S>(S initial, ReversedAccumulate<S, E> f) {
    var acc = initial;
    asList().reversed.forEach((e) {
      acc = f(e, acc);
    });
    return acc;
  }

  /// Accumulates a collection to a single value, which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f] in a reversed order, providing sequential index of the element.
  ///
  /// It's the index-aware version of [foldRight()].
  /// **Caution**: to reverse an [Iterable] may cause performance issue, see [sdk#26928](https://is.gd/lXPlJI)
  S foldRightIndexed<S>(S initial, IndexedReversedAccumulate<S, E> f) {
    final list = asList();
    var acc = initial;
    for (var i = list.length - 1; i >= 0; i--) {
      acc = f(i, list[i], acc);
    }
    return acc;
  }

  /// Transforms each element to another object of type [T], by applying the transformer [f],
  /// providing sequential index of the element.
  Iterable<T> mapIndexed<T>(IndexedTransform<E, T> f) => _IndexedMappedIterable(this, f);

  /// Transforms elements to objects of type [T] with the transformer [f],
  /// and appends the result to the given [destination].
  List<T> mapToList<T>(List<T> destination, Transform<E, T> f) {
    map(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Transforms elements to objects of type [T] with the transformer [f],
  /// providing sequential index of the element, and appends the result to the given [destination].
  List<T> mapToListIndexed<T>(List<T> destination, IndexedTransform<E, T> f) {
    mapIndexed(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Transforms elements to objects of type [T] with the transformer [f],
  /// and appends the result to the given [destination].
  Set<T> mapToSet<T>(Set<T> destination, Transform<E, T> f) {
    map(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Transforms elements to objects of type [T] with the transformer [f],
  /// providing sequential index of the element, and appends the result to the given [destination].
  Set<T> mapToSetIndexed<T>(Set<T> destination, IndexedTransform<E, T> f) {
    mapIndexed(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Return a new lazy [Iterable] of all elements yielded from results of transform [f] function
  /// being invoked on each element of original collection.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].flatMap((n) => [n, n]) // => [1, 1, 2, 2, 3, 3]
  /// ```
  Iterable<T> flatMap<T>(Transform<E, Iterable<T>> f) => _FlatMappedIterable(map(f));

  /// Return a new lazy [Iterable] of all elements yielded from results of transform [f] function
  /// being invoked on each element of original collection, providing sequential index of each element.
  ///
  /// It's the index-aware version of [flatMap()].
  Iterable<T> flatMapIndexed<T>(IndexedTransform<E, Iterable<T>> f) =>
      _FlatMappedIterable(mapIndexed(f));

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original collection.
  List<T> flatMapToList<T>(List<T> destination, Transform<E, Iterable<T>> f) {
    flatMap(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original collection, providing sequential index of each element.
  List<T> flatMapToListIndexed<T>(List<T> destination, IndexedTransform<E, Iterable<T>> f) {
    flatMapIndexed(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original collection.
  Set<T> flatMapToSet<T>(Set<T> destination, Transform<E, Iterable<T>> f) {
    flatMap(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Appends to the give [destination] with the elements yielded from results of transform [f] function
  /// being invoked on each element of original collection, providing sequential index of each element.
  Set<T> flatMapToSetIndexed<T>(Set<T> destination, IndexedTransform<E, Iterable<T>> f) {
    flatMapIndexed(f).forEach((e) => destination.add(e));
    return destination;
  }

  /// Splits this collection into pair ([Tuple2]) of lazy iterables,
  /// where `item1` contains elements for which [test] yields `true`,
  /// while `item2` contains elements for which [test] yields `false`.
  ///
  /// Example:
  /// ```dart
  /// [1, 0, -3, 4, -6].partition((n) => n.isNegative) // => ([-3, -6], [1, 0, 4])
  /// ```
  Tuple2<Iterable<E>, Iterable<E>> partition(Predicate<E> test) =>
      Tuple2(where(test), whereNot(test));

  /// Splits this collection into pair ([Tuple2]) of lazy iterables,
  /// where `item1` contains elements for which [test] yields `true`,
  /// while `item2` contains elements for which [test] yields `false`,
  /// comparing to [partition], [test] will has access to the sequential index of each element.
  Tuple2<Iterable<E>, Iterable<E>> partitionIndexed(IndexedPredicate<E> test) =>
      Tuple2(whereIndexed(test), whereNotIndexed(test));

  /// Return a new lazy iterable contains chunks of this collection each not exceeding the given [size].
  ///
  /// Example:
  /// ```dart
  /// [1, 0, -3, 4, -6].chunked(2) // => [[1, 0], [-3, 4], [-6]]
  /// ```
  Iterable<Iterable<E>> chunked(int size) =>
      size != null && size > 0 ? _ChunkedIterable(this, size) : [];

  /// Returns the sum of all values produced by [selector] function applied to each element in the collection.
  ///
  /// For example:
  /// ```dart
  /// [jon, amy, joe].sumBy((_, student) => student.score) // => total score
  /// ```
  T sumBy<T extends num>(T Function(int index, E) selector) => mapIndexed(selector).sum();

  /// Returns the first element yielding the largest value of the given function or `null` if there are no elements.
  ///
  /// For example:
  /// ```dart
  /// [-3, 2].maxBy((_, x) => x * x) // => -3
  /// ```
  E maxBy<T extends Comparable<Object>>(T Function(int index, E) selector) {
    E maxElem;
    T maxValue;

    forEachIndexed((i, e) {
      final v = selector(i, e);
      if (maxElem == null || v.compareTo(maxValue) > 0) {
        maxValue = v;
        maxElem = e;
      }
    });

    return maxElem;
  }

  /// Returns the first element yielding the smallest value of the given function or `null` if there are no elements.
  ///
  /// For example:
  /// ```dart
  /// [-3, 2].minBy((_, x) => x * x) // => 2
  /// ```
  E minBy<T extends Comparable<Object>>(T Function(int index, E) selector) {
    E minElem;
    T minValue;

    forEachIndexed((i, e) {
      final v = selector(i, e);
      if (minElem == null || v.compareTo(minValue) < 0) {
        minValue = v;
        minElem = e;
      }
    });

    return minElem;
  }

  /// Returns an average of all values produced by [selector] function or [double.nan] if there are no elements.
  ///
  /// For example:
  /// ```dart
  /// [jon, amy, joe].averageBy((_, student) => student.age) // => average age
  /// ```
  double averageBy<T extends num>(T Function(int index, E) selector) =>
      mapIndexed(selector).average();
}
