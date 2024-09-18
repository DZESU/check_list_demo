import 'package:check_list_demo/const/ui_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UIEdgeInsert.xl,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 100,child: SvgPicture.asset("assets/svg/empty_state.svg")),
          SizedBox(height: 12),
          Text("No task available", style: UITextStyle.label.copyWith(color: UIColors.title1),),
        ],
      ),
    );
  }
}
