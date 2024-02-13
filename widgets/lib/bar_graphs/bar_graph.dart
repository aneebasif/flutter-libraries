import 'package:flutter/material.dart';
import 'dart:math' as math;

class WOIBarGraph extends StatefulWidget {
  const WOIBarGraph({
    super.key,
    required this.yaxisValues,
    required this.xaxisValues,
    required this.height,
    required this.width,
    this.yAxisLabel,
    this.xAxisLabel,
    this.graphHeadingText,
    this.barColors = Colors.blue,
    this.incrementColors = Colors.red,
    this.backgroundColor = Colors.white,
    this.barPadding = 5,
    this.yaxisTextAndLinePadding = 30,
    this.labelPadding,
    this.headingPadding,
    this.textStyle,
    this.yaxisLabelTextBoxSize = 30,
    this.headingTextBoxSize = 30,
    this.xaxisLableTextBoxSize = 30,
    this.topPadding = 0,
  });
  final List<double> yaxisValues;
  final List<String> xaxisValues;
  final double height;
  final double width;
  final Text? yAxisLabel;
  final Text? xAxisLabel;
  final Text? graphHeadingText;
  final Color barColors;
  final Color incrementColors;
  final Color backgroundColor;
  final double barPadding;
  final double yaxisTextAndLinePadding;
  final double? labelPadding;
  final double? headingPadding;
  final TextStyle? textStyle;
  final double yaxisLabelTextBoxSize;
  final double headingTextBoxSize;
  final double xaxisLableTextBoxSize;
  final double topPadding;

  @override
  State<WOIBarGraph> createState() => _WOIBarGraphState();
}

class _WOIBarGraphState extends State<WOIBarGraph> {
  double max = 0;
  double min = 0;
  double tempForMax = 0;
  double tempForMin = 0;
  double increment = 0.2;
  int roundingFactor = 1;
  int positiveNumberOfIncrements = 0;
  int negativeNumberOfIncrements = 0;
  List<double> divisions = [];
  double partinionValue = 0;
  double stepSize = 0;

  List<double> createBackgroundDivision(List<double> values) {
    if (values.isEmpty) {
      return [];
    }

    double maxVal = values.reduce(math.max);
    double minVal = values.reduce(math.min);

    double maxTempVal = math.max(maxVal.abs(), minVal.abs());
    double minTempVal = math.min(maxVal.abs(), minVal.abs());

    // Calculate the range and dynamically determine an appropriate step size
    double range = maxTempVal - minTempVal;

    while (stepSize * 10 < range) {
      stepSize += 0.1;
    }

    // Find the nearest rounded values for min and max according to stepSize
    minVal = (minVal / stepSize).floor() * stepSize;
    maxVal = (maxVal / stepSize).ceil() * stepSize;

    // Finding the positive number of increments
    // if (maxVal >= 1) {
    //   for (int i = 4; i < 8; i++) {
    //     if (maxVal % i == 0) {
    //       positiveNumberOfIncrements = i;
    //     }
    //   }
    // } else {
    //   for (double i = 0.4; i < 0.8; i += 0.1) {
    //     if (maxVal % i == 0) {
    //       positiveNumberOfIncrements = (i * 10).toInt();
    //     }
    //   }
    // }

    // Ensure the division covers the entire range correctly, including an extra step if needed
    if (minVal - stepSize >=
        (values.reduce(math.min) / stepSize).floor() * stepSize) {
      minVal -= stepSize;
    }

    List<double> backgroundPositiveDivisions = [];

    // Populate the background division list
    for (int i = 0; i <= positiveNumberOfIncrements; i++) {
      backgroundPositiveDivisions
          .add((maxVal / positiveNumberOfIncrements) * i);
    }

    // Adjust to include one more step below if the lowest value is exactly on a step
    if (backgroundPositiveDivisions.last > minVal) {
      backgroundPositiveDivisions.add(minVal - stepSize);
    }

    backgroundPositiveDivisions.sort((a, b) => b.compareTo(a));
    return backgroundPositiveDivisions; //TODO
  }

  @override
  Widget build(BuildContext context) {
    roundingFactor = 1;

    // Max = the maximum value in the yaxisValues list.
    max = widget.yaxisValues.reduce(
      (value, element) => value > element ? value : element,
    );

    min = widget.yaxisValues.reduce(
      (value, element) => value < element ? value : element,
    );

    if (min < 0) {
      partinionValue = max - min;
    }

    max = partinionValue;

    divisions = createBackgroundDivision(widget.yaxisValues);
    max = divisions.first + divisions.last;
    min = divisions.last;

    partinionValue = widget.height / (divisions.length - 1);

    return positiveGraph();
  }

  Widget positiveGraph() {
    return Container(
      color: widget.backgroundColor,
      width: (widget.width + widget.yaxisLabelTextBoxSize),
      child: Row(
        children: [
          Visibility(
            visible: widget.yAxisLabel != null,
            child: RotatedBox(
                quarterTurns: -1,
                child: SizedBox(
                    height: widget.yaxisLabelTextBoxSize,
                    width: widget.height,
                    child: widget.yAxisLabel)),
          ),
          SizedBox(
            width: widget.labelPadding,
          ),
          Container(
            color: widget.backgroundColor,
            child: Column(
              children: [
                Container(
                  height: widget.topPadding,
                  color: widget.backgroundColor,
                ),
                Visibility(
                  visible: widget.graphHeadingText != null,
                  child: SizedBox(
                      height: widget.headingTextBoxSize,
                      child: widget.graphHeadingText ?? Container()),
                ),
                SizedBox(
                  height: widget.headingPadding,
                ),
                Container(
                  height: widget.height,
                  width: widget.width,
                  color: widget.backgroundColor,
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      yaxisLines(positiveNumberOfIncrements),
                      positiveGraphBars(),
                    ],
                  ),
                ),
                Container(
                  width: widget.width,
                  padding:
                      EdgeInsets.only(left: widget.yaxisTextAndLinePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: List.generate(
                      widget.xaxisValues.length,
                      (index) => Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: widget.barPadding,
                            right: widget.barPadding,
                          ),
                          child: Text(
                            widget.xaxisValues[index],
                            style: widget.textStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: widget.labelPadding,
                ),
                Visibility(
                  visible: widget.xAxisLabel != null,
                  child: SizedBox(
                      height: widget.xaxisLableTextBoxSize,
                      child: widget.xAxisLabel ?? Container()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget yaxisLines(int numberOfIncrements) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
              numberOfIncrements,
              (index) {
                return Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: widget.yaxisLabelTextBoxSize,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            divisions[index].toString(),
                            style: widget.textStyle ??
                                const TextStyle(
                                  height: 0.1,
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      width: 0.5,
                                      color: widget.incrementColors,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ) +
            [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.yaxisLabelTextBoxSize,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          divisions.last.toStringAsFixed(1),
                          style: widget.textStyle ??
                              const TextStyle(
                                height: 0.1,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    width: 0.5,
                                    color: widget.incrementColors,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
      ),
    );
  }

  Widget positiveGraphBars() {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.yaxisTextAndLinePadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          widget.yaxisValues.length,
          (index) {
            double value = 0;
            double minVal = 0;
            double paddingValue = 0;
            if (divisions.last < 0) {
              double upperMaxSteps = divisions.last / stepSize;
              double maxVal = partinionValue * (upperMaxSteps);
              value = (maxVal.abs() / divisions.last.abs()) *
                      widget.yaxisValues[index].abs() -
                  3;

              double multipl = (divisions.last / stepSize).abs();
              minVal = partinionValue * (multipl);

              double minMax = 0;
              if (isNegativeValue(index)) {
                minMax = minVal.abs();
                value = (minMax / divisions.last.abs()) *
                    widget.yaxisValues[index].abs();
              }

              paddingValue = minMax - value;
              if (value < 0) {
                value = 0;
              }
            } else {
              value = (widget.height / max) * widget.yaxisValues[index];
            }
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  isNegativeValue(index)
                      ? Column(
                          children: [
                            Container(
                              height: 3,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black,
                                  ),
                                  top: BorderSide(
                                    color: Colors.black,
                                  ),
                                  right: BorderSide(
                                    color: Colors.black,
                                  ),
                                  left: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                      left: widget.barPadding,
                      right: widget.barPadding,
                      bottom: isNegativeValue(index) ? (paddingValue) : 0,
                    ),
                    child: Container(
                      height: value.abs(),
                      decoration: BoxDecoration(
                        color: widget.barColors,
                        border: const Border(
                          top: BorderSide(),
                          left: BorderSide(),
                          right: BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  isNegativeValue(index)
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(
                            bottom: minVal,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 3,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      right: BorderSide(
                                        color: Colors.black,
                                      ),
                                      left: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isNegativeValue(int index) {
    return widget.yaxisValues[index] < 0;
  }
}
