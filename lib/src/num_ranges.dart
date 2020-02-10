import 'ranges.dart';

/// Add range extensions to [int].
extension IntRangeExt on int {
  /// Creates a range from this value to the specified [toInclusive] value, inclusively.
  IntRange rangeTo(int toInclusive, {step = 1}) => IntRange(this, toInclusive, step: step);

  /// Alias for [rangeTo()], creates a range from this value to the specified [toInclusive] value, inclusively.
  IntRange upTo(int toInclusive, {step = 1}) => IntRange(this, toInclusive, step: step);

  /// Creates a range from this value up to but excluding the specified [toExclusive] value.
  IntRange until(int toExclusive, {step = 1}) => this == toExclusive
    ? EmptyIntRange() // it's emtpy when all values are excluded
    : IntRange(this, toExclusive - step, step: step);

  /// Returns a progression from this value down to the specified [toInclusive] value with the step `-step`.
  IntRange downTo(int toInclusive, {step = 1}) => IntRange(this, toInclusive, step: -step);

  /// Returns a progression from this value down to but excluding the specified [toInclusive] value with the step `-step`.
  IntRange downUntil(int toExclusive, {step = 1}) => this == toExclusive
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
  bool within<T extends num>(T from, T to) => (from <= to && this >= from && this <= to) ||
    (from > to && this >= to && this <= from);

  /// Checks if this value is within the given [range].
  bool withinRange<T extends num>(Range<T> range) => range.contains(this);
}
