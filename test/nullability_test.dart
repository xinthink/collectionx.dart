import 'package:collection_ext/all.dart';
import 'package:test/test.dart';

/// Extension methods should work properly with nullable receivers.
void main() {
  test('treats null iterables as empty', () {
    Iterable<num> itr;
    expect(itr.all((x) => x.isNaN), isTrue);
    expect(itr.all((x) => !x.isNaN), isTrue);
    expect(itr.none((x) => x.isNaN), isTrue);
    expect(itr.none((x) => !x.isNaN), isTrue);
    expect(itr.chunked(2), isEmpty);
    expect(itr.sum(), equals(0));
    expect(itr.sumBy((_, x) => x), equals(0));
    expect(itr.max(), isNull);
    expect(itr.maxBy((_, x) => x), isNull);
    expect(itr.min(), isNull);
    expect(itr.minBy((_, x) => x), isNull);
    expect(itr.average(), isNaN);
    expect(itr.averageBy((_, x) => x), isNaN);
  });

  test('null iterables yield nulls', () {
    Iterable itr;
    expect(itr.asList(), isNull);
    expect(itr.whereIndexed((_, x) => x.isNaN), isNull);
    expect(itr.whereNot((x) => x.isNaN), isNull);
    expect(itr.whereNotIndexed((_, x) => x.isNaN), isNull);
    expect(itr.mapIndexed((_, x) => x), isNull);
    expect(itr.flatMap((x) => x), isNull);
    expect(itr.flatMapIndexed((_, x) => x), isNull);
    expect(itr.partition((x) => false), isNull);
    expect(itr.partitionIndexed((_, x) => false), isNull);
  });

  test('do nothing on null iterables', () {
    Iterable itr;
    itr.forEachIndexed((_, x) => x.isNaN);
    expect(itr.foldIndexed(0, (_, s, x) => s + x), equals(0));
    expect(itr.foldRight(0, (x, s) => s + x), equals(0));
    expect(itr.foldRightIndexed(0, (_, x, s) => s + x), equals(0));
    expect(itr.mapToList([], (x) => x), isEmpty);
    expect(itr.mapToListIndexed([], (_, x) => x), isEmpty);
    expect(itr.mapToSet({}, (x) => x), isEmpty);
    expect(itr.mapToSetIndexed({}, (i, x) => x), isEmpty);
    expect(itr.flatMapToList([], (x) => x), isEmpty);
    expect(itr.flatMapToListIndexed([], (_, x) => x), isEmpty);
    expect(itr.flatMapToSet({}, (x) => x), isEmpty);
    expect(itr.flatMapToSetIndexed({}, (i, x) => x), isEmpty);
  });

  test('treats null maps as empty', () {
    Map map;
    expect(map.all((_, __) => false), isTrue);
    expect(map.any((_, __) => true), isFalse);
    expect(map.none((_, __) => false), isTrue);
  });


  test('null maps yield nulls', () {
    Map map;
    expect(map.where((_, __) => true), isNull);
    expect(map.whereNot((_, __) => false), isNull);
    expect(map.mapEntries((_, __) => 0), isNull);
    expect(map.flatMap((_, __) => []), isNull);
  });

  test('do nothing on null maps', () {
    Map map;
    expect(map.mapToList([], (_, __) => 0), isEmpty);
    expect(map.mapToSet({}, (_, __) => 0), isEmpty);
    expect(map.flatMapToList([], (_, __) => []), isEmpty);
    expect(map.flatMapToSet({}, (_, __) => []), isEmpty);
  });
}
