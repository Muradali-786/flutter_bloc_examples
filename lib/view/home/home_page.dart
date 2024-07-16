import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_event.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    print('built ho rha ha ni again ');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc StateManagement'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
            return Center(
              child: Text(
                state.counter.toString(),
                style: const TextStyle(
                  fontSize: 68,
                  color: Colors.black,
                ),
              ),
            );
          }),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(DecrementCounter());
                  },
                  child: const Text('Decrement')),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(IncrementCounter());
                  },
                  child: const Text('Increment'))
            ],
          )
        ],
      ),
    );
  }
}
