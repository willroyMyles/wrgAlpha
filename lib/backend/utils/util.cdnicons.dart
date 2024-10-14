import 'package:flutter/widgets.dart';
import 'package:wrg2/backend/utils/Constants.dart';

const String src = "https://img.icons8.com/stickers/100";

class CDNIcons {
  static const String engine = "$src/break.png";
  static const String car = "$src/fiat-500.png";
  static const String garage = "$src/garage.png";
  static const String addImage = "$src/add-image.png";
  static const String addBookmark = "$src/add-bookmark.png";
  static const String removeBookmark = "$src/delete-bookmark.png";
}

extension AssetViewer on String {
  Widget get display => AnimatedSize(
      duration: Constants.defaultAnimationSpeed,
      child: SizedBox(width: 100, child: Image.network(toString())));
  Widget get displayl => AnimatedSize(
      duration: Constants.defaultAnimationSpeed,
      child: SizedBox(width: 100, child: Image.asset(toString())));
}

class AssetrService {
  static Widget getIcon(String src) {
    return Image.network(src);
  }

  static const String empty = "assets/icons/empty.png";
}
