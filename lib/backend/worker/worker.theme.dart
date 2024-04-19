import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrg2/backend/utils/Constants.dart';
import 'package:wrg2/backend/utils/util.colorGenerator.dart';

ThemeData get toc => Get.context == null ? ThemeData() : Theme.of(Get.context!);

extension TextColor on ThemeData {
  Color get textColor => textTheme.bodyLarge!.color!;
}

Color primaryOrg = const Color.fromRGBO(234, 97, 94, 1);
MaterialColor primarySwatch = generateMaterialColor(color: primaryOrg);

MaterialColor primaryGreen = generateMaterialColor(color: primaryOrg);

Color darkBackgroundColor = const Color.fromRGBO(30, 33, 30, 1);
Color darkForegrounColor = const Color.fromRGBO(60, 63, 60, 1);

// Color lightBackgroundColor = Color.fromRGBO(247, 248, 251, 1);
Color lightBackgroundColor = const Color.fromRGBO(235, 240, 241, 1);
Color lightForegrounColor = Colors.white;

MaterialStateProperty<T> mst<T>(T value) {
  return MaterialStateProperty.all(value);
}

class ThemeWorker {
  final ThemeData _theme = ThemeData(
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
      colorScheme: ColorScheme(
          background: lightBackgroundColor,
          brightness: Brightness.light,
          error: Colors.red,
          onBackground: lightForegrounColor,
          onError: Colors.black,
          surface: lightBackgroundColor,
          onSurface: lightForegrounColor,
          onPrimary: lightForegrounColor,
          primary: primaryOrg,
          onSecondary: Colors.black,
          secondary: lightBackgroundColor)
      // Add more theme properties as needed
      );

  ThemeData getDarkTheme() {
    var brightness = Brightness.dark;
    var bg = darkBackgroundColor;
    var fg = darkForegrounColor;
    var obg = lightBackgroundColor;
    var ofg = lightForegrounColor;
    return getColoredThemeData(brightness, bg, fg, obg, ofg);
  }

  ThemeData getLightTheme() {
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
      scaffoldBackgroundColor: bg,
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
        backgroundColor: fg,
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
        background: bg,
        brightness: brightness,
        onBackground: ofg,
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
