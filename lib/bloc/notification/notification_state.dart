part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final bool isTap;
  final double sliderVal;
  const NotificationState({
    this.isTap = false,
    this.sliderVal = 1.0,
  });
  NotificationState copyWith({bool? isTap, double? sliderVal}) {
    return NotificationState(
      isTap: isTap ?? this.isTap,
      sliderVal: sliderVal ?? this.sliderVal,
    );
  }

  @override
  List<Object?> get props => [isTap, sliderVal];
}
