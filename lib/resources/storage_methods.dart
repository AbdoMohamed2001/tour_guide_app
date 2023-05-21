import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class StorageMethods extends GetxService {
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String?> getImage(String? imgName) async{
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef = firebaseStorage
          .child("cairo/hotels/Ramses Hilton")
          .child('${imgName.toLowerCase()}.jpeg');
      var imgUrl = await urlRef.getDownloadURL();
    return imgUrl;
    } catch (e) {
      return null;
    }
  }
}
