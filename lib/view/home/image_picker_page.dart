import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/image/image_picker_bloc.dart';
import 'package:flutter_bloc_example/bloc/image/image_picker_event.dart';
import 'package:flutter_bloc_example/bloc/image/image_picker_state.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<ImagePickerBloc, ImagePickerState>(
              builder: (context, state) {
            if (state.file == null) {
              return const Icon(Icons.camera);
            } else {
              return Image.file(File(state.file!.path.toString()));
            }
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(CaptureCamera());
                  },
                  child: const Text('Pick From Camera')),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {
                    context.read<ImagePickerBloc>().add(GalleryPicker());
                  },
                  child: const Text('PiCK From Gallery'))
            ],
          )
        ],
      ),
    );
  }
}
