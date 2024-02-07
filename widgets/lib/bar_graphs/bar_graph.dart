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
  List<double> values = [];
  double numberOfIncrements = 0;
  List<double> divisions = [];
  double partinionValue = 0;
  double stepSize = 1.0;

  bool isDivisibleByRequiredIncrement(double value) {
    if (value % 10 == 0) {
      return true;
    }
    if (value % 5 == 0) {
      return true;
    }
    if (value % 0.5 == 0) {
      return true;
    }
    return false;
  }

  List<double> createBackgroundDivision(List<double> values) {
    if (values.isEmpty) {
      return [];
    }

    double maxVal = values.reduce(math.max);
    double minVal = values.reduce(math.min);

    // Calculate the range and dynamically determine an appropriate step size
    double range = maxVal - minVal;
    stepSize = 1.0;

    /* while (isDivisibleByRequiredIncrement(stepSize)) {
      stepSize *= 10;
    } */
    while (stepSize * 5 < range) {
      stepSize *= 10;
    }

    // Find the nearest rounded values for min and max according to stepSize
    minVal = (minVal / stepSize).floor() * stepSize;
    maxVal = (maxVal / stepSize).ceil() * stepSize;

    // Ensure the division covers the entire range correctly, including an extra step if needed
    if (minVal - stepSize >=
        (values.reduce(math.min) / stepSize).floor() * stepSize) {
      minVal -= stepSize;
    }

    List<double> backgroundDivision = [];

    // Populate the background division list
    for (double val = maxVal; val >= minVal; val -= stepSize) {
      backgroundDivision.add(val);
    }

    // Adjust to include one more step below if the lowest value is exactly on a step
    if (backgroundDivision.last > minVal) {
      backgroundDivision.add(minVal - stepSize);
    }

    return backgroundDivision;
  }

  @override
  Widget build(BuildContext context) {
    values.clear();
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

    print(partinionValue);

    // tempForMin = min;

    // If max value < 0, convert it to integer.
    /* while (max.ceil() != max.floor()) {
      max = tempForMax * roundingFactor;
      roundingFactor *= 10;
    }

    // If max is not divisible by either 0.5, 5, 10 keep updating it.
    while (!isDivisibleByRequiredIncrement(max)) {
      max++;
    }
    /* while (!isDivisibleByRequiredIncrement(min)) {
      min--;
    } */

    // Calculating the number of increments possible for the given data. Max is 7.
    for (var i = 0; i < 7; i++) {
      if ((max - min) % (i + 1) == 0) {
        values.add(i + 1);
      }
    }

    /* List<int> minVal = [];
    // Calculating the number of increments possible for the given data. Max is 7.
    for (var i = 0; i < 7; i++) {
      if ((min) % (i + 1) == 0) {
        minVal.add(i + 1);
      }
    }
 */
    // partitionValue is the max value from values list which means we are using maximum number of partitions
    numberOfIncrements =
        values.reduce((value, element) => value > element ? value : element);

    // int temp =
    //     minVal.reduce((value, element) => value < element ? value : element);

    // minVal = values.reduce((value, element) => value > element ? value : element);

    // Convert the max value back to < 0 if needed.
    if (roundingFactor != 1) {
      max /= (roundingFactor / 10);
    }

    // Value of each increment.
    increment = (max) / numberOfIncrements; */

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
                      yaxisLines(numberOfIncrements),
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

  /* Widget negativeGraph() {
    dummyListNegativeNumbers.clear();
    for (int i = 0; i < widget.yaxisValues.length; i++) {
      if (widget.yaxisValues[i] < 0) {
        dummyListNegativeNumbers.add(widget.yaxisValues[i].abs());
      }
    }
    dummyListNegativeNumbers.sort(
      (a, b) => b.compareTo(a),
    );
    getLargestNegativeValue = dummyListNegativeNumbers[0].toInt();

    if (getLargestNegativeValue % incrementDifference != 0) {
      getLargestNegativeValue += (incrementDifference -
          (getLargestNegativeValue % incrementDifference));
    }
    numberOfIncrements = (getLargestNegativeValue / incrementDifference).ceil();
    negativeVerticalUnitLength = widget.height / getLargestNegativeValue;
    return Column(
      children: [
        Container(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          color: widget.backgroundColor,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              yaxisLines(numberOfIncrements),
              Padding(
                padding: EdgeInsets.only(
                  left: widget.yaxisTextAndLinePadding,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.yaxisValues.length,
                    (index) {
                      return Expanded(
                        child: Stack(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                            Padding(
                              padding: EdgeInsets.only(
                                left: widget.barPadding,
                                right: widget.barPadding,
                              ),
                              child: Container(
                                height: ((negativeVerticalUnitLength *
                                        (widget.yaxisValues[index].abs()) -
                                    4)),
                                decoration: BoxDecoration(
                                  color: widget.barColors,
                                  border: const Border(
                                    top: BorderSide(),
                                    left: BorderSide(),
                                    right: BorderSide(),
                                    bottom: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.yaxisTextAndLinePadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(
              widget.xaxisValues.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (widget.yaxisTextAndLinePadding * 2),
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
        )
      ],
    );
  } */

  /*  Widget mixedValueGraph() {
    dummyList.clear();
    dummyListNegativeNumbers.clear();
    dummyList = List.generate(
        widget.yaxisValues.length, (index) => widget.yaxisValues[index]);
    dummyList.sort(
      (a, b) => b.compareTo(a),
    );
    getLargestPositiveValue = dummyList[0].toInt();
    if (getLargestPositiveValue % incrementDifference != 0) {
      getLargestPositiveValue += (incrementDifference -
          (getLargestPositiveValue % incrementDifference));
    }
    positiveVerticalUnitLength = widget.height / getLargestPositiveValue;
    for (int i = 0; i < widget.yaxisValues.length; i++) {
      if (widget.yaxisValues[i] < 0) {
        dummyListNegativeNumbers.add(widget.yaxisValues[i].abs());
      }
    }

    dummyListNegativeNumbers.sort(
      (a, b) => b.compareTo(a),
    );
    getLargestNegativeValue = dummyListNegativeNumbers[0].toInt();
    if (getLargestNegativeValue % incrementDifference != 0) {
      getLargestNegativeValue += (incrementDifference -
          (getLargestNegativeValue % incrementDifference));
    }
    numberOfIncrements = (getLargestPositiveValue / incrementDifference).ceil();
    negativeVerticalUnitLength = widget.height / getLargestNegativeValue;
    return Column(
      children: [
        Container(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          color: widget.backgroundColor,
          child: Column(
            children: [
              SizedBox(
                height: widget.height -
                    (widget.height /
                        getLargestPositiveValue *
                        incrementDifference),
                child: Stack(
                  children: [
                    yaxisLines(numberOfIncrements),
                    Padding(
                      padding: EdgeInsets.only(
                        left: widget.yaxisTextAndLinePadding,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          widget.yaxisValues.length,
                          (index) {
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: widget.barPadding,
                                      right: widget.barPadding,
                                    ),
                                    child: Container(
                                      height: widget.yaxisValues[index] >= 0
                                          ? (((positiveVerticalUnitLength / 2) *
                                              (widget.yaxisValues[index])))
                                          : 0,
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
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 0,
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
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: widget.height /
                    getLargestPositiveValue *
                    incrementDifference,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        1,
                        (index) {
                          return Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: widget.yaxisTextAndLinePadding,
                                  child: Text(
                                    "-${(50 + (index * incrementDifference))}",
                                    style: widget.textStyle ??
                                        const TextStyle(height: 0.1),
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
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: widget.yaxisTextAndLinePadding),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          widget.yaxisValues.length,
                          (index) {
                            return Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  widget.yaxisValues[index] < 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    height: 3,
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          color: Colors.black,
                                                          width: 1,
                                                        ),
                                                        right: BorderSide(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: widget.barPadding,
                                                      right: widget.barPadding,
                                                    ),
                                                    child:
                                                        widget.yaxisValues[
                                                                    index] >=
                                                                0
                                                            ? Container()
                                                            : Container(
                                                                height: ((((widget.height /
                                                                            getLargestPositiveValue *
                                                                            incrementDifference) /
                                                                        getLargestNegativeValue) *
                                                                    (widget
                                                                        .yaxisValues[
                                                                            index]
                                                                        .abs()))),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: widget
                                                                      .barColors,
                                                                  border:
                                                                      const Border(
                                                                    top:
                                                                        BorderSide(),
                                                                    bottom:
                                                                        BorderSide(),
                                                                    left:
                                                                        BorderSide(),
                                                                    right:
                                                                        BorderSide(),
                                                                  ),
                                                                ),
                                                              ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  widget.yaxisValues[index] >= 0
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 3,
                                                decoration: BoxDecoration(
                                                  border: index == 0
                                                      ? const Border(
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
                                                        )
                                                      : const Border(
                                                          top: BorderSide(
                                                            color: Colors.black,
                                                            width: 1,
                                                          ),
                                                          right: BorderSide(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: widget.yaxisTextAndLinePadding),
          child: Row(
            children: List.generate(
              widget.xaxisValues.length,
              (index) => Expanded(
                child: SizedBox(
                  child: Text(
                    widget.xaxisValues[index],
                    style: widget.textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  } */

  Widget yaxisLines(double numberOfIncrements) {
    return Container(
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: List.generate(
              // divisions
              divisions.length - 1,
              (index) {
                /* String stringVal =
                    ((max + min) - (index * increment)).toStringAsFixed(0); */
                // print(stringVal);
                return Container(
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: widget.yaxisLabelTextBoxSize,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              divisions[index].toStringAsFixed(0),
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
                  ),
                );
              },
            ) +
            [
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: widget.yaxisLabelTextBoxSize,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          divisions.last.toStringAsFixed(0),
                          // ((max + min) - (5 * increment)).toStringAsFixed(0),
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
              value = (maxVal.abs() /
                          //
                          // 200
                          divisions.last.abs()
                      //
                      ) *
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
                      height: value,
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
