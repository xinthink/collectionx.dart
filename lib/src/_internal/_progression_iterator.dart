part of '../ranges.dart';

/// An [Iterator] for [Progression]
class _ProgressionIterator extends Iterator<int> {
  final int _first;
  final int _last;
  final int _step;
  int _current;

  _ProgressionIterator(Progression progression)
      : _first = progression.first,
        _last = progression.last,
        _step = progression.step;

  @override
  int get current => _current;

  @override
  bool moveNext() {
    if (_current == null) {
      _current = _first;
      return true;
    }

    final next = _current + _step;
    final hasNext = (_step > 0 && next <= _last) || (_step < 0 && next >= _last);
    if (hasNext) {
      _current = next;
    }
    return hasNext;
  }
}

/// An empty [Progression] iterator.
class _EmptyProgressionIterator extends Iterator<int> {
  @override
  int get current => null;

  @override
  bool moveNext() => false;
}
