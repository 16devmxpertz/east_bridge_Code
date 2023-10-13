// import 'dart:convert';
// import 'dart:math';

// import 'package:east_bridge/utility/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/KYC/KYC Components/BankInfo.dart';
import 'package:east_bridge/Arranging/SubServiceCreation/tabOfSubServiceCreactionArranging.dart';
import 'package:http/http.dart' as http;
// import 'package:east_bridge/generated/l10n.dart';
// import 'package:east_bridge/utility/TextController.dart';
// import 'package:intl/intl.dart';

// enum SingingCharacter { yes, no }

// class ArrangingFees extends StatefulWidget {
// ArrangingFees({@required controller}) {
//   tabController = controller;
// }

//   @override
//   State<ArrangingFees> createState() => ArrangingFeesState();
//   static ValueNotifier<int> id = new ValueNotifier(0);
// }

// enum RadioSelected { RadioOne, RadioTwo }

// TabController? tabController;

// class ArrangingFeesState extends State<ArrangingFees> {
// TextEditingController RangeFrom = new TextEditingController();
// TextEditingController RangeTo = new TextEditingController();
// TextEditingController FixedArrangingFees = new TextEditingController();
// TextEditingController ArrangingFeesRate = new TextEditingController();
// TextEditingController PercentOf = new TextEditingController();
// TextEditingController Lower = new TextEditingController();
// TextEditingController Upper = new TextEditingController();

// String dropdownvalue = "";
//   String dropdownvalue2 = "";
//   String dropdownvalue3 = "";
//   String dropdownvalue4 = "";
//   String dropdownvalue5 = "";
//   String dropdownvalue6 = "";
//   String dropdownvalue7 = "";
//   String dropdownvalue8 = "";
//   String dropdownvalue9 = "";
//   String dropdownvalue10 = "";

// int numberOfRowsToAdd = 0;

//   @override
//   Widget build(BuildContext context) {
//     // List of items in our dropdown menu
// var feesType = [
//   'Establishment Expenses',
//   'Entry Fees',
//   'Management Fees',
//   'Performance Arranging Fees',
//   'Custody Arranging Fees',
//   'Arranging Operator Fees',
//   'Auditor Arranging Fees',
//   'Trading Arranging Fees',
//   'Arranging Financing',
//   'Other Expenses',
// ];
// var items = [
//   'Total Capital Commitment',
//   'Net Asset Value (NAV)',
//   'Investment Value',
//   'AUM Assets Under Management',
//   'Fund\'s Return Value',
//   'Other',
// ];

// void fundArrangingFees() async {
//   int? rangeFrom = int.tryParse(RangeFrom.text);
//   int? rangeTo = int.tryParse(RangeTo.text);
//   int? fixedArrangingFees = int.tryParse(FixedArrangingFees.text);
//   int? ArrangingFeesRate = int.tryParse("ArrangingFeesRate.text");
//   int? lower = int.tryParse(Lower.text);
//   int? upper = int.tryParse(Upper.text);

//   var url = Uri.parse(
//       'http://8.213.23.26:8081/apicore/api/ArrangingFeesDetail/ArrangingFeesDetail');

//   try {
//     var headers = {
//       'Content-Type': 'application/json',
//     };

//     var body = {};

//     print(body);

//     var response =
//         await http.post(url, headers: headers, body: jsonEncode(body));

//     if (response.statusCode == 200) {
//       print(jsonDecode(response.body));
//     } else {
//       var errorMessage = response.reasonPhrase;
//       print(response.statusCode);
//       print(response.body);
//       print(jsonDecode(response.body));
//       print("Error");
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }

//     @override
//     void initState() {
//       super.initState();
//     }

//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 20),
//             child: Text(
//               S.of(context).Fees,
//               style: TextController.BodyHeadingText,
//             ),
//           ),

//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     numberOfRowsToAdd++;
//                     dropdownvalue = "";
//                     RangeFrom.text = "";
//                     RangeTo.text = "";
//                     PercentOf.text = "";
//                     FixedArrangingFees.text = "";
//                     ArrangingFeesRate.text = "";
//                     dropdownvalue10 = "";
//                     Upper.text = "";
//                     Lower.text = "";
//                   });
//                 },
//                 child: Text("Add Row"),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               if (numberOfRowsToAdd > 0)
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       numberOfRowsToAdd--;
//                     });
//                   },
//                   child: Text("Delete Row"),
//                 ),
//             ],
//           ),
//           SizedBox(
//             height: 50,
//           ),
// Row(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     Padding(
//       padding: const EdgeInsets.only(right: 20, bottom: 25),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           height: 35,
//           width: 120,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: ColorSelect.tabBorderColor)),
//           child: TextButton(
//             onPressed: () {
//               tabController!.animateTo(2);
//             }, // Switch tabs
//             child: Text(
//               S.of(context).Back,
//               style: TextController.SideMenuText,
//             ),
//           ),
//         ),
//       ),
//     ),
//     Padding(
//       padding: const EdgeInsets.only(right: 50, bottom: 25),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           height: 35,
//           width: 140,
//           decoration: BoxDecoration(
//               color: ColorSelect.east_blue,
//               border: Border.all(color: ColorSelect.tabBorderColor)),
//           child: TextButton(
//             onPressed: () {
//               fundArrangingFees();
//             }, // Switch tabs
//             child: Text(
//               S.of(context).Next,
//               style: TextController.btnText,
//             ),
//           ),
//         ),
//       ),
//     ),
//   ],
// ),
//         ],
//       ),
//     );
//   }
// }

// Widget table(BuildContext context){
//   return  Container(
//             padding: EdgeInsets.all(25),
//             width: double.infinity,
//             margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
//             child: Table(
//               border: TableBorder.all(color: ColorSelect.tabBorderColor),
//               defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//               columnWidths: {
//                 // 0: FixedColumnWidth(150),
//                 // 1: FixedColumnWidth(150),
//                 // 2: FixedColumnWidth(150),
//                 // 3: FixedColumnWidth(150),
//                 // 4: FixedColumnWidth(150),
//                 // 5: FixedColumnWidth(150),
//                 // 6: FixedColumnWidth(150),
//                 // 7: FixedColumnWidth(150),
//                 0: FlexColumnWidth(2),
//                 1: FlexColumnWidth(1),
//                 2: FlexColumnWidth(1),
//                 3: FlexColumnWidth(1),
//                 4: FlexColumnWidth(1),
//                 5: FlexColumnWidth(2),
//                 6: FlexColumnWidth(1),
//                 7: FlexColumnWidth(1),
//               },
//               children: [
//                 TableRow(children: [
//                   Container(
//                       height: 70,
//                       alignment: Alignment.centerLeft,
//                       color: ColorSelect.east_grey,
//                       child: Center(
//                           child: Text(
//                         S.of(context).ArrangingFeestype,
//                         style: TextController.InvA,
//                       ))),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).FromDate,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).ToDate,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).FixedFees,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).FeesRate,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).percentof,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).Lowerlimit,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).Uperlimit,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                   Container(
//                       height: 70,
//                       color: ColorSelect.east_grey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10),
//                         child: Center(
//                             child: Text(
//                           S.of(context).CalculatedAmount,
//                           style: TextController.InvA,
//                           maxLines: 3,
//                         )),
//                       )),
//                 ]),
//                 TableRow(
//                   children: [
//                     Container(
//                       height: 70,
//                       width: double.infinity,
//                       child: DropdownButtonHideUnderline(
//                         child: Theme(
//                           data: Theme.of(context)
//                               .copyWith(focusColor: Colors.white),
//                           child: DropdownButtonFormField(
//                             hint: Center(
//                               child: Text(
//                                 S.of(context).SelectHere,
//                                 style: TextController.labelText,
//                               ),
//                             ),
//                             isExpanded: true,
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             decoration: InputDecoration(
//                               enabledBorder: InputBorder.none,
//                               border: InputBorder.none,
//                               hoverColor: Colors.white,
//                             ),
//                             items: feesType.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Center(
//                                     child: Text(items,
//                                         style: TextController.BodyText)),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 dropdownvalue = newValue!;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: RangeFrom,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: RangeTo,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: FixedArrangingFees,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: ArrangingFeesRate,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       width: 100,
//                       child: DropdownButtonHideUnderline(
//                         child: Theme(
//                           data: Theme.of(context)
//                               .copyWith(focusColor: Colors.white),
//                           child: DropdownButtonFormField(
//                             hint: Center(
//                               child: Text(
//                                 S.of(context).SelectHere,
//                                 style: TextController.labelText,
//                               ),
//                             ),
//                             isExpanded: true,
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             decoration: InputDecoration(
//                               enabledBorder: InputBorder.none,
//                               border: InputBorder.none,
//                               hoverColor: Colors.white,
//                             ),
//                             items: items.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Center(
//                                     child: Text(items,
//                                         style: TextController.BodyText)),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 dropdownvalue = newValue!;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: Lower,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: Upper,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: TextFormField(
//                         textAlign: TextAlign.center,
//                         controller: Upper,
//                         maxLines: null,
//                         keyboardType: TextInputType.multiline,
//                         decoration: InputDecoration(border: InputBorder.none),
//                       ),
//                     ),
//                   ],
//                 ),
//                 ...List.generate(
//                   numberOfRowsToAdd,
//                   (index) => TableRow(
//                     children: [
//                       Container(
//                         height: 70,
//                         width: double.infinity,
//                         child: DropdownButtonHideUnderline(
//                           child: Theme(
//                             data: Theme.of(context)
//                                 .copyWith(focusColor: Colors.white),
//                             child: DropdownButtonFormField(
//                               hint: Center(
//                                 child: Text(
//                                   S.of(context).SelectHere,
//                                   style: TextController.labelText,
//                                 ),
//                               ),
//                               isExpanded: true,
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               decoration: InputDecoration(
//                                 enabledBorder: InputBorder.none,
//                                 border: InputBorder.none,
//                                 hoverColor: Colors.white,
//                               ),
//                               items: feesType.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Center(
//                                       child: Text(items,
//                                           style: TextController.BodyText)),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   dropdownvalue = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: RangeFrom,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: RangeTo,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: FixedArrangingFees,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: ArrangingFeesRate,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         width: 100,
//                         child: DropdownButtonHideUnderline(
//                           child: Theme(
//                             data: Theme.of(context)
//                                 .copyWith(focusColor: Colors.white),
//                             child: DropdownButtonFormField(
//                               hint: Center(
//                                 child: Text(
//                                   S.of(context).SelectHere,
//                                   style: TextController.labelText,
//                                 ),
//                               ),
//                               isExpanded: true,
//                               icon: const Icon(Icons.keyboard_arrow_down),
//                               decoration: InputDecoration(
//                                 enabledBorder: InputBorder.none,
//                                 border: InputBorder.none,
//                                 hoverColor: Colors.white,
//                               ),
//                               items: items.map((String items) {
//                                 return DropdownMenuItem(
//                                   value: items,
//                                   child: Center(
//                                       child: Text(items,
//                                           style: TextController.BodyText)),
//                                 );
//                               }).toList(),
//                               onChanged: (String? newValue) {
//                                 setState(() {
//                                   dropdownvalue10 = newValue!;
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: Lower,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: Upper,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                       Container(
//                         height: 70,
//                         child: TextFormField(
//                           textAlign: TextAlign.center,
//                           controller: Upper,
//                           maxLines: null,
//                           keyboardType: TextInputType.multiline,
//                           decoration: InputDecoration(border: InputBorder.none),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
// }

import 'dart:convert';

import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class RowData1 {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController RangeFrom;
  late TextEditingController RangeTo;
  late TextEditingController FixedArrangingFees;
  late TextEditingController ArrangingFeesRate;
  late TextEditingController PercentOf;
  late TextEditingController Lower;
  late TextEditingController Upper;
  late TextEditingController ca;
  late String dropdownvalue;
  late String dropdownvalue2;

  RowData1() {
    nameController = TextEditingController();
    ageController = TextEditingController();
    RangeFrom = TextEditingController();
    RangeTo = TextEditingController();
    FixedArrangingFees = TextEditingController();
    ArrangingFeesRate = TextEditingController();
    PercentOf = TextEditingController();
    Lower = TextEditingController();
    Upper = TextEditingController();
    ca = TextEditingController();
    dropdownvalue = "";
    dropdownvalue2 = "";
  }
}

class MileStoneFeesArranging extends StatefulWidget {
  MileStoneFeesArranging({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;

class _DynamicTableState extends State<MileStoneFeesArranging> {
  List<RowData1> rowDataList = [];

  @override
  // void dispose() {
  //   for (var rowData in rowDataList) {
  //     rowData.RangeFrom.dispose();
  //     rowData.RangeTo.dispose();
  //     rowData.FixedArrangingFees.dispose();
  //     rowData.ArrangingFeesRate.dispose();
  //     rowData.Lower.dispose();
  //     rowData.Upper.dispose();
  //     rowData.ca.dispose();
  //     // rowData.dropdownvalue="";
  //     // rowData.dropdownvalue2="";
  //   }
  //   super.dispose();
  // }

  void addRow() {
    setState(() {
      rowDataList.add(RowData1());
    });
  }

  void removeRow(int index) {
    setState(() {
      rowDataList[index].RangeFrom.dispose();
      rowDataList[index].RangeTo.dispose();
      rowDataList[index].FixedArrangingFees.dispose();
      rowDataList[index].ArrangingFeesRate.dispose();
      rowDataList[index].Lower.dispose();
      rowDataList[index].Upper.dispose();
      rowDataList[index].ca.dispose();
      // rowDataList[index].dropdownvalue = "";
      // rowDataList[index].dropdownvalue2 = "";

      rowDataList.removeAt(index);
    });
  }

  void fundArrangingFees() async {
    List<Map<String, dynamic>> feesList = [];
    for (var rowData in rowDataList) {
      int rangeFrom = int.parse(rowData.RangeFrom.text);
      int rangeTo = int.parse(rowData.RangeTo.text);
      int fixedFees = int.parse(rowData.FixedArrangingFees.text);
      int feesRate = int.parse(rowData.ArrangingFeesRate.text);
      int lowerLimit = int.parse(rowData.Lower.text);
      int upperLimit = int.parse(rowData.Upper.text);
      int calculatedAmount = int.parse(rowData.ca.text);

      Map<String, dynamic> fee = {
        "feestype": rowData.dropdownvalue,
        "rangeFrom": rangeFrom,
        "rangeTo": rangeTo,
        "fixedFees": fixedFees,
        "feesRate": feesRate,
        "perOf": rowData.dropdownvalue2,
        "lowerLimit": lowerLimit,
        "upperLimit": upperLimit,
        "calculatedAmount": calculatedAmount,
      };

      feesList.add(fee);
    }

    print(feesList);

    var url = Uri.parse(
        'http://8.213.23.26:8081/apicore/api/ArrangingFeesDetail/ArrangingFeesModel');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "ArrangingId": MileStoneFeesArranging.id.value,
        "fees": feesList,
      };

      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Table(
            border: TableBorder.all(color: ColorSelect.tabBorderColor),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1),
              8: FlexColumnWidth(1),
              9: FlexColumnWidth(1),
              10: FlexColumnWidth(1),
              11: FlexColumnWidth(1.5),
            },
            children: [
              TableRow(children: [
                Container(
                    height: 70,
                    alignment: Alignment.centerLeft,
                    color: ColorSelect.east_grey,
                    child: Center(
                        child: Text(
                      S.of(context).Feestype,
                      style: TextController.InvA,
                    ))),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).FromDate,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).ToDate,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).FixedFees,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).FeesRate,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).percentof,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).Lowerlimit,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).Uperlimit,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                          child: Text(
                        S.of(context).CalculatedAmount,
                        style: TextController.InvA,
                        maxLines: 3,
                      )),
                    )),
                Container(
                    height: 70,
                    color: ColorSelect.east_grey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: addRow,
                          child: Text(
                            'Add Row',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )),
              ]),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: rowDataList.length,
            itemBuilder: (context, index) {
              return buildRowWidget(index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.tabBorderColor)),
                  child: TextButton(
                    onPressed: () {
                      tabController!.animateTo(0);
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Back,
                      style: TextController.SideMenuText,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 25),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 140,
                  decoration: BoxDecoration(
                      color: ColorSelect.east_blue,
                      border: Border.all(color: ColorSelect.tabBorderColor)),
                  child: TextButton(
                    onPressed: () {
                      fundArrangingFees();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              new tabOfSubServiceCreactionArranging()));
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Submit,
                      style: TextController.btnText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRowWidget(int index) {
    var feesType = [
      'Establishment Expenses',
      'Entry Fees',
      'Management Fees',
      'Performance Arranging Fees',
      'Custody Arranging Fees',
      'Arranging Operator Fees',
      'Auditor Arranging Fees',
      'Trading Arranging Fees',
      'Arranging Financing',
      'Other Expenses',
    ];
    var items = [
      'Total Capital Commitment',
      'Net Asset Value (NAV)',
      'Investment Value',
      'AUM Assets Under Management',
      'Fund\'s Return Value',
      'Other',
    ];

    return Container(
      //  padding: EdgeInsets.all(25),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Table(
        border: TableBorder.all(color: ColorSelect.tabBorderColor),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: {
          // 0: FixedColumnWidth(150),
          // 1: FixedColumnWidth(150),
          // 2: FixedColumnWidth(150),
          // 3: FixedColumnWidth(150),
          // 4: FixedColumnWidth(150),
          // 5: FixedColumnWidth(150),
          // 6: FixedColumnWidth(150),
          // 7: FixedColumnWidth(150),
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(2),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(1),
          8: FlexColumnWidth(1),
          9: FlexColumnWidth(1),
          10: FlexColumnWidth(1),
          11: FlexColumnWidth(1.5),
        },
        children: [
          TableRow(
            children: [
              Container(
                height: 70,
                width: double.infinity,
                child: DropdownButtonHideUnderline(
                  child: Theme(
                    data: Theme.of(context).copyWith(focusColor: Colors.white),
                    child: DropdownButtonFormField(
                      hint: Center(
                        child: Text(
                          S.of(context).SelectHere,
                          style: TextController.labelText,
                        ),
                      ),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hoverColor: Colors.white,
                      ),
                      items: feesType.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(
                              child:
                                  Text(items, style: TextController.BodyText)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          rowDataList[index].dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].RangeFrom,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].RangeTo,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].FixedArrangingFees,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].ArrangingFeesRate,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                width: 100,
                child: DropdownButtonHideUnderline(
                  child: Theme(
                    data: Theme.of(context).copyWith(focusColor: Colors.white),
                    child: DropdownButtonFormField(
                      hint: Center(
                        child: Text(
                          S.of(context).SelectHere,
                          style: TextController.labelText,
                        ),
                      ),
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hoverColor: Colors.white,
                      ),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(
                              child:
                                  Text(items, style: TextController.BodyText)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          rowDataList[index].dropdownvalue2 = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].Lower,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].Upper,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                height: 70,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: rowDataList[index].ca,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeRow(index),
                ),
              ),
            ],
          ),
          // ...List.generate(
          //   numberOfRowsToAdd,
          //   (index) => TableRow(
          //     children: [
          //       Container(
          //         height: 70,
          //         width: double.infinity,
          //         child: DropdownButtonHideUnderline(
          //           child: Theme(
          //             data: Theme.of(context)
          //                 .copyWith(focusColor: Colors.white),
          //             child: DropdownButtonFormField(
          //               hint: Center(
          //                 child: Text(
          //                   S.of(context).SelectHere,
          //                   style: TextController.labelText,
          //                 ),
          //               ),
          //               isExpanded: true,
          //               icon: const Icon(Icons.keyboard_arrow_down),
          //               decoration: InputDecoration(
          //                 enabledBorder: InputBorder.none,
          //                 border: InputBorder.none,
          //                 hoverColor: Colors.white,
          //               ),
          //               items: feesType.map((String items) {
          //                 return DropdownMenuItem(
          //                   value: items,
          //                   child: Center(
          //                       child: Text(items,
          //                           style: TextController.BodyText)),
          //                 );
          //               }).toList(),
          //               onChanged: (String? newValue) {
          //                 setState(() {
          //                   dropdownvalue = newValue!;
          //                 });
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: RangeFrom,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: RangeTo,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: FixedArrangingFees,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: ArrangingFeesRate,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         width: 100,
          //         child: DropdownButtonHideUnderline(
          //           child: Theme(
          //             data: Theme.of(context)
          //                 .copyWith(focusColor: Colors.white),
          //             child: DropdownButtonFormField(
          //               hint: Center(
          //                 child: Text(
          //                   S.of(context).SelectHere,
          //                   style: TextController.labelText,
          //                 ),
          //               ),
          //               isExpanded: true,
          //               icon: const Icon(Icons.keyboard_arrow_down),
          //               decoration: InputDecoration(
          //                 enabledBorder: InputBorder.none,
          //                 border: InputBorder.none,
          //                 hoverColor: Colors.white,
          //               ),
          //               items: items.map((String items) {
          //                 return DropdownMenuItem(
          //                   value: items,
          //                   child: Center(
          //                       child: Text(items,
          //                           style: TextController.BodyText)),
          //                 );
          //               }).toList(),
          //               onChanged: (String? newValue) {
          //                 setState(() {
          //                   dropdownvalue2 = newValue!;
          //                 });
          //               },
          //             ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Lower,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Upper,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //       Container(
          //         height: 70,
          //         child: TextFormField(
          //           textAlign: TextAlign.center,
          //           controller: Upper,
          //           maxLines: null,
          //           keyboardType: TextInputType.multiline,
          //           decoration: InputDecoration(border: InputBorder.none),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
