import 'package:collection_ext/iterables.dart';
import 'package:collection_ext/numbers.dart';
import 'package:test/test.dart';

/// Test numeric extensions to an [Iterable].
void main() {
  test('function-styled arithmetic operators', () {
    expect(add(2, 1), equals(3));
    expect(subtract(2, 1), equals(1));
    expect(multiply(2.5, -1), equals(-2.5));
    expect(divide(7, 2), equals(3.5));
    expect(divideTruncated(7, 2), equals(3));

    // used as parameter
    expect([99, 1, -1].reduce(add), equals(99));
    expect([99, 1, -1].mapIndexed(multiply), equals([0, 1, -2]));
  });
}
