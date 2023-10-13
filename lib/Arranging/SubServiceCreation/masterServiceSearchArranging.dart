import 'dart:convert';

import 'package:east_bridge/Arranging/Arranging%20Subscribe/ArrangingSubscribe.dart';
import 'package:east_bridge/Arranging/ArrangingAgreement/DefaultAgreement.dart';
import 'package:east_bridge/Arranging/ArrangingBankDetails.dart';
import 'package:east_bridge/Arranging/ArrangingDetails.dart';
import 'package:east_bridge/Arranging/ArrangingFees.dart';
import 'package:east_bridge/Arranging/EditArrangingAgreementSearch.dart';
import 'package:east_bridge/Agreement%20Masters/CustomerAddAgreement.dart';
import 'package:east_bridge/Fund%20Creation/Fees.dart';
import 'package:east_bridge/Fund%20Creation/FundBankDetails.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class masterServiceSearchArranging extends StatefulWidget {
  masterServiceSearchArranging({@required controller}) {
    tabController = controller;
  }

  @override
  State<masterServiceSearchArranging> createState() =>
      masterServiceSearchArrangingState();
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class masterServiceSearchArrangingState
    extends State<masterServiceSearchArranging> {
  masterServiceSearchArranging({@required controller}) {
    tabController = controller;
  }

  List li = [];
  List key = [];
  Map map = {};

  void fetchData() async {
    print("Shah");
    final response = await http.get(Uri.parse(
        'https://eastbridge.online/apicore/api/ArrangingCreateService/GetArrangingServiceNames'));

    print("Shah1");

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      setState(() {
        map = jsonDecode(json);
      });

      // title=json.decode(response.body);
      li = map.values.toList();
      key = map.keys.toList();
      print(li);
      print("Shah3");
    } else {
      print("ShahError");
      throw Exception('Failed to fetch data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: ColorSelect.east_grey,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Flexible(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               S.of(context).masterService,
            //               style: TextController.BodyText,
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Flexible(
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(horizontal: 10),
            //                 width: 280,
            //                 height: 35,
            //                 alignment: Alignment.centerLeft,
            //                 decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     border:
            //                         Border.all(color: ColorSelect.textField)),
            //                 child: TextFormField(
            //                   textAlignVertical: TextAlignVertical.center,
            //                   style: TextController.BodyHeadingText,
            //                   decoration: InputDecoration(
            //                       isDense: true,
            //                       hintText: S.of(context).TypeHere,
            //                       hintStyle: TextController.labelText,
            //                       border: InputBorder.none),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: ColorSelect.east_grey,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Flexible(
            //         child: Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           height: 35,
            //           width: 100,
            //           color: ColorSelect.east_blue,
            //           child: TextButton(
            //             style: TextButton.styleFrom(
            //               side: BorderSide(
            //                 width: 1.0,
            //                 color: Color(0xFFC9BBBB),
            //               ),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               ),
            //             ),
            //             onPressed: () {},
            //             child: Text(
            //               S.of(context).search,
            //               style: TextController.btnText,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            
            Container(
              width: 1000,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                border: TableBorder.all(color: ColorSelect.tabBorderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),

                  // 0: FixedColumnWidth(500),
                  // 1: FixedColumnWidth(500)
                },
                children: [
                  TableRow(
                    children: [
                      Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                          child: Text(
                            S.of(context).ServiceName,
                            style: TextController.tableHeading,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                          child: Text(
                            S.of(context).ServiceID,
                            style: TextController.tableHeading,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              // height: 800,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: li.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        //subServiceCreationAdv.id.value = int.parse(key[index]);
                        //subServiceArrangingFees.id.value = int.parse(key[index]);
                        ArrangingDetailss.id.value = int.parse(key[index]);
                        EditArranginggreementSearch.id.value =
                            int.parse(key[index]);

                        tabController!.animateTo(1);
                      },
                      child: table(li[index], key[index], context));
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                    color: ColorSelect.east_blue,
                  ),
                  child: TextButton(
                    onPressed: () {
                      tabController!.animateTo(1);
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Next,
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget table(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            width: 1000,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Table(
              border: TableBorder.all(color: ColorSelect.tabBorderColor),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
              children: [
                TableRow(children: [
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        templateName,
                        style: TextController.BodyText,
                      ))),
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        templateKeys,
                        style: TextController.BodyText,
                      ))),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
