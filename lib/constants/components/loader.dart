import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.colorBlack.withOpacity(0.4),
        child: Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.fromLTRB(12,6,12,6),
          child: LoadingAnimationWidget.staggeredDotsWave(
            size: 50, color: ColorUtils.primaryColor,
          ),
        ),
      ),
    ));
  }
}
