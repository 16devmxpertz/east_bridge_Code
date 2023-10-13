import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockDetails extends StatefulWidget {
  const StockDetails({super.key});

  @override
  State<StockDetails> createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  late List<_ChartData> data;

  @override
  void initState() {
    data = [
      _ChartData('Jan \'23', 20),
      _ChartData('Feb \'23', 10),
      _ChartData('Mar \'23', 15),
      _ChartData('Apr \'23', 30),
      _ChartData('May \'23', 12),
      _ChartData('Jun \'23', 40),
      _ChartData('Jul \'23', 35),
      _ChartData('Aug \'23', 30),
      _ChartData('Sep \'23', 20),
      _ChartData('Oct \'23', 40),
      _ChartData('Nov \'23', 10),
      _ChartData('Dec \'23', 25),
    ];
  }

  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
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
              // margin: EdgeInsetsDirectional.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        S.of(context).StockDetail,
                        style: DashFormTextController.SubHeading,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorSelect.east_grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 5,
                    ),
                    height: 25,
                    // width: 120,
                    child: DropdownButton(
                      value: dropdownvalue,
                      // isExpanded: true,
                      underline: Container(),
                      iconEnabledColor: Colors.black,
                      items: items.map(
                        (String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              S.of(context).ShowByMonth,
                              style: DashFormTextController.xAxis,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? newValue) {
                        setState(
                          () {
                            dropdownvalue = newValue!;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: 240,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    margin: EdgeInsets.all(20),
                    primaryXAxis: CategoryAxis(
                      labelStyle: DashFormTextController.xAxis,
                      majorGridLines: MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                      labelStyle: DashFormTextController.xAxis,
                      interval: 20,
                      minimum: 0,
                      maximum: 80,
                      axisLine: AxisLine(width: 0),
                    ),
                    series: <ChartSeries<_ChartData, String>>[
                      ColumnSeries<_ChartData, String>(
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        color: ColorSelect.east_blue,
                        width: 0.25,
                        // spacing: 0.6,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
