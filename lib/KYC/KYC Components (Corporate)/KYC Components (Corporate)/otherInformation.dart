import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'RegisteredAddress.dart';

enum SingingCharacter { yes, no }

class OtherInfoCorporate extends StatefulWidget {
  OtherInfoCorporate({super.key, @required controller}) {
    tabController = controller;
  }

  @override
  State<OtherInfoCorporate> createState() => OtherInfoCorporateState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

class OtherInfoCorporateState extends State<OtherInfoCorporate> {
  @override
  Widget build(BuildContext context) {
    TextEditingController OtherInformations = new TextEditingController();

    SingingCharacter? _character = SingingCharacter.yes;

    @override
    void otherInformation() async {
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/OtherInformationCorporate/OtherInformationCorporate');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "clientId": OtherInfoCorporate.id.value,
          "OtherInformation": OtherInformations.text
        };
        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print("Other Information is Working");
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

    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

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
                      child: TextButton(
                        onPressed: () {
                          otherInformation();
                          tabController?.animateTo(7);
                        }, // Switch tabs
                        child: Text(
                          S.of(context).Next,
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
