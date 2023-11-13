import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/steppers/steppers_model.dart';

class IconStepperItemStyle {
  IconThemeData? iconThemeData;
  BoxDecoration? boxDecoration;
  IconStepperItemStyle({
    this.iconThemeData,
    this.boxDecoration = const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
    ),
  });
}

class WOIStepper extends StatefulWidget {
  const WOIStepper({
    super.key,
    this.completedState,
    this.activeState,
    this.inactiveState,
    required this.activeStateIndex,
    required this.textItemsList,
    this.activeSeparatorWidget,
    this.inactiveSeparatorWidget,
    this.itemsPadding,
    this.saperatorsPadding,
    this.backgroundPadding,
    this.backgroundDecorator,
    this.sufixWidgetItemsList,
    this.itemsMargin,
    this.itemActiveDecorator,
    this.itemInactiveDecorator,
    this.itemCompletedDecorator,
    this.subtextList,
    this.subtextStyle,
  }) : assert(
          (sufixWidgetItemsList == null) ||
              textItemsList.length == sufixWidgetItemsList.length,
          "\n\n\"Sufix widgets lenght is not equal to Text items\"\n\n",
        );

  final StepperStyle? completedState;
  final StepperStyle? activeState;
  final StepperStyle? inactiveState;
  final List<String> textItemsList;
  final List<SufixWidgetStepper>? sufixWidgetItemsList;
  final Widget? activeSeparatorWidget;
  final Widget? inactiveSeparatorWidget;
  final int activeStateIndex;
  final EdgeInsets? itemsPadding;
  final EdgeInsets? saperatorsPadding;
  final EdgeInsets? backgroundPadding;
  final BoxDecoration? backgroundDecorator;
  final EdgeInsets? itemsMargin;
  final BoxDecoration? itemActiveDecorator;
  final BoxDecoration? itemInactiveDecorator;
  final BoxDecoration? itemCompletedDecorator;
  final List<String>? subtextList;
  final TextStyle? subtextStyle;

  WOIStepper.counterText({
    super.key,
    required this.textItemsList,
    this.activeSeparatorWidget,
    this.inactiveSeparatorWidget,
    required this.activeStateIndex,
    this.itemsPadding,
    this.saperatorsPadding,
    this.backgroundPadding,
    this.backgroundDecorator,
    this.itemsMargin,
    EdgeInsets? counterPadding,
    EdgeInsets? counterMargin,
    Color? activeColor,
    Color? completedColor,
    Color? inactiveColor,
    this.subtextList,
    this.subtextStyle,
    TextStyle? textStyle,
    TextStyle? subtextstyle,
    TextStyle? counterTextStyle,
  })  : assert(textItemsList.length > 1,
            '[textItemsList] length should be greater then 1'),
        assert(
            subtextList == null || (subtextList.length == textItemsList.length),
            '\n[subtextList] length should be equal to [textItemsList]'),
        sufixWidgetItemsList = List.generate(
          textItemsList.length,
          (index) => SufixWidgetStepper(
            widget: Container(
              padding: counterPadding ?? const EdgeInsets.all(5),
              margin: counterMargin ??
                  const EdgeInsets.only(
                    right: 5,
                  ),
              decoration: BoxDecoration(
                border: Border.all(),
                shape: BoxShape.circle,
              ),
              child: Text(
                (index + 1).toString(),
              ),
            ),
            inactiveState: Container(
              padding: counterPadding ?? const EdgeInsets.all(5),
              margin: counterMargin ??
                  const EdgeInsets.only(
                    right: 5,
                  ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: inactiveColor ?? Colors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                (index + 1).toString(),
                style: (counterTextStyle ?? const TextStyle())
                    .copyWith(color: inactiveColor ?? Colors.black),
              ),
            ),
            activeState: Container(
              padding: counterPadding ?? const EdgeInsets.all(5),
              margin: counterMargin ??
                  const EdgeInsets.only(
                    right: 5,
                  ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: activeColor ?? Colors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                (index + 1).toString(),
                style: (counterTextStyle ?? const TextStyle()).copyWith(
                  color: activeColor ?? Colors.black,
                ),
              ),
            ),
            completedState: Container(
              padding: counterPadding ?? const EdgeInsets.all(5),
              margin: counterMargin ??
                  const EdgeInsets.only(
                    right: 5,
                  ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: completedColor ?? Colors.black,
                ),
                shape: BoxShape.circle,
              ),
              child: Text(
                (index + 1).toString(),
                style: (counterTextStyle ?? const TextStyle())
                    .copyWith(color: completedColor ?? Colors.black),
              ),
            ),
          ),
        ),
        inactiveState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: inactiveColor,
          ),
        ),
        activeState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: activeColor,
          ),
        ),
        completedState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: completedColor,
          ),
        ),
        itemActiveDecorator = null,
        itemInactiveDecorator = null,
        itemCompletedDecorator = null;

  WOIStepper.icons({
    super.key,
    this.activeSeparatorWidget,
    this.inactiveSeparatorWidget,
    required this.activeStateIndex,
    required List<IconData> iconData,
    Color? activeIconsColor,
    IconStepperItemStyle? activeIconTheme,
    IconStepperItemStyle? inactiveIconTheme,
    IconStepperItemStyle? completedIconTheme,
    this.itemsPadding,
    this.saperatorsPadding,
    this.backgroundPadding,
    this.backgroundDecorator,
    // activeDecorator
    this.itemsMargin,
  })  : assert(
            iconData.length > 1, '[iconData] length should be greater then 1'),
        sufixWidgetItemsList = List.generate(
          iconData.length,
          (index) => SufixWidgetStepper(
            widget: Icon(iconData[index]),
            activeState: (activeIconTheme?.iconThemeData != null)
                ? (IconTheme(
                    data: activeIconTheme!.iconThemeData!,
                    child: Icon(iconData[index]),
                  ))
                : null,
            inactiveState: (inactiveIconTheme?.iconThemeData != null)
                ? (IconTheme(
                    data: inactiveIconTheme!.iconThemeData!,
                    child: Icon(iconData[index]),
                  ))
                : null,
            completedState: (completedIconTheme?.iconThemeData != null)
                ? (IconTheme(
                    data: completedIconTheme!.iconThemeData!,
                    child: Icon(iconData[index]),
                  ))
                : null,
          ),
        ),
        itemActiveDecorator = activeIconTheme?.boxDecoration ??
            BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
            ),
        itemInactiveDecorator = inactiveIconTheme?.boxDecoration ??
            BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
            ),
        itemCompletedDecorator = completedIconTheme?.boxDecoration ??
            BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.black,
              border: Border.all(
                color: Colors.black,
              ),
            ),
        inactiveState = null,
        activeState = null,
        textItemsList = List.generate(
          iconData.length,
          (index) => '',
        ),
        completedState = null,
        subtextList = null,
        subtextStyle = null;

  WOIStepper.iconText({
    super.key,
    required this.textItemsList,
    this.activeSeparatorWidget,
    this.inactiveSeparatorWidget,
    required this.activeStateIndex,
    this.itemsPadding,
    this.saperatorsPadding,
    this.backgroundPadding,
    this.backgroundDecorator,
    this.itemsMargin,
    List<Icon>? iconList,
    EdgeInsets? counterPadding,
    EdgeInsets? counterMargin,
    Color? activeColor,
    Color? completedColor,
    Color? inactiveColor,
    Widget? completedIcon,
    Widget? activeIcon,
    Widget? inactiveIcon,
    TextStyle? textStyle,
  })  : assert(textItemsList.length > 1,
            '[textItemsList] length should be greater then 1'),
        assert(
            iconList == null ||
                ((iconList.length == textItemsList.length) || iconList.isEmpty),
            '\n[iconData] length should be equal to [textItemsList]'),
        subtextList = null,
        subtextStyle = null,
        sufixWidgetItemsList = List.generate(
          textItemsList.length,
          (index) => SufixWidgetStepper(
            widget: iconList != null ? iconList[index] : const SizedBox(),
            inactiveState: inactiveIcon,
            activeState: activeIcon ??
                const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                ),
            completedState: completedIcon ??
                const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                ),
          ),
        ),
        inactiveState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: inactiveColor,
          ),
        ),
        activeState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: activeColor,
          ),
        ),
        completedState = StepperStyle(
          textStyle: (textStyle ?? const TextStyle()).copyWith(
            color: completedColor,
          ),
        ),
        itemActiveDecorator = null,
        itemInactiveDecorator = null,
        itemCompletedDecorator = null;

  @override
  State<WOIStepper> createState() => _WOIStepperState();
}

class _WOIStepperState extends State<WOIStepper> {
  @override
  Widget build(BuildContext context) {
    return
        //
        // ListView();
        Container(
      padding: widget.backgroundPadding ?? const EdgeInsets.all(12),
      decoration: widget.backgroundDecorator ??
          BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          _computeActualChildCount(widget.textItemsList.length),
          (index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return stepItem(itemIndex);
            }
            return separatorItem(itemIndex);
          },
        ),
      ),
    );
  }

  /// Calculatete the total lenght of list while combining the saperator and actual items
  static int _computeActualChildCount(int itemCount) {
    return math.max(0, itemCount * 2 - 1);
  }

  /// The saperateor Item that would be inbetween the actual items
  Widget separatorItem(int index) {
    Widget saperator = Container();
    // List list = widget.ac;
    Widget activeSaparator = widget.activeSeparatorWidget ?? saperator;
    Widget inactiveSaparator = widget.inactiveSeparatorWidget ?? saperator;

    return Expanded(
      child: Padding(
        padding: widget.saperatorsPadding ?? EdgeInsets.zero,
        child: widget.activeStateIndex > index
            ? activeSaparator
            : inactiveSaparator,
      ),
    );
  }

  /// Stepper Item Widget that returns the Text and optional Sufix widget
  Widget stepItem(int index) {
    String text = widget.textItemsList[index];
    String subText = '';
    if (widget.subtextList != null) {
      subText = widget.subtextList?[index] ?? '';
    }
    TextStyle textStyle = widget.inactiveState?.textStyle ?? // Inactive State
        const TextStyle(
          color: Colors.grey,
        );

    Widget userWidget = widget.sufixWidgetItemsList?[index].inactiveState ??
        widget.sufixWidgetItemsList?[index].widget ??
        Container();
    Widget sufixWidget = widget.inactiveState?.sufixWidget ?? userWidget;

    BoxDecoration decoration = widget.itemInactiveDecorator ??
        BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
        );
    if (index < widget.activeStateIndex) {
      // Completed State
      textStyle = widget.completedState?.textStyle ?? textStyle;
      sufixWidget = widget.completedState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].completedState ??
          userWidget;
      decoration = widget.itemCompletedDecorator ?? decoration;
    } else if (index == widget.activeStateIndex) {
      // Active State
      textStyle = widget.activeState?.textStyle ??
          widget.completedState?.textStyle ??
          textStyle; // Will use completed state if no active state style is provided
      sufixWidget = widget.activeState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].activeState ??
          widget.completedState?.sufixWidget ??
          userWidget;
      decoration = widget.itemActiveDecorator ?? decoration;
    }
    return Container(
      padding: widget.itemsPadding ?? const EdgeInsets.all(5),
      margin: widget.itemsMargin,
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sufixWidget,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: textStyle,
              ),
              subText.isEmpty
                  ? const SizedBox()
                  : Text(
                      subText,
                      style: (widget.subtextStyle ?? const TextStyle())
                          .copyWith(color: textStyle.color),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
