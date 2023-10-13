// import 'dart:convert';
// import 'dart:math';

// import 'package:east_bridge/utility/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:east_bridge/KYC/KYC Components/BankInfo.dart';
//${GlobalPermission.urlLink}/api/AdvisoryFeesDetail/AdvisoryFeesModel

import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/DPM/DPMGlobal.dart';
import 'package:east_bridge/DPM/PortfolioCreation/TabOfShareCreation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class MileStoneFees extends StatefulWidget {
  MileStoneFees({@required controller}) {
    tabController = controller;
  }
  @override
  _DynamicTableState createState() => _DynamicTableState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;

class _DynamicTableState extends State<MileStoneFees> {
  final _formKey = GlobalKey<FormState>();

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
      for (int i = 0; i < 10; i++) {
        TextEditingController temp = new TextEditingController();
        li.add(temp);
      }

      FeesList.add(li);
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
        '${GlobalPermission.urlLink}/api/AdvisoryMileStoneFees/AdvisoryMileStoneFeesModel');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "advisoryId": MileStoneFees.id.value,
      "fees": feesListfinal,
    };

    print(body);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Fees Working");

      // print(jsonDecode(response.body));
      tabController!.animateTo(4);
    } else {
      print(response.body);
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(jsonDecode(response.body));
      print("Error22");
    }
  }

  void PutData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryMileStoneFees/AdvisoryMileStoneFeesUpdate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "advisoryId": MileStoneFees.id.value,
        "fees": feesListfinal,
          "clientId": GlobalPermissionAdvisory.clientIdglobal
      };

      print(body);

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController!.animateTo(4);
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
        '${GlobalPermission.urlLink}/api/AdvisoryMileStoneFees/AdvisoryMileStoneFees/${GlobalPermissionAdvisory.AdvisoryIdglobal}'); // Replace with your API endpoint
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
          });

          FeesList.add(li);
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    print("Init  working");
    FeesList.clear();
    feesListfinal.clear();
    print(MileStoneFees.id.value);
    // fetchData(MileStoneFees.id.value);

    if (MileStoneFees.id.value != 0) {
      print("ftechinggg----------");
      fetchData(MileStoneFees.id.value);
      print(MileStoneFees.id.value);
      print("ftechinggg----------");
    } else {
      addRow();
    }
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
                              child: Text(
                            S.of(context).MileStoneFees,
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
                      print(FeesList);
                      for (List<TextEditingController> x in FeesList) {
                        print("cheack");
                        print(x[0].text);
                        print(x[1].text);
                        Map<String, dynamic> mp = {};
                        mp["feestype"] = x[0].text;
                        print("It's Working");
                        mp["rangeFrom"] = x[1].text;
                        print("It's Working");
                        mp["rangeTo"] = int.parse(x[2].text);
                        mp["fixedFees"] = int.parse(x[3].text);
                        mp["feesRate"] = int.parse(x[4].text);
                        mp["perOf"] = x[5].text;
                        print("It's Working");
                        mp["lowerLimit"] = int.parse(x[6].text);
                        mp["upperLimit"] = int.parse(x[7].text);
                        mp["calculatedAmount"] = int.parse(x[8].text);
                        mp["mileStoneFees"] = x[9].text;
                        print(mp);
                        setState(() {
                          feesListfinal.add(mp);
                        });
                      }
                      print("sett");
                      if (_formKey.currentState!.validate()) {
                        if (MileStoneFees.id.value != 0) {
                          PutData(MileStoneFees.id.value);
                        } else {
                          fundAdvisoryFees();
                        }

                        // tabController!.animateTo(3);
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
          8: FlexColumnWidth(1),
          9: FlexColumnWidth(1),
          10: FlexColumnWidth(1),
          11: FlexColumnWidth(1.5),
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
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][2],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][3],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][4],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
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
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][7],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][8],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
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
                  controller: FeesList[index][9],
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.center,
                  style: TextController.BodyText,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    errorStyle: TextController.inputErrorText,
                  ),
                ),
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
