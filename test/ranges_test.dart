import 'package:collection_ext/ranges.dart';
import 'package:test/test.dart';

void main() {
  test('progressions', () {
    expect(Range.progression(1, 3), equals([1, 2, 3]));
    expect(1.rangeTo(3), equals([1, 2, 3]));
    expect(Range.upTo(2), equals([0, 1, 2]));
    expect(0.upTo(2), equals([0, 1, 2]));
    expect(1.upTo(1), equals([1]));
  });

  test('progressions with steps > 1', () {
    expect(Range.upTo(6, step: 3), equals([0, 3, 6]));
    expect(Range.progression(-2, 4, step: 2), equals([-2, 0, 2, 4]));
    expect((-2).rangeTo(4, step: 2), equals([-2, 0, 2, 4]));
    expect((-2).until(4, step: 2), equals([-2, 0, 2]));
  });

  test('reverse progressions', () {
    expect(10.downTo(8), equals([10, 9, 8]));
    expect(10.downUntil(8), equals([10, 9]));
  });

  test('reverse progressions with negative steps', () {
    expect(10.rangeTo(8, step: -1), equals([10, 9, 8]));
    expect(10.until(8, step: -1), equals([10, 9]));
    expect(8.downTo(10, step: -1), equals([8, 9, 10]));
    expect(8.downUntil(10, step: -1), equals([8, 9]));
  });

  test('invalid progressions', () {
    // all values are excluded
    expect(0.until(0), isEmpty);
    expect(0.downUntil(0), isEmpty);
    expect(0.withinRange(0.downUntil(0)), isFalse);
    expect(0.downUntil(0).contains(0), isFalse);
    expect(0.downUntil(0), equals([]));
    expect(0.downUntil(0).toString(), '[]');

    // wrong step direction, no next value can be reached
    expect(0.upTo(-1), equals([0]));
    expect(0.downTo(1), equals([0]));

    // unvailable properties for en empty range
    expect(() => 0.until(0).from, throwsUnsupportedError);
    expect(() => 0.until(0).to, throwsUnsupportedError);
    expect(() => 0.until(0).first, throwsUnsupportedError);
    expect(() => 0.until(0).last, throwsUnsupportedError);
  });

  test('check progression ranges', () {
    var progression = 1.rangeTo(2);
    expect([progression.from, progression.to], equals([1, 2]));
    expect([progression.first, progression.last], equals([1, 2]));
    expect(progression.contains(0), isFalse);
    expect(progression.contains(1), isTrue);
    expect(progression.contains(2), isTrue);
    expect(progression.contains(3), isFalse);

    progression = Range.upTo(2, step: 2);
    expect([progression.from, progression.to], equals([0, 2]));
    expect([progression.first, progression.last], equals([0, 2]));
    expect(progression.contains(-1), isFalse);
    expect(progression.contains(0), isTrue);
    expect(progression.contains(1), isTrue);
    expect(progression.contains(2), isTrue);
    expect(progression.contains(3), isFalse);
  });

  test('check reverse progression ranges', () {
    var progression = 9.downTo(8);
    expect(progression.contains(10), isFalse);
    expect(progression.contains(9), isTrue);
    expect(progression.contains(8), isTrue);
    expect(progression.contains(7), isFalse);

    progression = 9.downUntil(8);
    expect(progression.contains(10), isFalse);
    expect(progression.contains(9), isTrue);
    expect(progression.contains(8), isFalse);
  });

  test('string representation of progressions', () {
    expect(0.upTo(2).toString(), equals('0..2 step 1'));
    expect((-2).until(4, step: 2).toString(), equals('-2..2 step 2'));
    expect(10.downUntil(8).toString(), equals('10..9 step -1'));
  });

  test('floating-point ranges', () {
    var range = Range.range(1, 3);
    expect([range.from, range.to], equals([1.0, 3]));
    expect(range.contains(0), isFalse);
    expect(range.contains(1), isTrue);
    expect(range.contains(2), isTrue);
    expect(range.contains(3), isTrue);
    expect(range.contains(4), isFalse);
    expect(3.0.withinRange(range), isTrue);
    expect(2.0.within(1.0, 3.0), isTrue);
    expect(0.0.within(1.0, 3.0), isFalse);

    range = 1.0.rangeTo(3);
    expect([range.from, range.to], equals([1, 3]));

    range = 1.0.upTo(3);
    expect([range.from, range.to], equals([1, 3]));

    range = 1.0.downTo(0);
    expect([range.from, range.to], equals([1.0, 0.0]));
    expect(2.0.withinRange(range), isFalse);
    expect(1.0.withinRange(range), isTrue);
    expect(0.0.withinRange(range), isTrue);
    expect((-1.0).withinRange(range), isFalse);
    expect(0.0.within(1.0, 0.0), isTrue);
  });

  test('string representation of floating-point ranges', () {
    expect(Range.range(2.0, 4.0).toString(), equals('2.0..4.0'));
    expect(2.0.upTo(4.0).toString(), equals('2.0..4.0'));
  });

  test('indices of iterables', () {
    expect([2, 4, 6].indices, equals([0, 1, 2]));
    expect({2, 4, 6}.indices, equals([0, 1, 2]));
  });

  test('indices of empty or nullable iterables', () {
    expect([].indices, isEmpty);
    expect(null.indices, isEmpty);
  });
}
