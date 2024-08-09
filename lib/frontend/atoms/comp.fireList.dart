import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

typedef Firebuilder = Widget Function(
    BuildContext context, Map<String, dynamic> item);

class FireList extends StatelessWidget {
  final int pageSize;
  final String collection;
  final String orderBy;
  final Firebuilder itemBuilder;
  const FireList(
      {super.key,
      this.pageSize = 2,
      required this.collection,
      required this.orderBy,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      pageSize: pageSize,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Text("Error: $error"),
        );
      },
      emptyBuilder: (context) {
        return const Center(
          child: Text("No events found"),
        );
      },
      fetchingIndicatorBuilder: (context) {
        print("fetching");
        return Container();
      },
      loadingBuilder: (context) {
        print("loading");
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      query: FirebaseFirestore.instance
          .collection(collection)
          .limit(pageSize)
          .orderBy(orderBy, descending: false),
      itemBuilder: (BuildContext context, DocumentSnapshot snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;
        return itemBuilder(context, data);
      },
    );
  }
}
