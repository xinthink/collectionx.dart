// ignore_for_file: unnecessary_this
import 'ranges.dart';

extension IterableRangeExt<E> on Iterable<E> {
  /// Returns an [IntRange] of the valid indices for this collection.
  ///
  /// Counting all elements may involve iterating through all elements
  /// and can therefore be slow.
  /// Some iterables have a more efficient way to find the number of elements.
  IntRange get indices => 0.until(this?.length ?? 0);
}
