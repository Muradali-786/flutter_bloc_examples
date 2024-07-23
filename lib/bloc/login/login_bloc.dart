import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChange>(_emailChange);
    on<PassChange>(_passChange);
    on<LoginApi>(_loginApi);
  }
  void _emailChange(EmailChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passChange(PassChange event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.passChange));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(
        message: 'Loading...', loginStatus: LoginStatus.loading));
    try {
      Map data = {
        'email': state.email,
        'password': state.password,
      };
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: data,
      );

      final e = jsonDecode(response.body);

      if (response.statusCode == 200) {
        emit(state.copyWith(
            message: 'Login Successful', loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(
            message: e['error'], loginStatus: LoginStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), loginStatus: LoginStatus.error));
    }
  }
}
