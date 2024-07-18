import 'package:flutter/material.dart';

import 'package:flutter_bloc_example/view/home/counter_page.dart';
import 'package:flutter_bloc_example/view/home/notification_page.dart';

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
              Navigator.push(context,  MaterialPageRoute(builder: (context) => const CounterPage()));

            },
          ),
          const SizedBox(height: 15),
          CustomButton(
            title: 'Notification Page',
            onTap: () {
              Navigator.push(context,  MaterialPageRoute(builder: (context) => const NotificationPage()));

            },
          )
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
