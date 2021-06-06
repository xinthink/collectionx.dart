import 'package:collection_ext/all.dart';
import 'package:test/test.dart';

/// Extension methods should work properly with nullable receivers.
void main() {
  test('treats null iterables as empty', () {
    Iterable<num>? itr;
    expect(itr.all((x) => x.isNaN), isTrue);
    expect(itr.all((x) => !x.isNaN), isTrue);
    expect(itr.none((x) => x.isNaN), isTrue);
    expect(itr.none((x) => !x.isNaN), isTrue);
    expect(itr.chunked(2), isEmpty);
    expect(() => itr.sum(), throwsStateError);
    expect(() => itr.sumBy((_, x) => x), throwsStateError);
    expect(itr.average(), isNaN);
    expect(itr.averageBy((_, x) => x), isNaN);
    expect(itr.asList(), isEmpty);
    expect(itr.whereIndexed((_, x) => x.isNaN), isEmpty);
    expect(itr.whereNot((x) => x.isNaN), isEmpty);
    expect(itr.whereNotIndexed((_, x) => x.isNaN), isEmpty);
    expect(itr.mapIndexed((_, x) => x), isEmpty);
    expect(itr.flatMap((x) => [x]), isEmpty);
    expect(itr.flatMapIndexed((_, x) => [x]), isEmpty);

    var parts = itr.partition((x) => false);
    expect(parts.item1, isEmpty);
    expect(parts.item2, isEmpty);

    parts = itr.partitionIndexed((_, x) => false);
    expect(parts.item1, isEmpty);
    expect(parts.item2, isEmpty);
  });

  test('null iterables yield nulls', () {
    Iterable<num>? itr;
    expect(itr.max(), isNull);
    expect(itr.maxBy((_, x) => x), isNull);
    expect(itr.min(), isNull);
    expect(itr.minBy((_, x) => x), isNull);
  });

  test('do nothing on null iterables', () {
    Iterable<int>? itr;
    itr.forEachIndexed((_, x) => x.isNaN);
    expect(itr.foldIndexed<int>(0, (_, s, x) => s + x), equals(0));
    expect(itr.foldRight<int>(0, (x, s) => s + x), equals(0));
    expect(itr.foldRightIndexed<int>(0, (_, x, s) => s + x), equals(0));
    expect(itr.mapToList([], (x) => x), isEmpty);
    expect(itr.mapToListIndexed([], (_, x) => x), isEmpty);
    expect(itr.mapToSet({}, (x) => x), isEmpty);
    expect(itr.mapToSetIndexed({}, (i, x) => x), isEmpty);
    expect(itr.flatMapToList(<int>[], (x) => [x]), isEmpty);
    expect(itr.flatMapToListIndexed(<int>[], (_, x) => [x]), isEmpty);
    expect(itr.flatMapToSet(<int>{}, (x) => {x}), isEmpty);
    expect(itr.flatMapToSetIndexed(<int>{}, (i, x) => {x}), isEmpty);
  });

  test('treats null maps as empty', () {
    Map? map;
    expect(map.all((_, __) => false), isTrue);
    expect(map.any((_, __) => true), isFalse);
    expect(map.none((_, __) => false), isTrue);
    expect(map.where((_, __) => true), isEmpty);
    expect(map.whereNot((_, __) => false), isEmpty);
    expect(map.mapEntries((_, __) => 0), isEmpty);
    expect(map.flatMap((_, __) => []), isEmpty);
  });

  test('do nothing on null maps', () {
    Map? map;
    expect(map.mapToList([], (_, __) => 0), isEmpty);
    expect(map.mapToSet({}, (_, __) => 0), isEmpty);
    expect(map.flatMapToList([], (_, __) => []), isEmpty);
    expect(map.flatMapToSet({}, (_, __) => []), isEmpty);
  });
}
