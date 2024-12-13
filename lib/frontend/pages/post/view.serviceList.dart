// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:wrg2/backend/mixin/mixin.text.dart';
// import 'package:wrg2/backend/models/post.model.dart';
// import 'package:wrg2/frontend/atoms/atom.customListVIew.dart';
// import 'package:wrg2/frontend/pages/post/state.service.dart';
// import 'package:wrg2/frontend/pages/post/view.postItem.dart';

// class ServiceList extends StatelessWidget {
//   const ServiceList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ServiceState>(
//       initState: (_) {},
//       builder: (_) {
//         return CustomListView<PostModel>(
//             loadMore: _.loadMore,
//             reset: _.setup,
//             header: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Services Requested",
//                     style: TS.h1,
//                   ),
//                 )
//               ],
//             ),
//             builder: (model) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Hero(
//                     tag: model.id,
//                     child: Material(
//                         color: Colors.transparent,
//                         child: PostItem(model: model)),
//                   ),
//                 ],
//               );
//             },
//             items: _.list,
//             con: _.scroll);
//       },
//     );
//   }
// }
