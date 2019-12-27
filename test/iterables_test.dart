import 'package:collection_ext/iterables.dart';
import 'package:test/test.dart';

void main() {
  test('if all elements with the predicate', () {
    final isEven = (x) => x % 2 == 0;
    expect([5, 19, 2].all(isEven), isFalse);
    expect([6, 12, 2].all(isEven), isTrue);
    expect([].all(isEven), isTrue);
  });

  test('filter a collection with index', () {
    final isEven = (i, _) => i % 2 == 0;
    expect([5, 19, 2].whereIndexed(isEven), equals([5, 2]));
  });

  test('filter a collection with false predicate', () {
    final isEven = (x) => x % 2 == 0;
    expect([3, 2, 19, 100].whereNot(isEven), equals([3, 19]));
  });

  test('filter a collection with false predicate and index', () {
    final isEven = (i, _) => i % 2 == 0;
    expect([3, 2, 19, 100].whereNotIndexed(isEven), equals([2, 100]));
  });

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

  test('map a collection into a list', () {
    expect([3, 2, 1].mapToList(['10'], (x) => '$x'), equals(['10', '3', '2', '1']));
    expect([].mapToList([], (x) => x), isEmpty);
    expect([].mapToList([2], (x) => x), equals([2]));
  });

  test('map a collection into a set', () {
    expect([3, 2, 1].mapToSet({'10', '0'}, (x) => '$x'), equals(['10', '0', '3', '2', '1']));
    expect([].mapToSet({}, (x) => x), isEmpty);
    expect([].mapToSet({2}, (x) => x), equals({2}));
  });

  test('map a collection into a list with index', () {
    expect([3, 2, 1].mapToListIndexed(['10'], (i, x) => '$i$x'), equals(['10', '03', '12', '21']));
    expect([].mapToListIndexed([], (i, _) => i), isEmpty);
    expect([].mapToListIndexed([2], (i, _) => i), equals([2]));
  });

  test('map a collection into a set with index', () {
    expect([3, 2, 1].mapToSetIndexed({'10'}, (i, x) => '$i$x'), equals(['10', '03', '12', '21']));
    expect([].mapToSetIndexed({}, (i, _) => i), isEmpty);
    expect([].mapToSetIndexed({2}, (i, _) => i), isA<Set<int>>());
    expect([].mapToSetIndexed({2}, (i, _) => i), equals({2}));
  });

  test('flatten transformations', () {
    var result = [3, 2, 1].flatMap((x) => ['$x', '${2 * x}']);
    expect(result, hasLength(6));
    expect(result, equals(['3', '6', '2', '4', '1', '2']));

    result = [3].flatMap((x) => ['${2 * x}']);
    expect(result, hasLength(1));
    expect(result, equals(['6']));

    expect([].flatMap((x) => [x, x]), isEmpty);
  });

  test('flatten empty transformations', () {
    expect([3, 2, 1].flatMap((x) => []), isEmpty);
  });

  test('turn a collection into a fixed-length list', () {
    final list = [3, 2, 1].asList();
    expect(list, hasLength(3));
    expect(() => list.add(4), throwsUnsupportedError);
  });

  test('partition a collection', () {
    final isEven = (x) => x % 2 == 0;
    final parts = [3, 2, 8, 19, 10, 0].partition(isEven);
    expect(parts.item1, equals([2, 8, 10, 0]));
    expect(parts.item2, equals([3, 19]));
  });

  test('partition a collection with index', () {
    final isEven = (i, _) => i % 2 == 0;
    final parts = [3, 2, 9, 8, 19, 11, 10, 0, 7].partitionIndexed(isEven);
    expect(parts.item1, equals([3, 9, 19, 10, 7]));
    expect(parts.item2, equals([2, 8, 11, 0]));
  });
}
