import 'package:flutter/material.dart';

class StepperStyle {
  TextStyle textStyle;
  Widget? sufixWidget;
  StepperStyle({
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
