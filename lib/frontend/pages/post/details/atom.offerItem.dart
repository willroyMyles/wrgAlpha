import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.whatsapp.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/atoms/atom.bottomSheet.dart';
import 'package:wrg2/frontend/pages/personal/view.personalItem.dart';

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
              PersonalProfileItem(
                name: model.snederName ?? "",
                photo: model.senderPhoto,
                id: model.senderId,
                mobile: model.mobile,
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
                              if (model.mobile != null)
                                Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.only(
                                      top: 40, bottom: 40),
                                  child: TextButton(
                                    style: BS.defaultBtnStyle,
                                    onPressed: () async {
                                      try {
                                        await openWhatsApp(
                                          phone: '${model.mobile}',
                                          text: 'Initial text',
                                        );
                                      } on Exception catch (e) {}
                                    },
                                    child: const Text("WhatsApp"),
                                  ),
                                )
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
