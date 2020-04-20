# collection_ext

[![Pub][pub-badge]][pub]
[![Check Status][check-badge]][github-runs]
[![Code Coverage][codecov-badge]][codecov]
[![MIT][license-badge]][license]

A set of extension methods for [Dart] collections, designed for the purpose of making it easier to write concise, functional-programming-styled [Dart] code.

Working on an `Iterable` for example, with `collection_ext`, we can write:

```dart
iterable.forEachIndexed((i, x) => /* use index i & element x */)
```

instead of:

```dart
var i = 0;
for (var x in iterable) {
  // use index i & element x
  i++;
}
```

## Usage

Import all extension methods at once:

```dart
import 'package:collection_ext/all.dart';

Column(
  children: getItems()
    .nonNull
    .mapIndexed((i, item) => Text("#$i ${item.title}"))
    .asList(),
)
```

Or you can import the needed module only, for example:

```dart
import 'package:collection_ext/iterables.dart';

final diff = [2, 4, 6].foldRight(0, (x, acc) => x - acc);
```

### Nullability

All extension methods of Iterables & Maps are null-safe. For example:

```dart
Iterable itr;
assert(itr.sum() == 0);

Map map;
assert(map.none((k, v) => true) == true);
```

See [nullability tests] for more details.

## Available Modules

- Extensions to [Iterables]
- Extensions to [Maps]
- [Ranges] & related extensions

:point_right: See [API Docs] for more details

I'm working on more useful extensions, PRs are welcome! :beers:🖖


[Dart]: https://dart.dev
[github-runs]: https://github.com/xinthink/dart_collection_ext/actions
[check-badge]: https://github.com/xinthink/dart_collection_ext/workflows/check/badge.svg
[codecov-badge]: https://codecov.io/gh/xinthink/dart_collection_ext/branch/master/graph/badge.svg
[codecov]: https://codecov.io/gh/xinthink/dart_collection_ext
[license-badge]: https://img.shields.io/github/license/xinthink/dart_collection_ext
[license]: https://raw.githubusercontent.com/xinthink/dart_collection_ext/master/LICENSE
[pub]: https://pub.dev/packages/collection_ext
[pub-badge]: https://img.shields.io/pub/v/collection_ext.svg
[API Docs]: https://xinthink.github.io/dart_collection_ext/index.html
[Iterables]: https://xinthink.github.io/dart_collection_ext/iterables/iterables-library.html
[Maps]: https://xinthink.github.io/dart_collection_ext/maps/maps-library.html
[Ranges]: https://xinthink.github.io/dart_collection_ext/ranges/ranges-library.html
[nullability tests]: https://github.com/xinthink/dart_collection_ext/blob/master/test/nullability_test.dart
