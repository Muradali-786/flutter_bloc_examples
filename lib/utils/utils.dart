import 'package:image_picker/image_picker.dart';

class Utils {
  Future<XFile?> captureFromCamera() async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickImage(source: ImageSource.camera);

    return file;
  }

  Future<XFile?> pickFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final XFile? file = await picker.pickImage(source: ImageSource.gallery);

    return file;
  }
}
