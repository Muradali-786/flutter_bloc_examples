import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationState()) {
    on<SwitchNotification>(_onNotificationSwitch);
    on<SliderFun>(_onSlider);
  }

  void _onNotificationSwitch(
      NotificationEvent event, Emitter<NotificationState> emit) {
    emit(state.copyWith(isTap: !state.isTap));
  }

  void _onSlider(SliderFun event, Emitter<NotificationState> emit) {
    emit(state.copyWith(sliderVal: event.isSlide));
  }
}
