part of 'maps.dart';

/// Create a [Map] from a list of [Tuple2]s, which provides key/value pairs.
Map<K, V> mapFromPairs<K, V>(Iterable<Tuple2<K, V>> pairs) =>
  {for (var t in pairs) t.item1: t.item2};

/// Create a [Map] from a list of key, value... pairs,
/// if the list has an odd length, the last entry of the resulted map will has a `null` value.
Map<K, V> mapFromList<K, V>(Iterable<dynamic> pairs) {
  final groups = pairs.partitionIndexed((i, _) => i % 2 == 0);
  final keys = groups.item1.iterator;
  final values = groups.item2.iterator;
  final entries = <MapEntry>[];
  var key;
  var i = 0;
  while (keys.moveNext()) {
    key = keys.current;
    if (values.moveNext()) {
      entries.add(MapEntry(key, values.current));
      i += 2;
    } else {
      i++;
    }
  }

  // the original list has an odd length
  if (i % 2 == 1) {
    entries.add(MapEntry(key, null));
  }
  return Map.fromEntries(entries).cast<K, V>();
}
