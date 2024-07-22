import 'package:flutter/material.dart';
import 'package:flutter_bloc_example/view/home/api_example.dart';
import 'package:flutter_bloc_example/view/home/counter_page.dart';
import 'package:flutter_bloc_example/view/home/favourite_page.dart';
import 'package:flutter_bloc_example/view/home/notification_page.dart';
import 'package:flutter_bloc_example/view/home/todo_list_page.dart';

import 'image_picker_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc StateManagement'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomButton(
            title: 'Counter Page',
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CounterPage()));
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            title: 'Notification Page',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            title: 'Image Picker Page',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ImagePickerPage()));
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            title: 'Todo List Page',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TodoListPage()));
            },
          ),
          const SizedBox(height: 15),
          CustomButton(
              title: 'Favourite Page',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavouritePage()));
              })
          ,
          const SizedBox(height: 15),
          CustomButton(
              title: 'Api Example Page',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ApiExample()));
              })
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(title),
        ),
      ),
    );
  }
}
