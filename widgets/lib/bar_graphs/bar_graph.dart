import 'package:flutter/material.dart';

class WOIBarGraph extends StatefulWidget {
  const WOIBarGraph({
    super.key,
    required this.yaxisValues,
  });
  final List<double> yaxisValues;

  @override
  State<WOIBarGraph> createState() => _WOIBarGraphState();
}

class _WOIBarGraphState extends State<WOIBarGraph> {
  int max = 4;
  int currentIndex = 0;
  int increments = 4;
  List<String> xaxisLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 380,
      color: Colors.white, //TODO
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              increments + 1,
              (index) {
                currentIndex = (max - index) * 50;
                if (currentIndex != 0) {
                  return Container(
                    margin: EdgeInsets.only(top: ((100 / 300) * 100)),
                    child: Row(
                      children: [
                        Container(
                          width: 30, //TODO
                          child: Text(
                            currentIndex.toString(),
                          ),
                        ),
                        Container(
                          width: 330, //TODO
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5,
                              color: Colors.grey, //TODO
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30, //TODO
                        child: Text(
                          currentIndex.toString(), //TODO: textstyle
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ((100 / 300) * 100)),
                        child: Row(
                          children: List.generate(
                            xaxisLabels.length,
                            (index) {
                              return Column(
                                children: [
                                  Container(
                                    width: 380 / 8,
                                    height: 5, //TODO
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(),
                                        right: BorderSide(),
                                        left: BorderSide(),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    xaxisLabels[index],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              7,
              (index) {
                return Container(
                  height: widget.yaxisValues[index],
                  width: 20,
                  margin: EdgeInsets.only(
                    left: index == 0 ? 46 : 27,
                    bottom: 53,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue, //TODO
                    border: Border(
                      top: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
