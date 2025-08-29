import 'package:digitalsaathi/constants/components/pro_text.dart';
import 'package:digitalsaathi/utils/color_utils.dart';
import 'package:digitalsaathi/utils/style_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? hintLabel;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final double height;
  final int maxLines;
  final TextInputAction textInputAction;
  final bool obscured;
  final bool hideLabel;
  final IconData iconData;
  final bool appendEnter;
  final bool requiredField;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? error;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int? maxChar;
  final bool? isEnabled;
  final bool displayLength;
  final bool displayCounter;
  final bool isIdNumber;
  final bool isNumber;
  final bool lableBold;
  final TextStyle? hintStyle;
  final TextCapitalization? textCapitalization;
  final bool isTranslatable;
  final Color disabledColor;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.controller,
    this.focusNode,
    this.iconData = Icons.lock,
    this.height = 80.0,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.obscured = false,
    this.hideLabel = false,
    this.appendEnter = false,
    this.requiredField = true,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.error,
    this.onChanged,
    this.maxChar,
    this.onTap,
    this.isEnabled,
    this.hintLabel,
    this.hintStyle,
    this.textCapitalization,
    this.displayLength = false,
    this.displayCounter = false,
    this.isIdNumber = false,
    this.isNumber = false,
    this.isTranslatable = true,
    this.lableBold = true,
    this.disabledColor = ColorUtils.fieldDisableColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!hideLabel)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProText(
                label,
                style: StyleUtils.t600_14,
              ),
              if (requiredField)
                ProText(
                  " *",
                  style: StyleUtils.t600_14
                      .copyWith(color: const Color.fromRGBO(239, 68, 68, 1)),
                )
            ],
          ),
        Container(
          padding: const EdgeInsets.only(top: 5),
          constraints: BoxConstraints(minHeight: height),
          child: TextFormField(
            autocorrect: false,
            focusNode: focusNode,
            enabled: isEnabled,
            maxLines: maxLines,
            obscureText: obscured,
            controller: controller,
            onTap: onTap,
            textCapitalization: textCapitalization ?? TextCapitalization.none,
            textAlign: TextAlign.start,
            textInputAction: textInputAction,
            maxLength: maxChar,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            buildCounter: (context,
                {required currentLength, required isFocused, maxLength}) {
              return Container(
                transform: Matrix4.translationValues(0, -26, 0),
                child: Row(
                  children: [
                    if (displayCounter)
                      ProText(
                        "$currentLength/$maxLength",
                        style: StyleUtils.t400_16,
                      ),
                  ],
                ),
              );
            },
            style: StyleUtils.t400_13.copyWith(
                color:
                    error == null ? ColorUtils.primaryColor : ColorUtils.errorColor),
            inputFormatters: maxChar != null
                ? [
                    LengthLimitingTextInputFormatter(maxChar),
                    FilteringTextInputFormatter.allow(
                        isIdNumber ? RegExp('^[a-zA-Z0-9 ]+') : RegExp(r'.')),
                  ]
                : null,
            onChanged: onChanged,
            cursorColor:
                error == null ? ColorUtils.primaryColor : ColorUtils.errorColor,
            decoration: InputDecoration(
              fillColor:
                  isEnabled == true ? ColorUtils.backgroundColor : disabledColor,
              prefixIcon: prefixIcon,
              constraints: BoxConstraints(maxHeight: height),
              filled: true,
              hintText: !hideLabel
                  ? (isTranslatable ? hintLabel?.trim() : hintLabel) ??
                      (isTranslatable ? label.trim() : label)
                  : hintLabel,
              suffixIcon: suffixIcon,
              suffixIconColor: ColorUtils.primaryColor,
              hintStyle: GoogleFonts.roboto(
                textStyle: hintStyle ??
                    StyleUtils.t400_14.copyWith(
                      color: error == null
                          ? ColorUtils.fieldDisableColor
                          : ColorUtils.errorColor,
                    ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:  const BorderSide(
                  color: ColorUtils.fieldDisableColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color:
                      error == null ? ColorUtils.fieldDisableColor : ColorUtils.errorColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color:
                      error == null ? ColorUtils.secondaryColor : ColorUtils.errorColor,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(
                  color: ColorUtils.errorColor,
                ),
              ),
            ),
            keyboardType: keyboardType,
          ),
        ),
        // if(displayLength && maxChar!=null) Text("${controller.text.length}/${maxChar.toString()}"),
        if (error != null) _buildErrorLabel(),
      ],
    );
  }

  Widget _buildErrorLabel() {
    return Row(
      children: [
       // SvgPicture.asset(AssetUtils.icCancelSvg),
        const SizedBox(width: 7),
        Text(error!, style: StyleUtils.t400_16.copyWith(color: ColorUtils.errorColor)),
      ],
    );
  }
}
