import 'ranges.dart';

/// Add range extensions to [int].
extension IntRangeExt on int {
  /// Creates a range from this value to the specified [toInclusive] value, inclusively.
  ///
  /// Example:
  /// ```dart
  /// 1.rangeTo(3) // => 1, 2, 3
  /// 1.rangeTo(5, step: 2) // => 1, 3, 5
  /// ```
  IntRange rangeTo(int toInclusive, {int step = 1}) =>
      IntRange(this, toInclusive, step: step);

  /// Alias for [rangeTo()], creates a range from this value to the specified [toInclusive] value, inclusively.
  ///
  /// Example:
  /// ```dart
  /// 1.upTo(3) // => 1, 2, 3
  /// 1.upTo(5, step: 2) // => 1, 3, 5
  /// ```
  IntRange upTo(int toInclusive, {int step = 1}) =>
      IntRange(this, toInclusive, step: step);

  /// Creates a range from this value up to but excluding the specified [toExclusive] value.
  ///
  /// Example:
  /// ```dart
  /// 1.until(3) // => 1, 2
  /// 1.until(5, step: 2) // => 1, 3
  /// ```
  IntRange until(int toExclusive, {int step = 1}) => this == toExclusive
      ? EmptyIntRange() // it's emtpy when all values are excluded
      : IntRange(this, toExclusive - step, step: step);

  /// Returns a progression from this value down to the specified [toInclusive] value with the step `-step`.
  ///
  /// Example:
  /// ```dart
  /// 3.downTo(1) // => 3, 2, 1
  /// 5.downTo(1, step: 2) // => 5, 3, 1
  /// ```
  IntRange downTo(int toInclusive, {int step = 1}) =>
      IntRange(this, toInclusive, step: -step);

  /// Returns a progression from this value down to but excluding the specified [toInclusive] value with the step `-step`.
  ///
  /// Example:
  /// ```dart
  /// 3.downUntil(1) // => 3, 2
  /// 5.downUntil(1, step: 2) // => 5, 3
  /// ```
  IntRange downUntil(int toExclusive, {int step = 1}) => this == toExclusive
      ? EmptyIntRange() // it's emtpy when all values are excluded
      : IntRange(this, toExclusive + step, step: -step);
}

/// Add range extensions to [double].
extension DoubleRangeExt on double {
  /// Creates a range from this value to the specified [toInclusive] value, inclusively.
  Range<double> rangeTo(double toInclusive) => Range.range(this, toInclusive);

  /// Alias for [rangeTo()], creates a range from this value to the specified [toInclusive] value, inclusively.
  Range<double> upTo(double toInclusive) => Range.range(this, toInclusive);

  /// Returns a range from this value down to the specified [toInclusive] value, inclusively.
  Range<double> downTo(double toInclusive) => Range.range(this, toInclusive);
}

/// Add range extensions to [num].
extension NumRangeExt on num {
  /// Checks if this value is within the range: \[[from], [to]\].
  bool within(num from, num to) =>
      (from <= to && this >= from && this <= to) ||
      (from > to && this >= to && this <= from);

  /// Checks if this value is within the given [range].
  bool withinRange<T extends num>(Range<T> range) => range.contains(this);
}
