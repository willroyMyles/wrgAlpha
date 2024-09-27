import 'package:cloud_functions/cloud_functions.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wrg2/backend/models/offer.dart';

class FBFunctions {
  static Future function_triggerOfferUpdatedNotification(
      {required String offerId,
      required bool accepted,
      required String email,
      String? postName}) async {
    try {
      var res = await FirebaseFunctions.instance
          .httpsCallable(
        'triggerOfferStatusChanged',
      )
          .call({
        "offerId": offerId,
        "accepted": accepted,
        "postName": postName ?? "",
        "ext": email,
        "id": await OneSignal.User.getOnesignalId()
      });
    } catch (e) {
      print(e);
    }
  }

  static Future function_triggerOfferMadeForPostNotification(
      OfferModel model) async {
    try {
      var res = await FirebaseFunctions.instance
          .httpsCallable(
        'triggerOfferMadeForPost',
      )
          .call({
        "offerId": model.id,
        "postName": model.postTitle,
        "sender": model.snederName,
        "reciever": model.recieverId,
      });
    } catch (e) {
      print(e);
    }
  }
}
