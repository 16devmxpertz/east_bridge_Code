import 'dart:convert';

import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'package:east_bridge/Advisory/SubServiceCreation/subServiceFeesAdv.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class Scopeofwork extends StatefulWidget {
  Scopeofwork({@required controller}) {
    tabController = controller;
  }

  @override
  State<Scopeofwork> createState() => ScopeofworkState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class ScopeofworkState extends State<Scopeofwork> {
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
    print("Sending");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryScopeOfWork/AdvisoryScopeOfWork');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "scopeOfWorkTitle": GlobalPermissionAdvisory.scopeOfWork.text,
      "description": GlobalPermissionAdvisory.description.text,
      "clientId": GlobalPermissionAdvisory.Advisoryclientid
    };
    print(body);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Data is sending");

      tabController?.animateTo(5);

      // print(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      print(response.body);
      print("Error");
    }
  }

  void PutData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryScopeOfWork/AdvisoryScopeOfWork?AdvisoryId=${GlobalPermissionAdvisory.AdvisoryIdglobal}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "advisoryId": GlobalPermissionAdvisory.AdvisoryIdService,
      "scopeOfWorkTitle": GlobalPermissionAdvisory.scopeOfWork.text,
      "description": GlobalPermissionAdvisory.description.text,
      "clientId": GlobalPermissionAdvisory.Advisoryclientid
    };

    print(body);
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Data is Updating");
      tabController?.animateTo(5);
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
  }

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AdvisoryScopeOfWork/${Id}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      setState(() {
        GlobalPermissionAdvisory.scopeOfWork.text =
            jsonResponse['scopeOfWorkTitle'].toString();
        GlobalPermissionAdvisory.description.text =
            jsonResponse['description'].toString();
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    dateController.text = " ";
    print("Init Working");

    if (GlobalPermissionAdvisory
            .Advisorydraftprogress["AdvisoryMileStoneFees"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionAdvisory.Advisoryclientid);
    } else {}

    print(GlobalPermissionAdvisory.Advisorydraftprogress);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         SizedBox(height: 20,),
            Row(children: [Text("Service Name: ", style: TextController.InvA,), Text("${GlobalPermissionAdvisory.AdvisoryServiceNameGlobal}", style: TextController.InvA,),]),
            SizedBox(height: 20,),
            Row(children: [Text("Client Name: ", style: TextController.InvA,), Text("${GlobalPermissionAdvisory.clientNameGlobal}", style: TextController.InvA,),]),
            SizedBox(height: 20,),
        SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Text(
              S.of(context).ScopeOfWork,
              style: TextController.BodyHeadingText,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ColorSelect.textField)),
            height: 250,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 25),
                      child: Text(
                        S.of(context).scopeOfWorkTitle,
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
                          margin: const EdgeInsets.only(
                              left: 15, top: 15, bottom: 15),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            controller: GlobalPermissionAdvisory.scopeOfWork,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: S.of(context).TypeHere,
                              hintStyle: TextController.labelText,
                              border: InputBorder.none,
                              errorStyle: TextController.BodyText,
                            ),
                          ),
                        ),
                      ),
    
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          height: 130,
                          margin: EdgeInsets.only(left: 15),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: TextFormField(
                            controller: GlobalPermissionAdvisory.description,
                            maxLines: null,
                            style: TextController.BodyText,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: S.of(context).TypeHere,
                              hintStyle: TextController.labelText,
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText,
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
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
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
                        tabController!.animateTo(3);
                      }, // Switch tabs
                      child: Text(
                        S.of(context).Back,
                        style: TextController.SideMenuText,
                      ),
                    ),
                  ),
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
    
                      // subServiceAdvisoryFees.id.value = id;
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
        ]),
      )),
    ]);
  }
}
