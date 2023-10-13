import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:east_bridge/NDPM/PortfolioCreation/ShareFeesDetail.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';

import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'dart:typed_data';

enum SingingCharacter { yes, no }

class PortfolioDetailsNDPM extends StatefulWidget {
  PortfolioDetailsNDPM({@required controller}) {
    tabController = controller;
  }

  @override
  State<PortfolioDetailsNDPM> createState() => ShareDetailsState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<String> name = new ValueNotifier("");
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class ShareDetailsState extends State<PortfolioDetailsNDPM> {
  TextEditingController TotalFundValue = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController _currency = new TextEditingController();

  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'USD',
      'EUR',
      'JPY',
      'GBP',
      'AUD',
      'CAD',
      'CHF',
      'CNY',
      'SEK',
      'NZD'
    ];

    void fundFinanicialDetail() async {
      int? valueOfFund = int.tryParse(TotalFundValue.text);
      int? perShare = int.tryParse(PerShareValue.text);
      int? noShare = int.tryParse(NoOfShares.text);
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/ClientownShareFinancial/InsertClientOWNShareFinancialDetail');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "clientId": PortfolioDetailsNDPM.clientid.value,
          "shareId": PortfolioDetailsNDPM.id.value,
          "valueOfFund": valueOfFund,
          "noOfShares": noShare,
          "perShareValue": perShare,
          "currency": _currency
        };
        print(body);
        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
          PortfolioFeesDetailNDPM.clientid.value =
              PortfolioDetailsNDPM.clientid.value;
          PortfolioFeesDetailNDPM.name.value = PortfolioDetailsNDPM.name.value;
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

    @override
    void initState() {
      super.initState();
    }

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text("Portfolio Details",
                  style: TextController.BodyHeadingText),
            ),
            Container(
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorSelect.textField)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 35, bottom: 0),
                        height: 35,
                        child: Center(
                          child: Text(S.of(context).TotalValueOfShare,
                              style: TextController.BodyText),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 35,
                        child: Center(
                          child: Text("Per Unit Value",
                              style: TextController.BodyText),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 35, bottom: 0),
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
                                controller: TotalFundValue,
                                decoration: InputDecoration(
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          child: Container(
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
                                controller: PerShareValue,
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
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0, top: 45),
                        child: Text("No. Of Units",
                            style: TextController.BodyText),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(S.of(context).Currency,
                          style: TextController.BodyText),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(top: 35, bottom: 15),
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
                              controller: NoOfShares,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                          ),
                          child: TextFormField(
                            controller: _currency,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextController.BodyText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required.';
                              }
                              return null; // Return null if the input is valid
                            },
                            onTap: () {
                              showCurrencyPicker(
                                theme: CurrencyPickerThemeData(),
                                context: context,
                                showFlag: true,
                                showSearchField: true,
                                showCurrencyName: true,
                                showCurrencyCode: true,
                                onSelect: (Currency currency) {
                                  setState(() {
                                    _currency.text = currency.name;
                                  });
                                  print('Select currency: ${currency.code}');
                                },
                                favorite: ['SAR'],
                              );
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                errorStyle: TextController.inputErrorText,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
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
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                          color: ColorSelect.east_blue,
                          border:
                              Border.all(color: ColorSelect.tabBorderColor)),
                      child: TextButton(
                        onPressed: () {
                          print(PortfolioDetailsNDPM.id.value);
                          fundFinanicialDetail();
                          tabController!.animateTo(2);
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
            )
          ],
        ),
      ),
    );
  }
}
