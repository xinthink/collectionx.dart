import 'ranges.dart';

/// Extensions to [int].
extension IntExt on int {
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

/// Extensions to [double].
extension DoubleExt on double {
  /// Creates a range from this value to the specified [toInclusive] value, inclusively.
  Range<double> rangeTo(double toInclusive) => Range.range(this, toInclusive);

  /// Alias for [rangeTo()], creates a range from this value to the specified [toInclusive] value, inclusively.
  Range<double> upTo(double toInclusive) => Range.range(this, toInclusive);

  /// Returns a range from this value down to the specified [toInclusive] value, inclusively.
  Range<double> downTo(double toInclusive) => Range.range(this, toInclusive);
}

/// Extensions to [num].
extension NumExt on num {
  /// Function-styled arithmetic operator `+`
  static T add<T extends num>(T a, T b) => a + b;

  /// Function-styled arithmetic operator `-`
  static T subtract<T extends num>(T a, T b) => a - b;

  /// Function-styled arithmetic operator `*`
  static T multiply<T extends num>(T a, T b) => a * b;

  /// Function-styled arithmetic operator `/`
  static double divide<T extends num>(T a, T b) => a / b;

  /// Function-styled arithmetic operator `~/`
  static int divideTruncated<T extends num>(T a, T b) => a ~/ b;

  /// Checks if this value is within the range: \[[from], [to]\].
  bool within<T extends num>(T from, T to) => (from <= to && this >= from && this <= to) ||
    (from > to && this >= to && this <= from);

  /// Checks if this value is within the given [range].
  bool withinRange<T extends num>(Range<T> range) => range.contains(this);
}
