import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child("Images");

  StorageServices();

  // get image
  void upLoadFile({Function onData, image}) {
    try {
      StorageUploadTask uploadTask = FirebaseStorage.instance.ref().putFile(image);
      /*await uploadTask.onComplete;
      storageReference.getDownloadURL().then((fileUrl) {
        onData(fileUrl);
      });*/
    } catch (e) {
      return;
    }
  }

// store images
}
