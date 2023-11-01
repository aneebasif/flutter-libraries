import 'package:flutter/material.dart';

class HorizontalTextIconStepperStyle {
  TextStyle textStyle;
  Widget? sufixWidget;
  HorizontalTextIconStepperStyle({
    required this.textStyle,
    this.sufixWidget,
  });
}

class SufixWidgetStepper {
  Widget widget;
  Widget? completedState;
  Widget? activeState;
  Widget? inactiveState;
  SufixWidgetStepper({
    required this.widget,
    this.completedState,
    this.activeState,
    this.inactiveState,
  });
}
