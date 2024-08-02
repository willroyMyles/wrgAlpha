import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.colorGenerator.dart';

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
  ThemeWorker() {
    _theme = ThemeData(
      primaryColor: primaryOrg, // Change to your desired primary color
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Roboto', // Change to your desired font family
      appBarTheme: AppBarTheme(
        color: primaryOrg, // Change to your desired app bar color
        elevation: 0, // Change elevation as needed
        iconTheme: const IconThemeData(
          color: Colors.white, // Change to your desired app bar icon color
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(239, 236, 233, 1)),
    );
  }

  Color primaryOrg = const Color.fromARGB(255, 234, 192, 107);
// MaterialColor primarySwatch = generateMaterialColor(color: primaryOrg);

  Color darkBackgroundColor = const Color.fromRGBO(30, 33, 30, 1);
  Color darkForegrounColor = const Color.fromRGBO(60, 63, 60, 1);

  Color lightBackgroundColor = const Color.fromARGB(255, 255, 255, 255);
  Color lightForegrounColor = Colors.white;

  late ThemeData _theme;

  ThemeData getDarkTheme() {
    primaryOrg = const Color.fromARGB(255, 0, 81, 255);
    var brightness = Brightness.dark;
    var bg = darkBackgroundColor;
    var fg = darkForegrounColor;
    var obg = lightBackgroundColor;
    var ofg = lightForegrounColor;
    return getColoredThemeData(brightness, bg, fg, obg, ofg);
  }

  ThemeData getLightTheme() {
    primaryOrg = const Color.fromARGB(255, 49, 124, 78);
    var brightness = Brightness.light;
    var bg = lightBackgroundColor;
    var fg = lightForegrounColor;
    var obg = darkBackgroundColor;
    var ofg = darkForegrounColor;
    return getColoredThemeData(brightness, bg, fg, obg, ofg);
  }

  Color getPrimaryColor() {
    return generateMaterialColor(color: primaryOrg);
  }

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
      scaffoldBackgroundColor: lightBackgroundColor,
      cardColor: fg,
      canvasColor: bg,
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

      popupMenuTheme: th.popupMenuTheme.copyWith(
          color: fg,
          elevation: 15,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: Constants.br)),
      listTileTheme: ListTileThemeData(
        textColor: obg,
        style: ListTileStyle.drawer,
        dense: false,
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
        systemOverlayStyle: th.appBarTheme.systemOverlayStyle?.copyWith(
          systemNavigationBarContrastEnforced: true,
          systemStatusBarContrastEnforced: true,
          statusBarBrightness:
              Brightness.values.elementAt(brightness.index == 1 ? 0 : 1),
          statusBarIconBrightness: Brightness.light,
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
        primary: getPrimaryColor(),
        error: Colors.red,
      ),
    );
  }
}

ThemeWorker _themeWorker = ThemeWorker();
ThemeWorker get tw => _themeWorker;
