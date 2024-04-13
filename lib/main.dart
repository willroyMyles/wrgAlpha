import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/network/executor/executor.general.dart';
import 'package:wrg2/backend/worker/worker.auth.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';
import 'package:wrg2/firebase_options.dart';
import 'package:wrg2/frontend/home/view.home.dart';
import 'package:wrg2/frontend/profile/state.profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  authWorker.init();
  Get.put(GE());
  Get.put(ProfileState());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: tw.getLightTheme(),
      darkTheme: tw.getDarkTheme(),
      home: const HomeView(),
    );
  }
}
