part of '../iterables.dart';

/// A lazy [Iterable] skip elements do **NOT** match the predicate [_f].
class _IndexedWhereIterable<E> extends Iterable<E> {
  final Iterable<E> _iterable;
  final IndexedPredicate<E> _f;

  _IndexedWhereIterable(this._iterable, this._f);

  @override
  Iterator<E> get iterator => _IndexedWhereIterator<E>(_iterable.iterator, _f);
}

/// [Iterator] for [_IndexedWhereIterable]
class _IndexedWhereIterator<E> extends Iterator<E> {
  final Iterator<E> _iterator;
  final IndexedPredicate<E> _f;
  int _index = 0;

  _IndexedWhereIterator(this._iterator, this._f);

  @override
  bool moveNext() {
    while (_iterator.moveNext()) {
      if (_f(_index++, _iterator.current)) {
        return true;
      }
    }
    return false;
  }

  @override
  E get current => _iterator.current;
}
