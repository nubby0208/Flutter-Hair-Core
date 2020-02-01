import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  final StorageReference storageReference =
      FirebaseStorage.instance.ref().child("Images");

  StorageServices();

  // get image
  void upLoadFile({Function onData, image}) async {
    try {
      StorageUploadTask uploadTask =
          storageReference.child("${DateTime.now()}.jpeg").putFile(image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      taskSnapshot.ref.getDownloadURL().then((dynamic) {
        onData(dynamic);
      });
    } catch (e) {
      print(e);
      print("hello");
    }
  }

  // deletes file using url
  void deleteFile(String url) {
    try {
      FirebaseStorage.instance.getReferenceFromUrl(url).then(
        (StorageReference value) {
          value.delete();
          print("Deleted");
        },
      );
    } catch (e) {
      print("Error");
    }
  }
}
