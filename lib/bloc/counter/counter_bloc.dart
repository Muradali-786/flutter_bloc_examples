import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_event.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {

  CounterBloc() : super(const CounterState()) {
    on<IncrementCounter>(_increment);
    on<DecrementCounter>(_decrement);
  }

  void _increment(CounterEvent event, Emitter<CounterState> states) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _decrement(CounterEvent event, Emitter<CounterState> states) {
    emit(state.copyWith(counter: state.counter - 1));
  }


}
