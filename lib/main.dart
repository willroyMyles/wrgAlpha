import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movements/support/widget.dart';
import 'package:wrg2/backend/mixin/mixin.get.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/store/store.gm.dart';
import 'package:wrg2/backend/store/store.storage.dart';
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

  Get.put(StorageService());
  await GF<StorageService>().init();
  Get.put(GlobalMap());
  authWorker.init();
  Get.lazyPut(() => OfferState(), fenix: true);
  Get.put(GE());
  Get.put(ProfileState());
  Get.put(CarState());
  Get.put(LifeCycleState());

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
