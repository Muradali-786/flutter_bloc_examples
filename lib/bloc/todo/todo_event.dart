import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class AddItem extends TodoEvent {
  final String task;
  const AddItem({required this.task});
  @override
  List<Object?> get props => [task];
}

class DelItem extends TodoEvent {
  final String task;
  const DelItem({required this.task});
  @override
  List<Object?> get props => [task];
}
