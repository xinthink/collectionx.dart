part of 'iterables.dart';

/// Lazy [Iterable] splits the original one into chunks, each as a new [Iterable].
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
