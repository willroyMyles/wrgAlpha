import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/utils/Constants.dart';

typedef AtomFutureTileBuilder<T> = Widget Function(
    BuildContext context, T item);
typedef AtomFutureItemuilder<T> = T Function(Map<String, dynamic> item);

class AtomFutureBuilder<T> extends StatefulWidget {
  final String? title;
  final FutureOr<List<T>> onCall;
  final AtomFutureTileBuilder<T> builder;
  final bool showCount;
  const AtomFutureBuilder({
    super.key,
    required this.builder,
    required this.onCall,
    this.title,
    this.showCount = true,
  });

  @override
  State<AtomFutureBuilder<T>> createState() => _AtomFutureBuilderState<T>();
}

class _AtomFutureBuilderState<T> extends State<AtomFutureBuilder<T>> {
  bool called = false;
  List<T> list = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: () async {
      if (called) {
        return Future.value([]);
      }

      return widget.onCall;
    }(), builder: (context, snapshot) {
      called = true;

      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: Constants.loading);
      }

      if (snapshot.hasError) {
        return Constants.emptyWidget("Something happened");
      }

      if (snapshot.data == null) {
        return Constants.emptyWidget("No data");
      }

      if (snapshot.hasData) {
        if (snapshot.data is List) {
          if (snapshot.data!.isNotEmpty) {
            list.addAll(snapshot.data as List<T>);
          } else {
            return Constants.emptyWidget(
                "No ${widget.title} as yet".capitalizeFirst);
          }
        }
      }

      return Column(
        children: [
          if (widget.title != null)
            Text(
              " ${widget.showCount ? list.length : ''} ${widget.title!}",
              style: TS.h2,
            ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                return widget.builder(context, list[index]);
              },
            ),
          ),
        ],
      );
    });
  }
}
