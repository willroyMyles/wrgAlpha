import 'package:flutter/material.dart';
import 'package:wrg2/backend/extension/color.extension.dart';
import 'package:wrg2/backend/worker/worker.theme.dart';

class TS {
  static const TextStyle _baseTextStyle =
      TextStyle(fontFamily: 'YourFontFamily');

  static TextStyle get h1 => _baseTextStyle.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: toc.textColor,
      );

  static TextStyle get h2 => _baseTextStyle.copyWith(
        fontSize: 20.0,
        color: toc.textColor,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get h3 => _baseTextStyle.copyWith(
        fontSize: 18.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get h4 => _baseTextStyle.copyWith(
        fontSize: 16.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get h5 => _baseTextStyle.copyWith(
        fontSize: 14.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get h6 => _baseTextStyle.copyWith(
        fontSize: 12.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get small => _baseTextStyle.copyWith(
        fontSize: 10.0,
        color: toc.textColor,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get hint1 => _baseTextStyle.copyWith(
        fontSize: 12.0,
        color: Colors.grey.darker,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get hint2 => _baseTextStyle.copyWith(
        fontSize: 12.0,
        color: toc.primaryColor.darker,
        fontWeight: FontWeight.w500,
      );
}

extension TSE on TextStyle {
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}

mixin TypographyMixin on Text {
  final TextStyle _baseTextStyle =
      const TextStyle(fontFamily: 'YourFontFamily');

  TextStyle get headlineLarge => _baseTextStyle.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: toc.textColor,
      );

  TextStyle get headlineMedium => _baseTextStyle.copyWith(
        fontSize: 20.0,
        color: toc.textColor,
        fontWeight: FontWeight.w600,
      );

  TextStyle get bodyLarge => _baseTextStyle.copyWith(
        fontSize: 18.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodyMedium => _baseTextStyle.copyWith(
        fontSize: 16.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );

  TextStyle get regularCaption => _baseTextStyle.copyWith(
        fontSize: 12.0,
        color: toc.textColor,
        fontWeight: FontWeight.w400,
      );
  TextStyle get small => _baseTextStyle.copyWith(
        fontSize: 10.0,
        color: toc.textColor,
        fontWeight: FontWeight.w500,
      );

  Text get h1 => Text(data!, key: key, style: style ?? headlineLarge);

  Text get h2 => Text(data!, key: key, style: style ?? headlineMedium);

  Text get h3 => Text(data!, key: key, style: style ?? bodyLarge);

  Text get h4 => Text(data!, key: key, style: style ?? bodyMedium);

  Text get h5 => Text(data!, key: key, style: style ?? regularCaption);

  Text get h6 => Text(data!, key: key, style: style ?? small);
}

class Txt extends Text with TypographyMixin {
  Txt(
    super.data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
  });
}
