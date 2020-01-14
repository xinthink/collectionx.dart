import 'package:collection_ext/maps.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

void main() {
  test('build a map from a list', () {
    final map = mapFromList<int, String>([1, 'one', 2, 'two']);
    expect(map, isA<Map<int, String>>());
    expect(map, equals({1: 'one', 2: 'two'}));
  });

  test('empty lists yield empty maps', () {
    expect(mapFromList([]), isEmpty);
  });

  test('build a map from a list with a odd length', () {
    final map = mapFromList<int, String>([1, '1', 2]);
    expect(map, isA<Map<int, String>>());
    expect(map, equals({1: '1', 2: null}));
  });

  test('build a map from a list in invalid order', () {
    expect(() => mapFromList<int, String>(['1', 2]), throwsA(TypeMatcher<CastError>()));
  });

  test('build a map from key/value pairs', () {
    final map = mapFromPairs([Tuple2(1, 'one'), Tuple2(2, 'two')]);
    expect(map, isA<Map<int, String>>());
    expect(map, equals({1: 'one', 2: 'two'}));

    expect(mapFromPairs([]), isEmpty);
  });
}
