import 'package:collection_ext/iterables.dart';
import 'package:collection_ext/maps.dart';
import 'package:collection_ext/ranges.dart';

void main() {
  iterablesExample();
  mapsExample();
  rangesExample();
}

/// Example usage of extensions to [Iterable]s.
void iterablesExample() {
  // tests if all the numbers are even
  final isEven = [5, 19, 2].all((n) => n.isEven);
  print('[5, 19, 2] are all even? $isEven');

  // index-aware `forEach`
  var indexes = '';
  [5, 6, 7].forEachIndexed((i, n) => indexes += '$i');
  print('indexes walked through: $indexes'); // => '012'

  // `fold` the list in reverse direction
  final subRight = [1, 2, 3, 4].foldRight(0, NumExt.subtract); // => (1 - (2 - (3 - (4 - 0)))) => -2
  final subLeft = [1, 2, 3, 4].fold(0, NumExt.subtract); // => ((((0 - 1) - 2) - 3) - 4) => -10
  print('[1, 2, 3, 4].foldRight(0, subtract) => $subRight, while `fold` => $subLeft');

  // duplicates each element using `flatMap`
  final duplicated = [1, 2, 3].flatMap((n) => [n, n]); // [1, 1, 2, 2, 3, 3]
  print('[1, 2, 3].flatMap((n) => [n, n]) => $duplicated');

  // splits the numbers into negatives and non-negatives
  final parts = [1, 0, -3, 4, -6].partition((n) => n.isNegative); // ([-3, -6], [1, 0, 4])
  print('split [1, 2, -3, 4, -6] by sign => $parts');

  // chunks a list into subsets with maximum length of 2
  final chunks = [1, 0, -3, 4, -6].chunked(2); // [[1, 0], [-3, 4], [-6]]
  print('chunks [1, 2, -3, 4, -6] by length of 2 => $chunks');
}

/// Example usage of extensions to [Map]s.
void mapsExample() {
  // turns a sequence of key/value pairs (a key followed by a value) into a map
  final map = mapFromList<int, String>([10, 'ten', -3, 'minus three']);
  print('map built from a list => $map');

  // tests if all the numbers are even
  final isEven = {'a': 5, 'b': 19, 'c': 2}.all((k, v) => v.isEven);
  print('the map contains only even numbers? $isEven');

  // transforms the map entries into another iterable
  final medals = {1: 'Gold', 2: 'Silver', 3: 'Bronze'}.mapEntries((k, v) => '$v is the #$k');
  print('ranking of medal: $medals');

  // duplicates entries using `flatMap`
  final duplicated = {1: 3, 2: 0}.flatMap((k, v) => ['$k$v', '$k$v']); // ['13', '13', '20', '20']
  print('{1: 3, 2: 0} duplicated => $duplicated');
}

void rangesExample() {
  Range.upTo(3).forEach(print); // => 0, 1, 2, 3
  Range.upTo(4, step: 2).forEach(print); // => 0, 2, 4
  1.upTo(3).forEach(print); // => 1, 2, 3
  1.until(3).forEach(print); // => 1, 2
  3.downTo(1).forEach(print); // => 3, 2, 1
  3.downUntil(1).forEach(print); // => 3, 2
}
