library weoveri_capsule_button;

import 'package:flutter/material.dart';

/// An all in one capsule button
class MyCapsuleButton extends StatelessWidget {
  const MyCapsuleButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.borderRadius = 50,
    this.showIcon = true,
    this.myIcon,
    this.isFilled,
    this.isLight = false,
    this.isExpanded = false,
    this.isRevresed = true,
    this.contentPadding,
    this.textStyle,
    this.borderColor,
    this.contentVerticalPadding,
    this.heigth,
    this.fillColor,
    this.isResponsiveText = false,
    this.child,
  }) : super(key: key);
  final double borderRadius;
  final bool showIcon;
  final Widget? myIcon;
  final bool isResponsiveText;
  final String? text;
  final VoidCallback? onTap;
  final bool? isFilled;
  final bool isLight;
  final bool isExpanded;
  final bool isRevresed;
  final EdgeInsets? contentPadding;
  final TextStyle? textStyle;
  final Color? borderColor;
  final EdgeInsets? contentVerticalPadding;
  final double? heigth;
  final Color? fillColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isFilled == false
              ? Colors.transparent
              : isLight
                  ? Colors.white
                  : fillColor ?? Colors.black,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isFilled == false
                ? borderColor ?? Colors.white
                : Colors.transparent,
          ),
        ),
        padding: contentPadding ??
            const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
        height: !isExpanded ? heigth ?? 38 : null,
        child: child ??
            (isRevresed
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isExpanded
                          ? Expanded(
                              child: _textContainer(),
                            )
                          : _textContainer(),
                      showIcon
                          ? myIcon ??
                              const Icon(
                                Icons.link,
                                color: Colors.white,
                                size: 18,
                              )
                          : Container(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showIcon
                          ? SizedBox(
                              child: myIcon ??
                                  const Icon(
                                    Icons.link,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                            )
                          : Container(),
                      isExpanded
                          ? Expanded(
                              child: _textContainer(),
                            )
                          : _textContainer(),
                    ],
                  )),
      ),
    );
  }

  Widget _textContainer() {
    return Container(
      margin: EdgeInsets.only(
        left: (!isRevresed && showIcon) ? 13 : 0,
        right: (isRevresed && showIcon) ? 13 : 0,
        top: contentVerticalPadding?.top ?? 10,
        bottom: contentVerticalPadding?.bottom ?? 10,
      ),
      child: isResponsiveText
          ? Text(
              text!,
              style: textStyle ??
                  const TextStyle(
                    fontFamily: "EuclidSquareRegular",
                    height: 1.4,
                    color: Colors.white,
                    letterSpacing: 0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
              maxLines: 1,
            )
          : Text(
              text!,
              overflow: TextOverflow.ellipsis,
              style: textStyle ??
                  TextStyle(
                    height: 1,
                    color: isLight ? Colors.black : Colors.white,
                    fontSize: 11,
                  ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
