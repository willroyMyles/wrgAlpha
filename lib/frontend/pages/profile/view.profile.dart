import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/messages/view.messages.dart';
import 'package:wrg2/frontend/pages/offers/view.offers.dart';
import 'package:wrg2/frontend/pages/personal/view.personalPosts.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class ProfileView extends GetView<ProfileState> {
  ProfileView({super.key});
  RxBool showFeedback = false.obs;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          padding: Constants.ePadding,
          child: GetBuilder<ProfileState>(
              init: controller,
              initState: (_) {},
              builder: (_) {
                return Obx(() => AnimatedSwitcher(
                    duration: 250.milliseconds,
                    child: showFeedback.value
                        ? Container(
                            key: UniqueKey(), child: _feedbackPage(context))
                        : _regularPage(context)));
              }),
        ),
      )),
    );
  }

  Widget _feedbackPage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Feedback"),
          const SizedBox(height: 20),
          const Text("Please leave your feedback below"),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              maxLines: 5,
              onChanged: (value) {
                controller.feedback = value;
              },
              decoration: const InputDecoration(
                  hintText: "Your feedback here",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(10)),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    showFeedback.value = false;
                  },
                  child: const Text("Close")),
              TextButton(
                  onPressed: () {
                    showFeedback.value = false;
                    controller.onSendFeedback();
                  },
                  child: const Text("Submit")),
            ],
          )
        ],
      ),
    );
  }

  Widget _regularPage(BuildContext context) {
    if (controller.userModel != null) {
      return Container(
        alignment: Alignment.center,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              height: 55,
              width: 55,
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: CircleAvatar(
                  radius: 35,
                  child: Obx(() =>
                      Image.network(controller.userModel!.value.userImageUrl)),
                ),
              )),
          const Spacer(),
          ListTile(
            onTap: () {
              Get.to(() => MessagesView());
            },
            title: const Text("Messages"),
            leading: Container(
              margin: const EdgeInsets.only(right: 15),
              child: Icon(
                CupertinoIcons.chat_bubble,
                color: toc.textColor,
              ),
            ),
          ),
          ListTile(
            title: const Text("Your Posts"),
            onTap: () {
              Get.to(() => PersonalPosts());
            },
            leading: Container(
              margin: const EdgeInsets.only(right: 15),
              child: Icon(
                CupertinoIcons.rectangle_on_rectangle_angled,
                color: toc.textColor,
              ),
            ),
          ),
          ListTile(
            title: const Text("Offers"),
            onTap: () {
              Get.to(() => const OffersView());
            },
            leading: Container(
              margin: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.inbox,
                color: toc.textColor,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: "feedback",
                child: TextButton(
                    onPressed: () {
                      showFeedback.value = true;
                    },
                    child: const Text("Feedback")),
              ),
              TextButton(
                  onPressed: () {
                    Get.find<GE>().user_logout();
                  },
                  child: const Text("Log out"))
            ],
          ),
        ]),
      );
    } else {
      // return const Text("Hello world");
      return Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () async {
                    await Get.find<GE>().signInWithGoogle();
                  },
                  child: const Text("Log in")),
              Hero(
                tag: "feedback",
                child: TextButton(
                    onPressed: () {
                      showFeedback.value = true;
                    },
                    child: const Text("Feedback")),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ]),
      );
    }
  }
}
