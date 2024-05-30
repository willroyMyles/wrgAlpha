import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/models/comment.model.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';

mixin CommentsExecutor {
  final String _col = "comments";
  final _fstore = FirebaseFirestore.instance;

  Future<bool> comments_createComments(CommentModel model) async {
    try {
      model.createdAt = DateTime.now();
      var id =
          "${model.userId.parseEmail}-${model.createdAt!.formatDateForPost()}";
      var data = model.toMap();
      data['id'] = id;

      var comment = _fstore.collection(_col).doc(data['id']);
      var post = _fstore.collection("posts").doc(model.postId);

      var res = await _fstore.runTransaction((transaction) async {
        comment.set(data);
        post.update({"comments": FieldValue.increment(1)});
      });
      //update post comment count
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<List<CommentModel>> comments_getComments(String postId) async {
    try {
      var res = await _fstore
          .collection(_col)
          .where("postId", isEqualTo: postId)
          .get();
      var ans = res.docs.map((e) => CommentModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
