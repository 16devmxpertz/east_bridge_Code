import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InvestmentDetails extends StatefulWidget {
  const InvestmentDetails({super.key});

  @override
  State<InvestmentDetails> createState() => _InvestmentDetailsState();
}

class _InvestmentDetailsState extends State<InvestmentDetails> {
  final List<ChartData> chartData = [
    ChartData('Bank', 60, '60%', ColorSelect.east_dark_blue),
    ChartData('Auto', 20, '20%', Color(0xFFBC6CCB)),
    ChartData('IT', 10, '10%', ColorSelect.east_blue),
    ChartData('Pharma', 10, '10%', Color(0xFFF03C59)),
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
                        'Investment Details',
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
                height: 270,
                child: SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.right,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (ChartData data, _) => data.sectors,
                      yValueMapper: (ChartData data, _) => data.invest,
                      dataLabelMapper: (ChartData data, _) => data.percentage,
                      pointColorMapper: (ChartData data, _) => data.color,
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                      // radius: '70%',
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
  ChartData(this.sectors, this.invest, this.percentage, this.color);
  final String sectors;
  final double? invest;
  final String percentage;
  final Color color;
}
