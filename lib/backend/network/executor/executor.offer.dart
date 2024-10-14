import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wrg2/backend/enums/enum.post.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.functions.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

mixin offersExecutor {
  final String _col = "offers";
  final _fstore = FirebaseFirestore.instance;

  Future<bool> offer_acceptOffer(OfferModel model) async {
    try {
      var post = await _fstore.collection("posts").doc(model.postId).get();
      var postData = PostModel.fromMap(post.data()!);
      List<String> offerIds = postData.offers;
      offerIds.remove(model.id);
      await _fstore
          .collection(_col)
          .doc(model.id)
          .update({"accepted": true, "status": OfferStatus.Accepted.index});

      await _fstore
          .collection("posts")
          .doc(model.postId)
          .update({"status": Status.PROCESSING.index});

      for (var element in offerIds) {
        _fstore
            .collection(_col)
            .doc(element)
            .update({"status": OfferStatus.Declined.index});
      }
      FBFunctions.function_triggerOfferUpdatedNotification(
          offerId: model.id,
          accepted: true,
          postName: model.postTitle,
          email: model.senderId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> offer_archiveOffer(String id) async {
    try {
      var post = await _fstore.collection(_col).doc(id).get();
      if (post.exists) {
        var data = post.data();
        data!["isArchived"] = true;
        await _fstore.collection("archived $_col").doc(id).set(data);
        await _fstore.collection(_col).doc(id).delete();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> offer_deleteOffer(String id) async {
    try {
      await _fstore.collection(_col).doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> offer_declineOffer(OfferModel model) async {
    try {
      await _fstore
          .collection(_col)
          .doc(model.id)
          .update({"status": OfferStatus.Declined.index});

      FBFunctions.function_triggerOfferUpdatedNotification(
          offerId: model.id, accepted: false, email: model.senderId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

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
      FBFunctions.function_triggerOfferMadeForPostNotification(model);
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

  Future<OfferModel?> offers_getOfferById(String offerId) async {
    try {
      var res = await _fstore.collection(_col).doc(offerId).get();
      var ans = OfferModel.fromMap(res.data()!);
      return ans;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<OfferModel>> offers_getOfferByPostId(String postId) async {
    try {
      var res = await _fstore
          .collection(_col)
          .where("postId", isEqualTo: postId)
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<OfferModel>> offers_getIncomingOffers() async {
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

  Future<List<OfferModel>> offers_getOutgoingOffers() async {
    try {
      if (!GF<ProfileState>().isSignedIn.value) return [];
      var res = await _fstore
          .collection(_col)
          .where("senderId",
              isEqualTo: GF<ProfileState>().userModel!.value.email)
          .where(Filter.or(Filter("status", isEqualTo: OfferStatus.Open.index),
              Filter("status", isNull: true)))
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //get declined offers
  Future<List<OfferModel>> offers_getDeclinedOffers() async {
    try {
      if (!GF<ProfileState>().isSignedIn.value) return [];
      var res = await _fstore
          .collection(_col)
          .where("senderId",
              isEqualTo: GF<ProfileState>().userModel!.value.email)
          .where("status", isEqualTo: OfferStatus.Declined.index)
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }

  //get archived offers
  Future<List<OfferModel>> offers_getArchivedOffers() async {
    try {
      if (!GF<ProfileState>().isSignedIn.value) return [];
      var res = await _fstore
          .collection(_col)
          .where("senderId",
              isEqualTo: GF<ProfileState>().userModel!.value.email)
          .where("status", isEqualTo: OfferStatus.Archived.index)
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<OfferModel>> offers_getAllOffersWithStatusAccepted() async {
    try {
      if (!GF<ProfileState>().isSignedIn.value) return [];
      var res = await _fstore
          .collection(_col)
          .where("recieverId",
              isEqualTo: GF<ProfileState>().userModel!.value.email)
          .where(Filter.or(
              Filter("status", isNotEqualTo: OfferStatus.Declined.index),
              Filter("status", isNull: true)))
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
          .where(Filter.or(
              Filter("recieverId",
                  isEqualTo: GF<ProfileState>().userModel!.value.email),
              Filter("senderId",
                  isEqualTo: GF<ProfileState>().userModel!.value.email)))
          .get();
      var ans = res.docs.map((e) => OfferModel.fromMap(e.data())).toList();
      return ans;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
