import 'package:flutter/material.dart';

class FPVText extends StatelessWidget {
  const FPVText({
    required this.text,
    super.key,
    TextStyle? style,
    this.textAlign = TextAlign.start,
  }) : textStyle = style ?? const TextStyle();

  const FPVText._builder({
    required this.text,
    required this.textStyle,
    required this.textAlign,
  });

  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;

  FPVText bold() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
      textAlign: textAlign,
    );
  }

  FPVText w700() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.w700),
      textAlign: textAlign,
    );
  }

  FPVText w900() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.w900),
      textAlign: textAlign,
    );
  }

  FPVText medium() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.w500),
      textAlign: textAlign,
    );
  }

  FPVText black() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.w900),
      textAlign: textAlign,
    );
  }

  FPVText extraBold() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontWeight: FontWeight.w800),
      textAlign: textAlign,
    );
  }

  FPVText s12() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 12),
      textAlign: textAlign,
    );
  }

  FPVText s14() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 14),
      textAlign: textAlign,
    );
  }

  FPVText s16() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 16),
      textAlign: textAlign,
    );
  }

  FPVText s18() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 18),
      textAlign: textAlign,
    );
  }

  FPVText s20() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 20),
      textAlign: textAlign,
    );
  }

  FPVText s24() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(fontSize: 24),
      textAlign: textAlign,
    );
  }

  FPVText color(Color? color) {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  FPVText align(TextAlign align) {
    return FPVText._builder(text: text, textStyle: textStyle, textAlign: align);
  }

  FPVText lineThrough() {
    return FPVText._builder(
      text: text,
      textStyle: textStyle.copyWith(decoration: TextDecoration.lineThrough),
      textAlign: textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle, textAlign: textAlign);
  }
}
