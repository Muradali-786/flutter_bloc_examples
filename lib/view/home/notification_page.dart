import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/notification/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (previous,current)=> current.isTap != previous.isTap,
            builder: (context, state) {
print('object');
              return Switch(
                value: state.isTap,
                onChanged: (value) {
                  context.read<NotificationBloc>().add(SwitchNotification());
                },
              );
            },
          ),
          const SizedBox(height: 40),
          BlocBuilder<NotificationBloc, NotificationState>(
            buildWhen: (previous,current)=>previous.sliderVal != current.sliderVal,
            builder: (context, state) {

              return Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(state.sliderVal)),
              );
            },
          ),
          const SizedBox(height: 10),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return  Slider(
                  value: state.sliderVal,
                  onChanged: (value) {
                    print(state.sliderVal);
                    context.read<NotificationBloc>().add(SliderFun(isSlide: value));
                  });
            },
          ),

        ],
      ),
    );
  }
}
