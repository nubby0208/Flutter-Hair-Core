import 'package:image_picker/image_picker.dart';

class ImageServices{
  static Future getImageFromCamera() async{
    return await ImagePicker.pickImage(source: ImageSource.camera);
  }

  static Future getImageFromGallery() async{
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }
}