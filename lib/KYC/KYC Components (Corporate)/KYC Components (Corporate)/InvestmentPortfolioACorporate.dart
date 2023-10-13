import 'dart:convert';

import 'package:east_bridge/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

enum SingingCharacter { radio1, radio2, radio3 }

enum SingingCharacter2 { radio11, radio22, radio33 }

class InvestmentPortfolioACorporate extends StatefulWidget {
  InvestmentPortfolioACorporate({@required controller}) {
    tabController = controller;
  }

  @override
  State<InvestmentPortfolioACorporate> createState() =>
      _InvestmentPortfolioAState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

TextEditingController _profileDepositeandMurabhaCurrent =
    new TextEditingController();
TextEditingController _profileDepositeandMurabhaIdeal =
    new TextEditingController();
TextEditingController _profileDebutInstrumentCurrent =
    new TextEditingController();
TextEditingController _profileDebutInstrumentIdeal =
    new TextEditingController();
TextEditingController _profileSharesCurrent = new TextEditingController();
TextEditingController _profileSharesIdeal = new TextEditingController();
TextEditingController _profileRealEstatesCurrent = new TextEditingController();
TextEditingController _profileRealEstatesIdeal = new TextEditingController();
TextEditingController _profileDerivativeContractsCurrent =
    new TextEditingController();
TextEditingController _profileDerivativeContractsIdeal =
    new TextEditingController();
TextEditingController _profileAlternativeInvestmentsCurrent =
    new TextEditingController();
TextEditingController _profileAlternativeInvestmentsIdeal =
    new TextEditingController();
TextEditingController _cikE1 = new TextEditingController();
TextEditingController _cikE2 = new TextEditingController();
TextEditingController _cikE3 = new TextEditingController();
TextEditingController _cikE4 = new TextEditingController();
TextEditingController _cikE5 = new TextEditingController();
TextEditingController _cikE6 = new TextEditingController();
TextEditingController _cikE7 = new TextEditingController();

TextEditingController currentdeposit = TextEditingController(text: "0");
TextEditingController idealdeposit = TextEditingController(text: "0");
TextEditingController currentdebt = TextEditingController(text: "0");
TextEditingController idealdebt = TextEditingController(text: "0");
TextEditingController currentreal = TextEditingController(text: "0");
TextEditingController idealreal = TextEditingController(text: "0");
TextEditingController currentshare = TextEditingController(text: "0");
TextEditingController idealshare = TextEditingController(text: "0");
TextEditingController currentderivative = TextEditingController(text: "0");
TextEditingController idealderivative = TextEditingController(text: "0");
TextEditingController currentalternative = TextEditingController(text: "0");
TextEditingController idealalternative = TextEditingController(text: "0");

String selectedValue = "";
String selectedValue2 = "";

class _InvestmentPortfolioAState extends State<InvestmentPortfolioACorporate> {
  final _formKey = GlobalKey<FormState>();

  bool? isChecked = false;

  bool radioError1 = false;
  bool radioError2 = false;
  bool isValidPercentage1 = false;
  bool isValidPercentage2 = false;

  // SingingCharacter? _SingingCharacter;
  // SingingCharacter2? _SingingCharacter2;

  String _SingingCharacter = "";
  String _SingingCharacter2 = "";

  String selectedRadioValue = '';

  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;

  List<String> invObj = [];

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     // currentdeposit.text = "0";
  //     // currentdeposit.text = "0";
  //     // idealdeposit.text = "0";
  //     // currentdebt.text = "0";
  //     // idealdebt.text = "0";
  //     // currentreal.text = "0";
  //     // idealreal.text = "0";
  //     // currentshare.text = "0";
  //     // idealshare.text = "0";
  //     // currentderivative.text = "0";
  //     // idealderivative.text = "0";
  //     // currentalternative.text = "0";
  //     // idealalternative.text = "0";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    int? deposit1 = int.tryParse(currentdeposit.text);
    int? deposit2 = int.tryParse(idealdeposit.text);
    int? debt1 = int.tryParse(currentdebt.text);
    int? debt2 = int.tryParse(idealdebt.text);
    int? real1 = int.tryParse(currentreal.text);
    int? real2 = int.tryParse(idealreal.text);
    int? share1 = int.tryParse(currentshare.text);
    int? share2 = int.tryParse(idealshare.text);
    int? derevative1 = int.tryParse(currentderivative.text);
    int? derevative2 = int.tryParse(idealderivative.text);
    int? alterative1 = int.tryParse(currentalternative.text);
    int? alterative2 = int.tryParse(idealalternative.text);
    void InvestmentProfileA() async {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": InvestmentPortfolioACorporate.id.value,
        "profileDepositeandMurabhaCurrent":
            _profileDepositeandMurabhaCurrent.text,
        "profileDepositeandMurabhaIdeal": _profileDepositeandMurabhaIdeal.text,
        "profileDebutInstrumentCurrent": _profileDebutInstrumentCurrent.text,
        "profileDebutInstrumentIdeal": _profileDebutInstrumentIdeal.text,
        "profileSharesCurrent": _profileSharesCurrent.text,
        "profileSharesIdeal": _profileSharesIdeal.text,
        "profileRealEstatesCurrent": _profileRealEstatesCurrent.text,
        "profileRealEstatesIdeal": _profileRealEstatesIdeal.text,
        "profileDerivativeContractsCurrent":
            _profileDerivativeContractsCurrent.text,
        "profileDerivativeContractsIdeal":
            _profileDerivativeContractsIdeal.text,
        "profileAlternativeInvestmentsCurrent":
            _profileAlternativeInvestmentsCurrent.text,
        "profileAlternativeInvestmentsIdeal":
            _profileAlternativeInvestmentsIdeal.text,
        "cikE1": _cikE1.text,
        "cikE2": _cikE2.text,
        "cikE3": _cikE3.text,
        "cikE4": _cikE4.text,
        "cikE5": _cikE5.text,
        "cikE6": _cikE6.text,
        "cikE7": _cikE7.text,
        "cikeClientInvestmentKnowledgeExperience": selectedValue,
        "clientAppetiteRisk": selectedValue2
      };
      final response = await http.post(
          Uri.parse(
              'https://eastbridge.online/apicore/api/InvestmentProfileACorporate'),
          headers: headers,
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        // tabController?.animateTo(9);

        print("Successfull");
        // Process the responseData
      } else {
        // Request failed, handle the error
        print(response.statusCode);
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
      }
    }

    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];
    double _screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    var InvA;
    return Material(
      child: Container(
        height: 610,
        child: Scaffold(
          body: Container(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  "Client’s Current Investment Portfolio Profile",
                                  style: TextController.BodyHeadingText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 600,
                                  child: Table(
                                    border: TableBorder.all(
                                        color: ColorSelect.tabBorderColor),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      0: FlexColumnWidth(),
                                      1: FlexColumnWidth(),
                                      2: FlexColumnWidth(),
                                      // 0: FixedColumnWidth(200),
                                      // 1: FixedColumnWidth(200),
                                      // 2: FixedColumnWidth(200),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            color: ColorSelect.east_grey,
                                            child: Center(
                                                child: Text(
                                              S.of(context).Type,
                                              style: TextController.InvA,
                                            ))),
                                        Container(
                                            height: 70,
                                            color: ColorSelect.east_grey,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Center(
                                                  child: Text(
                                                textAlign: TextAlign.center,
                                                S
                                                    .of(context)
                                                    .ClientCurrentInvestmentPortfolioProfile,
                                                style: TextController.InvACC,
                                                maxLines: 3,
                                              )),
                                            )),
                                        Container(
                                            height: 70,
                                            color: ColorSelect.east_grey,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Center(
                                                  child: Text(
                                                textAlign: TextAlign.center,
                                                S
                                                    .of(context)
                                                    .ClientIdealinvestmentportfolioprofile,
                                                style: TextController.InvACC,
                                                maxLines: 3,
                                              )),
                                            )),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              S.of(context).InvAT11 + " *",
                                              style: TextController.BodyText,
                                            ))),
                                        Container(
                                          height: 70,
                                          child: Center(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: currentdeposit,
                                              // initialValue: "0",

                                              onChanged: (value) {
                                                setState(() {
                                                  deposit1 = int.parse(value);
                                                });
                                              },

                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field is required.';
                                                }
                                                return null; // Return null if the input is valid
                                              },

                                              // initialValue:int.parse("0"),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              style: TextController.BodyText,

                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "%",
                                                  counterText: '',
                                                  errorStyle: TextController
                                                      .inputErrorText),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: Center(
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: idealdeposit,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              style: TextController.BodyText,
                                              onChanged: (value) {
                                                setState(() {
                                                  deposit2 = int.parse(value);
                                                });
                                              },
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'This field is required.';
                                                }
                                                return null; // Return null if the input is valid
                                              },
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "%",
                                                  counterText: '',
                                                  errorStyle: TextController
                                                      .inputErrorText),
                                            ),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                              child: Text(
                                                S.of(context).DebtInstruments +
                                                    " *",
                                                style: TextController.BodyText,
                                              ),
                                            )),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: currentdebt,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            onChanged: (value) {
                                              setState(() {
                                                debt1 = int.parse(value);
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: idealdebt,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            onChanged: (value) {
                                              setState(() {
                                                debt2 = int.parse(value);
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              S.of(context).InvAT12 + " *",
                                              style: TextController.BodyText,
                                            ))),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: currentshare,
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              setState(() {
                                                share1 = int.parse(value);
                                              });
                                            },
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: idealshare,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            onChanged: (value) {
                                              setState(() {
                                                share2 = int.parse(value);
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              S.of(context).InvAT13 + " *",
                                              style: TextController.BodyText,
                                            ))),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: currentreal,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            onChanged: (value) {
                                              setState(() {
                                                real1 = int.parse(value);
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: idealreal,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                real2 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              S.of(context).InvAT14 + " *",
                                              style: TextController.BodyText,
                                            ))),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: currentderivative,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            onChanged: (value) {
                                              setState(() {
                                                derevative1 = int.parse(value);
                                              });
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: idealderivative,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                derevative2 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 70,
                                            child: Center(
                                                child: Text(
                                              S.of(context).InvAT15 + " *",
                                              style: TextController.BodyText,
                                            ))),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: currentalternative,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                alterative1 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                        Container(
                                          height: 70,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: idealalternative,
                                            maxLines: null,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            onChanged: (value) {
                                              setState(() {
                                                alterative2 = int.parse(value);
                                              });
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "%",
                                                counterText: '',
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  S
                                      .of(context)
                                      .ClientInvestmentKnowledgeExperience,
                                  style: TextController.BodyHeadingText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 600,
                                  child: Table(
                                    border: TableBorder.all(
                                        color: ColorSelect.tabBorderColor),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    columnWidths: {
                                      // 0: FixedColumnWidth(400),
                                      // 1: FixedColumnWidth(300),
                                      0: FixedColumnWidth(2),
                                      1: FixedColumnWidth(1),
                                    },
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          height: 50,
                                          color: ColorSelect.east_grey,
                                          child: Center(
                                              child: Text(
                                            S.of(context).Questions,
                                            style: TextController.tableHeading,
                                          )),
                                        ),
                                        Container(
                                            height: 50,
                                            color: ColorSelect.east_grey,
                                            child: Center(
                                                child: Text(
                                              S.of(context).Description,
                                              style:
                                                  TextController.tableHeading,
                                            ))),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB1,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE1,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB2,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE2,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB3,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE3,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB4,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE4,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB5,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE5,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            height: 50,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              S.of(context).InvTaB6,
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 50,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE6,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "If Securities Transactions Were Executed Outside The Kingdom Over The Past Five Years, In Which Countries Were These Transactions Executed?",
                                              style: TextController.BodyText,
                                            )),
                                        Container(
                                          height: 80,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            controller: _cikE7,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            S.of(context).InvA1new,
                            style: TextController.BodyText,
                          ))),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            S.of(context).ClientInvestmentKnowledgeExperience,
                            style: TextController.BodyText,
                          ))),
                      Row(
                        children: [
                          Text(
                            S.of(context).High,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "High",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!; //<-- change this
                                radioError1 = false;
                              });
                            },
                          ),
                          Text(
                            S.of(context).Medium,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "Medium",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!; //<-- change this
                                radioError1 = false;
                              });
                            },
                          ),
                          Text(
                            S.of(context).Low,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "Low",
                            groupValue: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value!; //<-- change this
                                radioError1 = false;
                              });
                            },
                          ),
                        ],
                      ),
                      if (radioError1)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "This field is required.",
                            style: TextController.errorText,
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            S.of(context).ClientsAppetiteForRisk,
                            style: TextController.BodyText,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            S.of(context).High,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "High",
                            groupValue: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!; //<-- change this
                                radioError2 = false;
                              });
                            },
                          ),
                          Text(
                            S.of(context).Medium,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "Medium",
                            groupValue: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!; //<-- change this
                                radioError2 = false;
                              });
                            },
                          ),
                          Text(
                            S.of(context).Low,
                            style: TextController.BodyText,
                          ),
                          Radio(
                            value: "Low",
                            groupValue: selectedValue2,
                            onChanged: (value) {
                              setState(() {
                                selectedValue2 = value!; //<-- change this
                                radioError2 = false;
                              });
                            },
                          ),
                        ],
                      ),
                      if (radioError2)
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "This field is required.",
                            style: TextController.errorText,
                          ),
                        ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 35,
                            width: 140,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                tabController?.animateTo(7);
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
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState != null) {
                                  setState(() {
                                    radioError1 = selectedValue == "";
                                    radioError2 = selectedValue2 == "";

                                    isValidPercentage1 = (deposit1! +
                                            debt1! +
                                            share1! +
                                            real1! +
                                            derevative1! +
                                            alterative1!) ==
                                        100;
                                    isValidPercentage2 = (deposit2! +
                                            debt2! +
                                            share2! +
                                            real2! +
                                            derevative2! +
                                            alterative2!) ==
                                        100;

                                    if (!isValidPercentage1 ||
                                        !isValidPercentage2) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please Ensure that the sum of all percentages of each portfolio should be 100%",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  });
                                  if (_formKey.currentState!.validate() &&
                                      !radioError1 &&
                                      !radioError2 &&
                                      isValidPercentage1 &&
                                      isValidPercentage2) {
                                    _formKey.currentState?.save();
                                    InvestmentProfileA();
                                    tabController?.animateTo(9);
                                  }
                                } else {
                                  // Handle case where _formKey.currentState is null
                                }

                                // if (_formKey.currentState!.validate()) {
                                //   if ((deposit1! +
                                //               debt1! +
                                //               share1! +
                                //               real1! +
                                //               derevative1! +
                                //               alterative1! ==
                                //           100) &&
                                //       (deposit2! +
                                //               debt2! +
                                //               share2! +
                                //               real2! +
                                //               derevative2! +
                                //               alterative2! ==
                                //           100)) {
                                //     _formKey.currentState?.save();

                                //     InvestmentProfileA();
                                //     tabController?.animateTo(9);
                                //   } else {
                                //     print("----------------------e");
                                //     Fluttertoast.showToast(
                                //         webShowClose: true,
                                //         msg:
                                //             "Please Ensure that sum of all percentage of each portfolio should be 100%",
                                //         toastLength: Toast.LENGTH_SHORT,
                                //         gravity: ToastGravity.CENTER,
                                //         timeInSecForIosWeb: 3,
                                //         backgroundColor: Colors.red,
                                //         textColor: Colors.white,
                                //         fontSize: 16.0);
                                //   }
                                // }
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Next,
                                style: TextController.btnText,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
