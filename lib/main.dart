import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/counter/counter_bloc.dart';
import 'package:flutter_bloc_example/bloc/favourite/favourite_bloc.dart';
import 'package:flutter_bloc_example/bloc/notification/notification_bloc.dart';
import 'package:flutter_bloc_example/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc_example/repository/favourite_repository.dart';
import 'package:flutter_bloc_example/utils/utils.dart';
import 'package:flutter_bloc_example/view/home/home_page.dart';

import 'bloc/image/image_picker_bloc.dart';
import 'bloc/post_bloc/post_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(Utils()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(),
        ),
        BlocProvider(
          create: (context) =>
              FavouriteBloc(favouriteRepository: FavouriteRepository()),
        ),
        BlocProvider(
          create: (context) => PostBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
