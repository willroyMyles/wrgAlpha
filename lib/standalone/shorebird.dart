import 'package:flutter/widgets.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:wrg2/backend/utils/util.snackbars.dart';

class ShorebirdChecker {
  final shorebirdCodePush = ShorebirdCodePush();

  ShorebirdChecker() {
    shorebirdCodePush
        .currentPatchNumber()
        .then((value) => print('current patch number is $value'));
  }

  onCheck() async {
    final isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      // Download the new patch if it's available.
      await shorebirdCodePush.downloadUpdateIfAvailable();
      //show that update is available
      SBUtil.showInfoSnackBar("Update available, Click to restart",
          extra: GestureDetector(
            onTap: () {
              // shorebirdCodePush.();
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
