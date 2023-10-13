import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InvestmentPortfolioBCorporate extends StatefulWidget {
  InvestmentPortfolioBCorporate({@required controller}) {
    tabController = controller;
  }

  @override
  State<InvestmentPortfolioBCorporate> createState() =>
      _InvestmentPortfolioBState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> NameofClient = ValueNotifier("");
}

TabController? tabController;

class _InvestmentPortfolioBState extends State<InvestmentPortfolioBCorporate> {
  String btn = "Next";
  final _formKey = GlobalKey<FormState>();

  String _selectedItem = '';

  bool _ClientNameError = false;
  bool _DateError = false;
  bool checkError = false;
  bool _SalesProceedsError = false;
  bool _DividendsIncomeError = false;
  bool _CertificatesError = false;

  bool currencyError = false;
  bool periodError = false;
  bool termsError = false;
  bool mainCurrencyError = false;

  String PeriodDuringCashOut1 = "";

  late String dropdownvalue;

  bool _GIOIncome = false;
  bool _GIOBalanced = false;
  bool _GIOGrowth = false;
  bool _GIOCreateSaving = false;
  bool _GIOProjectFinancing = false;
  bool _GIOPurchaseAsset = false;
  bool _GIOProtection = false;
  bool _Agree = false;
  bool _Decline = false;

  String _Certificates = "";
  String _DividendsIncome = "";
  String _SalesProceeds = "";
  String _ClientsPreferredInvestment = "";
  String _PeriodDuringCashOut = "";
  bool terms = false;

  TextEditingController _OtherConstraints = TextEditingController();
  TextEditingController _ClientName = TextEditingController();
  TextEditingController _Date = TextEditingController();
  TextEditingController _DateHijri = TextEditingController();
  TextEditingController _currency = new TextEditingController();
  // TextEditingController _CertificatesClient = TextEditingController();
  // TextEditingController _DividendsIncomeClient = TextEditingController();
  // TextEditingController _SalesProceedsClient = TextEditingController();
  // TextEditingController _CertificatesCustodian = TextEditingController();
  // TextEditingController _CertificatesOther = TextEditingController();
  // TextEditingController _DividendsIncomeCustodian = TextEditingController();
  // TextEditingController _DividendsIncomeOther = TextEditingController();
  // TextEditingController _SalesProceedsCustodian = TextEditingController();
  // TextEditingController _SalesProceedsOther = TextEditingController();

  void InvestmentB() async {
    setState(() {
      btn = "Loading...";
    });
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "gioIncome": _GIOIncome,
      "gioBalanced": _GIOBalanced,
      "gioGrowth": _GIOGrowth,
      "gioCreateSaving": _GIOCreateSaving,
      "gioProjectFinancing": _GIOProjectFinancing,
      "gioPurchaseAsset": _GIOPurchaseAsset,
      "gioProtection": _GIOProtection,
      "certificatesClient": _Certificates,
      "certificatesCustodian": _Certificates,
      "certificatesOther": _Certificates,
      "dividendsIncomeClient": _DividendsIncome,
      "dividendsIncomeCustodian": _DividendsIncome,
      "dividendsIncomeOther": _DividendsIncome,
      "salesProceedsClient": _SalesProceeds,
      "salesProceedsCustodian": _SalesProceeds,
      "salesProceedsOther": _SalesProceeds,
      "clientsPreferredInvestment": _ClientsPreferredInvestment,
      "clientsPreferrefInvestmentText": _currency.text,
      "periodDuringCashOut": _PeriodDuringCashOut,
      "otherConstraints": _OtherConstraints.text,
      "agree": _Agree,
      "decline": _Decline,
      "clientName": _ClientName.text,
      "date": _Date.text,
      "dateHijri": _DateHijri.text
    };

    final response = await http.post(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/InvestmentProfileBCorporate/InvestmentProfileBCorporate'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      GlobalPermissionCorporate.getdraftprogresscorporate(
          GlobalPermissionCorporate.corporateclientid);

      tabController?.animateTo(10);
      setState(() {
        btn = "Next";
      });

      print("Successful");
      // tabController?.animateTo(10);

      // Process the responseData
    } else {
      setState(() {
        btn = "Next";
      });
      print("Error========");
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  Future<void> fetchData(int id) async {
    var url =
        '${GlobalPermission.urlLink}/api/InvestmentProfileBCorporate/InvestmentProfileBCorporate/${id}'; // Replace with your API endpoint

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Request successful, parse the response body

        var jsonResponse = json.decode(response.body);

        print(jsonResponse);
        setState(() {
          _GIOIncome = jsonResponse["gioIncome"];
          _GIOBalanced = jsonResponse["gioBalanced"];
          _GIOGrowth = jsonResponse["gioGrowth"];
          _GIOCreateSaving = jsonResponse["gioCreateSaving"];
          _GIOProjectFinancing = jsonResponse["gioProjectFinancing"];
          _GIOPurchaseAsset = jsonResponse["gioPurchaseAsset"];
          _GIOProtection = jsonResponse["gioProtection"];
          _Certificates = jsonResponse["certificatesClient"];
          _Certificates = jsonResponse["certificatesCustodian"];
          _Certificates = jsonResponse["certificatesOther"];
          _DividendsIncome = jsonResponse["dividendsIncomeClient"];
          _DividendsIncome = jsonResponse["dividendsIncomeCustodian"];
          _DividendsIncome = jsonResponse["dividendsIncomeOther"];
          print("---");
          _SalesProceeds = jsonResponse["salesProceedsClient"];
          _SalesProceeds = jsonResponse["salesProceedsCustodian"];
          _SalesProceeds = jsonResponse["salesProceedsOther"];
          print("---");
          _ClientsPreferredInvestment =
              jsonResponse["clientsPreferredInvestment"];
          _currency.text = jsonResponse["clientsPreferrefInvestmentText"];
          _PeriodDuringCashOut = jsonResponse["periodDuringCashOut"];
          _OtherConstraints.text = jsonResponse["otherConstraints"];
          terms = jsonResponse["agree"];
          _Decline = jsonResponse["decline"];
          _ClientName.text = jsonResponse["clientName"];
          _Date.text = jsonResponse["date"].toString();
          _DateHijri.text = jsonResponse["dateHijri"].toString();
        });

        // setState(() {
        //   data = jsonDecode(response.body);
        // });
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Request failed, handle the exception
      print('Exception occurred while fetching data: $e');
    }
  }

  void PutData(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": Id,
      "gioIncome": _GIOIncome,
      "gioBalanced": _GIOBalanced,
      "gioGrowth": _GIOGrowth,
      "gioCreateSaving": _GIOCreateSaving,
      "gioProjectFinancing": _GIOProjectFinancing,
      "gioPurchaseAsset": _GIOPurchaseAsset,
      "gioProtection": _GIOProtection,
      "certificatesClient": _Certificates,
      "certificatesCustodian": _Certificates,
      "certificatesOther": _Certificates,
      "dividendsIncomeClient": _DividendsIncome,
      "dividendsIncomeCustodian": _DividendsIncome,
      "dividendsIncomeOther": _DividendsIncome,
      "salesProceedsClient": _SalesProceeds,
      "salesProceedsCustodian": _SalesProceeds,
      "salesProceedsOther": _SalesProceeds,
      "clientsPreferredInvestment": _ClientsPreferredInvestment,
      "clientsPreferrefInvestmentText": _currency.text,
      "periodDuringCashOut": _PeriodDuringCashOut,
      "otherConstraints": _OtherConstraints.text,
      "agree": terms,
      "decline": _Decline,
      "clientName": _ClientName.text,
      "date": _Date.text,
      "dateHijri": _DateHijri.text
    };

    final response = await http.put(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/InvestmentProfileBCorporate/InvestmentProfileBCorporate?ClientId=${Id}'),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response

      print("Updating Data");
      tabController?.animateTo(10);
      setState(() {
        btn = "Next";
      });
      // tabController?.animateTo(10);

      // Process the responseData
    } else {
      setState(() {
        btn = "Next";
      });
      print("Error========");
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  // List of items in our dropdown menu
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

  bool? isChecked = false;

  @override
  void initState() {
    super.initState();
    _ClientName.text = InvestmentPortfolioBCorporate.NameofClient.value;
    // fetchData(9367);
    print(GlobalPermissionCorporate.corporateclientid);
    if (GlobalPermissionCorporate
            .corporatedraftprogress["InvestmentProfileBCorporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
    }
    print(GlobalPermissionCorporate.corporatedraftprogress);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: Scaffold(
        body: Container(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  S.of(context).GeneralInvestmentObjectives,
                                  style: TextController.BodyHeadingText,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 450,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Table(
                                        border: TableBorder.all(
                                            color: ColorSelect.tabBorderColor),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        columnWidths: {
                                          // 0: FixedColumnWidth(500),
                                          // 1: FixedColumnWidth(270),
                                          0: FlexColumnWidth(2),
                                          1: FlexColumnWidth(1),
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
                                                  value: _GIOProtection,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _GIOProtection = value!;
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
                                                  value: _GIOIncome,
                                                  onChanged: (value1) {
                                                    setState(() {
                                                      _GIOIncome = value1!;
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
                                                  value: _GIOBalanced,
                                                  onChanged: (value3) {
                                                    setState(() {
                                                      _GIOBalanced = value3!;
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
                                                  value: _GIOGrowth,
                                                  onChanged: (value3) {
                                                    setState(() {
                                                      _GIOGrowth = value3!;
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
                                                  value: _GIOCreateSaving,
                                                  onChanged: (value4) {
                                                    setState(() {
                                                      _GIOCreateSaving =
                                                          value4!;
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
                                                  value: _GIOProjectFinancing,
                                                  onChanged: (value5) {
                                                    setState(() {
                                                      _GIOProjectFinancing =
                                                          value5!;
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
                                                  value: _GIOPurchaseAsset,
                                                  onChanged: (value6) {
                                                    setState(() {
                                                      _GIOPurchaseAsset =
                                                          value6!;
                                                    });
                                                  }),
                                            ),
                                          ]),
                                        ],
                                      ),
                                      if (checkError)
                                        Container(
                                          margin: EdgeInsetsDirectional.only(
                                              top: 5),
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
                            width: 35,
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
                                Container(
                                  width: 550,
                                  alignment: Alignment.topRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Table(
                                        border: TableBorder.all(
                                            color: ColorSelect.tabBorderColor),
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
                                                      style:
                                                          TextController.InvACC,
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Center(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      S.of(context).InvAT27,
                                                      style:
                                                          TextController.InvACC,
                                                      maxLines: 5,
                                                    ),
                                                  )),
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
                                                    S.of(context).InvAT24,
                                                    style:
                                                        TextController.BodyText,
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
                                                    value: "Other Certificates",
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
                                                alignment: Alignment.centerLeft,
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).InvAT26,
                                                    style:
                                                        TextController.BodyText,
                                                  )),
                                              Container(
                                                height: 70,
                                                child: Center(
                                                  child: Radio(
                                                    value:
                                                        "Client Sales Proceeds",
                                                    groupValue: _SalesProceeds,
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
                                                    groupValue: _SalesProceeds,
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
                                                    groupValue: _SalesProceeds,
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
                                      if (_SalesProceedsError ||
                                          _CertificatesError ||
                                          _DividendsIncomeError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required.",
                                            style: TextController.errorText,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).InvA2New + " *",
                            style: TextController.BodyHeadingText,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  S.of(context).Opt1new,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio(
                                value: "Dominated in Saudi riyals",
                                groupValue: _ClientsPreferredInvestment,
                                onChanged: (value) {
                                  setState(() {
                                    currencyError = false;
                                    _ClientsPreferredInvestment =
                                        value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt2New,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio(
                                value: "Dominated in Foriegn Currency",
                                groupValue: _ClientsPreferredInvestment,
                                onChanged: (value) {
                                  setState(() {
                                    currencyError = false;
                                    _ClientsPreferredInvestment =
                                        value!; //<-- change this
                                  });
                                },
                              ),
                              if (_ClientsPreferredInvestment ==
                                  "Dominated in Foriegn Currency")
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
                                                        controller: _currency,
                                                        style: TextController
                                                            .BodyText,
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        decoration: InputDecoration(
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
                                                    _currency.text = suggestion;
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

                                            // Container(
                                            //   width: 270,
                                            //   height: 35,
                                            //   padding: EdgeInsets.symmetric(
                                            //     horizontal: 10,
                                            //   ),
                                            //   alignment: Alignment.centerLeft,
                                            //   decoration: BoxDecoration(
                                            //       color: Colors.white,
                                            //       border: Border.all(
                                            //           color: ColorSelect
                                            //               .textField)),
                                            //   child: TextFormField(
                                            //     controller: _currency,
                                            //     textAlignVertical:
                                            //         TextAlignVertical.center,
                                            //     style: TextController.BodyText,
                                            //     validator: (value) {
                                            //       if (_ClientsPreferredInvestment ==
                                            //               "Denominated in Foreign Currency" &&
                                            //           value!.isEmpty) {
                                            //         return 'This field is required.';
                                            //       }
                                            //       return null; // Return null if the input is valid
                                            //     },
                                            //     onTap: () {
                                            //       showCurrencyPicker(
                                            //         theme:
                                            //             CurrencyPickerThemeData(),
                                            //         context: context,
                                            //         showFlag: true,
                                            //         showSearchField: true,
                                            //         showCurrencyName: true,
                                            //         showCurrencyCode: true,
                                            //         onSelect:
                                            //             (Currency currency) {
                                            //           setState(() {
                                            //             _currency.text =
                                            //                 currency.name;
                                            //           });
                                            //           print(
                                            //               'Select currency: ${currency.code}');
                                            //         },
                                            //         favorite: ['SAR'],
                                            //       );
                                            //     },
                                            //     decoration: InputDecoration(
                                            //         isDense: true,
                                            //         hintText:
                                            //             S.of(context).TypeHere,
                                            //         hintStyle: TextController
                                            //             .labelText,
                                            //         errorStyle: TextController
                                            //             .inputErrorText,
                                            //         border: InputBorder.none),
                                            //   ),
                                            // ),
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
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    child: Text(
                                  S.of(context).InvA3n + " *",
                                  style: TextController.BodyHeadingText,
                                )),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).Opt11n,
                                style: TextController.BodyText,
                              ),
                              Radio(
                                value: "Short Term(Less Than 1 Year)",
                                groupValue: _PeriodDuringCashOut,
                                onChanged: (value) {
                                  setState(() {
                                    periodError = false;

                                    _PeriodDuringCashOut =
                                        value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt12n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio(
                                value: "Medium Term (1 Year - 5 Year)",
                                groupValue: _PeriodDuringCashOut,
                                onChanged: (value) {
                                  setState(() {
                                    periodError = false;
                                    _PeriodDuringCashOut =
                                        value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Text(
                                  S.of(context).Opt13n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Radio(
                                value: "Long Term(More Than 5 Year)",
                                groupValue: _PeriodDuringCashOut,
                                onChanged: (value) {
                                  setState(() {
                                    periodError = false;

                                    _PeriodDuringCashOut =
                                        value!; //<-- change this
                                  });
                                },
                              ),
                            ],
                          ),
                          if (periodError)
                            Text(
                              "Select any option",
                              style: TextController.errorText,
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).InvA4n,
                            style: TextController.BodyHeadingText,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  S.of(context).InvA5n,
                                  style: TextController.BodyText,
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: 270,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: TextFormField(
                                    style: TextController.BodyText,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _OtherConstraints,
                                    keyboardType: TextInputType.multiline,
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
                                          controller: _ClientName,
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
                                          controller: _Date,
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
                                                    lastDate: DateTime.now());
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
                                                      setState((_Date.text =
                                                              formattedDate)
                                                          as VoidCallback));
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) =>
                                                      setState((_DateHijri
                                                                  .text =
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
                                        controller: _DateHijri,
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
                      height: 15,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Row(
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
                                  setState(
                                    () {
                                      currencyError =
                                          _ClientsPreferredInvestment == "";
                                      periodError = _PeriodDuringCashOut == "";
                                      _SalesProceedsError =
                                          _SalesProceeds == "";
                                      _CertificatesError = _Certificates == "";
                                      _DividendsIncomeError =
                                          _DividendsIncome == "";
                                      termsError = terms != true;

                                      if (_currency.text == "" &&
                                          _ClientsPreferredInvestment ==
                                              "Dominated in Foriegn Currency") {
                                        mainCurrencyError = true;
                                      } else {
                                        mainCurrencyError = false;
                                      }
                                    },
                                  );
                                  if (!_GIOIncome &&
                                      !_GIOBalanced &&
                                      !_GIOGrowth &&
                                      !_GIOCreateSaving &&
                                      !_GIOProjectFinancing &&
                                      !_GIOPurchaseAsset &&
                                      !_GIOProtection) {
                                    checkError = true;
                                  } else {
                                    checkError =
                                        false; // At least one checkbox is selected, so remove the error
                                  }

                                  // Check if any of the error conditions are true
                                  bool hasError = currencyError ||
                                      periodError ||
                                      termsError;

                                  // If there's an error, don't proceed
                                  if (_formKey.currentState!.validate() &&
                                      !currencyError &&
                                      !periodError &&
                                      !checkError &&
                                      !_SalesProceedsError &&
                                      !_CertificatesError &&
                                      !_DividendsIncomeError &&
                                      !mainCurrencyError &&
                                      !termsError) {
                                    // No errors, proceed with investmentB
                                    _formKey.currentState?.save();

                                    if (GlobalPermissionCorporate
                                                .corporatedraftprogress[
                                            "InvestmentProfileBCorporate"] ==
                                        true) {
                                      PutData(GlobalPermissionCorporate
                                          .corporateclientid);
                                    } else {
                                      if (GlobalPermissionCorporate
                                              .corporateclientid !=
                                          0) {
                                        InvestmentB();
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Please fill general info first",
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

                                // if (_ClientsPreferredInvestment != null) {
                                //   if (_PeriodDuringCashOut != null) {
                                //     if (_formKey.currentState!.validate()) {
                                //       if (terms != "" && terms == "Agree") {
                                //         _formKey.currentState?.save();

                                //         InvestmentB();
                                //         tabController?.animateTo(10);
                                //       } else {
                                //         setState(() {
                                //           termsError = true;
                                //         });
                                //       }
                                //     }
                                //   } else {
                                //     setState(() {
                                //       periodError = true;
                                //     });
                                //   }
                                // } else {
                                //   setState(() {
                                //     currencyError = true;
                                //   });
                                // }
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
          ),
        ),
      ),
    );
  }
}
