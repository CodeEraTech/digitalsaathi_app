import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/style_utils.dart';
import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    required this.title,
    this.onPressed,
    this.enabled = true,
    this.icon,
    this.height = 55,
    this.borderRadius,
    this.style,
    this.isBusy = false,
    this.toTitleCase = true,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String title;
  final bool enabled;
  final String? icon;
  final double height;
  final double? borderRadius;
  final TextStyle? style;
  final bool isBusy;
  final bool toTitleCase;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enabled ? onPressed : null,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side:const BorderSide(color:ColorUtils.primaryColor),
        borderRadius: BorderRadius.circular(borderRadius ?? 24.0),
      ),
      enableFeedback: true,
      highlightElevation: 0,
      height: height,
      disabledColor: Colors.amberAccent.withOpacity(0.5),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProText(
              title,
              style: style ??
                  StyleUtils.t500_18.copyWith(
                    color: onPressed == null
                        ? ColorUtils.primaryColor.withOpacity(0.5)
                        : ColorUtils.primaryColor,
                  ),
            ),
            // if (icon != null)
            //   Padding(
            //     padding: const EdgeInsets.only(left: 8.0),
            //     child: SvgPicture.asset(icon!),
            //   )
          ],
        ),
      ),
    );
  }
}
