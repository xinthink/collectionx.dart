import 'package:collection_ext/iterables.dart';
import 'package:test/test.dart';

void main() {
  test('chunk a List', () {
    var numbers = [1, 2, 3, 4, 5, 6];
    var result = numbers.chunked(3);
    expect(result, hasLength(2));
    expect(result.first, hasLength(3));
    expect(result.last, hasLength(3));
    expect(result.last, [4, 5, 6]);

    numbers = [3, 2];
    result = numbers.chunked(2);
    expect(result, hasLength(1));
    expect(result.last, [3, 2]);
  });

  /// should also work for Sets
  test('chunk a Set', () {
    var numbers = {1, 2, 3, 4, 5, 6};
    var result = numbers.chunked(3);
    expect(result, hasLength(2));
    expect(result.first, hasLength(3));
    expect(result.last, hasLength(3));
    expect(result.last, [4, 5, 6]);

    numbers = {3, 2};
    result = numbers.chunked(2);
    expect(result, hasLength(1));
    expect(result.last, {3, 2});
  });

  test('chunk a collection with odd length', () {
    var list = [1, 2, 3, 4, 5, 6, 7];
    var result = list.chunked(3);
    expect(result, hasLength(3));
    expect(result.first, hasLength(3));
    expect(result.last, hasLength(1));
    expect(result.last, [7]);

    list = [1, 2, 3];
    result = list.chunked(3);
    expect(result, hasLength(1));
    expect(result.last, [1, 2, 3]);
  });

  test('chunk an empty collection should get an empty collection', () {
    expect([].chunked(3), isEmpty);
    expect(<dynamic>{}.chunked(3), isEmpty);
    expect(null.chunked(3), isEmpty);
  });

  test('chunk a collection with invalid batch size', () {
    expect([1, 2].chunked(0), isEmpty);
    expect([1, 2].chunked(-1), isEmpty);
  });
}
