import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

class UIEdgeInsert {
  UIEdgeInsert._();

  static const pagePadding = EdgeInsets.all(16);
  static const cardPadding = EdgeInsets.all(8);
}

class UIColors {
  UIColors._();

  static const header = Colors.black;
  static const title = Colors.black;
  static const label = Colors.grey;
  static const body = Colors.grey;
  static const caption = Colors.grey;
  static const cardBackground = Colors.white;

}

class UIDim {
  UIDim._();

  static const double headerText = 24.0;
  static const double titleText = 22.0;
  static const double labelText = 20.0;
  static const double bodyText = 16.0;
  static const double captionText = 12.0;
  static const double cardBorderRadius = 16.0;

}

class UIStyle{
  UIStyle._();

  static BorderRadius cardBorderRadius = BorderRadius.circular(UIDim.cardBorderRadius);

  static BoxDecoration cardDecoration = BoxDecoration(
    color: UIColors.cardBackground,
    borderRadius: cardBorderRadius,
  );
}

class UITextStyle {
  UITextStyle._();

  static const header = TextStyle(
      fontSize: UIDim.headerText,
      color: UIColors.header,
      fontWeight: FontWeight.bold);
  static const title =
      TextStyle(fontSize: UIDim.titleText, color: UIColors.title);
  static const label =
      TextStyle(fontSize: UIDim.labelText, color: UIColors.label);
  static const body = TextStyle(fontSize: UIDim.bodyText, color: UIColors.body);
  static const caption =
      TextStyle(fontSize: UIDim.captionText, color: UIColors.caption);
}
