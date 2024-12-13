import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

mixin StorageExecutor {
  Future<List<String>> storage_addPicturesForPost(
      String postId, List<File> list) async {
    try {
      final storgae = FirebaseStorage.instance;

      List<String> downloadUrls = [];

      for (var i = 0; i < list.length; i++) {
        Reference reference = storgae.ref();
        var task = await reference.child("images/$postId/$i").putFile(list[i]);
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
