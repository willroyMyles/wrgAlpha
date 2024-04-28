import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';

class OfferState extends GetxController with StateMixin {
  RxList<OfferModel> models = RxList([]);
  RxMap<String, List<OfferModel>> offerMap = RxMap({});

  @override
  void onInit() {
    super.onInit();
    setup();
  }

  Future setup() async {
    try {
      var offers = await GF<GE>().offers_getAllOffers();
      models.value = offers;
      _updateMap();
      change("", status: RxStatus.success());
      if (models.isEmpty) change("", status: RxStatus.empty());
    } catch (e) {
      change("", status: RxStatus.error("Could not get offers at this time"));

      print(e);
    }
  }

  _updateMap() {
    for (var of in models) {
      offerMap.update(of.postId, (value) => {...value, of}.toList(),
          ifAbsent: () => [of]);
    }
  }
}
