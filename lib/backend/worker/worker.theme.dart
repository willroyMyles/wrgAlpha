import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/service/service.storage.dart';

ThemeData get toc => Get.context == null ? ThemeData() : Theme.of(Get.context!);

extension TextColor on ThemeData {
  Color get textColor => textTheme.bodyLarge!.color!;
  TextStyle get cStyle =>
      CupertinoTheme.of(Get.context!).textTheme.navLargeTitleTextStyle;
}

WidgetStateProperty<T> mst<T>(T value) {
  return WidgetStateProperty.all(value);
}

class ThemeWorker {
  restoreTheme() {
    var theme = Storage.read("themeMode", "Light")!;
    changeTheme(theme);
  }

  changeTheme(String v) {
    // Storage.write("themeMode", v);
    switch (v.toLowerCase()) {
      case "system":
        Get.changeThemeMode(ThemeMode.system);
        break;
      case "light":
        Get.changeThemeMode(ThemeMode.light);
        break;
      case "dark":
        Get.changeThemeMode(ThemeMode.dark);
        break;

      default:
    }
  }

  ThemeWorker() {
    _theme = ThemeData(
      primaryColor: primaryColor, // Change to your desired primary color
      scaffoldBackgroundColor: Colors.white,
      fontFamily: '', // Change to your desired font family
      appBarTheme: AppBarTheme(
        color: primaryColor, // Change to your desired app bar color
        elevation: 0, // Change elevation as needed
        iconTheme: const IconThemeData(
          color: Colors.white, // Change to your desired app bar icon color
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255)),
    );
  }

  Color get primaryColor => const Color.fromARGB(255, 52, 146, 126);
  Color get darkBackgroundColor => const Color.fromARGB(255, 0, 0, 0);
  Color get darkForegrounColor => const Color.fromARGB(255, 39, 39, 39);
  Color get lightBackgroundColor => const Color.fromARGB(255, 225, 225, 229);
  Color get lightForegrounColor => const Color.fromARGB(255, 255, 255, 255);

  late ThemeData _theme;

  ThemeData getDarkTheme() {
    // primaryOrg = const Color.fromARGB(255, 234, 54, 54);
    var brightness = Brightness.dark;
    var bg = darkBackgroundColor;
    var fg = darkForegrounColor;
    var obg = lightBackgroundColor;
    var ofg = lightForegrounColor;
    return getColoredThemeData(brightness, bg, fg, obg, ofg);
  }

  ThemeData getLightTheme() {
    // primaryOrg = const Color.fromARGB(255, 234, 54, 54);
    var brightness = Brightness.light;
    var bg = lightBackgroundColor;
    var fg = lightForegrounColor;
    var obg = darkBackgroundColor;
    var ofg = darkForegrounColor;
    return getColoredThemeData(brightness, bg, fg, obg, ofg);
  }

  // Color getPrimaryColor() {
  //   // return generateMaterialColor(color: primaryOrg);
  // }

  ThemeData getColoredThemeData(
      Brightness brightness, Color bg, Color fg, obg, ofg) {
    var th = _theme;
    return th.copyWith(
      dividerTheme: th.dividerTheme.copyWith(
        color: bg.withOpacity(.3),
        indent: 10,
        endIndent: 10,
      ),
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: bg,
      canvasColor: bg,
      cardColor: fg,
      bottomNavigationBarTheme: th.bottomNavigationBarTheme.copyWith(
        backgroundColor: fg,
        unselectedItemColor: obg.withOpacity(.6),
      ),
      drawerTheme: th.drawerTheme
          .copyWith(surfaceTintColor: Colors.transparent, backgroundColor: bg),
      dialogTheme: th.dialogTheme.copyWith(
        surfaceTintColor: Colors.transparent,
        backgroundColor: fg,
      ),
      menuTheme: MenuThemeData(
          style: MenuStyle(
              backgroundColor: mst(bg),
              shadowColor: mst(obg.withOpacity(.9)),
              visualDensity: VisualDensity.comfortable,
              elevation: mst(10),
              padding: mst(EdgeInsets.all(10)),
              shape: mst(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))))),
      menuButtonTheme: MenuButtonThemeData(
          style: ButtonStyle(
              textStyle:
                  mst(TextStyle(fontWeight: FontWeight.w600, color: ofg)))),
      // popupMenuTheme: th.popupMenuTheme.copyWith(
      //     color: bg,
      //     elevation: 15,
      //     surfaceTintColor: Colors.transparent,
      //     shadowColor: fg.withOpacity(.1),
      //     shape: RoundedRectangleBorder(borderRadius: Constants.br)),
      listTileTheme: ListTileThemeData(
        textColor: obg,
        style: ListTileStyle.drawer,
        dense: false,
        iconColor: obg,
        minVerticalPadding: 0,
        horizontalTitleGap: 0,
        contentPadding: EdgeInsets.zero,
      ),
      textTheme: th.textTheme.copyWith(
        bodyLarge: TextStyle(color: obg),
        bodyMedium: TextStyle(color: obg),
        titleLarge: th.textTheme.titleLarge?.copyWith(color: obg),
        headlineSmall: th.textTheme.headlineSmall?.copyWith(color: obg),
        headlineMedium: th.textTheme.headlineMedium?.copyWith(color: obg),
        displaySmall: th.textTheme.displaySmall?.copyWith(color: obg),
      ),
      iconTheme: th.iconTheme.copyWith(color: obg, size: 20),

      cupertinoOverrideTheme: CupertinoThemeData(
        applyThemeToAll: true,
        scaffoldBackgroundColor: lightBackgroundColor,
        barBackgroundColor: lightBackgroundColor,
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: const TextStyle(color: Colors.black),
          inputDecorationTheme: th.inputDecorationTheme.copyWith()),
      searchBarTheme: th.searchBarTheme.copyWith(
        surfaceTintColor: mst(Colors.transparent),
      ),
      dividerColor: fg,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: bg,
      ),

      // popupMenuTheme: th.popupMenuTheme.copyWith(color: obg),
      appBarTheme: th.appBarTheme.copyWith(
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        surfaceTintColor: fg,
        toolbarTextStyle: TextStyle(color: obg),
        titleTextStyle: TextStyle(color: obg),
        iconTheme: th.iconTheme.copyWith(color: obg),
        actionsIconTheme: th.iconTheme.copyWith(color: obg),
        systemOverlayStyle: SystemUiOverlayStyle(
          systemNavigationBarContrastEnforced: true,
          systemStatusBarContrastEnforced: true,
          statusBarBrightness:
              Brightness.values.elementAt(brightness.index == 1 ? 0 : 1),
          statusBarIconBrightness:
              Brightness.values.elementAt(brightness.index == 1 ? 0 : 1),
          systemNavigationBarColor: fg,
          systemNavigationBarIconBrightness:
              Brightness.values.elementAt(brightness.index == 1 ? 0 : 1),
          // statusBarColor: Colors.red,
        ),
      ),
      colorScheme: th.colorScheme.copyWith(
        brightness: brightness,
        onError: bg,
        onPrimary: bg,
        onSecondary: obg,
        onSurface: ofg,
        surface: fg,
        primary: primaryColor,
        error: Colors.red,
      ),
    );
  }
}

ThemeWorker _themeWorker = ThemeWorker();
ThemeWorker get tw => _themeWorker;
