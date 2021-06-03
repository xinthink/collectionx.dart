part of '../iterables.dart';

/// Lazy [Iterable] splits the original one into chunks, each as a new [Iterable].
class _ChunkedIterable<E> extends Iterable<Iterable<E>> {
  final Iterable<E> _iterable;
  final int _size;

  /// Create a [_ChunkedIterable] given the original [iterable], and a chunk [size].
  factory _ChunkedIterable(Iterable<E> iterable, int size) =>
      _ChunkedIterable._(iterable, size);

  _ChunkedIterable._(this._iterable, this._size);

  @override
  Iterator<Iterable<E>> get iterator => _ChunkedIterator(_iterable, _size);
}

/// [Iterator] of the [_ChunkedIterable].
class _ChunkedIterator<E> extends Iterator<Iterable<E>> {
  final int _size;
  final Iterable<E> _iterable;
  Iterable<E>? _remains;

  _ChunkedIterator(this._iterable, this._size);

  @override
  Iterable<E> get current => _remains?.take(_size) ?? Iterable.empty();

  @override
  bool moveNext() {
    _remains = _remains?.skip(_size) ?? _iterable;
    return _remains?.isNotEmpty == true;
  }
}
