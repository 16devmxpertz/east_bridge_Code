import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Fees extends StatefulWidget {
  Fees({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;

class _DynamicTableState extends State<Fees> {
  final _formKey = GlobalKey<FormState>();

  bool tableError = false;

  List<List<TextEditingController>> FeesList = [];
  List<Map<String, dynamic>> feesListfinal = [];

  @override
  // void dispose() {
  //   for (var rowData in rowDataList) {
  //     rowData.RangeFrom.dispose();
  //     rowData.RangeTo.dispose();
  //     rowData.FixedAdvisoryFees.dispose();
  //     rowData.AdvisoryFeesRate.dispose();
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
      List<TextEditingController> li = [];
      for (int i = 0; i < 9; i++) {
        if (i == 0 || i == 5 || i == 8) {
          // Initialize dropdown column with its default value
          TextEditingController temp = new TextEditingController();
          li.add(temp);
        } else {
          // Initialize numerical columns with default value '0.0'
          TextEditingController temp = new TextEditingController();
          li.add(temp);
        }
      }

      FeesList.add(li);
      rangesList.add({'from': 0.0, 'to': 0.0});
    });
  }

  void deleteRow(int i) {
    setState(() {
      FeesList.removeAt(i);
    });
  }

  List<String> dropdownItems = [
    'Establishment Expenses',
    'Entry Fees',
    'Management Fees',
    'Performance Fees',
    'Custody Fees',
    'Advisory Operator Fees',
    'Auditor Fees',
    'Trading Fees',
    'Financing',
    'SPV Set Up Fee',
    'SPV Wind Up Fee',
    'Financial Statements Preparation Fee',
    'Other Expenses',
  ];

  String?
      selectedValue; // Initialize it with an empty string or an initial value

  // TextEditingController customItemController = TextEditingController();

  void fundAdvisoryFees() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFeesDetail/FundFeesDetail');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "fundId": GlobalPermissionFund.Fundclientid,
      "fees": feesListfinal,
    };

    print(body);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Fees Working");
      GlobalPermissionFund.getdraftprogressfund(
          GlobalPermissionFund.Fundclientid);
      // print(jsonDecode(response.body));
      tabController!.animateTo(3);
      setState(() {
        tableError = false;
      });
    } else {
      setState(() {
        tableError = true;
      });
      print(response.body);
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(jsonDecode(response.body));
      print("Error22");
    }
  }

  void PutData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFeesDetail/FundFeesDetailUpdate?FundId=$Id');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "fundId": Id,
        "fees": feesListfinal,
      };

      print(body);

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController!.animateTo(3);
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

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFeesDetail/FundFeesDetail?FundId=$Id'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Fetch Working");
      // Request was successful

      List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        for (var i in jsonResponse) {
          List<TextEditingController> li = [];
          setState(() {
            // FeesList[0][0] =
            //     TextEditingController(text: i["feestype"].toString());
            // FeesList[0][5] = TextEditingController(text: i["perOf"].toString());

            li.add(TextEditingController(text: i["feestype"].toString()));
            li.add(TextEditingController(
                text: i["rangeFrom"].toString() == "null"
                    ? ""
                    : i["rangeFrom"].toString()));
            li.add(TextEditingController(
                text: i["rangeTo"].toString() == "null"
                    ? ""
                    : i["rangeTo"].toString()));
            li.add(TextEditingController(
                text: i["fixedFees"].toString() == "null"
                    ? ""
                    : i["fixedFees"].toString()));
            li.add(TextEditingController(
                text: i["feesRate"].toString() == "null"
                    ? ""
                    : i["feesRate"].toString()));
            li.add(TextEditingController(text: i["perOf"].toString()));
            li.add(TextEditingController(
                text: i["lowerLimit"].toString() == "null"
                    ? ""
                    : i["lowerLimit"].toString()));
            li.add(TextEditingController(
                text: i["upperLimit"].toString() == "null"
                    ? ""
                    : i["upperLimit"].toString()));
            li.add(TextEditingController(text: i["payableAt"].toString()));
          });

          FeesList.add(li);
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  List<Map<String, double>> rangesList = [];

  @override
  void initState() {
    super.initState();
    print("Init  working");
    FeesList.clear();
    feesListfinal.clear();
    print(GlobalPermissionFund.Funddraftprogress);

    if (GlobalPermissionFund.Funddraftprogress["FundFeesDetail"] == true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionFund.Fundclientid);
      print(GlobalPermissionFund.Funddraftprogress);
      print("ftechinggg----------");
    } else {
      addRow();
    }
  }

  //validations
  void validateAndProcessData() {
    // Validation flags
    bool hasEmptyRow = false;
    bool hasDuplicateRow = false;

    for (int rowIndex = 0; rowIndex < FeesList.length; rowIndex++) {
      try {
        String feeType = FeesList[rowIndex][0].text;
        double rangeFrom =
            double.parse(FeesList[rowIndex][1].text.replaceAll(",", ""));
        double rangeTo =
            double.parse(FeesList[rowIndex][2].text.replaceAll(",", ""));
        double fixedFees =
            double.parse(FeesList[rowIndex][3].text.replaceAll(",", ""));
        double feesRate =
            double.parse(FeesList[rowIndex][4].text.replaceAll(",", ""));
        String percentOf = FeesList[rowIndex][5].text;
        double lowerLimit =
            double.parse(FeesList[rowIndex][6].text.replaceAll(",", ""));
        double upperLimit =
            double.parse(FeesList[rowIndex][7].text.replaceAll(",", ""));
        String payableAt = FeesList[rowIndex][8].text;

        // Check for empty row
        if (feeType.isEmpty &&
            rangeFrom == 0.0 &&
            rangeTo == 0.0 &&
            fixedFees == 0.0 &&
            feesRate == 0.0 &&
            percentOf.isEmpty &&
            lowerLimit == 0.0 &&
            upperLimit == 0.0 &&
            payableAt.isEmpty) {
          hasEmptyRow = true;
          continue; // Skip further validation for empty row
        }

        // Check if "feestype" is empty
        if (feeType.isEmpty) {
          Fluttertoast.showToast(
              msg: "Please select a fees type",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        // Check if Range From is greater than Range To
        if (rangeFrom >= rangeTo) {
          Fluttertoast.showToast(
              msg: "Range 'From' must be less than 'To'",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        // Check for conflicts with existing ranges
        for (Map<String, double> existingRange in rangesList) {
          double existingRangeFrom = existingRange['from']!;
          double existingRangeTo = existingRange['to']!;

          if ((rangeFrom >= existingRangeFrom &&
                  rangeFrom <= existingRangeTo) ||
              (rangeTo >= existingRangeFrom && rangeTo <= existingRangeTo)) {
            Fluttertoast.showToast(
                msg: "Range conflicts with an existing range",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }
        }

        // Check if Fixed Fees is greater than 0 when fixed fees are used
        // if (fixedFees > 0.0) {
        //   // Validate other attributes for fixed fee calculation
        //   if (feesRate > 0.0 || percentOf.isNotEmpty) {
        //     Fluttertoast.showToast(
        //         msg: "Fixed Fees selected, clear Fees Rate and % of fields",
        //         toastLength: Toast.LENGTH_SHORT,
        //         gravity: ToastGravity.CENTER,
        //         timeInSecForIosWeb: 3,
        //         backgroundColor: Colors.red,
        //         textColor: Colors.white,
        //         fontSize: 16.0);
        //     return;
        //   }
        // } else if (feesRate <= 0.0) {
        //   Fluttertoast.showToast(
        //       msg: "Fees Rate must be greater than 0",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 3,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   return;
        // }

        // Check for percentage validation
        if (percentOf.isNotEmpty) {
          double percentOfValue = double.parse(percentOf);
          if (percentOfValue < 0 || percentOfValue > 100) {
            Fluttertoast.showToast(
                msg: "Percentage must be between 0 and 100",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            return;
          }
        }

        // Check for upper and lower limit validation
        if ((upperLimit > 0 && lowerLimit > 0) && (upperLimit <= lowerLimit)) {
          Fluttertoast.showToast(
              msg: "Upper Limit must be greater than Lower Limit",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

        // Check for combination validation
        // if ((fixedFees > 0 && (feesRate > 0 || percentOf.isNotEmpty)) ||
        //     (feesRate > 0 && (fixedFees > 0 || percentOf.isNotEmpty))) {
        //   Fluttertoast.showToast(
        //       msg:
        //           "Select either Fixed Fees, Fees Rate, or % of, not a combination",
        //       toastLength: Toast.LENGTH_SHORT,
        //       gravity: ToastGravity.CENTER,
        //       timeInSecForIosWeb: 3,
        //       backgroundColor: Colors.red,
        //       textColor: Colors.white,
        //       fontSize: 16.0);
        //   return;
        // }

        // Check for duplicate row
        for (int i = 0; i < rowIndex; i++) {
          if (feeType == FeesList[i][0].text &&
              rangeFrom ==
                  double.parse(FeesList[i][1].text.replaceAll(",", "")) &&
              rangeTo ==
                  double.parse(FeesList[i][2].text.replaceAll(",", ""))) {
            hasDuplicateRow = true;
            break;
          }
        }
      } catch (e) {
        // Handle parsing errors here
        Fluttertoast.showToast(
            msg: "Invalid input format for numerical values",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }

    // Check for empty row
    if (hasEmptyRow) {
      Fluttertoast.showToast(
          msg: "Please fill in at least one attribute for non-empty rows",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    // Check for duplicate rows
    if (hasDuplicateRow) {
      Fluttertoast.showToast(
          msg: "Duplicate rows found, please correct or remove them",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }

    // Rest of your validation and processing logic
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Form(
            key: _formKey,
            child: Container(
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
                  8: FlexColumnWidth(2),
                  9: FlexColumnWidth(0.5),
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
                            S.of(context).RangeFrom,
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
                            S.of(context).RangeTo,
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
                            "Payable At",
                            style: TextController.InvA,
                            maxLines: 3,
                          )),
                        )),
                    Container(
                      height: 70,
                      color: ColorSelect.east_grey,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: IconButton(
                        onPressed: addRow,
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: FeesList.length,
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
                      tabController!.animateTo(1);
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
                      feesListfinal.clear();

                      // Validate the form
                      if (_formKey.currentState!.validate()) {
                        // Check if the FeesList is not empty
                        if (FeesList.isNotEmpty) {
                          for (List<TextEditingController> x in FeesList) {
                            // Check if fees type is selected
                            for (int rowIndex = 0;
                                rowIndex < FeesList.length;
                                rowIndex++) {
                              try {
                                String feeType = FeesList[rowIndex][0].text;

                                // Check if "feestype" is empty
                                if (feeType.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please select a fees type",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }

                                if ((x[5].text.isEmpty && x[3].text == "") &&
                                    (x[1].text == "" && x[2].text == "")) {
                                  Fluttertoast.showToast(
                                      msg: "Please fill other details",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                if (x[8].text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Enter Payable at value",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                if ((x[1].text != "" && x[2].text != "")) {
                                  double rangeFrom = double.parse(
                                      x[1].text.replaceAll(",", ""));
                                  double rangeTo = double.parse(
                                      x[2].text.replaceAll(",", ""));
                                  if (rangeFrom >= rangeTo) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Range 'From' must be less than 'To'",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                }

                                if ((x[3].text.isEmpty && x[4].text == "") &&
                                    (x[1].text != "" && x[2].text != "")) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Please enter either Fixed Fees or Fees Rate ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                if (x[4].text != "") {
                                  double feesRate = double.parse(
                                      x[4].text.replaceAll(",", ""));
                                  if (feesRate < 0 || feesRate > 100) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Fees Rate must be between 0 and 100",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                }
                                if (x[3].text.isNotEmpty &&
                                    x[4].text.isNotEmpty) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Fill either Fixed Fee or Fee Rate, not both",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                } else if (x[3].text.isEmpty &&
                                    x[4].text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Fill either Fixed Fee or Fee Rate",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }
                                if (x[5].text.isNotEmpty && x[4].text == "") {
                                  Fluttertoast.showToast(
                                      msg: "Please enter fees rate",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  return;
                                }

                                //  Check percentage validation

                                // Check for empty fields in other attributes
                                if (x[6].text != "" && x[7].text != "") {
                                  double lowerLimit = double.parse(
                                      x[6].text.replaceAll(",", ""));
                                  double upperLimit = double.parse(
                                      x[7].text.replaceAll(",", ""));
                                  if ((upperLimit > 0 && lowerLimit > 0) &&
                                      (upperLimit <= lowerLimit)) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Upper Limit must be greater than Lower Limit",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    return;
                                  }
                                }
                                // if (x[1].text != "" && x[2].text != "") {
                                //   double rangeFrom = double.parse(
                                //       x[1].text.replaceAll(",", ""));
                                //   double rangeTo = double.parse(
                                //       x[2].text.replaceAll(",", ""));
                                //   for (int i = 0; i < rowIndex; i++) {
                                //     if (feeType == FeesList[i][0].text &&
                                //         rangeFrom ==
                                //             double.parse(FeesList[i][1]
                                //                 .text
                                //                 .replaceAll(",", "")) &&
                                //         rangeTo ==
                                //             double.parse(FeesList[i][2]
                                //                 .text
                                //                 .replaceAll(",", ""))) {
                                //       Fluttertoast.showToast(
                                //           msg:
                                //               "Duplicate rows found, please correct or remove them",
                                //           toastLength: Toast.LENGTH_SHORT,
                                //           gravity: ToastGravity.CENTER,
                                //           timeInSecForIosWeb: 3,
                                //           backgroundColor: Colors.red,
                                //           textColor: Colors.white,
                                //           fontSize: 16.0);
                                //       return;
                                //     }
                                //   }

                                // }
                              } catch (e) {
                                // Handle parsing errors here
                                Fluttertoast.showToast(
                                    msg:
                                        "Invalid input format for numerical values",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                return;
                              }
                            }

                            // Create a map for the fee details
                            Map<String, dynamic?> mp = {};
                            mp["feestype"] = x[0].text;
                            mp["rangeFrom"] = x[1].text == ""
                                ? null
                                : double.parse(x[1].text.replaceAll(",", ""));
                            mp["rangeTo"] = x[2].text == ""
                                ? null
                                : double.parse(x[2].text.replaceAll(",", ""));

                            mp["fixedFees"] = x[3].text == ""
                                ? null
                                : double.parse(x[3].text.replaceAll(",", ""));
                            mp["feesRate"] = x[4].text == ""
                                ? null
                                : double.parse(x[4].text.replaceAll(",", ""));
                            mp["perOf"] = x[5].text == "" ? null : x[5].text;
                            mp["lowerLimit"] = x[6].text == ""
                                ? null
                                : double.parse(x[6].text.replaceAll(",", ""));
                            mp["upperLimit"] = x[7].text == ""
                                ? null
                                : double.parse(x[7].text.replaceAll(",", ""));
                            mp["PayableAt"] = x[8].text;

                            // Add the fee details to the final list
                            feesListfinal.add(mp);
                          }

                          // Perform further actions, e.g., API calls or navigation
                          if (GlobalPermissionFund
                                  .Funddraftprogress["FundFeesDetail"] ==
                              true) {
                            PutData(GlobalPermissionFund.Fundclientid);
                          } else {
                            if (GlobalPermissionFund.Fundclientid != 0) {
                              fundAdvisoryFees();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill Fund Detail first",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }
                        } else {
                          // Show a message if FeesList is empty
                          Fluttertoast.showToast(
                              msg: "Please fill in Fees Details",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      }
                    }, // Switch tabs
                    child: Text(
                      S.of(context).Next,
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
      'Performance Fees',
      'Custody Fees',
      'Advisory Operator Fees',
      'Auditor Fees',
      'Trading Fees',
      'Financing',
      'SPV Set Up Fee',
      'SPV Wind Up Fee',
      'Financial Statements Preparation Fee',
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
    var payable = [
      'Subscription',
      'Redemption',
      'Monthly',
    ];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
      ),
      //  padding: EdgeInsets.all(25),
      // width: double.infinity,
      //  margin: const EdgeInsets.symmetric(horizontal: 5),
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
          8: FlexColumnWidth(2),
          9: FlexColumnWidth(0.5),
        },
        children: [
          TableRow(
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 45,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField)),
                      child: DropdownButtonHideUnderline(
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(focusColor: Colors.white),
                          child: DropdownButtonFormField(
                            hint: Center(
                              child: Text(
                                S.of(context).SelectHere,
                                style: TextController.labelText,
                              ),
                            ),
                            value: FeesList[index][0].text.isNotEmpty
                                ? FeesList[index][0].text
                                : null,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hoverColor: Colors.white,
                            ),
                            items: dropdownItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Center(
                                    child: Text(items,
                                        style: TextController.BodyText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                FeesList[index][0].text = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    if (FeesList[index][0].text == "Other Expenses")
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: TextFormField(
                          controller: FeesList[index][0],
                          style: TextController.BodyText,
                          textAlignVertical: TextAlignVertical.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          onFieldSubmitted: (value) {
                            setState(() {
                              if (!dropdownItems.contains(value)) {
                                FeesList[index][1].text = value!;
                                dropdownItems.add(value);
                              }
                              FeesList[index][0].text = "";
                            });
                          },
                          decoration: InputDecoration(
                              errorStyle: TextController.inputErrorText,
                              isDense: true,
                              hintText: S.of(context).TypeHere,
                              hintStyle: TextController.labelText,
                              border: InputBorder.none),
                        ),
                      ),
                  ],
                ),
              ),
              Container(
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][1],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][2],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][3],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][4],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),
              Container(
                // height: 127,
                // width: 100,
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
                      value: FeesList[index][5].text.isNotEmpty
                          ? FeesList[index][5].text
                          : null,
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
                          FeesList[index][5].text = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][6],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      tableError = false;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: FeesList[index][7],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    ThousandsSeparatorInputFormatter()
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
              ),

              Container(
                // height: 127,
                // width: 100,
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
                      value: FeesList[index][8].text.isNotEmpty
                          ? FeesList[index][8].text
                          : null,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hoverColor: Colors.white,
                      ),
                      items: payable.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Center(
                              child:
                                  Text(items, style: TextController.BodyText)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          FeesList[index][8].text = newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),

              // Container(
              //   // height: 127,
              //   child: TextFormField(
              //     validator: (value) {
              //       if (value!.isEmpty) {
              //         return 'This field is required.';
              //       }
              //       return null; // Return null if the input is valid
              //     },
              //     textAlign: TextAlign.center,
              //     controller: FeesList[index][8],
              //     maxLines: null,
              //     keyboardType: TextInputType.multiline,
              //     textAlignVertical: TextAlignVertical.center,
              //     style: TextController.BodyText,
              //     inputFormatters: <TextInputFormatter>[
              //       FilteringTextInputFormatter.digitsOnly
              //     ],
              //     decoration: InputDecoration(
              //       isDense: true,
              //       border: InputBorder.none,
              //       errorStyle: TextController.inputErrorText,
              //     ),
              //   ),
              // ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteRow(index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String cleanedText = newValue.text.replaceAll(',', '');
    final parts = cleanedText.split('.');
    String formattedValue = _formatWithCommas(parts[0]);

    if (parts.length > 1) {
      formattedValue += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatWithCommas(String text) {
    final int length = text.length;
    if (length <= 3) {
      return text;
    }
    String temp = "";
    int count = 3;
    int j = 0;
    for (int i = length - 1; i >= 0; i--) {
      j++;
      temp += text[i];
      if (j == count) {
        j = 0;
        temp += ",";
      }
    }

    temp = temp.split('').reversed.join('');
    if (temp[0] == ",") {
      temp = temp.substring(1);
    }
    return temp;
  }
}
