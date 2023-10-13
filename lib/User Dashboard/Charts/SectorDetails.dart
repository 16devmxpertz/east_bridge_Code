import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SectorDetails extends StatefulWidget {
  const SectorDetails({super.key});

  @override
  State<SectorDetails> createState() => _SectorDetailsState();
}

class _SectorDetailsState extends State<SectorDetails> {
  final List<ChartData> chartData = [
    ChartData('Private', 70, ColorSelect.east_dark_blue),
    ChartData('Public', 50, ColorSelect.east_blue),
    ChartData('Government', 20, Color(0xFFF03C59)),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(blurRadius: 3, color: Color.fromRGBO(0, 0, 0, 0.363)),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        // height: 500,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: EdgeInsets.only(bottom: 10),
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
                      'Sector Details',
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
            Center(
              child: Container(
                height: 500,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  margin: EdgeInsets.all(20),
                  primaryXAxis: CategoryAxis(
                    labelStyle: DashFormTextController.SubHeading,
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: AxisLine(width: 0),
                    minimum: 0,
                    maximum: 100,
                    interval: 10,
                  ),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData ch, _) => ch.x,
                      yValueMapper: (ChartData ch, _) => ch.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      width: 0.4,
                      spacing: 0.1,
                    ),
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
  ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}
