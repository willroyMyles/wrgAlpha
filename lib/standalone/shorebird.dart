import 'package:flutter/widgets.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';

class ShorebirdChecker {
  final shorebirdCodePush = ShorebirdUpdater();

  ShorebirdChecker() {
    shorebirdCodePush
        .checkForUpdate()
        .then((value) => print('current patch number is $value'));
  }

  onCheck() async {
    final isUpdateAvailable = await shorebirdCodePush.checkForUpdate();

    if (isUpdateAvailable == UpdateStatus.outdated) {
      // Download the new patch if it's available.
      //show that update is available
      SBUtil.showInfoSnackBar("Update available, Click to restart",
          extra: GestureDetector(
            onTap: () async {
              // shorebirdCodePush.();
              await shorebirdCodePush.update();
            },
            child: const Text(
              "Restart",
            ),
          ));
    }
  }
}

ShorebirdChecker _showrebirdChecker = ShorebirdChecker();
ShorebirdChecker get shorebirdChecker => _showrebirdChecker;
