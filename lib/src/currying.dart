import 'types.dart';

/// Returns a partial applied version of function [f].
///
/// It holds the function [f] and an argument [a], returns a new function,
/// which accepts an argument [b], when applied, it returns the result of `f(a, b)`. For example:
///
/// ```dart
/// final multiply = (num a, num b) => a * b;
/// final multiply2 = partial(multiply, 2);
/// multiply2(3); // => 6
/// ```
///
/// See [Parital Application](https://en.wikipedia.org/wiki/Partial_application) &
/// [Currying](https://en.wikipedia.org/wiki/Currying)
UnaryFun<T2, R> partial<T1, T2, R>(BinaryFun<T1, T2, R> f, T1 a) => (b) => f(a, b);

/// Returns a partial applied version of function [f], in a right-to-left manner.
///
/// It holds the function [f] and an argument [b], returns a new function,
/// which accepts an argument [a], when applied, it returns the result of `f(a, b)`. For example:
///
/// ```dart
/// final subtract = (num a, num b) => a - b;
/// final subtract2 = partialRight(subtract, 2);
/// final subtractBy2 = partial(subtract, 2);
/// subtract2(3); // => (3 - 2) => 1
/// subtractBy2(3); // => (2 - 3) => -1
/// ```
///
/// See [Parital Application](https://en.wikipedia.org/wiki/Partial_application) &
/// [Currying](https://en.wikipedia.org/wiki/Currying)
UnaryFun<T1, R> partialRight<T1, T2, R>(BinaryFun<T1, T2, R> f, T2 b) => (a) => f(a, b);
