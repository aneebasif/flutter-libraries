import 'package:flutter/material.dart';

class WOIBarGraph extends StatefulWidget {
  const WOIBarGraph(
      {super.key,
      required this.yaxisValues,
      required this.xaxisLabels,
      required this.height});
  final List<double> yaxisValues;
  final List<String> xaxisLabels;
  final double height;

  @override
  State<WOIBarGraph> createState() => _WOIBarGraphState();
}

class _WOIBarGraphState extends State<WOIBarGraph> {
  double padding = 5;
  double positiveVerticalUnitLength = 0;
  double negativeVerticalUnitLength = 0;
  bool negative = false;
  bool allNegative = false;
  List<double> dummyList = [];
  List<double> dummyListNegativeNumbers = [];
  List<double> listToCheckIfAllValuesAreNegative = [];
  int getLargestPositiveValue = 0;
  int getLargestNegativeValue = 0;
  int numberOfIncrements = 0;
  int incrementDifference = 50;

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.yaxisValues.length; i++) {
      if (widget.yaxisValues[i] < 0) {
        negative = true;
        break;
      } else {
        negative = false;
      }
    }
    for (int i = 0; i < widget.yaxisValues.length; i++) {
      if (widget.yaxisValues[i] < 0) {
        listToCheckIfAllValuesAreNegative.add(widget.yaxisValues[i]);
      } else {
        break;
      }
    }
    if (listToCheckIfAllValuesAreNegative.length == widget.yaxisValues.length) {
      allNegative = true;
      negative = false;
    } else {
      allNegative = false;
    }
    listToCheckIfAllValuesAreNegative.clear();
    if (negative) {
      return mixedValueGraph();
    } else if (allNegative) {
      return negativeGraph();
    } else {
      dummyList.clear();
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
      numberOfIncrements =
          (getLargestPositiveValue / incrementDifference).ceil();

      positiveVerticalUnitLength = widget.height / getLargestPositiveValue;
      return Container(
        height: widget.height,
        width: 380,
        // color: Colors.red, //TODO
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            yaxisLines(numberOfIncrements),
            positiveGraph(),
          ],
        ),
      );
    }
  }

  Widget negativeGraph() {
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
    return Container(
      height: widget.height,
      width: 380,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          yaxisLines(numberOfIncrements),
          Padding(
            padding: EdgeInsets.only(
              left: 30,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                widget.yaxisValues.length,
                (index) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                height: 3,
                                decoration: BoxDecoration(
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
                            left: padding,
                            right: padding,
                          ),
                          child: Container(
                            height: ((negativeVerticalUnitLength *
                                    (widget.yaxisValues[index].abs()) -
                                4)),
                            decoration: BoxDecoration(
                              color: Colors.blue, //TODO
                              border: Border(
                                top: BorderSide(),
                                left: BorderSide(),
                                right: BorderSide(),
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
          )
        ],
      ),
    );
  }

  Widget mixedValueGraph() {
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
    return Container(
      height: widget.height,
      width: 380,
      margin: EdgeInsets.only(bottom: 5),
      // color: Colors.red, //TODO
      child: Column(
        children: [
          Container(
            height: widget.height -
                (widget.height / getLargestPositiveValue * incrementDifference),
            color: Colors.orange,
            child: Stack(
              children: [
                yaxisLines(numberOfIncrements),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
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
                                  left: padding,
                                  right: padding,
                                ),
                                child: Container(
                                  height: widget.yaxisValues[index] >= 0
                                      ? (((positiveVerticalUnitLength / 2) *
                                          (widget.yaxisValues[index])))
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue, //TODO
                                    border: Border(
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
          Container(
            height:
                widget.height / getLargestPositiveValue * incrementDifference,
            color: Colors.purple,
            child: Padding(
              padding: EdgeInsets.only(
                left: 0,
              ),
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
                                width: 35,
                                child: Text(
                                  "-${(50 + (index * incrementDifference))}",
                                  style: TextStyle(
                                    height: 0.1,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 0.5,
                                              color: Colors.red, //TODO
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
                  ), //TODO: Copied code for background widget ends here
                  Padding(
                    padding: EdgeInsets.only(left: 30),
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
                                                  decoration: BoxDecoration(
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
                                                    left: padding,
                                                    right: padding,
                                                  ),
                                                  child: widget.yaxisValues[
                                                              index] >=
                                                          0
                                                      ? Container()
                                                      : Container(
                                                          height: ((((widget
                                                                          .height /
                                                                      getLargestPositiveValue *
                                                                      incrementDifference) /
                                                                  getLargestNegativeValue) *
                                                              (widget
                                                                  .yaxisValues[
                                                                      index]
                                                                  .abs()))),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .blue, //TODO
                                                            border: Border(
                                                              top: BorderSide(),
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
                                                    ? Border(
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
                                                    : Border(
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
          ), //TODO copied code ends here
        ],
      ),
    );
  }

  Widget yaxisLines(int numberOfIncrements) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: List.generate(
        numberOfIncrements,
        (index) {
          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 35,
                  child: Text(
                    ((getLargestPositiveValue) - (index * incrementDifference))
                        .toString(),
                    style: TextStyle(
                      height: 0.1,
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 0.5,
                                color: Colors.red, //TODO
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
    );
  }

  Widget positiveGraph() {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
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
                      left: padding,
                      right: padding,
                    ),
                    child: Container(
                      height: ((positiveVerticalUnitLength *
                              (widget.yaxisValues[index]) -
                          4)),
                      decoration: BoxDecoration(
                        color: Colors.blue, //TODO
                        border: Border(
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
                          height: 3,
                          decoration: BoxDecoration(
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
    );
  }
}
