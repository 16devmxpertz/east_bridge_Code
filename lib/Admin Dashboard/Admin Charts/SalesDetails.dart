import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesDetails extends StatefulWidget {
  const SalesDetails({super.key});

  @override
  State<SalesDetails> createState() => SalesDetailsState();
}

class SalesDetailsState extends State<SalesDetails> {
  final List<ChartData> chartData = <ChartData>[
    ChartData(2010, 5),
    ChartData(2011, 1),
    ChartData(2012, 10),
    ChartData(2013, 6),
    ChartData(2014, 11),
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromRGBO(0, 0, 0, 0.363),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        S.of(context).SalesDetails,
                        style: DashFormTextController.SubHeading,
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.more_horiz,
                          color: ColorSelect.tabBorderColor,
                          size: 30,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                      '../../../images/SalesDetailsBag.png',
                                      width: 35),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          '\$2,034',
                                          style: DashFormTextController
                                              .SalesHeading,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          S.of(context).AuthorSales,
                                          style: DashFormTextController.Ctgry,
                                        ),
                                        margin: EdgeInsets.only(bottom: 5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                      '../../../images/SalesDetailsBag.png',
                                      width: 35),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          '\$46',
                                          style: DashFormTextController
                                              .SalesHeading,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          S.of(context).AverageBid,
                                          style: DashFormTextController.Ctgry,
                                        ),
                                        margin: EdgeInsets.only(bottom: 5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                      '../../../images/SalesDetailsBag.png',
                                      width: 35),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          '\$706',
                                          style: DashFormTextController
                                              .SalesHeading,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          S.of(context).Commission,
                                          style: DashFormTextController.Ctgry,
                                        ),
                                        margin: EdgeInsets.only(bottom: 5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Image.asset(
                                      '../../../images/SalesDetailsBag.png',
                                      width: 35),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text(
                                          '\$5.8M',
                                          style: DashFormTextController
                                              .SalesHeading,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          S.of(context).AllTimeSales,
                                          style: DashFormTextController.Ctgry,
                                        ),
                                        margin: EdgeInsets.only(bottom: 5),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(
                    // labelStyle: DashFormTextController.SubHeading,
                    majorGridLines: MajorGridLines(width: 0),
                    isVisible: false,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    isVisible: false,
                  ),
                  series: <ChartSeries>[
                    SplineAreaSeries<ChartData, int>(
                        dataSource: chartData,
                        splineType: SplineType.cardinal,
                        cardinalSplineTension: 0.8,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final int x;
  final double y;
}
