import 'package:flutter/material.dart';

class UIEdgeInsert {
  UIEdgeInsert._();

  static const double _smValue = 8;
  static const double _mdValue = 12;
  static const double _lgValue = 16;
  static const double _xlValue = 24;
  static const none = EdgeInsets.zero;
  static const sm = EdgeInsets.all(_smValue);
  static const smVert = EdgeInsets.symmetric(vertical: _smValue);
  static const smHori = EdgeInsets.symmetric(horizontal: _smValue);
  static const md = EdgeInsets.all(_mdValue);
  static const mdVert = EdgeInsets.symmetric(vertical: _mdValue);
  static const mdHori = EdgeInsets.symmetric(horizontal: _mdValue);
  static const lg = EdgeInsets.all(_lgValue);
  static const lgVert = EdgeInsets.symmetric(vertical: _lgValue);
  static const lgHori = EdgeInsets.symmetric(horizontal: _lgValue);
  static const xl = EdgeInsets.all(_xlValue);
  static const xlVert = EdgeInsets.symmetric(vertical: _xlValue);
  static const xlHori = EdgeInsets.symmetric(horizontal: _xlValue);
}

class UIColors {
  UIColors._();

  static const header = Colors.black;
  static const title = Colors.black;
  static const title1 = Colors.grey;
  static const label = Colors.black;
  static const label1 = Colors.grey;
  static const body = Colors.black;
  static const body1 = Colors.grey;
  static const caption = Colors.black;
  static const caption1 = Colors.grey;
  static const cardBackground = Colors.white;
}

class UIDim {
  UIDim._();

  static const double headerText = 24.0;
  static const double titleText = 20.0;
  static const double labelText = 16.0;
  static const double bodyText = 14.0;
  static const double captionText = 12.0;
  static const double cardBorderRadius = 12.0;
}

class UIStyle {
  UIStyle._();

  static BorderRadius cardBorderRadius =
      BorderRadius.circular(UIDim.cardBorderRadius);

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
