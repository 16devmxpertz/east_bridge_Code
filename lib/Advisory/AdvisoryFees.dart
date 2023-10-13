import 'dart:convert';

import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class RowData1 {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController RangeFrom;
  late TextEditingController RangeTo;
  late TextEditingController FixedAdvisoryFees;
  late TextEditingController AdvisoryFeesRate;
  late TextEditingController PercentOf;
  late TextEditingController Lower;
  late TextEditingController Upper;
  late TextEditingController ca;
  late TextEditingController customItemController;
  late String dropdownvalue;
  late String dropdownvalue2;

  RowData1() {
    nameController = TextEditingController();
    ageController = TextEditingController();
    RangeFrom = TextEditingController();
    RangeTo = TextEditingController();
    FixedAdvisoryFees = TextEditingController();
    AdvisoryFeesRate = TextEditingController();
    PercentOf = TextEditingController();
    Lower = TextEditingController();
    Upper = TextEditingController();
    ca = TextEditingController();
    dropdownvalue = "";
    dropdownvalue2 = "";
    customItemController = TextEditingController();
  }
}

class AdvisoryFees extends StatefulWidget {
  AdvisoryFees({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;

class _DynamicTableState extends State<AdvisoryFees> {
  final _formKey = GlobalKey<FormState>();
  String? milestones;

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
        TextEditingController temp = new TextEditingController();
        li.add(temp);
      }

      GlobalPermissionAdvisory.FeesList.add(li);
    });
  }

  void deleteRow(int i) {
    setState(() {
      GlobalPermissionAdvisory.FeesList.removeAt(i);
    });
  }

  List<String> dropdownItems = [
    'Investment Planning & Review Fees',
    'Capital markets Investment Advisory Fees',
    'General Financial Advisory services Fees',
    'Screening Note Fees',
    'Investment Note Fees',
    'Buy side Advisory Fees',
    'Sell side Advisory Fees',
    'Joint Venture Advisory Fees',
    'Real Estate monitoring Fees',
    'Valuation Services Fees',
    'Debt Advisory Fees',
    'Financial Feasibility Study Fees',
  ];
  // List<String> dropdownItems = [
  //   'Establishment Expenses',
  //   'Entry Fees',
  //   'Management Fees',
  //   'Performance Fees',
  //   'Custody Fees',
  //   'Advisory Operator Fees',
  //   'Auditor Fees',
  //   'Trading Fees',
  //   'Financing',
  //   'SPV Set Up Fee',
  //   'SPV Wind Up Fee',
  //   'Financial Statements Preparation Fee',
  //   'Other Expenses',
  // ];
  String?
      selectedValue; // Initialize it with an empty string or an initial value

  // TextEditingController customItemController = TextEditingController();

  void fundAdvisoryFees() async {
    print("data Sending");
    final url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStoneFees/AdvisoryMileStoneFeesModel');

    double? valueOfTotal = double.tryParse(
        GlobalPermissionAdvisory.TotalFeesValue.text.replaceAll(",", ""));
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "totalFees": valueOfTotal,
      "fees": GlobalPermissionAdvisory.feesListfinal,
      "clientId": GlobalPermissionAdvisory.Advisoryclientid
    };
    print(body);

    try {
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Fees Working");
        setState(() {
          GlobalPermissionAdvisory.Advisorydraftprogress["Fees"] = true;
        });

        tabController!.animateTo(4);
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  void putData() async {
    print("Updating data");
    double? valueOfTotal = double.tryParse(
        GlobalPermissionAdvisory.TotalFeesValue.text.replaceAll(",", ""));

    final url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStoneFees/AdvisoryMileStoneFeesUpdate');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = {
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "totalFees": valueOfTotal,
      "fees": GlobalPermissionAdvisory.feesListfinal,
      "clientId": GlobalPermissionAdvisory.Advisoryclientid
    };

    print("Request body: $body");

    try {
      final response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Fees updated successfully");
        print("Client ID: ${GlobalPermissionAdvisory.Advisoryclientid}");
        print("Advisory ID: ${GlobalPermissionAdvisory.AdvisoryIdService}");

        tabController!.animateTo(4);
      } else {
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
        var errorMessage = response.reasonPhrase;

        // Handle the error appropriately here
        // For example, you can show a toast or display an error message.
      }
    } catch (e) {
      print("Error: $e");

      // Handle exceptions that might occur during the HTTP request.
      // For example, you can show a toast or display a generic error message.
    }
  }

  Future<void> fetchData(int Id, int AdvisoryId) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}./api/AdvisoryMileStoneFees/AdvisoryMileStoneFees/${GlobalPermissionAdvisory.AdvisoryIdService}?ClientId=${GlobalPermissionAdvisory.Advisoryclientid}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Fetch Working");

      // Request was successful

      List<dynamic> jsonResponse = jsonDecode(response.body) as List<dynamic>;
      setState(() {
        for (var i in jsonResponse) {
          List<TextEditingController> li = [];
          setState(() {
            li.add(TextEditingController(text: i["feestype"].toString()));
            li.add(TextEditingController(text: i["rangeFrom"].toString()));
            li.add(TextEditingController(text: i["rangeTo"].toString()));
            li.add(TextEditingController(text: i["fixedFees"].toString()));
            li.add(TextEditingController(text: i["feesRate"].toString()));
            li.add(TextEditingController(text: i["perOf"].toString()));
            li.add(TextEditingController(text: i["lowerLimit"].toString()));
            li.add(TextEditingController(text: i["upperLimit"].toString()));
            li.add(
                TextEditingController(text: i["calculatedAmount"].toString()));
            li.add(TextEditingController(text: i["mileStoneFees"].toString()));
            GlobalPermissionAdvisory.TotalFeesValue.text =
                i['totalFees'].toString();
          });

          GlobalPermissionAdvisory.FeesList.add(li);
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void _showPopupBox1(BuildContext context, int i) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Milestone'),
          content: SizedBox(
            width: double.maxFinite, // Use maximum width
            height: 200, // Set a fixed height or adjust as needed
            child: ListView.builder(
              itemCount: GlobalPermissionAdvisory.milestones.length,
              itemBuilder: (context, index) {
                final milestone = GlobalPermissionAdvisory.milestones[index];
                return Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          GlobalPermissionAdvisory.FeesList[i][8].text =
                              (index + 1).toString();
                          Navigator.of(context).pop();
                        },
                        child: Text("MileStone Number:${index + 1}" +
                            "     " +
                            "${GlobalPermissionAdvisory.milestones[index]}"))
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print("Init  working");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 150,
                child: Text(
                  S.of(context).ServiceName + ":",
                  style: TextController.InvA,
                ),
              ),
              Text(
                "${GlobalPermissionAdvisory.AdvisoryServiceNameGlobal}",
                style: TextController.InvA,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                width: 150,
                child: Text(
                  S.of(context).ClientName + ":",
                  style: TextController.InvA,
                ),
              ),
              Text(
                "${GlobalPermissionAdvisory.clientNameGlobal}",
                style: TextController.InvA,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 150,
                  child: Text(
                    "Total Fees",
                    style: TextController.InvA,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: 400,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.textField)),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    style: TextController.BodyText,
                    controller: GlobalPermissionAdvisory.TotalFeesValue,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      ThousandsSeparatorInputFormatter(),
                    ],
                    decoration: InputDecoration(
                        isDense: true,
                        errorStyle: TextStyle(height: 0),
                        hintText: S.of(context).TypeHere,
                        hintStyle: TextController.labelText,
                        border: InputBorder.none),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                width: double.infinity,
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
                    9: FlexColumnWidth(1),
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                            height: 70,
                            alignment: Alignment.centerLeft,
                            color: ColorSelect.east_grey,
                            child: Center(
                                child: Text(
                              "Fees Type",
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
                            alignment: Alignment.centerLeft,
                            color: ColorSelect.east_grey,
                            child: Center(
                                child: Text(
                              "MileStones Fees",
                              style: TextController.InvA,
                            ))),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: GlobalPermissionAdvisory.FeesList.length,
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
                        tabController!.animateTo(2);
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
                        //                   "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
                        // "fees": GlobalPermissionAdvisory.feesListfinal,
                        // "clientId": GlobalPermissionAdvisory.Advisoryclientid

                        print("sett");
                        if (_formKey.currentState!.validate()) {
                          if (GlobalPermissionAdvisory.FeesList.isNotEmpty) {
                            if (GlobalPermissionAdvisory.AdvisoryIdService !=
                                    0 &&
                                GlobalPermissionAdvisory.Advisoryclientid !=
                                    0) {
                              GlobalPermissionAdvisory.feesListfinal.clear();
                              print(GlobalPermissionAdvisory.FeesList);
                              for (List<TextEditingController> x
                                  in GlobalPermissionAdvisory.FeesList) {
                                for (int rowIndex = 0;
                                    rowIndex <
                                        GlobalPermissionAdvisory
                                            .FeesList.length;
                                    rowIndex++) {
                                  try {
                                    String feeType = GlobalPermissionAdvisory
                                        .FeesList[rowIndex][0].text;

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

                                    if ((x[5].text.isEmpty &&
                                            x[3].text == "") &&
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
                                          msg: "Select Milestone",
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

                                    if ((x[3].text.isEmpty &&
                                            x[4].text == "") &&
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
                                    if (x[5].text.isNotEmpty &&
                                        x[4].text == "") {
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
                                          msg:
                                              "Fill either Fixed Fee or Fee Rate",
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

                                Map<String, dynamic> mp = {};
                                mp["feestype"] = x[0].text;
                                print("It's Working");
                                mp["rangeFrom"] = x[1].text == ""
                                    ? null
                                    : double.parse(
                                        x[1].text.replaceAll(",", ""));
                                print("It's Working");
                                mp["rangeTo"] = x[2].text == ""
                                    ? null
                                    : double.parse(
                                        x[2].text.replaceAll(",", ""));
                                mp["fixedFees"] = x[3].text == ""
                                    ? null
                                    : double.parse(
                                        x[3].text.replaceAll(",", ""));
                                mp["feesRate"] = x[4].text == ""
                                    ? null
                                    : double.parse(
                                        x[4].text.replaceAll(",", ""));
                                mp["perOf"] =
                                    x[5].text == "" ? null : x[5].text;
                                print("It's Working");
                                mp["lowerLimit"] = x[6].text == ""
                                    ? null
                                    : double.parse(
                                        x[6].text.replaceAll(",", ""));
                                mp["upperLimit"] = x[7].text == ""
                                    ? null
                                    : double.parse(
                                        x[7].text.replaceAll(",", ""));
                                mp["calculatedAmount"] = double.parse("0");
                                mp["mileStoneFees"] = double.parse(x[8].text);
                                print(mp);
                                setState(() {
                                  GlobalPermissionAdvisory.feesListfinal
                                      .add(mp);
                                });
                              }

                              if (GlobalPermissionAdvisory
                                      .Advisorydraftprogress["Fees"] ==
                                  false) {
                                fundAdvisoryFees();
                              } else {
                                putData();
                              }

                              // tabController!.animateTo(3);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Please Complete The Previous Tab Details.",
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
      ),
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
    // var feesType = [
    //   'Investment Planning & Review Fees',
    //   'Capital markets Investment Advisory Fees',
    //   'General Financial Advisory services Fees',
    //   'Screening Note Fees',
    //   'Investment Note Fees',
    //   'Buy side Advisory Fees',
    //   'Sell side Advisory Fees',
    //   'Joint Venture Advisory Fees',
    //   'Real Estate monitoring Fees',
    //   'Valuation Services Fees',
    //   'Debt Advisory Fees',
    //   'Financial Feasibility Study Fees',
    // ];

    var items = [
      'Total Fees',
    ];

    return Container(
      width: double.infinity,
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 30,
      // ),
      //  padding: EdgeInsets.all(25),
      // width: double.infinity,
      //  margin: const EdgeInsets.symmetric(horizontal: 5),
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
          9: FlexColumnWidth(1),
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
                                GlobalPermissionAdvisory
                                    .FeesList[index][0].text = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    if (GlobalPermissionAdvisory.FeesList[index][0].text ==
                        "Other Expenses")
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
                          controller: GlobalPermissionAdvisory.FeesList[index]
                              [0],
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
                                GlobalPermissionAdvisory
                                    .FeesList[index][1].text = value!;
                                dropdownItems.add(value);
                              }
                              GlobalPermissionAdvisory.FeesList[index][0].text =
                                  "";
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][1],
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][2],
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][3],
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][4],
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
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 45,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorSelect.textField)),
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
                        isDense: true,
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
                          GlobalPermissionAdvisory.FeesList[index][5].text =
                              newValue!;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                // height: 127,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][6],
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required.';
                    }
                    return null; // Return null if the input is valid
                  },
                  textAlign: TextAlign.center,
                  controller: GlobalPermissionAdvisory.FeesList[index][7],
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
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    alignment: Alignment.centerLeft,
                    child: Center(
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
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              hoverColor: Colors.white,
                            ),
                            items: GlobalPermissionAdvisory.milestones
                                .map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Center(
                                    child: Text(items,
                                        style: TextController.BodyText)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                milestones = newValue!;
                                GlobalPermissionAdvisory.FeesList[index][8]
                                    .text = (index + 1).toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
