import 'package:flutter/material.dart';
import 'package:weoveri_button/main.dart';

class WoiButtonStyle {
  TextStyle? textStyle;
  BorderRadius? borderRadius;
  Border? border;
  Widget? sideWidget;
  double? sideWidgetSize;
  WidgetLocation widgetLocation;
  Color? backgroundColor;
  List<BoxShadow>? boxShadow;
  Gradient? gradient;
  double? height;
  double? width;
  EdgeInsets? textMargin;
  WoiButtonStyle({
    this.textStyle,
    this.borderRadius,
    this.border,
    this.sideWidget,
    this.sideWidgetSize,
    this.widgetLocation = WidgetLocation.start,
    this.backgroundColor,
    this.boxShadow,
    this.gradient,
    this.height,
    this.width,
    this.textMargin,
  });
}
