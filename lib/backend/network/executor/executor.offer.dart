import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/comment.model.dart';

mixin offersExecutor {
  final String _col = "offers";
  final _fstore = FirebaseFirestore.instance;

  Future<bool> offers_createOffers(CommentModel model) async {
    try {
      var data = model.toMap();

      var comment = _fstore.collection(_col).doc(data['id']);
      var post = _fstore.collection("posts").doc(model.postId);

      var res = await _fstore.runTransaction((transaction) async {
        comment.set(data);
        post.update({"offers": FieldValue.increment(1)});
      });
      //update post comment count
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<List<CommentModel>> offers_getOffers(String postId) async {
    try {
      var res = await _fstore
          .collection(_col)
          .where("postId", isEqualTo: postId)
          .where("isOffer", isEqualTo: true)
          .get();
      var ans = res.docs.map((e) => CommentModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
