import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:wrg2/backend/enums/enum.post.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/comment.model.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/models/post.model.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';
import 'package:wrg2/frontend/pages/post/state.posts.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class PostDetailsState extends GetxController {
  late PostModel model;
  List<OfferModel> offers = [];
  RxString commentString = "".obs;
  RxString offerString = "".obs;
  List<CommentModel> comments = [];
  RxInt bottomView = 0.obs;

  onView() {
    Get.find<GE>().posts_incrimentViews(model.id);
    model.views = model.views + 1;
    Future.delayed(const Duration(seconds: 3), () {
      var idx = Get.find<PostState>().posts.indexOf(model);

      Get.find<PostState>().posts[idx] = model;
    });
  }

  Future<List<CommentModel>> getCommentsForPost() async {
    await Future.delayed(3.seconds);
    var res = await Get.find<GE>().comments_getComments(model.id);
    return res;
    // comments.addAll(res);
    // refresh();
  }

  onWatching() async {
    var user = Get.find<ProfileState>().userModel;
    if (user == null) {
      //throw error
      SBUtil.showErrorSnackBar("You need to be sign in to watch this post");
      return;
    }

    var isWatching = user.value.watching.contains(model.id);

    var res =
        await Get.find<GE>().user_modifyWatching(model.id, add: !isWatching);

    //add to watching
    if (res) {
      var state = Get.find<PostState>();
      if (isWatching) {
        model.watching = model.watching - 1;
      } else {
        model.watching = model.watching + 1;
      }
      var idx = state.posts.indexOf(model);
      state.posts[idx] = model;
      SBUtil.showSuccessSnackBar(isWatching
          ? "You no longer bookmark this post"
          : "You've bookmarked this post");
    } else {
      //throw error
    }

    Get.find<ProfileState>().onRefresh();

    getArgs();
    refresh();
  }

  @override
  void onInit() {
    super.onInit();
    getArgs();
  }

  getArgs() {
    var args = Get.arguments ?? Get.rawRoute?.settings.arguments ?? {};
    var post = args['post'];
    model = post;
    getOffers();
  }

  Future<List<OfferModel>> getOffers() async {
    try {
      var res = await GF<GE>().offers_getOfferByPostId(model.id);
      return res;
      // offers.addAll(res);
      // return offers;
    } catch (e) {
      return [];
    }
  }

  sendOffers([OfferModel? offerModel]) async {
    if (offerString.value.isEmpty) {
      //throw error
      return;
    }

    offerModel ??= OfferModel();

    offerModel.postId = model.id;
    offerModel.postTitle = model.title;
    offerModel.accepted = false;
    offerModel.completed = false;
    offerModel.id = nanoid(length: 7);
    offerModel.message = offerString.value;

    var auth = FirebaseAuth.instance.currentUser!;

    offerModel.senderId = auth.email ?? "";
    offerModel.senderPhoto = auth.photoURL ?? "";
    offerModel.snederName = auth.displayName ?? "";
    offerModel.recieverId = model.userEmail;

    offerModel.createdAt = DateTime.now();

    offerModel.recieverId = model.userEmail;

    var res = await GF<GE>().offers_createOffers(offerModel);

    if (res) {
      //success
      SBUtil.showSuccessSnackBar("Offer was sent");

      if (Get.isBottomSheetOpen ?? false) {
        Get.close(1);
        GF<ProfileState>().setup();
      } else {
        //show error
        SBUtil.showErrorSnackBar("Offer was not created successfully");
      }
    }

    refresh();
  }

  sendComment({bool offer = false}) async {
    if (commentString.value.isEmpty && !offer) {
      //throw error
      return;
    }

    var comment = CommentModel(content: commentString.value);
    comment.isOffer = false;
    comment.postId = model.id;

    var auth = FirebaseAuth.instance.currentUser!;
    comment.userId = auth.email!;
    comment.userImageUrl = auth.photoURL ?? "";
    comment.username = auth.displayName ?? "";
    comment.isOffer = offer;

    bool res;

    res = await Get.find<GE>().comments_createComments(comment);

    if (res) {
      //success
      model.comments += 1;
      if (Get.isBottomSheetOpen ?? false) {
        Get.close(1);
      } else {
        //show error
      }
    }

    refresh();
  }

  void updateBottomView(int value) {
    bottomView.value = value;
    refresh();
  }

  void updateStatus(Status e) async {
    var res =
        await Get.find<GE>().posts_modifyPost(model.id, {"status": e.index});
    if (res) {
      model.status = e;
      GF<PostState>().posts.where((e) => e.id == model.id).first.status = e;
      SBUtil.showSuccessSnackBar("Status updated");
      refresh();
    } else {
      SBUtil.showErrorSnackBar("Unable to update status");
    }
  }

  void deletePost() async {
    var res = await Get.find<GE>().posts_deletePost(model.id);
    if (res) {
      SBUtil.showSuccessSnackBar("Post deleted");
      Get.back();
    } else {
      SBUtil.showErrorSnackBar("Unable to delete post");
    }
  }
}
