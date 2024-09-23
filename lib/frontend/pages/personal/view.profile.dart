import 'package:flutter/material.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/userinfo.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/atoms/atom.appbar.dart';

class PersonalProfile extends StatelessWidget {
  final String id;
  const PersonalProfile({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const WRGAppBar("Profile")];
        },
        body: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder<UserInfoModel?>(
              future: GF<GE>().user_getUserById(id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error"),
                  );
                }

                if (snapshot.hasData) {
                  var model = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  Image.network(model.userImageUrl).image,
                            ),
                            const SizedBox(height: 5),
                            Text(model.username, style: TS.h3),
                            const SizedBox(height: 5),
                            Text(model.email, style: TS.h3),
                            const SizedBox(height: 5),
                            Text(model.mobile ?? "--No Contact--",
                                style: TS.h3),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 0),
                            child: Text(
                              "${model.ratings.length} Ratings",
                              style: TS.h3,
                            ),
                          ),
                          // TextButton(
                          //     style: BS.plainBtnStyle,
                          //     onPressed: () {},
                          //     child: const Text("View All"))
                        ],
                      ),
                    ],
                  );
                }
                return const Center(
                  child: Text("Profile"),
                );
              }),
        ),
      ),
    );
  }
}
