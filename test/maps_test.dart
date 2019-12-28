import 'package:collection_ext/maps.dart';
import 'package:test/test.dart';

void main() {
  test('if all entries match the predicate', () {
    expect({1: 3, 2: 0}.all((k, v) => v > 0), isFalse);
    expect({1: 3, 2: 1}.all((k, v) => v > 0), isTrue);
    expect({}.all((k, v) => v > 0), isTrue);
  });

  test('if any entry match the predicate', () {
    expect({1: 3, 2: 0}.any((k, v) => v == 0), isTrue);
    expect({1: 3, 2: 1}.any((k, v) => v == 0), isFalse);
    expect({}.any((k, v) => v < 0), isFalse);
  });

  test('filter map entries with predicate', () {
    final isEven = (k, v) => v % 2 == 0;
    expect({1: 3, 2: 0}.where(isEven).first.value, equals(0));
    expect({1: 3, 2: 0}.whereNot(isEven).first.value, equals(3));
  });

  test('transform a map', () {
    expect({1: 3, 2: 0}.mapEntries((k, v) => '$k$v'), equals(['13', '20']));
    expect({}.mapEntries((_, v) => v), isEmpty);
  });

  test('append a transformed map into a list', () {
    expect({1: 3, 2: 0}.mapToList(['10'], (k, v) => '$k$v'), equals(['10', '13', '20']));
    expect({}.mapToList([], (_, v) => v), isEmpty);
    expect({}.mapToList([2], (_, v) => v), isA<List<int>>());
    expect({}.mapToList([2], (_, v) => v), equals([2]));
  });

  test('append a transformed map into a set', () {
    expect({1: 3, 2: 0}.mapToSet({'10'}, (k, v) => '$k$v'), equals(['10', '13', '20']));
    expect({}.mapToSet({}, (_, v) => v), isEmpty);
    expect({}.mapToSet({2}, (_, v) => v), isA<Set<int>>());
    expect({}.mapToSet({2}, (_, v) => v), equals([2]));
  });

  test('flatten transformations', () {
    var result = {1: 3, 2: 0}.flatMap((k, v) => ['$k', '$k$v']);
    expect(result, hasLength(4));
    expect(result, equals(['1', '13', '2', '20']));

    result = {5: 7}.flatMap((k, v) => ['$v$k']);
    expect(result, hasLength(1));
    expect(result, equals(['75']));

    expect({}.flatMap((k, v) => [k, v]), isEmpty);
  });

  test('flatten empty transformations', () {
    expect({1: 3, 2: 0}.flatMap((_, __) => []), isEmpty);
  });
}
