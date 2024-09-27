import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

/// A utility method to open WhatsApp on different devices
/// Optionality you can add [text] message
Future<void> openWhatsApp({
  required String phone,
  String? text,
  LaunchMode mode = LaunchMode.externalApplication,
}) async {
  try {
    final String textIOS = text != null ? Uri.encodeFull('?text=$text') : '';
    final String textAndroid =
        text != null ? Uri.encodeFull('&text=$text') : '';

    final String urlIOS = 'https://wa.me/$phone$textIOS';
    final String urlAndroid = 'whatsapp://send/?phone=$phone$textAndroid';

    final String effectiveURL = Platform.isIOS ? urlIOS : urlAndroid;

    if (await canLaunchUrl(Uri.parse(effectiveURL))) {
      await launchUrl(Uri.parse(effectiveURL), mode: mode);
    } else {
      throw Exception('openWhatsApp could not launching url: $effectiveURL');
    }
  } catch (e) {
    showDialog(
        context: Get.context!,
        builder: (context) => CupertinoAlertDialog(
              title: const Text("Attention!"),
              content: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  'We did not find the «SMS Messenger» application on your phone, please install it and try again»',
                  style: context.theme.textTheme.labelSmall?.copyWith(
                    height: 1.1,
                    color: context.theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ));
  }
}
