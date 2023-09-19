import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToggleButtonWithMenu extends StatefulWidget {
  ToggleButtonWithMenu({
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
    this.collapsed = const SizedBox(
      height: 10,
    ),
    this.expanded = const Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Divider(color: Colors.black, thickness: 2, height: 0.2),
        SizedBox(
          height: 30,
        ),
        Divider(color: Colors.black, thickness: 2, height: 0.2),
      ],
    ),
  });
  VoidCallback onChanged = () {};
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
  final Widget collapsed;
  final Widget expanded;

  @override
  State<ToggleButtonWithMenu> createState() => _ToggleButtonWithMenuState();
}

class _ToggleButtonWithMenuState extends State<ToggleButtonWithMenu> {
  // var expandController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(children: [
      ExpansionPanel(
        headerBuilder: (context, isOpen) {
          return Text('this is header');
        },
        body: Text('this is body'),
      )
    ]); /* ExpandablePanl(
              controller: expandController,
              theme: const ExpandableThemeData(
                animationDuration: Duration(milliseconds: 500),
                hasIcon: false,
                tapHeaderToExpand: false,
              ),
              header: ListTile(
                title: Text(widget.title, style: widget.titleTextStyle),
                subtitle: widget.label == null
                    ? null
                    : Text(widget.label!, style: widget.labelTextStyle),
                tileColor: widget.backgroundColor,
                contentPadding: widget.contentPadding,
                trailing: CupertinoSwitch(
                  value: expandController.value,
                  onChanged: (value) {
                    expandController.toggle();
                    widget.onChanged();
                    setState(() {});
                  },
                  activeColor: widget.toggleActiveColor,
                  trackColor: widget.toggleTrackColor,
                  thumbColor: widget.toggleThumbColor,
                ),
              ),
              collapsed: widget.collapsed,
              expanded: widget.expanded,
            ); */
  }
}
