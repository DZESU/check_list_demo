
import 'package:flutter/material.dart';
import 'package:moon_design/moon_design.dart';

import '../../../const/ui_const.dart';

class XCard extends StatelessWidget {
  const XCard({super.key, required this.child, this.padding, this.color});

  final Widget child;
  final EdgeInsets? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? UIEdgeInsert.md,
      decoration: BoxDecoration(
          color: color ?? context.moonColors?.goku,
          borderRadius: UIStyle.cardBorderRadius,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ]),
      child: child,
    );
  }
}
