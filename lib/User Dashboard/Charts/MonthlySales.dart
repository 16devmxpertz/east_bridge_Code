import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MonthlySales extends StatefulWidget {
  const MonthlySales({super.key});

  @override
  State<MonthlySales> createState() => _MonthlySalesState();
}

class _MonthlySalesState extends State<MonthlySales> {
  late List<_ChartData> data;

  @override
  void initState() {
    data = [
      _ChartData('01', 15000, 21000),
      _ChartData('02', 21000, 25000),
      _ChartData('03', 18000, 23000),
      _ChartData('04', 16000, 25000),
      _ChartData('05', 15000, 21000),
      _ChartData('06', 21000, 25000),
      _ChartData('07', 18000, 23000),
      _ChartData('08', 16000, 25000),
      _ChartData('09', 15000, 21000),
      _ChartData('10', 21000, 25000),
    ];
  }

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
              margin: EdgeInsetsDirectional.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom:
                      BorderSide(width: 0.5, color: ColorSelect.tabBorderColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                        child: Text(
                      'Monthly Sales',
                      style: DashFormTextController.SubHeading,
                    )),
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
              height: 500,
              // padding: EdgeInsetsDirectional.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 55,
                                  child:
                                      Image.asset('../../../images/profit.png'),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Profit',
                                          style: UserDashFormTextController
                                              .StatusTxt,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: '60,6%',
                                            style: UserDashFormTextController
                                                .StatusAmt,
                                            children: [
                                              WidgetSpan(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 55,
                                  child:
                                      Image.asset('../../../images/margin.png'),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Profit Margin',
                                          style: UserDashFormTextController
                                              .StatusTxt,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: '60,6%',
                                            style: UserDashFormTextController
                                                .StatusAmt,
                                            children: [
                                              WidgetSpan(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Container(
                            width: 200,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 55,
                                  child:
                                      Image.asset('../../../images/sales.png'),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'Sales',
                                          style: UserDashFormTextController
                                              .StatusTxt,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: RichText(
                                          text: TextSpan(
                                            text: '60,6%',
                                            style: UserDashFormTextController
                                                .StatusAmt,
                                            children: [
                                              WidgetSpan(
                                                child: Container(),
                                              ),
                                            ],
                                          ),
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
                  Center(
                    child: Flexible(
                      flex: 6,
                      child: Container(
                        height: 400,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          margin: EdgeInsets.all(20),
                          primaryXAxis: CategoryAxis(
                            // labelStyle: DashFormTextController.SubHeading,
                            majorGridLines: MajorGridLines(width: 0),
                          ),
                          primaryYAxis: NumericAxis(
                            interval: 5000,
                            minimum: 5000,
                            axisLine: AxisLine(width: 0),
                          ),
                          series: <ChartSeries<_ChartData, String>>[
                            ColumnSeries<_ChartData, String>(
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y,
                              color: ColorSelect.east_blue,
                              width: 0.4,
                              spacing: 0.1,
                            ),
                            StackedLineSeries<_ChartData, String>(
                              dataSource: data,
                              xValueMapper: (_ChartData data, _) => data.x,
                              yValueMapper: (_ChartData data, _) => data.y1,
                              markerSettings: MarkerSettings(isVisible: true),
                              color: ColorSelect.east_blue,
                            )
                          ],
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
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}
