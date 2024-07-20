import 'package:bloc/bloc.dart';

import 'package:flutter_bloc_example/bloc/image/image_picker_event.dart';
import 'package:flutter_bloc_example/bloc/image/image_picker_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/utils.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  Utils utils;

  ImagePickerBloc(this.utils) : super(const ImagePickerState()) {
    on<CaptureCamera>(_cameraCapture);
    on<GalleryPicker>(_galleryPicker);
  }

  void _cameraCapture(
      ImagePickerEvent event, Emitter<ImagePickerState> states) async {
    XFile? file = await utils.captureFromCamera();
    emit(state.copyWith(file: file));
  }

  void _galleryPicker(
      ImagePickerEvent event, Emitter<ImagePickerState> states) async {
    XFile? file = await utils.pickFromGallery();
    emit(state.copyWith(file: file));
  }
}
