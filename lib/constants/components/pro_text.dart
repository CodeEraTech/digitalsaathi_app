import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isTranslatable;

  const ProText(
    this.data, {
    Key? key,
    this.style,
    this.textAlign,
    this.isTranslatable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      isTranslatable ? data.trim() : data,
      textAlign: textAlign,
      style: GoogleFonts.roboto(textStyle: style),
    );
  }
}

class CommonKhandText extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextOverflow? overflow;
  final int? maxLine;
  const CommonKhandText({
    super.key,
    this.title,
    this.textColor,
    this.fontWeight,
    this.fontSize, this.textAlign, this.overflow, this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      style: GoogleFonts.playfairDisplay(
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
          )
      ),
    );
  }
}

