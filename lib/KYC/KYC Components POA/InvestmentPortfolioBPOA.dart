import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/GlobalPOA.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InvestmentPortfolioBPOA extends StatefulWidget {
  InvestmentPortfolioBPOA({@required controller}) {
    tabController = controller;
  }

  @override
  State<InvestmentPortfolioBPOA> createState() =>
      _InvestmentPortfolioBPOAState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> clientName = ValueNotifier("");
}

TabController? tabController;
final _formKey = GlobalKey<FormState>();

class _InvestmentPortfolioBPOAState extends State<InvestmentPortfolioBPOA> {
  String btn = "Next";
  // InvestmentPortfolioBPOA({controller}) {
  //   tabController = controller;
  // }

  // TextEditingController certificateClient = new TextEditingController();
  // TextEditingController certificateCustodian = new TextEditingController();
  // TextEditingController certificateOther = new TextEditingController();
  // TextEditingController dividendCustodian = new TextEditingController();
  // TextEditingController dividendClient = new TextEditingController();
  // TextEditingController dividendOther = new TextEditingController();
  // TextEditingController salesClient = new TextEditingController();
  // TextEditingController salesCustodian = new TextEditingController();
  // TextEditingController salesOther = new TextEditingController();

  bool networthError = false;
  bool termsError = false;
  bool mainCurrencyError = false;
  String _selectedItem = '';
  String selectedValue = "";
  String selectedValue2 = "";
  String? dropdownvalue;
  TextEditingController inv1 = new TextEditingController();
  TextEditingController inv2 = new TextEditingController();
  TextEditingController inv3 = new TextEditingController();
  TextEditingController inv4 = new TextEditingController();
  TextEditingController inv5 = new TextEditingController();
  TextEditingController inv6 = new TextEditingController();
  TextEditingController inv7 = new TextEditingController();
  TextEditingController _currency = new TextEditingController();
  TextEditingController otherConstraint = new TextEditingController();
  TextEditingController ClientName = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController dateHijri = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();

  var selectedDate = HijriCalendar.now();

  String _Certificates = "";
  String _DividendsIncome = "";
  String _SalesProceeds = "";
  bool terms = false;
  bool _ClientNameError = false;
  bool _DateError = false;
  bool ClientTableError = false;

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var Currencies = [
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
  bool? isChecked = false;
  bool currencyError = false;
  bool periodError = false;
  List<String> currencies = [
    "United States Dollar (USD)",
    "Euro (EUR)",
    "Japanese Yen (JPY)",
    "British Pound Sterling (GBP)",
    "Swiss Franc (CHF)",
    "Canadian Dollar (CAD)",
    "Australian Dollar (AUD)",
    "New Zealand Dollar (NZD)",
    "Chinese Yuan Renminbi (CNY)",
    "Indian Rupee (INR)",
    "South Korean Won (KRW)",
    "Brazilian Real (BRL)",
    "Russian Ruble (RUB)",
    "South African Rand (ZAR)",
    "Mexican Peso (MXN)",
    "Argentine Peso (ARS)",
    "Saudi Riyal (SAR)",
    "United Arab Emirates Dirham (AED)",
    "Singapore Dollar (SGD)",
    "Hong Kong Dollar (HKD)",
    "Malaysian Ringgit (MYR)",
    "Thai Baht (THB)",
    "Indonesian Rupiah (IDR)",
    "Philippine Peso (PHP)",
    "Turkish Lira (TRY)",
    "Egyptian Pound (EGP)",
    "Israeli New Shekel (ILS)",
    "Swiss Franc (CHF)",
    "Swedish Krona (SEK)",
    "Norwegian Krone (NOK)",
    "Danish Krone (DKK)",
    "Polish Złoty (PLN)",
    "Hungarian Forint (HUF)",
    "Czech Koruna (CZK)",
    "Slovak Koruna (SKK)",
    "Croatian Kuna (HRK)",
    "Serbian Dinar (RSD)",
    "Bosnian Convertible Mark (BAM)",
    "Bulgarian Lev (BGN)",
    "Romanian Leu (RON)",
    "Ukrainian Hryvnia (UAH)",
    "Belarusian Ruble (BYN)",
    "Kazakhstani Tenge (KZT)",
    "Azerbaijani Manat (AZN)",
    "Georgian Lari (GEL)",
    "Armenian Dram (AMD)",
    "Iranian Rial (IRR)",
    "Pakistani Rupee (PKR)",
    "Afghan Afghani (AFN)",
    "Bangladeshi Taka (BDT)",
    "Sri Lankan Rupee (LKR)",
    "Nepalese Rupee (NPR)",
    "Bhutanese Ngultrum (BTN)",
    "Maldivian Rufiyaa (MVR)",
    "Kuwaiti Dinar (KWD)",
    "Bahraini Dinar (BHD)",
    "Qatari Riyal (QAR)",
    "Omani Rial (OMR)",
    "Jordanian Dinar (JOD)",
    "Lebanese Pound (LBP)",
    "Syrian Pound (SYP)",
    "Iraqi Dinar (IQD)",
    "Yemeni Rial (YER)",
    "Sudanese Pound (SDG)",
    "Libyan Dinar (LYD)",
    "Tunisian Dinar (TND)",
    "Algerian Dinar (DZD)",
    "Moroccan Dirham (MAD)",
    "Mauritanian Ouguiya (MRU)",
    "Western Sahara Sahrawi Peseta (SHP)",
    "Mauritian Rupee (MUR)",
    "Seychellois Rupee (SCR)",
    "Ethiopian Birr (ETB)",
    "Eritrean Nakfa (ERN)",
    "Djiboutian Franc (DJF)",
    "Somali Shilling (SOS)",
    "Kenyan Shilling (KES)",
    "Ugandan Shilling (UGX)",
    "Rwandan Franc (RWF)",
    "Burundian Franc (BIF)",
    "Tanzanian Shilling (TZS)",
    "Congolese Franc (CDF)",
    "Zambian Kwacha (ZMW)",
    "Malawian Kwacha (MWK)",
    "Zimbabwean Dollar (ZWL)",
    "Botswana Pula (BWP)",
    "Namibian Dollar (NAD)",
    "South African Rand (ZAR)",
    "Lesotho Loti (LSL)",
    "Swazi Lilangeni (SZL)",
    "Mozambican Metical (MZN)",
    "Angolan Kwanza (AOA)",
    "Namibian Dollar (NAD)",
    "Seychellois Rupee (SCR)",
    "Malagasy Ariary (MGA)",
    "Comorian Franc (KMF)",
    "Mauritanian Ouguiya (MRU)",
    "Central African CFA Franc (XAF)",
    "West African CFA Franc (XOF)",
    "Gambian Dalasi (GMD)",
    "Guinea Franc (GNF)",
    "Sierra Leonean Leone (SLL)",
    "Liberian Dollar (LRD)",
    "Ivorian Franc (XOF)",
    "Ghanaian Cedi (GHS)",
    "Nigerian Naira (NGN)",
    "Cameroonian CFA Franc (XAF)",
    "Equatorial Guinean CFA Franc (XAF)",
    "Gabonese CFA Franc (XAF)",
    "Congolese CFA Franc (XAF)",
    "Sao Tome and Principe Dobra (STD)",
    "Cape Verdean Escudo (CVE)",
    "Dominican Peso (DOP)",
    "Haitian Gourde (HTG)",
    "Jamaican Dollar (JMD)",
    "Trinidad and Tobago Dollar (TTD)",
    "Eastern Caribbean Dollar (XCD)",
    "Barbadian Dollar (BBD)",
    "Guyanese Dollar (GYD)",
    "Surinamese Dollar (SRD)",
    "Venezuelan Bolívar (VES)",
    "Colombian Peso (COP)",
    "Ecuadorian Sucre (ECS)",
    "Peruvian Sol (PEN)",
    "Bolivian Boliviano (BOB)",
    "Paraguayan Guarani (PYG)",
    "Uruguayan Peso (UYU)"
  ];

  @override
  void initState() {
    super.initState();
    // getdata(9043);
    ClientName.text = InvestmentPortfolioBPOA.clientName.value;

    print("Init Runnng");
    if (GlobalPOA.poadraftprogress["InvestmentProfileBPOA"] == true) {
      print("ftechinggg----------");
      getdata(GlobalPOA.poalclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/InvestmentProfileBPOA/InvestmentProfileBPOA/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        _Certificates = data["certificateClient"];
        _DividendsIncome = data["dividendsIncomeClient"];
        _SalesProceeds = data["salesProceedsClient"];
        selectedValue = data["clientPreferredInvestmentAssets"];
        selectedValue2 = data["periodDuringClientExpects"];
        terms = data["clientDeclarationCondition"];
      });
      inv1.text = data["ikE1"];
      inv2.text = data["ikE2"];
      inv3.text = data["ikE3"];
      inv4.text = data["ikE4"];
      inv5.text = data["ikE5"];
      inv6.text = data["ikE6"];
      inv7.text = data["ikE7"];
      _typeAheadController.text = data["clientPreferredInvestmentAssetsText"];
      ClientName.text = data["clientName"];
      date.text = data["date"];
      dateHijri.text = data["dateHijri"];
      otherConstraint.text = data["otherConstraints"];

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
        '${GlobalPermission.urlLink}/api/InvestmentProfileBPOA/InvestmentProfileBPOA/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPOA.poalclientid,
        "ikE1": inv1.text,
        "ikE2": inv2.text,
        "ikE3": inv3.text,
        "ikE4": inv4.text,
        "ikE5": inv5.text,
        "ikE6": inv6.text,
        "ikE7": inv7.text,
        "certificateClient": _Certificates,
        "certificateCustodian": "",
        "certificateSpecifyAllDetail": "",
        "dividendsIncomeClient": _DividendsIncome,
        "dividendsIncomeCustodian": "",
        "dividendsIncomeSpecifyAllDetail": "",
        "salesProceedsClient": _SalesProceeds,
        "salesProceedsCustodian": "",
        "salesProceedsSpecifyAllDetail": "",
        "clientPreferredInvestmentAssets": selectedValue,
        "clientPreferredInvestmentAssetsText": _typeAheadController.text,
        "periodDuringClientExpects": selectedValue2,
        "otherConstraints": otherConstraint.text,
        "clientDeclarationCondition": terms,
        "clientName": ClientName.text,
        "date": date.text,
        "dateHijri": dateHijri.text
      };
      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalPOA.getdraftprogresspoa(GlobalPOA.poalclientid);
        tabController?.animateTo(8);
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
        '${GlobalPermission.urlLink}/api/InvestmentProfileBPOA/InvestmentProfileBPOAPut?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "ikE1": inv1.text,
        "ikE2": inv2.text,
        "ikE3": inv3.text,
        "ikE4": inv4.text,
        "ikE5": inv5.text,
        "ikE6": inv6.text,
        "ikE7": inv7.text,
        "certificateClient": _Certificates,
        "certificateCustodian": "",
        "certificateSpecifyAllDetail": "",
        "dividendsIncomeClient": _DividendsIncome,
        "dividendsIncomeCustodian": "",
        "dividendsIncomeSpecifyAllDetail": "",
        "salesProceedsClient": _SalesProceeds,
        "salesProceedsCustodian": "",
        "salesProceedsSpecifyAllDetail": "",
        "clientPreferredInvestmentAssets": selectedValue,
        "clientPreferredInvestmentAssetsText": _typeAheadController.text,
        "periodDuringClientExpects": selectedValue2,
        "otherConstraints": otherConstraint.text,
        "clientDeclarationCondition": terms,
        "clientName": ClientName.text,
        "date": date.text,
        "dateHijri": dateHijri.text
      };
      print(body);
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(8);
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
    return Container(
      color: Colors.white,
      // height: 650,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S
                                        .of(context)
                                        .InvestmentKnowledgeAndExperience,
                                    style: TextController.BodyHeadingText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 700,
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Table(
                                          border: TableBorder.all(
                                              color:
                                                  ColorSelect.tabBorderColor),
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: {
                                            0: FlexColumnWidth(1.5),
                                            1: FlexColumnWidth(0.5),
                                            // 0: FixedColumnWidth(400),
                                            // 1: FixedColumnWidth(300),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: 50,
                                                color: ColorSelect.east_grey,
                                                child: Center(
                                                    child: Text(
                                                  S.of(context).Questions,
                                                  style: TextController
                                                      .tableHeading,
                                                )),
                                              ),
                                              Container(
                                                  height: 50,
                                                  color: ColorSelect.east_grey,
                                                  child: Center(
                                                      child: Text(
                                                    S.of(context).Description,
                                                    style: TextController
                                                        .tableHeading,
                                                  ))),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                  height: 50,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB1n +
                                                            " *",
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv1,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB2n +
                                                            " *",
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv2,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB3n +
                                                            " *",
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv3,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB4n +
                                                            " *",
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv4,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB5n +
                                                            " *",
                                                        style: TextController
                                                            .BodyText,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv5,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB6n +
                                                            " *",
                                                        style: TextController
                                                            .BodyTextCC,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv6,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        S.of(context).InvTaB7n +
                                                            " *",
                                                        style: TextController
                                                            .BodyTextCC,
                                                      ),
                                                    ),
                                                  )),
                                              Container(
                                                height: 50,
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  controller: inv7,
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  style:
                                                      TextController.BodyText,
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S
                                        .of(context)
                                        .ClientsInvestmentPortfolioProfile,
                                    style: TextController.BodyHeadingText,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 550,
                                        alignment: Alignment.topRight,
                                        child: Table(
                                          border: TableBorder.all(
                                              color:
                                                  ColorSelect.tabBorderColor),
                                          defaultVerticalAlignment:
                                              TableCellVerticalAlignment.middle,
                                          columnWidths: {
                                            // 0: FixedColumnWidth(200),
                                            // 1: FixedColumnWidth(170),
                                            // 2: FixedColumnWidth(170),
                                            // 3: FixedColumnWidth(170),
                                            0: FlexColumnWidth(2),
                                            1: FlexColumnWidth(1.5),
                                            2: FlexColumnWidth(1.5),
                                            3: FlexColumnWidth(1.8),
                                          },
                                          children: [
                                            TableRow(
                                              decoration: BoxDecoration(
                                                  color: ColorSelect.east_grey),
                                              children: [
                                                Container(
                                                    height: 120,
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        S.of(context).InvAT21,
                                                        style: TextController
                                                            .InvACC,
                                                      ),
                                                    )),
                                                Container(
                                                    height: 120,
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        S.of(context).InvAT22,
                                                        style:
                                                            TextController.InvA,
                                                        maxLines: 3,
                                                      ),
                                                    )),
                                                Container(
                                                    height: 120,
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        S.of(context).InvAT23,
                                                        style:
                                                            TextController.InvA,
                                                        maxLines: 3,
                                                      ),
                                                    )),
                                                Container(
                                                    height: 120,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        S.of(context).InvAT27,
                                                        style: TextController
                                                            .InvACC,
                                                        maxLines: 5,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                    height: 70,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).InvAT24,
                                                      style: TextController
                                                          .BodyText,
                                                    )),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Client Certificates",
                                                      groupValue: _Certificates,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _Certificates =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Custodian Certificates",
                                                      groupValue: _Certificates,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _Certificates =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Other Certificates",
                                                      groupValue: _Certificates,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _Certificates =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                  height: 70,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).InvAT25,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Client Dividends/Other Incomes",
                                                      groupValue:
                                                          _DividendsIncome,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _DividendsIncome =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Custodian Dividends/Other Incomes",
                                                      groupValue:
                                                          _DividendsIncome,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _DividendsIncome =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Other Dividends/Other Incomes",
                                                      groupValue:
                                                          _DividendsIncome,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _DividendsIncome =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TableRow(
                                              children: [
                                                Container(
                                                    height: 70,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      S.of(context).InvAT26,
                                                      style: TextController
                                                          .BodyText,
                                                    )),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Client Sales Proceeds",
                                                      groupValue:
                                                          _SalesProceeds,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _SalesProceeds =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Custodian Sales Proceeds",
                                                      groupValue:
                                                          _SalesProceeds,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _SalesProceeds =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 70,
                                                  child: Center(
                                                    child: Radio(
                                                      value:
                                                          "Other Sales Proceeds",
                                                      groupValue:
                                                          _SalesProceeds,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _SalesProceeds =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (ClientTableError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required",
                                            style: TextController.errorText,
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            S.of(context).InvA2New + " *",
                            style: TextController.BodyHeadingText,
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  S.of(context).Opt1new,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio<String>(
                                value: "Denominated in Saudi Riyals",
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    currencyError = false;
                                    selectedValue = value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt2New,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio<String>(
                                value: "Denominated in Foreign Currency",
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    currencyError = false;
                                    selectedValue = value!; //<-- change this
                                  });
                                },
                              ),
                              if (selectedValue ==
                                  "Denominated in Foreign Currency")
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).Opt3New,
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 270,
                                              height: 35,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TypeAheadField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        controller:
                                                            _typeAheadController,
                                                        style: TextController
                                                            .BodyText,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        decoration:
                                                            InputDecoration(
                                                                isDense: true,
                                                                enabledBorder:
                                                                    InputBorder
                                                                        .none,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                hintText: S
                                                                    .of(context)
                                                                    .Currency)),
                                                suggestionsCallback: (pattern) {
                                                  // Return a filtered list of suggestions based on the search pattern.
                                                  return currencies
                                                      .where((item) => item
                                                          .toLowerCase()
                                                          .contains(pattern
                                                              .toLowerCase()))
                                                      .toList();
                                                },
                                                itemBuilder:
                                                    (context, suggestion) {
                                                  return ListTile(
                                                    title: Text(
                                                      suggestion,
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  // Update the selected item when a suggestion is selected.
                                                  setState(() {
                                                    _selectedItem = suggestion;
                                                    _typeAheadController.text =
                                                        suggestion;
                                                  });
                                                },
                                              ),
                                            ),
                                            if (mainCurrencyError)
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
                                )
                            ],
                          ),
                          if (currencyError)
                            Text(
                              "Select any option",
                              style: TextController.errorText,
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              child: Text(
                            S.of(context).InvA3n + " *",
                            style: TextController.BodyHeadingText,
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  S.of(context).Opt11n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio<String>(
                                value: "Short Term",
                                groupValue: selectedValue2,
                                onChanged: (value) {
                                  setState(() {
                                    periodError = false;
                                    selectedValue2 = value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt12n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio<String>(
                                value: "Medium Term",
                                groupValue: selectedValue2,
                                onChanged: (value) {
                                  setState(() {
                                    periodError = false;
                                    selectedValue2 = value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt13n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio<String>(
                                value: "Long Term",
                                groupValue: selectedValue2,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      selectedValue2 = value!; //<-- change this
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          if (periodError)
                            Text(
                              "Select any option",
                              style: TextController.errorText,
                            )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Text(
                            S.of(context).InvA4n,
                            style: TextController.BodyHeadingText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  S.of(context).InvA5new,
                                  style: TextController.BodyText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
                              width: 270,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.center,
                                style: TextController.BodyText,
                                controller: otherConstraint,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: ColorSelect.east_grey,
                        border: Border.all(
                          color: ColorSelect.tabBorderColor,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              S.of(context).ClientDeclaration,
                              style: TextController.SubHeadingText,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      // padding: const EdgeInsets.only(right: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          S.of(context).TermsConditions,
                                          style: TextController.BodyHeadingText,
                                        ),
                                        content: Text(
                                          S.of(context).CLientTermsText,
                                          style: TextController.BodyText,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            style: TextButton.styleFrom(
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge,
                                            ),
                                            child: Text(S.of(context).OK),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  S.of(context).Termsnew,
                                  style: TextController.termsText,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                S.of(context).Agree,
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Checkbox(
                                value: terms,
                                onChanged: (value) {
                                  setState(() {
                                    termsError = false;
                                    terms = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (termsError)
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Please Accept Terms & Conditions",
                                style: TextController.errorText,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).ClientName,
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
                                        width: 290,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          textAlign: TextAlign.start,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: ClientName,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                _ClientNameError = true;
                                              });
                                              return "";
                                            } else {
                                              setState(() {
                                                _ClientNameError = false;
                                              });
                                            }
                                            return null;
                                          },
                                          style: TextController.BodyHeadingText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(height: 0.0),
                                          ),
                                        ),
                                      ),
                                      if (_ClientNameError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required.",
                                            style: TextController.errorText,
                                          ),
                                        )
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).Date,
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
                                        width: 290,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: date,
                                          style: TextController.BodyHeadingText,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                _DateError = true;
                                              });
                                              return "";
                                            } else {
                                              setState(() {
                                                _DateError = false;
                                              });
                                            }
                                            return null;
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            hintText: S.of(context).DateFormat,
                                            hintStyle:
                                                TextController.labelTextDate,
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(height: 0.0),
                                          ),
                                          //readOnly: true,
                                          onTap: () async {
                                            DateTime? datepicked =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now(),
                                            );
                                            if (datepicked != null) {
                                              print(
                                                  datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                              String formattedDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(datepicked!);
                                              HijriCalendar picked =
                                                  HijriCalendar.fromDate(
                                                      datepicked);
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) =>
                                                      setState((date.text =
                                                              formattedDate)
                                                          as VoidCallback));
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) =>
                                                      setState((dateHijri.text =
                                                              picked.toString())
                                                          as VoidCallback));
                                              // format date in required form here we use yyyy-MM-dd that means time is remove
                                            } else {
                                              print("Date is not selected");
                                            }
                                          },
                                        ),
                                      ),
                                      if (_DateError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required.",
                                            style: TextController.errorText,
                                          ),
                                        )
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).DateHijri,
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Container(
                                      width: 290,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: dateHijri,
                                        style: TextController.BodyHeadingText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            hintText: S.of(context).DateFormat,
                                            hintStyle:
                                                TextController.labelTextDate,
                                            border: InputBorder.none),
                                        readOnly: true,
                                        // onTap: () async {
                                        //   final HijriCalendar? picked =
                                        //       await showHijriDatePicker(
                                        //     context: context,
                                        //     initialDate: selectedDate,
                                        //     lastDate: new HijriCalendar()
                                        //       ..hYear = 1445
                                        //       ..hMonth = 9
                                        //       ..hDay = 25,
                                        //     firstDate: new HijriCalendar()
                                        //       ..hYear = 1438
                                        //       ..hMonth = 12
                                        //       ..hDay = 25,
                                        //     initialDatePickerMode:
                                        //         DatePickerMode.day,
                                        //   );
                                        //   if (picked != null) {
                                        //     //print(picked);
                                        //     WidgetsBinding.instance
                                        //         .addPostFrameCallback((_) =>
                                        //             setState((dateHijri.text =
                                        //                     picked.toString())
                                        //                 as VoidCallback));
                                        //   }
                                        // },
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Container(
                              height: 35,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: ColorSelect.tabBorderColor)),
                              child: TextButton(
                                onPressed: () {
                                  tabController?.animateTo(6);
                                }, // Switch tabs
                                child: Text(
                                  S.of(context).Back,
                                  style: TextController.SideMenuText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
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
                                    setState(
                                      () {
                                        currencyError = selectedValue ==
                                            ""; // Set currencyError based on selectedValue
                                        periodError = selectedValue2 ==
                                            ""; // Set periodError based on selectedValue2
                                        termsError = terms !=
                                            true; // Set termsError based on terms value
                                        if (_typeAheadController.text == "" &&
                                            selectedValue ==
                                                "Denominated in Foreign Currency") {
                                          mainCurrencyError = true;
                                        } else {
                                          mainCurrencyError = false;
                                        }

                                        if (_Certificates == "" ||
                                            _DividendsIncome == "" ||
                                            _SalesProceeds == "") {
                                          ClientTableError = true;
                                        } else {
                                          ClientTableError = false;
                                        }
                                      },
                                    );

                                    // Check if any of the error conditions are true
                                    bool hasError = currencyError ||
                                        periodError ||
                                        termsError;

                                    // If there's an error, don't proceed
                                    if (_formKey.currentState!.validate() &&
                                        !currencyError &&
                                        !periodError &&
                                        !mainCurrencyError &&
                                        !ClientTableError &&
                                        !termsError) {
                                      // No errors, proceed with investmentB
                                      _formKey.currentState?.save();
                                      if (GlobalPOA.poadraftprogress[
                                              "InvestmentProfileBPOA"] ==
                                          true) {
                                        putdata(GlobalPOA.poalclientid);
                                      } else {
                                        if (GlobalPOA.poalclientid != 0) {
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
                                },
                                child: Text(
                                  btn,
                                  style: TextController.btnText,
                                ),
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
          ),
        ),
      ),
    );
  }
}
