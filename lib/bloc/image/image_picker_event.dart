

import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object?> get props => [];
}

class CaptureCamera extends ImagePickerEvent {}

class GalleryPicker extends ImagePickerEvent {}
