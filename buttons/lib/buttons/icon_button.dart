import 'package:flutter/material.dart';

class WOIIconButton extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final bool isDisabled;
  final Function? onTap;
  final BorderRadius? borderRadius;
  final Widget? child;

  /// An Icon button with custom border radius
  ///
  /// Atleast one field in `icon` or `child` is required
  const WOIIconButton({
    Key? key,
    this.size = 35,
    this.backgroundColor = Colors.black,
    this.border,
    this.boxShadow,
    this.borderRadius,
    this.isDisabled = false,
    required this.onTap,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              if (isDisabled) {
                return;
              }
              onTap!();
            },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          boxShadow: boxShadow,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: child ?? Container(),
        ),
      ),
    );
  }
}
