import 'package:collection_ext/iterables.dart';
import 'package:test/test.dart';

/// Test numeric extensions to an [Iterable].
void main() {
  test('sum of numeric iterables', () {
    expect([5, 19, 2].sum(), equals(26));
    expect(<double>[1.0, 1.0, -2, 0.0].sum(), equals(0.0));
  });

  test('sum of iterables using selectors', () {
    expect(['a', 'ab', 'abc'].sumBy((_, s) => s.length), equals(6));
    expect(['a', 'b', 'c'].sumBy((i, _) => i.toDouble()), isA<double>());
    expect(['a', 'b', 'c'].sumBy((i, _) => i.toDouble()), equals(3.0));
  });

  test('sum of empty iterables', () {
    expect(() => <num>[].sum(), throwsStateError);
    expect(() => <double>[].sum(), throwsStateError);
    expect(() => [].sumBy((i, _) => i), throwsStateError);
  });

  test('finds maximum of numeric iterables', () {
    expect([5, 19, 2].max(), equals(19));
    expect(<double>[1.0, 1.0, -2.0, 0.0].max(), equals(1.0));
  });

  test('finds maximum of iterables using selectors', () {
    expect([-3, 2].maxBy((_, x) => x * x), equals(-3));
    expect(['abc', 'cdef', 'ab'].maxBy((_, s) => s.length), equals('cdef'));
  });

  test('finds maximum of empty iterables', () {
    expect(<num>[].max(), isNull);
    expect(<double>[].max(), isNull);
    expect([].maxBy((i, _) => i), isNull);
  });

  test('finds minimum of numeric iterables', () {
    expect([5, 19, 2].min(), equals(2));
    expect(<double>[1.0, 1.0, -2.0, 0.0].min(), equals(-2.0));
  });

  test('finds minimum of iterables using selectors', () {
    expect([-3, 2].minBy((_, x) => x * x), equals(2));
    expect(['abc', 'cdef', 'ab'].minBy((_, s) => s.length), equals('ab'));
  });

  test('finds minimum of empty iterables', () {
    expect(<num>[].min(), isNull);
    expect(<double>[].min(), isNull);
    expect([].minBy((i, _) => i), isNull);
  });

  test('calculates average of numeric iterables', () {
    expect([5, 19, 2].average(), equals(26 / 3));
    expect([1.0, 1.0, -2.0, 0.0].average(), equals(0.0));
  });

  test('calculates average of iterables using selectors', () {
    expect(['a', 'abc', 'ab'].averageBy((_, s) => s.length), equals(2));
    expect(['a', 'abc', 'cd'].averageBy((i, s) => i.toDouble() * s.length),
        equals(7 / 3));
  });

  test('calculates average of empty iterables', () {
    expect(<num>[].average(), isNaN);
    expect(<double>[].average(), isNaN);
    expect([].averageBy((i, _) => i), isNaN);
  });
}
