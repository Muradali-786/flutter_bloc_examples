import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  final List<String> myList;
  const CounterState({this.counter = 0, this.myList=const []});

  CounterState copyWith({int? counter, List<String>? myList}) {
    return CounterState(
      counter: counter ?? this.counter,
      myList: myList ?? this.myList,
    );
  }

  @override
  List<Object?> get props => [counter, myList];
}
