part of 'iterables.dart';

/// Extensions to numeric iterables.
extension NumericIterableExt<E extends num> on Iterable<E> {
  /// Returns the sum of all elements in the collection, or `0` if empty.
  E sum() => this == null || isEmpty ? (E == double ? 0.0 : 0) : reduce(add);

  /// Returns the largest element or `null` if there are no elements.
  E max() => this == null || isEmpty ? null : reduce(math.max);

  /// Returns the smallest element or `null` if there are no elements.
  E min() => this == null || isEmpty ? null : reduce(math.min);

  /// Returns an average value of elements in the collection, [double.nan] if empty.
  double average() {
    var count = 0;
    num sum = 0;
    if (this != null) {
      for (final e in this) {
        sum += e;
        count++;
      }
    }
    return count > 0 ? sum / count : double.nan;
  }
}
