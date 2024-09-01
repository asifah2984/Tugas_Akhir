import 'package:equatable/equatable.dart';

class Pair<F, S> extends Equatable {
  const Pair(
    this.first,
    this.second,
  );

  final F first;
  final S second;

  (F, S) call() {
    return (first, second);
  }

  Pair<F, S> copyWith({
    F? first,
    S? second,
  }) {
    return Pair<F, S>(
      first ?? this.first,
      second ?? this.second,
    );
  }

  @override
  String toString() {
    return 'Pair($first, $second)';
  }

  @override
  List<Object?> get props => [first, second];
}
