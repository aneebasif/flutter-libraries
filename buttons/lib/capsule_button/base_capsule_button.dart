import 'package:flutter/material.dart';
import 'package:weoveri_button/capsule_button/woi_button_style.dart';

import '../enums.dart';

/// An all in one capsule button
class WoiBaseButton extends StatelessWidget {
  const WoiBaseButton({
    Key? key,
    this.onTap,
    this.borderRadius = 50,
    this.borderColor,
    this.heigth,
    this.width,
    this.fillColor,
    this.isDisabled = false,
    this.boxShadowList,
    this.buttonStyle,
  }) : super(key: key);
  final double borderRadius;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double? heigth;
  final Color? fillColor;
  final double? width;
  final bool isDisabled;
  final List<BoxShadow>? boxShadowList;
  final WoiButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          color: buttonStyle?.backgroundColor ?? fillColor ?? Colors.black,
          borderRadius:
              buttonStyle?.borderRadius ?? BorderRadius.circular(borderRadius),
          border: buttonStyle?.border ??
              Border.all(
                color: borderColor ?? Colors.black,
              ),
          gradient: buttonStyle?.gradient,
          boxShadow: buttonStyle?.boxShadow ?? boxShadowList,
        ),
        height: buttonStyle?.height ?? heigth ?? 38,
        width: buttonStyle?.width ?? width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (buttonStyle?.widgetLocation ?? WidgetLocation.start) ==
                    WidgetLocation.start
                ? _prePostWidgets()
                : Container(),
            _textContainer(),
            (buttonStyle?.widgetLocation ?? WidgetLocation.start) ==
                    WidgetLocation.end
                ? _prePostWidgets()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _prePostWidgets() {
    if (buttonStyle?.widget != null) {
      return buttonStyle!.widget!;
    }
    if (buttonStyle?.circularProgressIndicator != null) {
      return SizedBox(
        height: buttonStyle?.progressIndicatorheight,
        width: buttonStyle?.progressIndicatorheight,
        child: buttonStyle?.circularProgressIndicator,
      );
    }
    return Container();
  }

  Widget _textContainer() {
    if (buttonStyle?.text == null) {
      return Container();
    }
    return Text(
      buttonStyle?.text ?? '',
      overflow: TextOverflow.ellipsis,
      style: buttonStyle?.textStyle ??
          const TextStyle(
            height: 1,
            color: Colors.white,
            fontSize: 11,
          ),
      textAlign: TextAlign.center,
    );
  }
}
