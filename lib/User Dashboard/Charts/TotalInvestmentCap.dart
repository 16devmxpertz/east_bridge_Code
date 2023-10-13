import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalInvestmentCap extends StatefulWidget {
  const TotalInvestmentCap({super.key});

  @override
  State<TotalInvestmentCap> createState() => _TotalInvestmentCapState();
}

class _TotalInvestmentCapState extends State<TotalInvestmentCap> {
  final List<ChartData> chartData = [
    ChartData('Large Cap', 0.60, ColorSelect.east_blue),
    ChartData('Mid Cap', 0.30, ColorSelect.east_dark_blue),
    ChartData('Small Cap', 0.10, Color(0xFFF03C59)),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: Container(
          // padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(blurRadius: 3, color: Color.fromRGBO(0, 0, 0, 0.363)),
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
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.5, color: ColorSelect.tabBorderColor),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Center(
                          child: Text(
                        'Total Investment Cap',
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
                height: 250,
                margin: EdgeInsets.only(top: 20),
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  margin: EdgeInsets.all(20),
                  primaryXAxis: CategoryAxis(
                    axisLine: AxisLine(width: 0),
                    labelStyle: TextStyle(
                      fontFamily: 'Frutiger',
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    majorGridLines: MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    // isVisible: false,
                    numberFormat: NumberFormat.decimalPercentPattern(),
                    axisLine: AxisLine(width: 0),
                    majorGridLines: MajorGridLines(width: 1),
                    minimum: 0,
                    maximum: 1,
                    interval: 0.1,
                  ),
                  series: <CartesianSeries>[
                    BarSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData ch, _) => ch.x,
                      yValueMapper: (ChartData ch, _) => ch.y,
                      pointColorMapper: (ChartData data, _) => data.color,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          // Positioning the data label
                          labelAlignment: ChartDataLabelAlignment.bottom),
                      width: 0.6,
                    )
                  ],
                ),
              ),
            ],
          ),
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
