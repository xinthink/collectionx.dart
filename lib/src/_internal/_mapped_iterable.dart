part of '../iterables.dart';

/// A lazy [Iterable] maps each element of type [S] to type [T],
/// the transform function will be provided with the sequential index of the element.
class _IndexedMappedIterable<S, T> extends Iterable<T> {
  final Iterable<S> _iterable;
  final IndexedTransform<T, S> _f;

  factory _IndexedMappedIterable(Iterable<S> iterable, IndexedTransform<T, S> f) =>
    _IndexedMappedIterable<S, T>._(iterable, f);

  _IndexedMappedIterable._(this._iterable, this._f);

  @override
  Iterator<T> get iterator => _IndexedMappedIterator<S, T>(_iterable.iterator, _f);
}

/// [Iterator] for [_IndexedMappedIterator].
class _IndexedMappedIterator<S, T> extends Iterator<T> {
  T _current;
  int _index = 0;
  final Iterator<S> _iterator;
  final IndexedTransform<T, S> _f;

  _IndexedMappedIterator(this._iterator, this._f);

  @override
  bool moveNext() {
    if (_iterator.moveNext()) {
      _current = _f(_index++, _iterator.current);
      return true;
    }
    _current = null;
    return false;
  }

  @override
  T get current => _current;
}

/// A lazy [Iterable] can flatten its' child iterables, to form a single flatten collection.
class _FlatMappedIterable<E> extends Iterable<E> {
  final Iterable<Iterable<E>> _iterables;

  /// Create a [_FlatMappedIterable] given the original [iterable].
  factory _FlatMappedIterable(Iterable<Iterable<E>> iterable) =>
    _FlatMappedIterable._(iterable);

  _FlatMappedIterable._(this._iterables);

  @override
  Iterator<E> get iterator => _FlatMappedIterator(_iterables.iterator);
}

/// [Iterator] of the [_FlatMappedIterable].
class _FlatMappedIterator<E> extends Iterator<E> {
  /// Original squence of iterables
  final Iterator<Iterable<E>> _iterables;

  /// Current iterator
  Iterator<E> _iterator;

  _FlatMappedIterator(this._iterables);

  @override
  E get current => _iterator?.current;

  @override
  bool moveNext() {
    if (_iterator?.moveNext() == true) return true;

    // current iterator is null or ended
    if (_iterables.moveNext()) {
      _iterator = _iterables.current.iterator;
      return _iterator.moveNext() == true;
    }

    return false;
  }
}
