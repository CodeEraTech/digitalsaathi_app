import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../utils/color_utils.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? titleText;
  final String? hintText;
  final String? labelText;
  final Widget? preFixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final int? maxLength;
  final Color? cursorColor;
  final Function(String)? onChanged;
  final String? Function(String?)? validation;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final bool showBorders;
  final double? textSize ;


  final void Function()? onTap;
  final TextAlignVertical? textAlignVertical;
  final void Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatter;

  const  MyTextField({
    super.key,
    required this.controller,
    this.titleText,
    this.hintText,
    this.keyboardType,
    this.readOnly,
    this.maxLines,
    this.onTap,
    this.onFieldSubmitted,
    this.inputFormatter,
    this.borderRadius,
    this.preFixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validation,
    this.onChanged,
    this.maxLength,
    this.labelText,
    this.focusNode, this.textAlignVertical, this.minLines, this.cursorColor, this.initialValue, required this.showBorders, this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return TextFormField(
      buildCounter: (
          BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
        return null;
      },
      maxLines: maxLines,
      minLines: minLines,
      textAlignVertical: textAlignVertical,
      maxLength: maxLength,
      onChanged: onChanged,
      cursorWidth: 1.5,
      validator: validation,
      obscureText: obscureText,
      controller: controller,
      onTap: onTap,
      inputFormatters: inputFormatter==null? [
        FilteringTextInputFormatter.allow(RegExp(r'.*')),
      ]:inputFormatter,
      style: GoogleFonts.playfairDisplay(
        textStyle:  TextStyle(
          fontSize:textSize??  15,
          fontWeight: FontWeight.w400,
          color: ColorUtils.colorWhite,
        ),
      ),
      keyboardType: keyboardType ?? TextInputType.text,
      cursorColor:Colors.white,
      cursorHeight: 15,
      focusNode: focusNode,
      decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: preFixIcon,
          suffixIcon: suffixIcon,
          hintStyle: GoogleFonts.playfairDisplay(
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: ColorUtils.colorWhite,
            ),
          ),
          enabledBorder: showBorders
              ? const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )
              : InputBorder.none,
          focusedBorder: showBorders
              ? const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          )
              : InputBorder.none,
          // border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          // fillColor: Colors.black.withOpacity(0.1),
          // filled: true,
          labelStyle: GoogleFonts.playfairDisplay(
            textStyle: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.w800,
              // color: Color(0xff434343),
              color:ColorUtils.colorWhite,
            ),
          )
          // enabledBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Color(0xffFFFFFF)),
          //   borderRadius: BorderRadius.circular(borderRadius),
          // ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.red),
          //   borderRadius: BorderRadius.circular(borderRadius),
          // ),
          // errorBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: Colors.red),
          //   borderRadius: BorderRadius.circular(borderRadius),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(borderRadius),
          //   borderSide: BorderSide(color: Colors.yellow),
          // ),
          ),
    );
  }
}
