import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SalesLastWeek extends StatefulWidget {
  const SalesLastWeek({super.key});

  @override
  State<SalesLastWeek> createState() => SalesLastWeekState();
}

class SalesLastWeekState extends State<SalesLastWeek> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Center(
                      child: Text(
                        S.of(context).Salesofthelastweek,
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
            Center(
              child: Container(
                height: 130,
                child: Stack(
                  children: [
                    SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          showLabels: false,
                          showTicks: false,
                          startAngle: 180,
                          endAngle: 0,
                          radiusFactor: 1.2,
                          canScaleToFit: true,
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.15,
                            color: const Color.fromARGB(30, 0, 169, 181),
                            thicknessUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.startCurve,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              color: ColorSelect.east_blue,
                              // enableAnimation: true,
                              value: 80,
                              width: 0.15,
                              sizeUnit: GaugeSizeUnit.factor,
                              cornerStyle: CornerStyle.bothFlat,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 65,
                              ),
                              child: Text(
                                '80%',
                                style:
                                    UserDashFormTextController.salesPercentage,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 2,
                              ),
                              child: Text(
                                S.of(context).Progress,
                                style: UserDashFormTextController.statusTxt,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            '../../../images/progress_icon.png',
                            filterQuality: FilterQuality.high,
                            width: 30,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  S.of(context).Salesofthelastweek,
                                  style: UserDashFormTextController.ListHead,
                                ),
                              ),
                              Container(
                                child: Text(
                                  S.of(context).AuthorsWithTheBestSales,
                                  style: UserDashFormTextController.ListSubHead,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            '../../../images/progress_icon.png',
                            filterQuality: FilterQuality.high,
                            width: 30,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  S.of(context).TotalSalesLead,
                                  style: UserDashFormTextController.ListHead,
                                ),
                              ),
                              Container(
                                child: Text(
                                  S.of(context).increasedOnWeekToWeekReports,
                                  style: UserDashFormTextController.ListSubHead,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Image.asset(
                            '../../../images/progress_icon.png',
                            filterQuality: FilterQuality.high,
                            width: 30,
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  S.of(context).AverageBestseller,
                                  style: UserDashFormTextController.ListHead,
                                ),
                              ),
                              Container(
                                child: Text(
                                  S.of(context).PitstopEmailMarketing,
                                  style: UserDashFormTextController.ListSubHead,
                                ),
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
          ],
        ),
      ),
    );
  }
}
