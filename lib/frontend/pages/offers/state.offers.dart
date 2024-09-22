import 'package:get/get.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/models/offer.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';

class OfferState extends GetxController with StateMixin {
  RxList<OfferModel> models = RxList([]);

  RxMap<int, Map<String, List<OfferModel>>> offerMap2 = RxMap({});
  RxInt currentIndex = 0.obs;

  int getIncomingOffersLength() {
    return models
        .where((e) =>
            e.recieverId == GF<ProfileState>().userModel!.value.email &&
            e.status != OfferStatus.Declined)
        .length;
  }

  Future setup() async {
    try {
      var offers = await GF<GE>().offers_getAllOffers();
      models.clear();
      offerMap2.clear();
      models.value = offers;
      _updateMap();
      change("", status: RxStatus.success());
      if (models.isEmpty) change("", status: RxStatus.empty());
    } catch (e) {
      change("", status: RxStatus.error("Could not get offers at this time"));

      print(e);
    }
  }

  String indexName(int index) {
    var str = switch (index) {
      0 => "Incoming Offers",
      1 => "Outgoing Offers",
      2 => "Declined Offers",
      3 => "Archived Offers",
      _ => "Unknown Offers",
    };
    return str;
  }

  onTabChanged(int index) async {
    currentIndex.value = index;
  }

  _getIndex(OfferModel model) {
    int idx = 0;
    var myId = GF<ProfileState>().userModel!.value.email;

    if (model.recieverId == myId) return 0;
    if (model.senderId == myId && model.status == OfferStatus.Declined) {
      return 2;
    }
    if (model.senderId == myId) return 1;
    if (model.senderId == myId && model.status == OfferStatus.Archived) {
      return 3;
    }

    return idx;
  }

  _updateMap() {
    for (var of in models) {
      offerMap2.update(_getIndex(of), (value) {
        // if (value.postId == of.postId) value.list.add(of);
        value.update(of.postId, (v) {
          v.add(of);
          return v;
        }, ifAbsent: () => [of]);
        return value;
      },
          ifAbsent: () => {
                of.postId: [of]
              });
    }
  }
}
