import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_event.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_state.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List Example'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state.todoList.isEmpty) {
          return const Center(child: Text('add some todos'));
        } else {
          return ListView.builder(
              itemCount: state.todoList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    ' ${state.todoList[index]} Item  ',
                    style: const TextStyle(fontSize: 20),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        context
                            .read<TodoBloc>()
                            .add(DelItem(task: state.todoList[index]));
                      },
                      icon: const Icon(Icons.delete)),
                );
              });
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for(int i=0;i<5;i++){
            context.read<TodoBloc>().add(AddItem(task: 'khans$i'));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
