import 'package:flutter/material.dart';
import 'package:weoveri_button/utils/woi_button_style.dart';
import '../utils/enums.dart';

class WoiTextButton extends StatelessWidget {
  /// The all in one button
  const WoiTextButton({
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
    this.text = '',
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
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        decoration: _boxDecorator(),
        height: buttonStyle?.height ?? heigth ?? 38,
        width: buttonStyle?.width ?? width,
        child: _bodyWidgets(),
      ),
    );
  }

  Widget _bodyWidgets() {
    return Row(
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
    );
  }

  Widget _textContainer() {
    if (text == '') {
      return Container();
    }
    return Container(
      margin: buttonStyle?.textMargin,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: buttonStyle?.textStyle ??
            const TextStyle(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }

  BoxDecoration _boxDecorator() {
    return BoxDecoration(
      color: buttonStyle?.backgroundColor ?? fillColor ?? Colors.black,
      borderRadius:
          buttonStyle?.borderRadius ?? BorderRadius.circular(borderRadius),
      border: buttonStyle?.border ??
          Border.all(
            color: borderColor ?? Colors.black,
          ),
      gradient: buttonStyle?.gradient,
      boxShadow: buttonStyle?.boxShadow ?? boxShadowList,
    );
  }

  Widget _prePostWidgets() {
    if (buttonStyle?.sideWidget != null) {
      return SizedBox(
        height: buttonStyle?.sideWidgetSize,
        width: buttonStyle?.sideWidgetSize,
        child: buttonStyle!.sideWidget!,
      );
    }
    return Container();
  }
}
