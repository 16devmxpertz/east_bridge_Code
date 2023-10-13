import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class OtherInfoCorporate extends StatefulWidget {
  OtherInfoCorporate({@required controller}) {
    tabController = controller;
  }

  @override
  State<OtherInfoCorporate> createState() => OtherInfoCorporateState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class OtherInfoCorporateState extends State<OtherInfoCorporate> {
  String btn = "Next";
  TextEditingController OtherInformations = new TextEditingController();

  SingingCharacter? _character = SingingCharacter.yes;

  @override
  void otherInformation() async {
    setState(() {
      btn = "Loading...";
    });
    print("InsertinggData");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtherInformationCorporate/OtherInformationCorporate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "OtherInformation": OtherInformations.text
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Other Information is Working");
        GlobalPermissionCorporate.getdraftprogresscorporate(
            GlobalPermissionCorporate.corporateclientid);
        tabController?.animateTo(7);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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

  void PutData(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    // Assuming you have a unique identifier for the resource, replace 'resourceId' with it.
    var resourceId = 'your_unique_resource_id';
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtherInformationCorporate/OtherInformationCorporate?ClientId=${Id}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {"clientId": Id, "OtherInformation": OtherInformations.text};

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Other Information has been updated");
        tabController?.animateTo(7);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
        '${GlobalPermission.urlLink}/api/OtherInformationCorporate/OtherInformationCorporate/${Id}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request was successful
      var jsonResponse = response.body;
      print(jsonResponse);
      setState(() {
        OtherInformations.text = jsonResponse.toString();
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // Future<void> fetchData(int Id) async {
  //   // Assuming you have a unique identifier for the resource, replace 'resourceId' with it.

  //   var url = Uri.parse(
  //       '${GlobalPermission.urlLink}/api/OtherInformationCorporate/OtherInformationCorporate/${Id}');

  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //     };

  //     var response = await http.get(url, headers: headers);

  //     if (response.statusCode == 200) {
  //       // Parse the response body, assuming it's a JSON object.
  //       var responseBody = response.body;
  //       print(responseBody);

  //       OtherInformations.text = responseBody['OtherInformation'];
  //     } else {
  //       var errorMessage = response.reasonPhrase;
  //       print(response.statusCode);
  //       print(response.body);
  //       print("Error");
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  @override
  void initState() {
    super.initState();

    if (GlobalPermissionCorporate
            .corporatedraftprogress["OtherInformationCorporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
      print(GlobalPermissionCorporate.corporatedraftprogress);
    }
  }

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
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        S
                            .of(context)
                            .Anyotherfinancialinformationontheclientsfinancialsituation,
                        style: TextController.BodyText,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.only(right: 30),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      height: 35,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.textField)),
                      child: TextFormField(
                        controller: OtherInformations,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextController.BodyHeadingText,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: S.of(context).TypeHere,
                            hintStyle: TextController.labelText,
                            border: InputBorder.none),
                      ),
                    ),
                    // child: Container(
                    //   margin: EdgeInsets.only(right: 30),
                    //   width: double.infinity,
                    //   height: 35,
                    //   alignment: Alignment.centerLeft,
                    //   decoration: BoxDecoration(
                    //       color: Colors.white,
                    //       border: Border.all(color: ColorSelect.textField)),
                    //   child: TextFormField(
                    //     textAlignVertical:TextAlignVertical.center,
                    //     controller: OtherInformations,
                    //     decoration: InputDecoration(
                    //         hintText: S.of(context).EnterDetails,
                    //         hintStyle: TextController.labelText,
                    //         border: InputBorder.none),
                    //   ),
                    // ),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 200, left: 20, right: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: ColorSelect.tabBorderColor)),
                      child: TextButton(
                        onPressed: () {
                          tabController?.animateTo(5);
                        }, // Switch tabs
                        child: Text(
                          S.of(context).Back,
                          style: TextController.SideMenuText,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                          color: ColorSelect.east_blue,
                          border:
                              Border.all(color: ColorSelect.tabBorderColor)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorSelect.east_blue),
                        ),
                        onPressed: () {
                          if (GlobalPermissionCorporate.corporatedraftprogress[
                                  "OtherInformationCorporate"] ==
                              true) {
                            PutData(
                                GlobalPermissionCorporate.corporateclientid);
                          } else {
                            if (GlobalPermissionCorporate.corporateclientid !=
                                0) {
                              otherInformation();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please fill general info first",
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
                          btn,
                          style: TextController.btnText,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
