import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String? data;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? wordSpacing;
  final List<Shadow>? shadows;
  final TextDecoration? textDecoration;
  final String? fontFamily;
  final double? height;
  final Paint? foreground;

  const AppText(
    this.data, {
    super.key,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
    this.textColor,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.wordSpacing,
    this.shadows,
    this.textDecoration,
    this.fontFamily,
    this.height,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data ?? '',
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: TextStyle(
        color: textColor,
        backgroundColor: backgroundColor,
        fontSize: fontSize ?? 14.0,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        shadows: shadows,
        decoration: textDecoration,
        fontFamily: fontFamily,
        height: height,
        foreground: foreground,
      ),
    );
  }
}
