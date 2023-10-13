import 'dart:convert';

import 'package:east_bridge/Arranging/Arranging%20Subscribe/ArrangingSubscribe.dart';
import 'package:east_bridge/Arranging/ArrangingAgreement/DefaultAgreement.dart';
import 'package:east_bridge/Arranging/ArrangingBankDetails.dart';
import 'package:east_bridge/Arranging/ArrangingDetails.dart';
import 'package:east_bridge/Arranging/ArrangingFees.dart';
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

class ArrangingCreations extends StatefulWidget {
  ArrangingCreations({@required controller}) {
    tabController = controller;
  }

  @override
  State<ArrangingCreations> createState() => ArrangingCreationsState();
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class ArrangingCreationsState extends State<ArrangingCreations> {
  ArrangingCreations({@required controller}) {
    tabController = controller;
  }

  String selectedValue = "";
  late final id;
  TextEditingController _serviceName = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _fromDate = new TextEditingController();
  //TextEditingController FromDate = new TextEditingController();
  TextEditingController _toDate = new TextEditingController();
  TextEditingController _industryCategory = new TextEditingController();
  TextEditingController _addressForCorrespondense = new TextEditingController();
  TextEditingController _serviceCategory = new TextEditingController();
  TextEditingController _serviceType = new TextEditingController();
  TextEditingController _status = new TextEditingController();
  TextEditingController _ArrangingServiceCode = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _CustomerExpectation = new TextEditingController();

  bool serviceAllotment = false;
  TextEditingController radioOne = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  TextEditingController _addIndustry = new TextEditingController();
  TextEditingController _addType = new TextEditingController();
  TextEditingController _addSRCatogory = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = "";
  String dropdownvalue1 = "";
  String dropdownvalue2 = "";
  String dropdownvalue3 = "";

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    var cateogry = [
      'Large Cap',
      'Medium Cap',
      'Small Cap',
    ];
    var status = [
      'Open Ended',
      'Closed Ended',
    ];
    var type = [
      'Public Equity',
      'Private Equity',
      'Sukuks',
    ];

    var industry = [
      'Banking & Financial Services',
      'Information Technology',
      'Engineering & Capital Goods',
      'Oil & Gas',
      'Pharmaceuticals',
      'Automotive',
      'Chemicals',
      'Utilities',
      'Metals & Mining',
      'Cement & Construction',
      'Miscellaneous',
      'Tobacco',
      'Manufacturing',
      'Telecommunication',
      'Consumer Non-durables',
      'Services',
      'Conglomerates',
      'Retail & Real Estate',
      'Food & Beverages',
      'Media & Entertainment',
      'Consumer Durables',
      'Tourism',
    ];

    void _addItemToList() {
      String enteredText = _addIndustry.text;

      setState(() {
        industry.add(enteredText);
      });
      print(industry);
      _addIndustry.clear();
    }

    void _addTypeItemToList() {
      String enteredText = _addType.text;

      setState(() {
        type.add(enteredText);
      });
      print(type);
      _addType.clear();
    }

    void _addSRCatogoryItemToList() {
      String enteredText = _addSRCatogory.text;

      setState(() {
        cateogry.add(enteredText);
      });
      print(cateogry);
      _addSRCatogory.clear();
    }

    void fundDetail() async {
      var url = Uri.parse(
          'http://8.213.23.26:8081/apicore/api/ArrangingCreateService/Arrangingcreation/');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "ArrangingServiceCode": _ArrangingServiceCode.text,
          "serviceName": _serviceName.text,
          "description": _description.text,
          "duration": int.parse(_duration.text),
          "industryCategory": dropdownvalue,
          "serviceCategory": dropdownvalue1,
          "serviceType": dropdownvalue2,
          "belongsTo": 0
        };

        print(body);
        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
          id = int.parse(response.body);
          print("Successfull");
          print(id);
          return id;
        } else {
          print(response.statusCode);
          print("Error========");
          // Request failed, handle the error
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
    void initState() {
      super.initState();
      dateController.text = " ";
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Text(
                S.of(context).FundDetails,
                style: TextController.BodyHeadingText,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorSelect.textField)),
              height: 250,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40, top: 25),
                        child: Text(
                          S.of(context).ArrangingServiceCode,
                          style: TextController.BodyText,
                        ),
                      ),
                      Text(
                        S.of(context).Description,
                        style: TextController.BodyText,
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(top: 150),
                      //   child: Text(
                      //     S.of(context).CustomerExpectation,
                      //     style: TextController.BodyText,
                      //   ),
                      // ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            width: 400,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 10),
                              child: TextFormField(
                                controller: _ArrangingServiceCode,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 400,
                            height: 130,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 10),
                              child: TextFormField(
                                controller: _description,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     width: 400,
                        //     height: 130,
                        //     alignment: Alignment.centerLeft,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         border:
                        //             Border.all(color: ColorSelect.textField)),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(
                        //         left: 15,
                        //       ),
                        //       child: TextFormField(
                        //         controller: _CustomerExpectation,
                        //         decoration: InputDecoration(
                        //             hintText: S.of(context).TypeHere,
                        //             hintStyle: TextController.labelText,
                        //             border: InputBorder.none),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 40),
                        child: Text(
                          S.of(context).ServiceName,
                          style: TextController.BodyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Text(
                          S.of(context).Duration,
                          style: TextController.BodyText,
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            width: 400,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 10),
                              child: TextFormField(
                                controller: _serviceName,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                controller: _duration,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                S.of(context).ServiceClassification,
                style: TextController.BodyHeadingText,
              ),
            ),
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorSelect.textField)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: Text(
                          S.of(context).IndustryCategory,
                          style: TextController.BodyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: Text(
                          S.of(context).ServiceType,
                          style: TextController.BodyText,
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 30, bottom: 20),
                      //   child: Text(
                      //     S.of(context).ServiceAllotment,
                      //     style: TextController.BodyText,
                      //   ),
                      // ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: industry.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 0),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: type.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue1 = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Row(
                        //     children: [
                        //       Flexible(
                        //         child: Text(
                        //           S.of(context).Cash,
                        //           style: TextController.BodyText,
                        //         ),
                        //       ),
                        //       Radio<String>(
                        //         value: "Cash",
                        //         groupValue: selectedValue,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             selectedValue = value!; //<-- change this
                        //           });
                        //         },
                        //       ),
                        //       SizedBox(
                        //         height: 60,
                        //       ),
                        //       Flexible(
                        //         child: Text(
                        //           S.of(context).Kind,
                        //           style: TextController.BodyText,
                        //         ),
                        //       ),
                        //       Radio<String>(
                        //         value: "Kind",
                        //         groupValue: selectedValue,
                        //         onChanged: (value) {
                        //           setState(() {
                        //             selectedValue = value!; //<-- change this
                        //           });
                        //         },
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              S.of(context).ServiceCatogory,
                              style: TextController.BodyText,
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Container(
                        //     margin: const EdgeInsets.only(top: 25, bottom: 20),
                        //     child: Text(
                        //       S.of(context).Status,
                        //       style: TextController.BodyText,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: cateogry.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue2 = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Container(
                        //     margin: const EdgeInsets.only(top: 10, bottom: 10),
                        //     padding: const EdgeInsets.only(
                        //       left: 15,
                        //     ),
                        //     width: 400,
                        //     height: 44,
                        //     alignment: Alignment.centerLeft,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         border:
                        //             Border.all(color: ColorSelect.textField)),
                        //     child: DropdownButtonHideUnderline(
                        //       child: Theme(
                        //         data: Theme.of(context)
                        //             .copyWith(focusColor: Colors.white),
                        //         child: DropdownButtonFormField(
                        //           hint: Text(
                        //             S.of(context).SelectHere,
                        //             style: TextController.labelText,
                        //           ),
                        //           isExpanded: true,
                        //           icon: const Icon(Icons.keyboard_arrow_down),
                        //           decoration: InputDecoration(
                        //             enabledBorder: InputBorder.none,
                        //             border: InputBorder.none,
                        //             hoverColor: Colors.white,
                        //           ),
                        //           items: status.map((String items) {
                        //             return DropdownMenuItem(
                        //               value: items,
                        //               child: Text(items,
                        //                   style: TextController.BodyText),
                        //             );
                        //           }).toList(),
                        //           onChanged: (String? newValue) {
                        //             setState(() {
                        //               dropdownvalue3 = newValue!;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 35,
                width: 140,
                decoration: BoxDecoration(
                  color: ColorSelect.east_blue,
                ),
                child: TextButton(
                  onPressed: () {
                    fundDetail();

                    ArrangingFees.id.value = id;

                    tabController!.animateTo(1);
                  }, // Switch tabs
                  child: Text(
                    S.of(context).Next,
                    style: TextController.btnText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
