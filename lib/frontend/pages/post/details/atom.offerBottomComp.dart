import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.text.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.btns.dart';
import 'package:wrg2/backend/utils/util.formatter.dart';
import 'package:wrg2/backend/utils/util.textFormField.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/frontend/pages/post/details/state.postDetails.dart';

class OfferBottomComp extends GetView<PostDetailsState> {
  OfferBottomComp({super.key});
  var offerModel = OfferModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: toc.scaffoldBackgroundColor,
      child: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: Constants.br, color: toc.scaffoldBackgroundColor),
            // alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: Constants.cardpadding,
                vertical: Constants.cardVerticalMargin),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Make Offer",
                        style: TS.h2,
                      ),
                      const SizedBox(width: 10),
                      buildPopup(
                          const Icon(
                            Icons.info_outline,
                            size: 30,
                          ),
                          [
                            Text(
                              "    Here you will be able to send the owner of the post a message, they will then be able to contact you via your mobile number. Them accepting your offer will increase your reputation and you completing their request will also increase your reputation.",
                              style: TS.h3,
                            )
                          ]),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: buildInput("Additional", (val) {
                        controller.offerString.value = val;
                      })),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      buildInputHorizontal("Offer Price", (val) {
                        offerModel.offerPrice = val;
                      },
                          formatter:
                              CurrencyInputFormatter(leadingSymbol: "\$")),
                      const SizedBox(height: 15),
                      buildInputHorizontal("Mobile number", (val) {
                        offerModel.mobile = val;
                      }, formatter: mobileFormatter),
                      const SizedBox(height: 8),
                      buildDropdownInputHorizontal("availability", (val) {
                        offerModel.hasPart = val;
                      },
                          items: ["Available", "Not Availble", "Soon", "Other"],
                          dense: true),
                      buildDropdownInputHorizontal("payment method", (val) {
                        offerModel.paymentMethod = val;
                      },
                          items: ["COD: Cash on delivery", "Online", "Other"],
                          dense: true),
                      buildDropdownInputHorizontal("logistics", (val) {
                        offerModel.logistics = val;
                      }, items: ["I Deliver", "Pick-up", "Other"], dense: true),
                      buildDropdownInputHorizontal("condition", (val) {
                        offerModel.condition = val;
                      }, items: [
                        "Used 1/10",
                        "Used 2/10",
                        "Used 3/10",
                        "Used 4/10",
                        "Used 5/10",
                        "Used 6/10",
                        "Used 7/10",
                        "Used 8/10",
                        "Used 9/10",
                        "Used 10/10",
                        "New",
                        "Used",
                        "Other"
                      ], dense: true),
                      buildDropdownInputHorizontal("Return Policy", (val) {
                        offerModel.policy = val;
                      }, items: [
                        "No Returns",
                        "Returns Accepted",
                        "Exchange Allowed",
                        "All Sales Are Final"
                      ], dense: true),
                      buildDropdownInputHorizontal("Be Annonymous", (val) {
                        offerModel.anonymous = val == "Yes";
                      },
                          additional:
                              "Your name will be hidden from other vendors",
                          items: ["Yes", "No"],
                          dense: true),
                    ],
                  ),
                  TextButton(
                      style: BS.defaultBtnStyle,
                      onPressed: () {
                        controller.sendOffers(offerModel);
                      },
                      child: const Text("Submit Offer"))
                ],
              ),
            )),
      ),
    );
  }
}
