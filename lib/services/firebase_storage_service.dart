import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  static late FirebaseStorage _storage;

  FirebaseStorageService() {
    _storage = FirebaseStorage.instance;
  }

  Future<String> upload({
    required String path,
    required String contentType,
    required Uint8List file,
    Function(double)? onProgress,
  }) async {
    final storageRef = _storage.ref().child(path);
    final metadata = SettableMetadata(contentType: contentType);

    UploadTask uploadTask = storageRef.putData(file, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      if (snapshot.totalBytes == 0) return;

      double progress = (snapshot.bytesTransferred / snapshot.totalBytes);
      progress = (progress * 100).round() / 100;
      onProgress?.call(progress);
    });

    await uploadTask;
    return await storageRef.getDownloadURL();
  }

  Future<void> delete({required String path}) async {
    final storageRef = _storage.ref().child(path);
    await storageRef.delete();
  }

  Future<void> list({required String path}) async {
    final storageRef = _storage.ref().child(path);
    await storageRef.list();
  }
}
