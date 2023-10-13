import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AgrrementPdfViewer extends StatefulWidget {
  AgrrementPdfViewer({@required controller}) {
    tabController = controller;
  }
  @override
  State<AgrrementPdfViewer> createState() => _AgrrementPdfViewerState();
  static ValueNotifier<String> name = ValueNotifier("");
}

TabController? tabController;

class _AgrrementPdfViewerState extends State<AgrrementPdfViewer> {
  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];
  bool _agreementError = false;
  final _formKey = GlobalKey<FormState>();

  int? editIndex; // Updated type to int?
  bool btn = true;
  @override
  void initState() {
    super.initState();
    print("----");
  }

  Future<bool> senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = {
      "generatedBy": GlobalPermission.employeeId,
      "FundId": GlobalPermissionFund.Fundclientid,
      "TemplateName": valueText,
      "todos": finalitems
    };
    print(data);
    final response = await http.post(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/FundAgreeementCreation/FundAgreementTemplates'),
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.body);
    if (response.statusCode == 200) {
      // Request successful, handle the response

      bool y = await GlobalPermission.formApproval("Fund Creation",
          GlobalPermissionFund.Fundclientid, AgrrementPdfViewer.name.value, 0);
      GlobalPermissionFund.Fundclientid = 0;
      GlobalPermissionFund.Funddraftprogress = {};
      if (y == true) {
        Fluttertoast.showToast(
            msg: "Sent for Approval",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print("Successful");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }

      // Process the responseData
    } else {
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      return false;
      // Display or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Image.asset(
              'images/1.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/2.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/3.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/4.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/5.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/6.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/7.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/8.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/9.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/10.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/11.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/12.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/13.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/14.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/15.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/16.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/17.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/18.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/19.png', // Replace with your image path
              width: 1000, // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/20.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Container(
            child: Image.asset(
              'images/21.png', // Replace with your image path
              // Set the width of the image
              // height: 1000, // Set the height of the image
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 35,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: ColorSelect.tabBorderColor)),
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
                  Container(
                    height: 35,
                    width: 140,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                S.of(context).Save,
                                style: TextController.BodyHeadingText,
                              ),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).EnterTemplateName,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 290,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                onChanged: (value) {
                                                  setState(() {
                                                    valueText = value;
                                                  });
                                                },
                                                controller: tempName,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController
                                                    .BodyHeadingText,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).TypeHere,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none),
                                              ),
                                            ),
                                            if (_agreementError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              actions: <Widget>[
                                Container(
                                  height: 35,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.tabBorderColor)),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text(
                                      S.of(context).Cancel,
                                      style: TextController.SideMenuText,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: ColorSelect.east_blue,
                                      border: Border.all(
                                          color: ColorSelect.tabBorderColor)),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (_formKey.currentState != null) {
                                        // setState(() {
                                        //   _agreementError = tempName.text == "";
                                        // });
                                        if (btn == false) {
                                          return;
                                        }
                                        setState(() {
                                          btn = false;
                                        });
                                        print("pressedd");
                                        bool x = false;
                                        var tempdraft = GlobalPermissionFund
                                            .Funddraftprogress;

                                        bool allValuesTrue = tempdraft.values
                                            .every((value) => value == true);
                                        if (tempName.text != "") {
                                          if (allValuesTrue &&
                                              GlobalPermissionFund
                                                      .Fundclientid !=
                                                  0) {
                                            Fluttertoast.showToast(
                                                msg: "Data Storing",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                            x = await senddata();
                                            setState(() {
                                              btn = true;
                                            });
                                          } else {
                                            var field = "Fund Creation";
                                            print(GlobalPermissionFund
                                                .Funddraftprogress.keys);
                                            for (var entry
                                                in GlobalPermissionFund
                                                    .Funddraftprogress.keys) {
                                              print(entry);
                                              if (GlobalPermissionFund
                                                          .Funddraftprogress[
                                                      entry] ==
                                                  false) {
                                                field = entry;
                                                print("ff$field");
                                                break; // Exit the loop when the first key with a false value is found.
                                              }
                                            }
                                            Fluttertoast.showToast(
                                                msg: "Please fill ${field}",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          }

                                          if (x == true) {
                                            setState(() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TabOfFundCreation()));
                                            });
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Please enter agreement name",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      }
                                    },
                                    child: Text(
                                      S.of(context).OK,
                                      style: TextController.btnText,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        //customerGetAgreement.id.value=id;
                      },
                      child: Text("Save"),
                      style: ElevatedButton.styleFrom(
                        primary: ColorSelect
                            .east_blue, // Set the desired background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Set border radius to 0
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
