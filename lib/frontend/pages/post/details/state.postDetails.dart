import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:nanoid2/nanoid2.dart';
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
  RxString commentString = "".obs;
  RxString offerString = "".obs;
  List<CommentModel> comments = [];

  onView() {
    Get.find<GE>().posts_incrimentViews(model.id);
    model.views = model.views + 1;
    Future.delayed(const Duration(seconds: 3), () {
      var idx = Get.find<PostState>().posts.indexOf(model);

      Get.find<PostState>().posts[idx] = model;
    });
  }

  Future<dynamic> getCommentsForPost() async {
    var res = await Get.find<GE>().comments_getComments(model.id);
    comments.addAll(res);
    refresh();
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
  }

  sendOffers(OfferModel offerModel) async {
    if (offerString.value.isEmpty) {
      //throw error
      return;
    }

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
}
