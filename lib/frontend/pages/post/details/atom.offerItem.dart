import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.bottomSheet.dart';

class OfferItemAtom extends StatelessWidget {
  final OfferModel model;
  const OfferItemAtom({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.transparent, width: 2)),
                  child: CircleAvatar(
                    minRadius: 25,
                    backgroundImage: Image.network(model.senderPhoto).image,
                  )),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    model.snederName,
                    style: TS.h4,
                  ),
                  Text(
                    model.mobile ?? "--No Contact--",
                    style: TS.h4,
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  await Get.bottomSheet(BottomSheetComponent(
                    builder: (context, scrollController) {
                      return Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: toc.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model.message,
                                style: TS.h2,
                              ),
                              const Divider(),
                              _buildChip(
                                "Sender:",
                                " ${model.snederName ?? ""}",
                              ),
                              _buildChip(
                                "Offer Price:",
                                " ${model.offerPrice ?? ""}",
                              ),
                              _buildChip(
                                "Has Part:",
                                " ${model.hasPart ?? ""}",
                              ),
                              _buildChip(
                                "Logistics:",
                                " ${model.logistics ?? ""}",
                              ),
                              _buildChip(
                                "Condition:",
                                " ${model.condition ?? ""}",
                              ),
                              _buildChip(
                                "Payment Method:",
                                " ${model.paymentMethod ?? ""}",
                              ),
                              _buildChip(
                                "Refund Policy:",
                                " ${model.policy ?? ""}",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
                },
                style: BS.plainBtnStyle,
                child: const Text("See Details"),
              )
            ],
          ),
          Text(
            model.message,
            style: TS.h4,
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String s, String t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
          // color: toc.scaffoldBackgroundColor,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(s, style: TS.h4.copyWith(color: toc.textColor.withOpacity(.8))),
          const SizedBox(width: 10),
          Expanded(flex: 2, child: Text(t, style: TS.h3)),
        ],
      ),
    );
  }
}
