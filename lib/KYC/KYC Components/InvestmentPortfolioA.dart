import 'dart:convert';
import 'dart:js_util';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/services.dart';

import '../../RiskAssessmentFormInvidual.dart';

class InvestmentPortfolioA extends StatefulWidget {
  InvestmentPortfolioA({@required controller}) {
    tabController = controller;
  }

  @override
  State<InvestmentPortfolioA> createState() => _InvestmentPortfolioAState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

final _formKey = GlobalKey<FormState>();

class _InvestmentPortfolioAState extends State<InvestmentPortfolioA> {
  String btn = "Next";
  // InvestmentPortfolioA({@required controller}) {
  //   tabController = controller;
  // }
  String selectedValue = "";
  String selectedValue2 = "";

  bool isChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  bool isChecked6 = false;
  bool checkError = false;
  bool radioError1 = false;
  bool radioError2 = false;
  bool isValidPercentage1 = false;
  bool isValidPercentage2 = false;
  List<String> invObj = [];
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

  late int deposit1 = int.tryParse(currentdeposit.text)!;
  late int deposit2 = int.tryParse(idealdeposit.text)!;
  late int debt1 = int.tryParse(currentdebt.text)!;
  late int debt2 = int.tryParse(idealdebt.text)!;
  late int real1 = int.tryParse(currentreal.text)!;
  late int real2 = int.tryParse(idealreal.text)!;
  late int share1 = int.tryParse(currentshare.text)!;
  late int share2 = int.tryParse(idealshare.text)!;
  late int derevative1 = int.tryParse(currentderivative.text)!;
  late int derevative2 = int.tryParse(idealderivative.text)!;
  late int alterative1 = int.tryParse(currentalternative.text)!;
  late int alterative2 = int.tryParse(idealalternative.text)!;

  @override
  void initState() {
    super.initState();
    // getdata(9043);

    print("Init Runnng");
    if (GlobalIndividual.individualdraftprogress["InvestmentProfileA"] ==
        true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/InvesmentProfileA/InvestmentProfileA/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        isChecked = data["protectionOfCapital"];
        isChecked1 = data["income"];
        isChecked2 = data["balanced"];
        isChecked3 = data["growthOfCapital"];
        isChecked4 = data["createSavingForRetirement"];
        isChecked5 = data["projectFinancing"];
        isChecked6 = data["purchaseAnAsset"];
        selectedValue = data["clientKnowledgeAndExperience"];
        selectedValue2 = data["clientAppetiteRisk"];
      });
      currentdeposit.text = data["depositsAndMurabahaCurrent"].toString();
      idealdeposit.text = data["depositsAndMurabahaIdeal"].toString();
      currentdebt.text = data["debtInstrumentsCurrent"].toString();
      idealdebt.text = data["debtInstrumentsIdeal"].toString();
      currentshare.text = data["sharesCurrent"].toString();
      idealshare.text = data["sharesIdeal"].toString();
      currentreal.text = data["realEstatesCurrent"].toString();
      idealreal.text = data["realEstatesIdeal"].toString();
      currentderivative.text = data["derivativeContractsCurrent"].toString();
      idealderivative.text = data["derivativeContractsIdeal"].toString();
      currentalternative.text =
          data["alternativeInvestmentsCurrent"].toString();
      idealalternative.text = data["alternativeInvestmentsIdeal"].toString();

      // _branchName.text = data["branchName"];
      // _accountNum.text = data["mainAccountNumber"];
      // _accountName.text = data["accountHolderName"];
      // _codeNum.text = data["codeNumber"];
    } else {
      print(response.statusCode);
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
    }
  }

  void senddata() async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/InvesmentProfileA/InvestmentProfileA/');

    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "depositsAndMurabahaCurrent": deposit1,
        "depositsAndMurabahaIdeal": deposit2,
        "debtInstrumentsCurrent": debt1,
        "debtInstrumentsIdeal": debt2,
        "sharesCurrent": share1,
        "sharesIdeal": share2,
        "realEstatesCurrent": real1,
        "realEstatesIdeal": real2,
        "derivativeContractsCurrent": derevative1,
        "derivativeContractsIdeal": derevative2,
        "alternativeInvestmentsCurrent": alterative1,
        "alternativeInvestmentsIdeal": alterative1,
        "protectionOfCapital": isChecked,
        "income": isChecked1,
        "balanced": isChecked2,
        "growthOfCapital": isChecked3,
        "createSavingForRetirement": isChecked4,
        "projectFinancing": isChecked5,
        "purchaseAnAsset": isChecked6,
        "clientKnowledgeAndExperience": selectedValue,
        "clientAppetiteRisk": selectedValue2
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalIndividual.getdraftprogressindividual(
            GlobalIndividual.individualclientid);
        tabController?.animateTo(10);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    } catch (e) {
      print(e.toString());
    }
  }

  void putdata(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/InvesmentProfileA/InvestmentProfileA?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };

      var body = {
        "clientId": GlobalIndividual.individualclientid,
        "depositsAndMurabahaCurrent": deposit1,
        "depositsAndMurabahaIdeal": deposit2,
        "debtInstrumentsCurrent": debt1,
        "debtInstrumentsIdeal": debt2,
        "sharesCurrent": share1,
        "sharesIdeal": share2,
        "realEstatesCurrent": real1,
        "realEstatesIdeal": real2,
        "derivativeContractsCurrent": derevative1,
        "derivativeContractsIdeal": derevative2,
        "alternativeInvestmentsCurrent": alterative1,
        "alternativeInvestmentsIdeal": alterative1,
        "protectionOfCapital": isChecked,
        "income": isChecked1,
        "balanced": isChecked2,
        "growthOfCapital": isChecked3,
        "createSavingForRetirement": isChecked4,
        "projectFinancing": isChecked5,
        "purchaseAnAsset": isChecked6,
        "clientKnowledgeAndExperience": selectedValue,
        "clientAppetiteRisk": selectedValue2
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(10);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String? numberValidator(String? value) {
      if (value == null) {
        return "";
      }
      final n = num.tryParse(value);
      if (n == null) {
        return '"$value" is not a valid number';
      }
    }

    // currentdeposit1 = Float.parse(currentdeposit.text);

    double _screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      // height: 610,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S
                                    .of(context)
                                    .ClientCurrentInvestmentPortfolioProfile,
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
                                            padding:
                                                const EdgeInsets.only(left: 10),
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
                                            padding:
                                                const EdgeInsets.only(left: 10),
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
                                            keyboardType: TextInputType.number,
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
                                            keyboardType: TextInputType.number,
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                                          inputFormatters: <TextInputFormatter>[
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
                          width: 50,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).GeneralInvestmentObjectives,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 450,
                                child: Column(
                                  children: [
                                    Table(
                                      border: TableBorder.all(
                                          color: ColorSelect.tabBorderColor),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        0: FlexColumnWidth(2),
                                        1: FlexColumnWidth(1),
                                        // 0: FixedColumnWidth(300),
                                        // 1: FixedColumnWidth(150),
                                      },
                                      children: [
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Options,
                                                  style: TextController.InvA,
                                                ))),
                                          ),
                                          Container(
                                              height: 50,
                                              color: ColorSelect.east_grey,
                                              child: Center(
                                                  child: Text(
                                                S.of(context).Select,
                                                style: TextController.InvA,
                                              ))),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .ProtectionOfCapitalNew,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add(
                                                        "Protection Of Capital");
                                                    isChecked = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Income,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked1,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add("Income");
                                                    isChecked1 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Balanced,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked2,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add("Balanced");
                                                    isChecked2 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .GrowthOfCapitalNew,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked3,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add(
                                                        "Growth Of Capital");
                                                    isChecked3 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .CreateSavingForRetirementNew,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked4,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add(
                                                        "Create Saving For Retirement");
                                                    isChecked4 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .ProjectFinancing,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked5,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add(
                                                        "Project Financing");
                                                    isChecked5 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                        TableRow(children: [
                                          Center(
                                            child: Container(
                                                height: 50,
                                                child: Center(
                                                    child: Text(
                                                  S
                                                      .of(context)
                                                      .PurchaseAnAssetNew,
                                                  style:
                                                      TextController.BodyText,
                                                ))),
                                          ),
                                          Container(
                                            height: 50,
                                            child: Checkbox(
                                                value: isChecked6,
                                                onChanged: (val) {
                                                  setState(() {
                                                    invObj.add(
                                                        "Purchase An Asset");
                                                    isChecked6 = val!;
                                                  });
                                                }),
                                          ),
                                        ]),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if (checkError)
                                      Text(
                                        "This field is required.",
                                        style: TextController.errorText,
                                      )
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
                          S.of(context).InvestmentKnowledgeAndExperiencen,
                          style: TextController.BodyHeadingText,
                        ))),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).High,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
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
                            Radio<String>(
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
                            Radio<String>(
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
                          )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            child: Text(
                          S.of(context).ClientsAppetiteForRiskn,
                          style: TextController.BodyHeadingText,
                        ))),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).High,
                              style: TextController.BodyText,
                            ),
                            Radio<String>(
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
                            Radio<String>(
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
                            Radio<String>(
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
                          )
                      ],
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
                              tabController?.animateTo(8);
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorSelect.east_blue),
                            ),
                            onPressed: () {
                              if (_formKey.currentState != null) {
                                setState(() {
                                  radioError1 = selectedValue == "";
                                  radioError2 = selectedValue2 == "";
                                  if (!isChecked &&
                                      !isChecked1 &&
                                      !isChecked2 &&
                                      !isChecked3 &&
                                      !isChecked4 &&
                                      !isChecked5 &&
                                      !isChecked6) {
                                    checkError = true;
                                  } else {
                                    checkError =
                                        false; // At least one checkbox is selected, so remove the error
                                  }
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
                                    !checkError &&
                                    isValidPercentage1 &&
                                    isValidPercentage2) {
                                  _formKey.currentState?.save();
                                  if (GlobalIndividual.individualdraftprogress[
                                          "InvestmentProfileA"] ==
                                      true) {
                                    putdata(
                                        GlobalIndividual.individualclientid);
                                  } else {
                                    if (GlobalIndividual.individualclientid !=
                                        0) {
                                      senddata();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please fill personal info first",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 3,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
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
                              //               alterative1!) !=
                              //           100 ||
                              //       (deposit2! +
                              //               debt2! +
                              //               share2! +
                              //               real2! +
                              //               derevative2! +
                              //               alterative2!) !=
                              //           100) {
                              //     Fluttertoast.showToast(
                              //         msg:
                              //             "Please Ensure that sum of all percentage of each portfolio should be 100%",
                              //         toastLength: Toast.LENGTH_SHORT,
                              //         gravity: ToastGravity.CENTER,
                              //         timeInSecForIosWeb: 3,
                              //         backgroundColor: Colors.red,
                              //         textColor: Colors.white,
                              //         fontSize: 16.0);
                              //   } else {
                              //     investmentA();
                              //   }
                              //}
                            }, // Switch tab
                            child: Text(
                              btn,
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
    );
  }
}
