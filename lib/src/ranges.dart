import 'num_ranges.dart';

export 'num_ranges.dart';

part '_internal/_progression_iterator.dart';

/// Represents a range of numbers.
///
/// Please note that it's not a strict counterpart of the range in mathematics.
/// In fact, to keep things simple, it's just a pair of numbers,
/// marks the beginning and end of the range, respectively.
/// So that it can represent a reverse range easily, e.g., `3.0..1.0`.
class Range<T extends num> {
  /// The beginning value in the range.
  ///
  /// It's usually but not guaranteed the minimum one.
  final T from;

  /// The end value in the range.
  ///
  /// It's usually but not guaranteed the maximum one.
  final T to;

  Range._(this.from, this.to);

  /// Factory method to create a progression in which the maximum value is [to],
  /// with an optional minimum value [from] which defaults to `0`,
  /// and a common difference of [step] which defaults to `1`.
  ///
  /// Example:
  /// ```dart
  /// Range.upTo(2) // => 0, 1, 2
  /// Range.upTo(5, from: 1, step: 2) // => 1, 3, 5
  /// ```
  static IntRange upTo(int to, {int from = 0, int step = 1}) =>
      IntRange(from, to, step: step);

  /// Create an arithmetic progression from [first] to [last] inclusively,
  /// with common difference of [step] which defaults to `1`.
  ///
  /// Example:
  /// ```dart
  /// Range.progression(1, 3) // => 1, 2, 3
  /// Range.progression(1, 5, step: 2) // => 1, 3, 5
  /// ```
  static IntRange progression(int first, int last, {int step = 1}) =>
      IntRange(first, last, step: step);

  /// Factory method to create a closed floating-point range of type [double]: \[[from], [to]\].
  ///
  /// Example:
  /// ```dart
  /// Range.range(1.0, 3.0) // => 1.0..3.0
  /// Range.range(5.0, 0.0) // => 5.0..0.0
  /// ```
  static Range<double> range(double from, double to) => Range._(from, to);

  /// Checks if the given value [n] is within this range.
  bool contains(num n) => n.within(from, to);

  @override
  String toString() => '$from..$to';
}

/// A range of values of type [int], and it also represents an [arithmetic progression](https://en.wikipedia.org/wiki/Arithmetic_progression).
///
/// It can be used as an [Iterable] to access each integer in the range. For example:
///
/// ```dart
/// Range.upTo(2).forEach((n) => print(n)) // => 0, 1, 2
/// 1.upTo(5, step: 2).forEach((n) => print(n)) // => 1, 3, 5
/// 1.downTo(-1).forEach((n) => print(n)) // => 1, 0, -1
/// ```
class IntRange extends Progression implements Range<int> {
  /// Creates an arithmetic progression from [first] to [last] inclusively,
  /// with common difference of [step] which defaults to `1`.
  const IntRange(int first, int last, {int step = 1})
      : super(first, last, step: step);

  @override
  int get from => _first;

  @override
  int get to => _last;

  @override
  bool contains(Object? n) => n is int && n.within(_first, _last);
}

/// An empty [IntRange], which contains no value.
///
/// It's returned when you try to create an [IntRange] with the same value of `first` and `last`,
/// in an exclusive manner. For example:
///
/// ```dart
/// 1.until(1) // => EmptyIntRange
/// 1.downUntil(1) // => EmptyIntRange
/// ```
///
/// An [UnsupportedError] will be raised when you try to access
/// the `from`/`to`/`first`/`last` property of an [EmptyIntRange].
class EmptyIntRange extends IntRange {
  const EmptyIntRange() : super(-1, -1);

  @override
  int get from => throw UnsupportedError(
      '`from` property is unavailable for an empty progression.');

  @override
  int get to => throw UnsupportedError(
      '`to` property is unavailable for an empty progression.');

  @override
  int get first => throw UnsupportedError(
      '`first` element is unavailable for an empty progression.');

  @override
  int get last => throw UnsupportedError(
      '`last` element is unavailable for an empty progression.');

  @override
  Iterator<int> get iterator => _EmptyProgressionIterator();

  @override
  bool contains(Object? n) => false;

  @override
  String toString() => '[]';
}

/// An [arithmetic progression](https://en.wikipedia.org/wiki/Arithmetic_progression).
///
/// It can be used as an [Iterable] to access each integer in the progression. For example:
///
/// ```dart
/// Progression(1, 3).forEach((n) => print(n)) // => 1, 2, 3
/// Progression(1, 5, step: 2).forEach((n) => print(n)) // => 1, 3, 5
/// Progression(1, -1, step: -1).forEach((n) => print(n)) // => 1, 0, -1
/// ```
class Progression extends Iterable<int> {
  /// Size of an increment/decrement step,
  /// also known as common difference between the consecutive terms.
  final int step;

  final int _first;
  final int _last;

  /// Creates an arithmetic progression from [first] to [last] inclusively,
  /// with common difference of [step].
  const Progression(int first, int last, {int step = 1})
      : _first = first,
        _last = last,
        step = step != 0 ? step : 1;

  @override
  Iterator<int> get iterator => _ProgressionIterator(this);

  @override
  int get first => _first;

  @override
  int get last => _last;

  @override
  String toString() => '$_first..$_last step $step';
}
