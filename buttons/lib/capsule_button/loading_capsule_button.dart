import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';
import 'package:weoveri_button/enums.dart';

import 'base_capsule_button.dart';

/// An all in one capsule button
class WoiCapsuleLoadingButton extends StatelessWidget {
  WoiCapsuleLoadingButton({
    Key? key,
    required this.onTap,
    this.textStyle,
    this.borderColor,
    this.heigth,
    this.width,
    this.fillColor,
    this.isDisabled = false,
    this.circularProgressSize = 20,
    required this.circularProgressIndicator,
    this.boxShadowList,
    this.text = '',
    this.widgetLocation = WidgetLocation.start,
    this.borderWidth = 1,
  }) : super(key: key);
  final VoidCallback? onTap;
  final TextStyle? textStyle;
  final String text;
  final Color? borderColor;
  final double? heigth;
  final Color? fillColor;
  final double? width;
  final bool isDisabled;
  final CircularProgressIndicator circularProgressIndicator;
  final double circularProgressSize;
  final List<BoxShadow>? boxShadowList;
  final Color disabledColor = const Color(0xffD9D9D9);
  final WidgetLocation widgetLocation;
  final double borderWidth;

  final WoiButtonStyle buttonStyle = WoiButtonStyle(
    border: Border.all(
      color: Colors.black,
    ),
    backgroundColor: Colors.black,
    borderRadius: BorderRadius.circular(50),
  );

  @override
  Widget build(BuildContext context) {
    return WoiBaseButton(
      onTap: () {
        if (isDisabled) {
          return;
        }
        onTap!();
      },
      buttonStyle: WoiButtonStyle(
        backgroundColor: fillColor ?? buttonStyle.backgroundColor,
        text: text,
        height: heigth,
        widgetLocation: widgetLocation,
        width: width,
        boxShadow: boxShadowList,
        textStyle: textStyle,
        border: Border.all(
          color: borderColor ?? Colors.black,
          width: borderWidth,
        ),
      ),
    );
  }
}
