import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundAgreement.dart';
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribe.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class CustomerFundAgreementDoc extends StatefulWidget {
  CustomerFundAgreementDoc({@required controller}) {
    tabController = controller;
  }
  @override
  State<CustomerFundAgreementDoc> createState() =>
      _CustomerFundAgreementDocState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<int> fundid = ValueNotifier(0);
}

TabController? tabController;

class _CustomerFundAgreementDocState extends State<CustomerFundAgreementDoc> {
  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];
  int Id = 0;
  bool _agreementError = false;

  int? editIndex; // Updated type to int?

  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/CustomerAgreement/CustomerAgreementRelation/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "customerId": CustomerFundAgreementDoc.id.value,
        "templateId": CustomerFundAgreementDoc.fundid.value
      };

      print(body);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // formApproval();
        Fluttertoast.showToast(
            msg: "Agreement successfully linked with client",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => new FundSubscribe()));
        print("----------success");
        // print(jsonDecode(response.body));
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  S.of(context).Status,
                  style: TextController.SubHeadingText,
                ),
                content: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).SomethingWentWrong + "!",
                        style: TextController.BodyText,
                      ),
                    ],
                  ),
                ),
              );
            });
        print("----------fail");
        print(response.statusCode);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                S.of(context).Status,
                style: TextController.SubHeadingText,
              ),
              content: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).SomethingWentWrong + "!",
                      style: TextController.BodyText,
                    ),
                  ],
                ),
              ),
            );
          });
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    print("----");
    print("FundAgreementttttttttttttttttttttt");
    print(CustomerFundAgreementDoc.fundid.value);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            width: double.infinity,
            // height: 1000, // Adjust the height as needed
            // color: Colors.red,
            child: Html(
              data: '''
<h1>View PDF</h1>
                <div>
            <iframe src="${GlobalPermission.urlLink}/api/FundAgreementPdf/FundPDF?Fundid=${CustomerFundAgreementDoc.fundid.value}"
                    type="application/pdf" width="100%" height="1000"></iframe>
                </div>
              ''',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
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
                Container(
                  height: 35,
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () {
                      if (CustomerFundAgreementDoc.id.value == 0) {
                        Fluttertoast.showToast(
                            msg: "Please select client first",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else if (CustomerFundAgreementDoc.fundid.value == 0) {
                        Fluttertoast.showToast(
                            msg: "Please select fund first",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        sendData();
                      }

                      //customerGetAgreement.id.value=id;
                    },
                    child: Text("Save"),
                    style: ElevatedButton.styleFrom(
                      primary: ColorSelect
                          .east_blue, // Set the desired background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0), // Set border radius to 0
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
