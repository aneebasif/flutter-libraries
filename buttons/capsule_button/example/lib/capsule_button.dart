import 'package:flutter/material.dart';

class MyCapsuleButton extends StatelessWidget {
  const MyCapsuleButton({
    Key? key,
    required this.text,
    this.showIcon = true,
    this.onPressed,
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
    this.showLoading = false,
    this.isResponsiveText = false,
    this.child,
  }) : super(key: key);
  final bool showIcon;
  final Widget? myIcon;
  final bool isResponsiveText;
  final String? text;
  final VoidCallback? onPressed;
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
  final bool showLoading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isFilled == false
              ? Colors.transparent
              : isLight
                  ? Colors.white
                  : fillColor ?? Colors.black,
          borderRadius: BorderRadius.circular(50),
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
                      showLoading
                          ? const Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: Center(
                                child: SizedBox(
                                  // height: 20,
                                  // // HelperMethods().getMyDynamicHeight(20),
                                  // width: 20,
                                  // // HelperMethods().getMyDynamicWidth(20),
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 3,
                                  ),
                                ),
                              ),
                            )
                          : showIcon
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
                      showLoading
                          ? const Center(
                              child: SizedBox(
                                // height:
                                //     HelperMethods().getMyDynamicHeight(20),
                                // width: HelperMethods().getMyDynamicWidth(20),
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 3,
                                ),
                              ),
                            )
                          : showIcon
                              ? SizedBox(
                                  // width:
                                  // HelperMethods().getMyDynamicWidth(20),
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
                    letterSpacing: 0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
              textAlign: TextAlign.center,
              // maxFontSize: 11,
              // minFontSize: 7,
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
