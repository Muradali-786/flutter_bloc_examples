part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class EmailChange extends LoginEvent {
  final String email;
  const EmailChange({required this.email});
  @override
  List<Object?> get props => [email];
}

class PassChange extends LoginEvent {
  final String passChange;
  const PassChange({required this.passChange});
  @override
  List<Object?> get props => [passChange];
}

class LoginApi extends LoginEvent {
  const LoginApi();
}
