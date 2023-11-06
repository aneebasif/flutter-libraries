import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/steppers/steppers_model.dart';

class WOIHorizontalTextIconStepper extends StatefulWidget {
  const WOIHorizontalTextIconStepper({
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
  }) : assert(
          (sufixWidgetItemsList == null) ||
              textItemsList.length == sufixWidgetItemsList.length,
          "\n\n\"Sufix widgets lenght is not equal to Text items\"\n\n",
        );

  final HorizontalTextIconStepperStyle? completedState;
  final HorizontalTextIconStepperStyle? activeState;
  final HorizontalTextIconStepperStyle? inactiveState;
  final List<String> textItemsList;
  final List<SufixWidgetStepper>? sufixWidgetItemsList;
  final Widget? activeSeparatorWidget;
  final Widget? inactiveSeparatorWidget;
  final int activeStateIndex;
  final EdgeInsets? itemsPadding;
  final EdgeInsets? saperatorsPadding;
  final EdgeInsets? backgroundPadding;
  final BoxDecoration? backgroundDecorator;

  @override
  State<WOIHorizontalTextIconStepper> createState() =>
      _WOIHorizontalTextIconStepperState();
}

class _WOIHorizontalTextIconStepperState
    extends State<WOIHorizontalTextIconStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.backgroundPadding ?? const EdgeInsets.all(12),
      decoration: widget.backgroundDecorator ??
          BoxDecoration(
            border: Border.all(),
            color: Colors.red,
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
    TextStyle textStyle = widget.inactiveState?.textStyle ?? // Inactive State
        const TextStyle(
          color: Colors.grey,
        );

    Widget userWidget =
        widget.sufixWidgetItemsList?[index].widget ?? Container();
    Widget sufixWidget = widget.inactiveState?.sufixWidget ?? userWidget;
    if (index < widget.activeStateIndex) {
      // Completed State
      textStyle = widget.completedState?.textStyle ?? textStyle;
      sufixWidget = widget.completedState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].completedState ??
          userWidget;
    } else if (index == widget.activeStateIndex) {
      // Active State
      textStyle = widget.activeState?.textStyle ??
          widget.completedState?.textStyle ??
          textStyle; // Will use completed state if no active state style is provided
      sufixWidget = widget.activeState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].activeState ??
          widget.completedState?.sufixWidget ??
          userWidget;
    }
    return Container(
      color: Colors.green,
      margin: widget.itemsPadding,
      // child: sufixWidget,
      child: Row(
        children: [
          sufixWidget,
          Text(
            text,
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
