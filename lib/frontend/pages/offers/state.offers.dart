import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class OfferState extends GetxController {
  RxList<OfferModel> models = RxList([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    setup();
  }

  Future setup() async {
    try {
      var offers = await GF<GE>().offers_getAllOffers();
      models.value = offers;
    } catch (e) {
      print(e);
    }
  }
}
