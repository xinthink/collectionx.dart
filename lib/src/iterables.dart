/// Extensions to [Iterable]
extension IteratorExt<E> on Iterable<E> {
  /// Applies the function [f] on each element, providing sequential index of the element.
  void forEachIndexed(void Function(int index, E) f) {
    var i = 0;
    forEach((e) => f(i++, e));
  }

  /// Accumulates a collection to a single value, which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f], providing sequential index of the element.
  S foldIndexed<S>(S initial, S Function(int index, S acc, E) f) {
    var i = 0;
    return fold(initial, (acc, e) => f(i++, acc, e));
  }

  /// Accumulates a collection to a single value, which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f] in a reversed order.
  ///
  /// **Caution**: to reverse an [Iterable] may cause performance issue, see [sdk#26928](https://is.gd/lXPlJI)
  ///
  /// See also: [List.reversed]
  S foldRight<S>(S initial, S Function(S acc, E) f) =>
    toFixedList().reversed.fold(initial, f);

  /// Accumulates a collection to a single value, which starts from an [initial] value,
  /// by combining each element with the current accumulator value,
  /// with the combinator [f] in a reversed order, providing sequential index of the element.
  ///
  /// **Caution**: to reverse an [Iterable] may cause performance issue, see [sdk#26928](https://is.gd/lXPlJI)
  ///
  /// See also: [List.reversed]
  S foldRightIndexed<S>(S initial, S Function(int index, S acc, E) f) {
    final list = toFixedList();
    var acc = initial;
    for (var i = list.length - 1; i >= 0; i--) {
      acc = f(i, acc, list[i]);
    }
    return acc;
  }

  /// Transform each element to another object with the type of [T], with the transformer [f].
  Iterable<T> mapIndexed<T>(T Function(int index, E) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }

  /// Returns a new lazy [Iterable] with all `non-null` elements.
  ///
  /// See [Iterable.where]
  Iterable<E> get nonNull => where((e) => e != null);

  /// Creates a fixed-length [List] containing the elements of this [Iterable].
  ///
  /// See [Iterable.toList]
  List<E> toFixedList() => toList(growable: false);
}