import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/login/login_bloc.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previouse, current) =>
                  previouse.email != current.email,
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Email', border: OutlineInputBorder()),
                      onChanged: (e) {
                        context.read<LoginBloc>().add(EmailChange(email: e));
                      },
                    );
                  }),
              const SizedBox(height: 15),
              BlocBuilder<LoginBloc, LoginState>(
                  buildWhen: (previouse, current) =>
                  previouse.password != current.password,
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Password', border: OutlineInputBorder()),
                      onChanged: (e) {
                        context
                            .read<LoginBloc>()
                            .add(PassChange(passChange: e));
                      },
                    );
                  }),
              const SizedBox(height: 15),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  switch(state.loginStatus){
                    case LoginStatus.initial:
                      print('initial');
                    case LoginStatus.loading:
                      print('Loading');
                    case LoginStatus.error:
                      print('error');
                    case LoginStatus.success:
                      print('Succes');

                  }

                },
                child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previouse, current) => false,
                    builder: (context, state) {
                      return CustomButton(
                          title: 'Login',
                          onTap: () {
                            context.read<LoginBloc>().add(const LoginApi());
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
