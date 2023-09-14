import 'package:flutter/material.dart';
import 'package:weoveri_button/main.dart';

class WoiButtonStyle {
  TextStyle? textStyle;
  BorderRadius? borderRadius;
  Border? border;
  Widget? widget;
  WidgetLocation widgetLocation;
  CircularProgressIndicator? circularProgressIndicator;
  String? text;
  Color? backgroundColor;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  double? height;
  double? width;
  double? progressIndicatorheight;
  WoiButtonStyle({
    this.textStyle,
    this.borderRadius,
    this.border,
    this.widget,
    this.widgetLocation = WidgetLocation.start,
    this.circularProgressIndicator,
    this.text,
    this.backgroundColor,
    this.boxShadow,
    this.gradient,
    this.height,
    this.width,
    this.progressIndicatorheight,
  });
}
