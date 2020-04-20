/// Range classes and related extensions.
///
/// The most commonly used range is [IntRange],
/// which represents an [arithmetic progression](https://en.wikipedia.org/wiki/Arithmetic_progression),
/// e.g. `0..3`, is the sequence `0, 1, 2, 3` with *common difference* (`step`) of `1`.
///
/// You can work with progressions directly via range-related classes like [IntRange] or [Progression], for example:
/// ```dart
/// Range.upTo(3); // => 0..3
/// Range.progression(1, 3); // => 1..3
/// IntRange(1, 5, step: 2); // => 1, 3, 5
/// Progression(1, 5, step: 2); // => 1, 3, 5
/// ```
///
/// The more intuitive way to create ranges might be using extension methods on [int]:
/// ```dart
/// 1.upTo(3); // => 1..3, alias for rangeTo
/// 1.rangeTo(3); // same as above
/// 1.upTo(5, step: 2); // => 1, 3, 5
/// 1.until(3); // exclusive manner => 1, 2
/// 3.downTo(1); // => 3..1
/// 3.downUntil(1); // exclusive manner => 3,2
/// ```
///
/// Furthermore, progressions are [Iterable]:
/// ```dart
/// 0.until(list.legth).forEach((i) => print(list[i]));
/// (list.legth - 1).downTo(0).forEach((i) => print(list[i]));
/// ```
///
/// Another kind of range is *closed floating-point range*, which is much less useful.
/// It is in fact a pair of numbers, marks the beginning and end of the range, respectively.
/// So that it can represent a reverse range easily, e.g. `3.0..1.0`.
///
/// Closed floating-point ranges can be created using the [Range] factory methods:
/// ```dart
/// final range = Range.range(1.0, 3.0); // => 1.0..3.0
/// assert(range.contains(3.0));
/// assert(range.contains(1.0));
/// assert(range.contains(0.0) == false);
/// ```
///
/// You can also use extension methods on [double]:
/// ```dart
/// 1.0.upTo(3.0); // => 1.0..3.0, alias for rangeTo
/// 1.0.rangeTo(3.0); // same as above
/// final range = 3.0.downTo(1.0); // => 3.0..1.0
/// assert(3.0.withinRange(range));
/// assert(1.0.withinRange(range));
/// assert(0.0.withinRange(range) == false);
/// ```
///
/// For more details, please see API docs.
library ranges;

export 'src/ranges.dart';
export 'src/iterable_indices.dart';
