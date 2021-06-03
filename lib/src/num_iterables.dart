part of 'iterables.dart';

/// Extensions to numeric iterables.
extension NumericIterableExt<E extends num> on Iterable<E>? {
  /// Returns the sum of all elements in the collection.
  ///
  /// The iterable must have at least one element.
  E sum() => (this ?? Iterable.empty()).reduce(add);

  /// Returns the largest element or `null` if there are no elements.
  E? max() => this?.reduce(math.max);

  /// Returns the smallest element or `null` if there are no elements.
  E? min() => this?.reduce(math.min);

  /// Returns an average value of elements in the collection, [double.nan] if empty.
  double average() {
    final self = this;
    var count = 0;
    num sum = 0;
    if (self != null) {
      for (final e in self) {
        sum += e;
        count++;
      }
    }
    return count > 0 ? sum / count : double.nan;
  }
}
