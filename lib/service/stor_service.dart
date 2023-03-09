
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

import 'log_service.dart';

class StoreService{
  static final _storage = FirebaseStorage.instance.ref();
  static final folder = "post_image";

  static Future<String> uploadImage(File image) async{
    String img_name = "image_" + DateTime.now().toString();
    var firebaseStorageRef = _storage.child(folder).child(img_name);
    var uploadTask = firebaseStorageRef.putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    LogService.e(downloadUrl);
    return downloadUrl;
  }
}