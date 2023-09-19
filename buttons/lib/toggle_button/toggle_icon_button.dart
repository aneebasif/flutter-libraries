import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleSwitchButton extends StatefulWidget {
  const ToggleSwitchButton({
    super.key,
    required this.onChanged,
    this.toggleActiveColor = Colors.white,
    this.toggleThumbColor = Colors.black87,
    this.toggleTrackColor = Colors.white54,
  });
  final VoidCallback onChanged;
  final Color toggleActiveColor;
  final Color toggleTrackColor;
  final Color toggleThumbColor;

  @override
  State<ToggleSwitchButton> createState() => _ToggleSwitchButtonState();
}

class _ToggleSwitchButtonState extends State<ToggleSwitchButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isSelected,
      onChanged: (value) {
        isSelected = !isSelected;
        widget.onChanged();
        setState(() {});
      },
      activeColor: widget.toggleActiveColor,
      trackColor: widget.toggleTrackColor,
      thumbColor: widget.toggleThumbColor,
    );
  }
}
