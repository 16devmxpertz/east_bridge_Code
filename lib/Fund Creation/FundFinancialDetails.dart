import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class FundFinancial extends StatefulWidget {
  FundFinancial({@required controller}) {
    tabController = controller;
  }

  @override
  State<FundFinancial> createState() => FundFinancialState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class FundFinancialState extends State<FundFinancial> {
  bool currencyError = false;
  bool TotalFundValueError = false;
  bool PerShareValueError = false;
  bool minimumAmountError = false;
  bool NoOfSharesError = false;
  TextEditingController TotalFundValue = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController minimumAmount = new TextEditingController();

  TextEditingController type = new TextEditingController();

  TextEditingController FmName = new TextEditingController();
  TextEditingController FmCompany = new TextEditingController();
  TextEditingController FmAddress = new TextEditingController();
  TextEditingController FmRegistration = new TextEditingController();
  TextEditingController FmUnified = new TextEditingController();
  TextEditingController FmLicense = new TextEditingController();

  TextEditingController FoName = new TextEditingController();
  TextEditingController FoCompany = new TextEditingController();
  TextEditingController FoAddress = new TextEditingController();
  TextEditingController FoRegistration = new TextEditingController();
  TextEditingController FoUnified = new TextEditingController();
  TextEditingController FoLicense = new TextEditingController();

  TextEditingController ctName = new TextEditingController();
  TextEditingController ctCompany = new TextEditingController();
  TextEditingController ctAddress = new TextEditingController();
  TextEditingController ctRegistration = new TextEditingController();
  TextEditingController ctUnified = new TextEditingController();
  TextEditingController ctLicense = new TextEditingController();

  TextEditingController atName = new TextEditingController();
  TextEditingController atCompany = new TextEditingController();
  TextEditingController atAddress = new TextEditingController();
  TextEditingController atRegistration = new TextEditingController();
  TextEditingController atUnified = new TextEditingController();
  TextEditingController atLicense = new TextEditingController();

  TextEditingController lcName = new TextEditingController();
  TextEditingController lcCompany = new TextEditingController();
  TextEditingController lcAddress = new TextEditingController();
  TextEditingController lcRegistration = new TextEditingController();
  TextEditingController lcUnified = new TextEditingController();
  TextEditingController lcLicense = new TextEditingController();
  TextEditingController _currency = new TextEditingController();

  List<Map<String, String>> rowsData = []; // List to store data for each row

  final _formKey = GlobalKey<FormState>();
  List<List<TextEditingController>> feesListfinal = [];
  List<List<String>> FeesList = [];
  String dropdownvalue = "";

  void addRow() {
    setState(() {
      List<TextEditingController> li = [];
      for (int i = 0; i < 9; i++) {
        TextEditingController temp = new TextEditingController();
        li.add(temp);
      }

      feesListfinal.add(li);
    });
  }

  void deleteRow(int i) {
    setState(() {
      feesListfinal.removeAt(i);
    });
  }

  @override
  void initState() {
    super.initState();
    print("Init  working");
    feesListfinal.clear();
    FeesList.clear();
    print("ftechinggg----------");
    print(GlobalPermissionFund.Funddraftprogress);

    if (GlobalPermissionFund.Funddraftprogress["FundFinancial"] == true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionFund.Fundclientid);
      print(GlobalPermissionFund.Funddraftprogress);
      print("ftechinggg----------");
    }
  }

  void fundFinanicialDetail() async {
    print(FmUnified.text);
    int? fmr = int.tryParse(FmRegistration.text);
    int? fmu = int.tryParse(FmUnified.text);
    int? fml = int.tryParse(FmLicense.text);
    int? foR = int.tryParse(FoRegistration.text);
    int? fou = int.tryParse(FoUnified.text);
    int? fol = int.tryParse(FoLicense.text);
    int? ctr = int.tryParse(ctRegistration.text);
    int? ctu = int.tryParse(ctUnified.text);
    int? ctl = int.tryParse(ctLicense.text);
    int? atr = int.tryParse(atRegistration.text);
    int? atu = int.tryParse(atUnified.text);
    int? atl = int.tryParse(atLicense.text);
    int? lcr = int.tryParse(lcRegistration.text);
    int? lcu = int.tryParse(lcUnified.text);
    int? lcl = int.tryParse(lcLicense.text);

    double? valueOfFund =
        double.tryParse(TotalFundValue.text.replaceAll(",", ""));
    double? perShare = double.tryParse(PerShareValue.text.replaceAll(",", ""));
    int? noShare = int.tryParse(NoOfShares.text.replaceAll(",", ""));
    double? minimum = double.tryParse(minimumAmount.text.replaceAll(",", ""));
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFinancial/FundFinancialDetail');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "fundId": GlobalPermissionFund.Fundclientid,
        "totalValue": valueOfFund,
        "noOfShares": noShare,
        "perShareValue": perShare,
        "minimumAmountToStartFund": minimum,
        "data": FeesList,
        "currency": _currency.text,
      };

      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("FundFinancialWorking");
        GlobalPermissionFund.getdraftprogressfund(
            GlobalPermissionFund.Fundclientid);
        // print(jsonDecode(response.body));
        tabController!.animateTo(2);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        // print(jsonDecode(response.body));
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
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void PutData(int Id) async {
    print(FmUnified.text);
    int? fmr = int.tryParse(FmRegistration.text);
    int? fmu = int.tryParse(FmUnified.text);
    int? fml = int.tryParse(FmLicense.text);
    int? foR = int.tryParse(FoRegistration.text);
    int? fou = int.tryParse(FoUnified.text);
    int? fol = int.tryParse(FoLicense.text);
    int? ctr = int.tryParse(ctRegistration.text);
    int? ctu = int.tryParse(ctUnified.text);
    int? ctl = int.tryParse(ctLicense.text);
    int? atr = int.tryParse(atRegistration.text);
    int? atu = int.tryParse(atUnified.text);
    int? atl = int.tryParse(atLicense.text);
    int? lcr = int.tryParse(lcRegistration.text);
    int? lcu = int.tryParse(lcUnified.text);
    int? lcl = int.tryParse(lcLicense.text);
    double? valueOfFund =
        double.tryParse(TotalFundValue.text.replaceAll(",", ""));
    double? perShare = double.tryParse(PerShareValue.text.replaceAll(",", ""));
    int? noShare = int.tryParse(NoOfShares.text.replaceAll(",", ""));
    double? minimum = double.tryParse(minimumAmount.text.replaceAll(",", ""));
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFinancial/UpdateFundFinancialDetail');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "fundId": Id,
        "totalValue": valueOfFund,
        "noOfShares": noShare,
        "perShareValue": perShare,
        "minimumAmountToStartFund": minimum,
        "currency": _currency.text,
        "data": FeesList,
      };

      print(body);
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("FundFinancial Update Working");
        tabController!.animateTo(2);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        // print(jsonDecode(response.body));
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
        print("Error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundFinancial/GetFundFinancialAndAdministrationDetail/${Id}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Fetch Working");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        TotalFundValue.text = jsonResponse["totalValue"].toString();
        NoOfShares.text = jsonResponse["noOfShares"].toString();
        PerShareValue.text = jsonResponse["perShareValue"].toString();
        minimumAmount.text =
            jsonResponse["minimumAmountToStartFund"].toString();
        _currency.text = jsonResponse["currency"];
      });

      var x = jsonResponse["data"] as List<List<String>>;
      setState(() {
        for (var i in x) {
          List<TextEditingController> li = [];
          setState(() {
            li.add(TextEditingController(text: i[0].toString()));
            li.add(TextEditingController(text: i[1].toString()));
            li.add(TextEditingController(text: i[2].toString()));
            li.add(TextEditingController(text: i[3].toString()));
            li.add(TextEditingController(text: i[4].toString()));
            li.add(TextEditingController(text: i[5].toString()));
          });

          feesListfinal.add(li);
        }
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
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

    String _selectedItem = '';
    List<List<String>> table = [];

    List<String> tableData = [];

// Your calculatePerShareValue method
    void calculatePerShareValue() {
      double totalFundValue =
          double.parse(TotalFundValue.text.replaceAll(',', ''));
      int noOfShares = int.parse(NoOfShares.text.replaceAll(',', ''));

      double perShareValue = totalFundValue / noOfShares;

      // Format the perShareValue with commas
      NumberFormat formatter = NumberFormat("#,###.##", "en_US");
      String formattedPerShareValue = formatter.format(perShareValue);

      PerShareValue.text = formattedPerShareValue;
    }

    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
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
                child: Text(S.of(context).FundFinancial,
                    style: TextController.BodyHeadingText),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: ColorSelect.textField),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).fundtotalvalue + "*",
                                    style: TextController.BodyText,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          width: 400,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            controller: TotalFundValue,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              ThousandsSeparatorInputFormatter(),
                                            ],
                                            onChanged: (value) {
                                              calculatePerShareValue();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  TotalFundValueError = true;
                                                });
                                                return '';
                                              }

                                              // Check if the input contains alphabets
                                              if (RegExp(r'[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                setState(() {
                                                  TotalFundValueError = true;
                                                });
                                                return '';
                                              }

                                              setState(() {
                                                TotalFundValueError = false;
                                              });
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                errorStyle:
                                                    TextStyle(height: 0),
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        if (TotalFundValueError)
                                          (RegExp(r'[a-zA-Z]').hasMatch(
                                                  TotalFundValue.text))
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "Please enter a valid number.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "This field is required.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "No Of Units*",
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 400,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            controller: NoOfShares,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              ThousandsSeparatorInputFormatter(),
                                            ],
                                            onChanged: (value) {
                                              calculatePerShareValue();
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  NoOfSharesError = true;
                                                });
                                                return '';
                                              }

                                              // Check if the input contains alphabets
                                              if (RegExp(r'[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                setState(() {
                                                  NoOfSharesError = true;
                                                });
                                                return '';
                                              }

                                              setState(() {
                                                NoOfSharesError = false;
                                              });
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              isDense: true,
                                              errorStyle: TextStyle(height: 0),
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        if (NoOfSharesError)
                                          (RegExp(r'[a-zA-Z]')
                                                  .hasMatch(NoOfShares.text))
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "Please enter a valid number.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "This field is required.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Per Unit Value*",
                                    style: TextController.BodyText,
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
                                          width: 400,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: PerShareValue,
                                            keyboardType: TextInputType.number,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              ThousandsSeparatorInputFormatter(),
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  PerShareValueError = true;
                                                });
                                                return '';
                                              }
                                              setState(() {
                                                PerShareValueError = false;
                                              });
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                errorStyle:
                                                    TextStyle(height: 0),
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        if (PerShareValueError)
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
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).Currency + "*",
                                    style: TextController.BodyText,
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
                                          width: 400,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TypeAheadField(
                                            textFieldConfiguration:
                                                TextFieldConfiguration(
                                                    controller: _currency,
                                                    style:
                                                        TextController.BodyText,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    decoration: InputDecoration(
                                                        isDense: true,
                                                        enabledBorder:
                                                            InputBorder.none,
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
                                            itemBuilder: (context, suggestion) {
                                              return ListTile(
                                                title: Text(
                                                  suggestion,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              );
                                            },
                                            onSuggestionSelected: (suggestion) {
                                              // Update the selected item when a suggestion is selected.
                                              setState(() {
                                                _selectedItem = suggestion;
                                                _currency.text = suggestion;
                                                setState(() {
                                                  currencyError = false;
                                                });
                                              });
                                            },
                                          ),
                                        ),
                                        if (currencyError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This Feild is Required",
                                              style: TextController.errorText,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Minimum Amount to start fund*",
                                    style: TextController.BodyText,
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
                                          width: 400,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            controller: minimumAmount,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              ThousandsSeparatorInputFormatter()
                                            ],
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  minimumAmountError = true;
                                                });
                                                return '';
                                              }

                                              // Check if the input contains alphabets
                                              if (RegExp(r'[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                setState(() {
                                                  minimumAmountError = true;
                                                });
                                                return '';
                                              }

                                              setState(() {
                                                minimumAmountError = false;
                                              });
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                                isDense: true,
                                                errorStyle:
                                                    TextStyle(height: 0),
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                        if (minimumAmountError)
                                          (RegExp(r'[a-zA-Z]')
                                                  .hasMatch(minimumAmount.text))
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "Please enter a valid number.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Text(
                                                    "This field is required.",
                                                    style: TextController
                                                        .errorText,
                                                  ),
                                                ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          Flexible(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    S.of(context).FundAdministrationDetails,
                    style: TextController.BodyHeadingText,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: Table(
                  border: TableBorder.all(color: ColorSelect.tabBorderColor),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                    3: FlexColumnWidth(1),
                    4: FlexColumnWidth(1),
                    5: FlexColumnWidth(1),
                    6: FlexColumnWidth(1), // Column for Delete button
                  },
                  children: [
                    TableRow(
                      children: [
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Center(
                            child: Text(
                              S.of(context).Type,
                              style: TextController.InvA,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                S.of(context).Name,
                                style: TextController.InvA,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                S.of(context).Address,
                                style: TextController.InvA,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                S.of(context).RegistrationNo,
                                style: TextController.InvA,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                S.of(context).UnifiedNo,
                                style: TextController.InvA,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: Text(
                                S.of(context).LicenseNo,
                                style: TextController.InvA,
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          color: ColorSelect.east_grey,
                          child: Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              onPressed: () {
                                setState(() {
                                  addRow();
                                });
                              },
                              child: Text(
                                'Add Row',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    for (int index = 0; index < feesListfinal.length; index++)
                      TableRow(children: [
                        TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][0],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle: TextController.inputErrorText,
                          ),
                        ),
                        buildDataCell(TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][1],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText),
                        )),
                        buildDataCell(TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][2],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText),
                        )),
                        buildDataCell(TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][3],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText),
                        )),
                        buildDataCell(TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][4],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText),
                        )),
                        buildDataCell(TextFormField(
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'This field is required.';
                            }
                            return null; // Return null if the input is valid
                          },
                          controller: feesListfinal[index][5],
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              errorStyle: TextController.inputErrorText),
                        )),
                        buildDataCell(IconButton(
                          onPressed: () {
                            setState(() {
                              deleteRow(index);
                            });
                          },
                          icon: Icon(Icons.delete),
                        )),
                      ]),
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
                            FeesList.clear();
                            print(FeesList);
                            for (List<TextEditingController> x
                                in feesListfinal) {
                              List<String> mp = [];
                              mp.add(x[0].text);
                              mp.add(x[1].text);
                              mp.add(x[2].text);
                              mp.add(x[3].text);
                              mp.add(x[4].text);
                              mp.add(x[5].text);

                              setState(() {
                                FeesList.add(mp);
                              });
                            }
                            print("sett");
                            if (_formKey.currentState != null) {
                              setState(() {
                                currencyError = _currency.text == "";
                              });
                              if (_formKey.currentState!.validate() &&
                                  !currencyError) {
                                _formKey.currentState!.save();

                                if (GlobalPermissionFund
                                        .Funddraftprogress["FundFinancial"] ==
                                    true) {
                                  PutData(GlobalPermissionFund.Fundclientid);
                                } else {
                                  if (GlobalPermissionFund.Fundclientid != 0) {
                                    fundFinanicialDetail();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill Fund Detail first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              }
                            }
                            // if ((_formKey.currentState!.validate())) {
                            //   if (dropdownvalue != "") {
                            //     _formKey.currentState?.save();
                            //     fundFinanicialDetail();
                            //     tabController!.animateTo(2);
                            //   } else {
                            //     setState(() {
                            //       currencyError = true;
                            //     });
                            //   }
                            // }
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
      ),
    );
  }

  Widget buildDataCell(Widget child) {
    return Container(
      height: 50,
      child: Center(child: child),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final String cleanedText = newValue.text.replaceAll(',', '');
    final parts = cleanedText.split('.');
    String formattedValue = _formatWithCommas(parts[0]);

    if (parts.length > 1) {
      formattedValue += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _formatWithCommas(String text) {
    final int length = text.length;
    if (length <= 3) {
      return text;
    }
    String temp = "";
    int count = 3;
    int j = 0;
    for (int i = length - 1; i >= 0; i--) {
      j++;
      temp += text[i];
      if (j == count) {
        j = 0;
        temp += ",";
      }
    }

    temp = temp.split('').reversed.join('');
    if (temp[0] == ",") {
      temp = temp.substring(1);
    }
    return temp;
  }
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any previous formatting characters
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Split the text into integer and decimal parts
    List<String> parts = newText.split('.');
    if (parts.length > 2) {
      // If there are more than one decimal point, remove extras
      newText = parts[0] + '.' + parts.sublist(1).join('');
    }

    // Add commas for thousands separator
    String formattedText = '';
    int counter = 0;
    for (int i = newText.length - 1; i >= 0; i--) {
      formattedText = newText[i] + formattedText;
      counter++;
      if (counter % 3 == 0 && i > 0) {
        formattedText = ',' + formattedText;
      }
    }

    // Add back the decimal part, if it exists
    if (parts.length == 2) {
      formattedText += '.' + parts[1];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
// class ThousandsSeparatorInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     if (newValue.text.isEmpty) {
//       return newValue;
//     }

//     final String cleanedText = newValue.text.replaceAll(',', '');
//     final String formattedValue = _formatWithSarCommas(cleanedText);

//     return TextEditingValue(
//       text: formattedValue,
//       selection: TextSelection.collapsed(offset: formattedValue.length),
//     );
//   }

//   String _formatWithSarCommas(String text) {
//     final int length = text.length;
//     if (length <= 3) {
//       return text;
//     }
//     String temp = "";
//     int count = 0;
//     for (int i = length - 1; i >= 0; i--) {
//       count++;
//       temp += text[i];
//       if (count == 3 && i > 0) {
//         count = 0;
//         temp += ","; // Use a standard comma as the thousands separator
//       }
//     }

//     temp = temp.split('').reversed.join('');
//     if (temp[0] == ",") {
//       temp = temp.substring(1);
//     }
//     return temp;
//   }
// }
