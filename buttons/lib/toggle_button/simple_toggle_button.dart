import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColorMode { light, dark }

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.title,
    required this.onChanged,
    this.label,
    this.backgroundColor = Colors.black87,
    this.toggleActiveColor = Colors.white,
    this.toggleThumbColor = Colors.black87,
    this.toggleTrackColor = Colors.white54,
    this.titleTextStyle = const TextStyle(fontSize: 13, color: Colors.white),
    this.labelTextStyle = const TextStyle(fontSize: 10, color: Colors.white),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
    this.borderRadius = 0,
  });

  final VoidCallback onChanged;
  final String title;
  final String? label;
  final TextStyle titleTextStyle;
  final TextStyle labelTextStyle;
  final Color backgroundColor;
  final Color toggleActiveColor;
  final Color toggleTrackColor;
  final Color toggleThumbColor;
  final EdgeInsetsGeometry contentPadding;
  final double borderRadius;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(widget.title, style: widget.titleTextStyle),
          subtitle: widget.label == null
              ? null
              : Text(widget.label!, style: widget.labelTextStyle),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          tileColor: widget.backgroundColor,
          contentPadding: widget.contentPadding,
          trailing: CupertinoSwitch(
            value: isSelected,
            onChanged: (value) {
              isSelected = !isSelected;
              widget.onChanged();
              setState(() {});
            },
            activeColor: widget.toggleActiveColor,
            trackColor: widget.toggleTrackColor,
            thumbColor: widget.toggleThumbColor,
          ),
        ),
      ],
    );
  }
}
