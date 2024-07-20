import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_event.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<String> todoList = [];

  TodoBloc() : super(const TodoState()) {
    on<AddItem>(_addItem);
    on<DelItem>(_delItem);
  }

  void _addItem(AddItem event, Emitter<TodoState> states) {
    todoList.add(event.task);
    emit(state.copyWith(todoList: List.from(todoList)));
  }

  void _delItem(DelItem event, Emitter<TodoState> states) {
    todoList.remove(event.task);
    emit(state.copyWith(todoList: List.from(todoList)));
  }
}
