import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ImageServices{
  static Future getImageFromCamera() async{
    return await ImagePicker.pickImage(source: ImageSource.camera);
  }

  static Future getImageFromGallery() async{
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  static ImageProvider getNetworkImage(url){
    try {
      return NetworkImage(url);
    }catch(e){
      return AssetImage("asserts/no_profile.jpg");
    }
  }
}