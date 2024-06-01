import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

mixin offersExecutor {
  final String _col = "offers";
  final _fstore = FirebaseFirestore.instance;

  Future<bool> offers_createOffers(OfferModel model) async {
    try {
      var id =
          "${model.senderId.parseEmail}-${model.createdAt!.formatDateForPost()}";
      model.id = id;
      var data = model.toMap();
      var comment = _fstore.collection(_col).doc(model.id);
      var post = _fstore.collection("posts").doc(model.postId);

      var res = await _fstore.runTransaction((transaction) async {
        comment.set(data);
        post.update({
          "offers": FieldValue.arrayUnion([model.id])
        });
      });
      //update post comment count
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<OfferModel>> offers_getOffers(String postId) async {
    try {
      var res = await _fstore
          .collection(_col)
          .where("postId", isEqualTo: postId)
          // .where("isOffer", isEqualTo: true)
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<OfferModel>> offers_getAllOffers() async {
    try {
      if (!GF<ProfileState>().isSignedIn.value) return [];
      var res = await _fstore
          .collection(_col)
          .where("recieverId",
              isEqualTo: GF<ProfileState>().userModel!.value.email)
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
