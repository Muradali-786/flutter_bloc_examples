part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class SwitchNotification extends NotificationEvent {}

class SliderFun extends NotificationEvent {
  final double isSlide;
  const SliderFun({required this.isSlide});

  @override
  List<Object?> get props => [isSlide];
}
