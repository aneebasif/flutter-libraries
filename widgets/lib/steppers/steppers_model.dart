import 'package:flutter/material.dart';

/// This style model is used to customize the stepper states that are `completed` `active` and `inactive`.
/// You can change the styles for the items based on the states.
class StepperStyle {
  TextStyle textStyle;
  Widget? suffixWidget;
  StepperStyle({
    required this.textStyle,
    this.suffixWidget,
  });
}

/// The stepper have multiple variations and one of them include the Icon variation
/// This model helps in defining the style for the icons in all 3 states.
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

/// This model class is used to help define the suffix widget along with its states
/// in all three states.
class SuffixWidgetStepper {
  Widget widget;
  Widget? completedState;
  Widget? activeState;
  Widget? inactiveState;
  SuffixWidgetStepper({
    required this.widget,
    this.completedState,
    this.activeState,
    this.inactiveState,
  });
}
