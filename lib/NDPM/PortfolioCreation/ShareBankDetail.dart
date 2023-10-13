import 'dart:convert';
import 'package:east_bridge/DPM/DPM%20Agreement/DefaultAgreement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class ShareBankDetails extends StatefulWidget {
  ShareBankDetails({@required controller}) {
    tabController = controller;
  }

  @override
  State<ShareBankDetails> createState() => _ShareBankDetailsState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

TabController? tabController;

class _ShareBankDetailsState extends State<ShareBankDetails> {
  BankInfoPOA({@required controller}) {
    tabController = controller;
  }

  TextEditingController _bankName = new TextEditingController();
  TextEditingController _branchName = new TextEditingController();
  TextEditingController _accNum = new TextEditingController();
  TextEditingController _accHolder = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void Fundbank() async {
      var url = Uri.parse(
          'https://localhost:44323/api/ShareBankDetail/ShareBankDetail/');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "shareId": ShareBankDetails.id.value,
          "bankName": _bankName.text,
          "branchName": _branchName.text,
          "mainAccountNumber": _accNum.text,
          "accountHolderName": _accHolder.text
        };

        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
        } else {
          print(response.statusCode);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    @override
    void initState() {
      super.initState();
    }

    return Container(
      // height: 400,
      child: Scaffold(
        body: Container(
            child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        S.of(context).BankName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 140,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _bankName,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).BranchName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 85,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _branchName,
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
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        S.of(context).IBAN,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: _accNum,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        S.of(context).AccountHolderName,
                        style: TextController.BodyText,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Container(
                          width: 400,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: _accHolder,
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
                  SizedBox(
                    height: 50,
                  ),
                  Row(
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
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
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
                        padding: const EdgeInsets.only(right: 50),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: ColorSelect.east_blue,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                Fundbank();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        new DPMDefaultAgreement()));
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
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
