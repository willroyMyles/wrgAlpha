import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movements/support/widget.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/firebase_options.dart';
import 'package:wrg2/frontend/cars/state.cars.dart';
import 'package:wrg2/frontend/home/view.home.dart';
import 'package:wrg2/frontend/pages/offers/state.offers.dart';
import 'package:wrg2/frontend/pages/profile/state.profile.dart';
import 'package:wrg2/standalone/state.lifecycle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  authWorker.init();
  Get.lazyPut(() => OfferState(), fenix: true);
  Get.put(GE());
  Get.put(ProfileState());
  Get.put(CarState());
  Get.put(LifeCycleState());

  //initialize one signal
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("347f29ed-6636-469f-bc56-9feeefe1aaeb");
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: tw.getLightTheme(),
      // darkTheme: tw.getDarkTheme(),
      home: HomeView(),
      navigatorObservers: [
        MoveObserver(),
      ],
      onUnknownRoute: (settings) {
        print(settings);
        return null;
      },
      onGenerateRoute: (settings) {
        print(settings);
        return null;
      },
    );
  }
}
