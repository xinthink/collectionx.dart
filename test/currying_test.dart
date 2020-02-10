import 'package:collection_ext/currying.dart';
import 'package:collection_ext/numbers.dart';
import 'package:test/test.dart';

void main() {
  test('currified arithmetic operators', () {
    expect([3, 2, 1].map(partial(add, 1)), equals([4, 3, 2]));
    expect([3, 2, 1].map(partial(subtract, 1)), equals([-2, -1, 0]));
    expect([3, 2, 1].map(partialRight(subtract, 1)), equals([2, 1, 0]));
    expect([3, 2, 1].map(partial(multiply, 2)), equals([6, 4, 2]));
    expect([3, 2, 1].map(partial(divide, 2)), equals([2 / 3, 1, 2 / 1]));
    expect([3, 2, 1].map(partialRight(divide, 2)), equals([1.5, 1, 0.5]));
    expect([3, 2, 1].map(partial(divideTruncated, 2)), equals([2 ~/ 3, 1, 2 ~/ 1]));
    expect([3, 2, 1].map(partialRight(divideTruncated, 2)), equals([1, 1, 0]));
  });
}
