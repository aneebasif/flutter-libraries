import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:weoveri_flutter_widgets/steppers/steppers_model.dart';

/// The is the stepper widget that has multiple variations based enwrapped in multiple constructor.
///
/// If only a stepper is required that has only icons then use [WOIStepper.icons]. This have the fields dedicated to custumize the icons in the widget.
///
/// Here is the small example for this:
/// ```dart
/// Padding(
///   padding: const EdgeInsets.all(10),
///   child: WOIStepper.icons(
///     activeStateIndex: currentStepperIndex,
///     activeSeparatorWidget: Container(
///       height: 2,
///       color: Colors.black,
///     ),
///     iconData: const [
///       Icons.home,
///       Icons.person,
///       Icons.check,
///     ],
///     completedIconTheme: IconStepperItemStyle(
///       boxDecoration: const BoxDecoration(
///         color: Colors.black,
///         shape: BoxShape.circle,
///       ),
///       iconThemeData: const IconThemeData(
///         color: Colors.white,
///       ),
///     ),
///   ),
/// ),
/// ```
///
/// Furthure moving on to the a variation that include the icons and text which is [WOIStepper.iconText].
/// This provides the options to add text along with the icons while custumize the states for both widgets.
///
/// Here is a small example on how to use that:
/// ```dart
/// Padding(
///   padding: const EdgeInsets.all(10),
///   child: WOIStepper.iconText(
///     activeStateIndex: currentStepperIndex,
///     activeSeparatorWidget: Container(
///       height: 2,
///       color: Colors.black,
///     ),
///     textItemsList: const [
///       'Step1',
///       'Step2',
///       'Step3',
///     ],
///   ),
/// ),
/// ```
///
/// Moving on to the a variation that include the counters and text which is [WOIStepper.counterText].
/// This provides the options to add counter widget as a sufix along with the text while providing the custumization for all states.
/// Here is a small example on how to use that:
///```dart
/// Padding(
///   padding: const EdgeInsets.all(10),
///   child: WOIStepper.counterText(
///     activeStateIndex: currentStepperIndex,
///     activeSeparatorWidget: Container(
///       height: 2,
///       color: Colors.black,
///     ),
///     textItemsList: const [
///       'Step1',
///       'Step2',
///       'Step3',
///     ],
///   ),
/// ),
///```
///
/// Lastly we have a variation which can be used to create your own version of stepper called [WOIStepper.custom].
/// This widget is so powerfull that it provides with the option to customize the whole stepper widget as much an however you want
/// This breaks down to 3 states active, inactive and completed.
///
///
class WOIStepper extends StatefulWidget {
  /// Styling for the completed state of the stepper.
  final StepperStyle? completedState;

  /// Styling for the active state of the stepper.
  final StepperStyle? activeState;

  /// Styling for the inactive state of the stepper.
  final StepperStyle? inactiveState;

  /// List of text items displayed in the stepper.
  final List<String> textItemsList;

  /// List of suffix widgets associated with each step in the stepper.
  final List<SufixWidgetStepper>? sufixWidgetItemsList;

  /// Widget to be used as a separator for active steps.
  final Widget? activeSeparatorWidget;

  /// Widget to be used as a separator for inactive steps.
  final Widget? inactiveSeparatorWidget;

  /// Index of the currently active step.
  final int activeStateIndex;

  /// Padding for the items in the stepper.
  final EdgeInsets? itemsPadding;

  /// Padding for the separators in the stepper.
  final EdgeInsets? saperatorsPadding;

  /// Padding for the overall background of the stepper.
  final EdgeInsets? backgroundPadding;

  /// Decoration for the overall background of the stepper.
  final BoxDecoration? backgroundDecorator;

  /// Margin for the items in the stepper.
  final EdgeInsets? itemsMargin;

  /// Decoration for the active item in the stepper.
  final BoxDecoration? itemActiveDecorator;

  /// Decoration for the inactive item in the stepper.
  final BoxDecoration? itemInactiveDecorator;

  /// Decoration for the completed item in the stepper.
  final BoxDecoration? itemCompletedDecorator;

  /// List of subtext associated with each step in the stepper.
  final List<String>? subtextList;

  /// Style for the subtext in the stepper.
  final TextStyle? subtextStyle;

  /// Axis along which the stepper should be oriented (default is horizontal).
  final Axis axis;

  /// Height of the stepper.
  final double? height;

  /// Width of the stepper.
  final double? width;

  /// Padding for the text items in the stepper.
  final EdgeInsets? textPadding;

  /// Creates an instance of [WOIStepper].
  ///
  /// This constructor has all of the fields for the steppers
  /// giving it the most powerfull one so far but complex one as well
  ///
  /// Using this you can create your own stepper variation with as much custumizations as possible.
  const WOIStepper.custom({
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
    this.axis = Axis.horizontal,
    this.height,
    this.width,
    this.textPadding,
  }) : assert(
          (sufixWidgetItemsList == null) ||
              textItemsList.length == sufixWidgetItemsList.length,
          "\n\n\"Sufix widgets lenght is not equal to Text items\"\n\n",
        );

  /// Creates an instance of [WOIStepper] with counters as sufix widgets.
  ///
  /// The [textStyle] defines the style of the counter text.
  /// The [counterTextStyle] defines the style of the counter text.
  /// The [counterPadding] defines the padding of the counter.
  /// The [counterMargin] defines the margin of the counter.
  /// The [activeColor], [completedColor] and [inactiveColor] will define color for both text and counter in those states.
  ///
  ///
  /// If [subtextList] is provided then need to make sure its lenght is similar to the [textItemsList]
  /// otherwise it would through error
  /// Here is a small example on how to use that:
  ///```dart
  /// Padding(
  ///   padding: const EdgeInsets.all(10),
  ///   child: WOIStepper.counterText(
  ///     activeStateIndex: currentStepperIndex,
  ///     activeSeparatorWidget: Container(
  ///       height: 2,
  ///       color: Colors.black,
  ///     ),
  ///     textItemsList: const [
  ///       'Step1',
  ///       'Step2',
  ///       'Step3',
  ///     ],
  ///   ),
  /// ),
  ///```
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
    TextStyle? counterTextStyle,
    this.axis = Axis.horizontal,
    this.height,
    this.width,
    this.textPadding,
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

  /// Creates an instance of [WOIStepper] as icons as their items.
  ///
  ///
  /// The [activeIconTheme], [inactiveIconTheme] and [completedIconTheme] will be responsible for
  ///  defining the themes of icons in those states.
  /// Here is the small example for this:
  /// ```dart
  /// Padding(
  ///   padding: const EdgeInsets.all(10),
  ///   child: WOIStepper.icons(
  ///     activeStateIndex: currentStepperIndex,
  ///     activeSeparatorWidget: Container(
  ///       height: 2,
  ///       color: Colors.black,
  ///     ),
  ///     iconData: const [
  ///       Icons.home,
  ///       Icons.person,
  ///       Icons.check,
  ///     ],
  ///     completedIconTheme: IconStepperItemStyle(
  ///       boxDecoration: const BoxDecoration(
  ///         color: Colors.black,
  ///         shape: BoxShape.circle,
  ///       ),
  ///       iconThemeData: const IconThemeData(
  ///         color: Colors.white,
  ///       ),
  ///     ),
  ///   ),
  /// ),
  /// ```
  WOIStepper.icons({
    super.key,
    this.activeSeparatorWidget,
    this.inactiveSeparatorWidget,
    required this.activeStateIndex,
    required List<IconData> iconData,
    IconStepperItemStyle? activeIconTheme,
    IconStepperItemStyle? inactiveIconTheme,
    IconStepperItemStyle? completedIconTheme,
    this.itemsPadding,
    this.saperatorsPadding,
    this.backgroundPadding,
    this.backgroundDecorator,
    this.axis = Axis.horizontal,
    this.itemsMargin,
    this.height,
    this.width,
  })  : assert(
            iconData.length > 1, '[iconData] length should be greater then 1'),
        textPadding = null,
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

  /// Creates an instance of [WOIStepper] as combinations for (optional) icons and text as their items.
  ///
  ///
  /// The [iconList] would be used to provide the icons with the items.
  /// if [iconList] is provided then its lenght needs to be equal to that of the [textItemsList] otherwise it would through error.
  ///
  /// [activeIcon], [inactiveIcon] and [completedIcon] will be displaed based on the state for the item.
  ///
  ///Here is a small example on how to use that:
  /// ```dart
  /// Padding(
  ///   padding: const EdgeInsets.all(10),
  ///   child: WOIStepper.iconText(
  ///     activeStateIndex: currentStepperIndex,
  ///     activeSeparatorWidget: Container(
  ///       height: 2,
  ///       color: Colors.black,
  ///     ),
  ///     textItemsList: const [
  ///       'Step1',
  ///       'Step2',
  ///       'Step3',
  ///     ],
  ///   ),
  /// ),
  /// ```
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
    Color? activeColor,
    Color? completedColor,
    Color? inactiveColor,
    Widget? completedIcon,
    Widget? activeIcon,
    Widget? inactiveIcon,
    TextStyle? textStyle,
    this.axis = Axis.horizontal,
    this.height,
    this.width,
    this.textPadding,
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
    return Container(
      height: widget.axis.index == Axis.vertical.index
          ? widget.height ?? 200
          : widget.height,
      width: widget.width,
      padding: widget.backgroundPadding ?? const EdgeInsets.all(12),
      decoration: widget.backgroundDecorator ??
          BoxDecoration(
            border: Border.all(),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
      child: widget.axis.index == Axis.horizontal.index
          ? Row(
              // Horizontal View
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
            )
          : Column(
              // Verticle View
              crossAxisAlignment: CrossAxisAlignment.center,
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

  /// Returns the text style for a specific step based on its index.
  /// If no specific state styling is provided, it falls back to default text style.
  /// Handles states such as completed, active, and inactive.
  TextStyle _getTextStyle(int index) {
    // Default text style for inactive state or user-defined style.

    TextStyle textStyle = widget.inactiveState?.textStyle ?? // Inactive State
        const TextStyle(
          color: Colors.grey,
        );

    if (index < widget.activeStateIndex) {
      // Completed State: Use the specified completed state text style or fallback to default or user-defined.
      textStyle = widget.completedState?.textStyle ?? textStyle;
    } else if (index == widget.activeStateIndex) {
      // Active State: Use the specified active state text style, completed state, or fallback to default or user-defined.
      textStyle = widget.activeState?.textStyle ??
          widget.completedState?.textStyle ??
          textStyle;

      // Will use completed state text style if no active state style is provided.
    }

    return textStyle;
  }

  /// Returns the suffix widget for a specific step based on its index.
  /// If no specific state styling is provided, it falls back to default widget.
  /// Handles states such as completed, active, and inactive.
  Widget _getSufixWidget(int index) {
    // User-defined widget for inactive state or fallback to a default container.

    Widget userWidget = widget.sufixWidgetItemsList?[index].inactiveState ??
        widget.sufixWidgetItemsList?[index].widget ??
        Container();

    // Default widget for inactive state or user-defined widget.

    Widget sufixWidget = widget.inactiveState?.sufixWidget ?? userWidget;

    if (index < widget.activeStateIndex) {
      // Completed State: Use the specified completed state widget or fallback to user-defined or default.
      sufixWidget = widget.completedState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].completedState ??
          userWidget;
    } else if (index == widget.activeStateIndex) {
      // Active State: Use the specified active state widget, user-defined, or fallback to completed state or default.
      sufixWidget = widget.activeState?.sufixWidget ??
          widget.sufixWidgetItemsList?[index].activeState ??
          widget.completedState?.sufixWidget ??
          userWidget;
    }

    return sufixWidget;
  }

  /// Returns the box decoration for a specific step based on its index.
  /// If no specific state decoration is provided, it falls back to default decoration.
  /// Handles states such as completed, active, and inactive.
  BoxDecoration _getItemDecorator(int index) {
    // Default item decoration for inactive state decoration.

    BoxDecoration decoration = widget.itemInactiveDecorator ??
        BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
          ),
        );

    if (index < widget.activeStateIndex) {
      // Completed State: Use the specified completed state decoration or fallback to default.
      decoration = widget.itemCompletedDecorator ?? decoration;
    } else if (index == widget.activeStateIndex) {
      // Active State: Use the specified active state decoration or fallback to default or user-defined.
      decoration = widget.itemActiveDecorator ?? decoration;
    }

    return decoration;
  }

  /// Stepper Item Widget that returns the Text and optional Sufix widget
  Widget stepItem(int index) {
    String text = widget.textItemsList[index];
    String subText = '';
    if (widget.subtextList != null) {
      subText = widget.subtextList?[index] ?? '';
    }
    TextStyle textStyle = _getTextStyle(index);

    Widget sufixWidget = _getSufixWidget(index);

    BoxDecoration decoration = _getItemDecorator(index);

    return Container(
      padding: widget.itemsPadding ?? const EdgeInsets.all(5),
      margin: widget.itemsMargin,
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          sufixWidget,
          textWidget(
            text,
            textStyle,
            subText,
          ),
        ],
      ),
    );
  }

  /// Generates a widget with a primary text and an optional subtext.
  /// Allows customization of text style and subtext style.
  Widget textWidget(
    String text,
    TextStyle textStyle,
    String subText,
  ) {
    return Padding(
      padding: widget.textPadding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primary Text
          Text(
            text,
            style: textStyle,
          ),

          // Optional Subtext
          subText.isEmpty
              ? const SizedBox()
              : Text(
                  subText,
                  style: (widget.subtextStyle ?? const TextStyle()).copyWith(
                    color: textStyle.color,
                  ),
                ),
        ],
      ),
    );
  }
}
