import 'package:collection_ext/iterables.dart';
import 'package:test/test.dart';

void main() {
  test('forEach with index', () {
    final indexes = <int>[];
    [5, 19, 2].forEachIndexed((i, _) => indexes.add(i));
    expect(indexes, equals([0, 1, 2]));

    indexes.clear();
    [].forEachIndexed((i, _) => indexes.add(i));
    expect(indexes, isEmpty);
  });

  test('fold a collection with index', () {
    final indexes = <int>[];
    final add = (i, acc, n) {
      indexes.add(i);
      return acc + n;
    };

    var sum = [2, 4].foldIndexed(0, add);
    expect(indexes, equals([0, 1]));
    expect(sum, equals(6));

    indexes.clear();
    sum = [].foldIndexed(0, add);
    expect(indexes, isEmpty);
    expect(sum, equals(0));
  });

  test('fold a collection in reversed order', () {
    final numbers = <int>[];
    final add = (acc, n) {
      numbers.add(n);
      return acc + n;
    };

    var sum = [2, 4].foldRight(0, add);
    expect(numbers, equals([4, 2]));
    expect(sum, equals(6));

    numbers.clear();
    sum = [].foldRight(0, add);
    expect(numbers, isEmpty);
    expect(sum, equals(0));
  });

  test('fold a collection in reversed order with index', () {
    final indexes = <int>[];
    final add = (i, acc, n) {
      indexes.add(i);
      return acc + n;
    };

    var sum = [2, 4].foldRightIndexed(0, add);
    expect(indexes, equals([1, 0]));
    expect(sum, equals(6));

    indexes.clear();
    sum = [].foldRightIndexed(0, add);
    expect(indexes, isEmpty);
    expect(sum, equals(0));
  });

  test('retrieves a collection with no `null` elements', () {
    var result = [1, 'a', null, 'c', 0, null].nonNull;
    expect(result, hasLength(4));
    expect(result, equals([1, 'a', 'c', 0]));

    result = [null, null].nonNull;
    expect(result, isEmpty);

    result = [].nonNull;
    expect(result, isEmpty);
  });

  test('transform a collection with index', () {
    expect([3, 2, 1].mapIndexed((i, x) => '$i$x'), equals(['03', '12', '21']));
    expect([].mapIndexed((i, _) => i), isEmpty);
  });
}
