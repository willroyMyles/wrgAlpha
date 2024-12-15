import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

mixin StorageExecutor {
  Future<List<String>> storage_addPicturesForPost(
      String postId, List<File> list) async {
    try {
      final storage = FirebaseStorage.instance;

      List<String> downloadUrls = [];

      for (var i = 0; i < list.length; i++) {
        var file = list[i];
        var operation = storage.ref("images/${basename(file.path)}");
        var task = await operation.putFile(file);
        var durl = await task.ref.getDownloadURL();
        downloadUrls.add(durl);
      }

      return downloadUrls;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future storage_reversePicturesForPost(String postId) async {
    try {} catch (e) {
      print(e);
    }
  }
}
