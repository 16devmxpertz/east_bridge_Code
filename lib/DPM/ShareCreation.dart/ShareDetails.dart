import 'dart:convert';

import 'package:east_bridge/DPM/DPMGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

enum SingingCharacter { yes, no }

class ShareDetails extends StatefulWidget {
  ShareDetails({@required controller}) {
    tabController = controller;
  }

  @override
  State<ShareDetails> createState() => ShareDetailsState();
  // static ValueNotifier<int> id = new ValueNotifier(0);
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class ShareDetailsState extends State<ShareDetails> {
  TextEditingController TotalFundValue = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController _currency = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();
  String dropdownvalue = "";
  String _selectedItem = '';
  bool valueError = false;

  bool priceError = false;
  bool quantityError = false;
  bool currencyError = false;
  // To store the selected item
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int currentValue = 0;
  // void updateTotalFundValue() {
  //   String noOfShares = NoOfShares.text;
  //   String perShareValue = PerShareValue.text;

  //   // Remove commas for calculation
  //   String noOfSharesWithoutCommas = noOfShares.replaceAll(',', '');
  //   String perShareValueWithoutCommas = perShareValue.replaceAll(',', '');

  //   setState(() {
  //     currentValue = int.parse(noOfSharesWithoutCommas);
  //     TotalFundValue.text = NumberFormat('#,##0')
  //         .format(currentValue * double.parse(perShareValueWithoutCommas));
  //   });
  // }
  // void calculatePerShareValue() {
  //   int perShareValue = int.parse(PerShareValue.text.replaceAll(',', ''));
  //   int noOfShares = int.parse(NoOfShares.text.replaceAll(',', ''));

  //   double totalFundValue = (perShareValue * noOfShares) as double;
  //   TotalFundValue.text = totalFundValue.toStringAsFixed(2);
  // }

// Your calculatePerShareValue method
  void calculatePerShareValue() {
    double perShareValue = double.parse(PerShareValue.text.replaceAll(',', ''));
    double noOfShares = double.parse(NoOfShares.text.replaceAll(',', ''));

    double totalFundValue = (perShareValue * noOfShares);

    // Format the totalFundValue with commas
    String formattedTotalFundValue = ThousandsSeparatorInputFormatter()
        .formatEditUpdate(
          TextEditingValue(),
          TextEditingValue(
              text: totalFundValue
                  .toStringAsFixed(2)), // Format with two decimal places
        )
        .text;
    TotalFundValue.text = formattedTotalFundValue;
  }

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

  void fundFinanicialDetail() async {
    double? valueOfFund =
        double.tryParse(TotalFundValue.text.replaceAll(",", ""));
    double? perShare = double.tryParse(PerShareValue.text.replaceAll(",", ""));
    double? noShare = double.tryParse(NoOfShares.text.replaceAll(",", ""));
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ShareFinancialAndAdministrationDetail/ShareFinancialAndAdministrationDetail');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "shareId": GlobalPermissionDPM.DPMid,
      "valueOfFund": valueOfFund.toString(),
      "noOfShares": noShare.toString(),
      "perShareValue": perShare.toString(),
      "currency": _typeAheadController.text
    };
    print(body);
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      await GlobalPermissionDPM.getdraftprogressfund(GlobalPermissionDPM.DPMid);
      // print(jsonDecode(response.body));
      tabController!.animateTo(2);
    } else {
      print(response.body);
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

  void PutData(int id) async {
    print("PutData");
    double? valueOfFund =
        double.tryParse(TotalFundValue.text.replaceAll(",", ""));
    double? perShare = double.tryParse(PerShareValue.text.replaceAll(",", ""));
    double? noShare = double.tryParse(NoOfShares.text.replaceAll(",", ""));
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ShareFinancialAndAdministrationDetail/ShareFinancialAndAdministrationDetail/${GlobalPermissionDPM.DPMid}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "shareId": GlobalPermissionDPM.DPMid,
      "valueOfFund": valueOfFund.toString(),
      "noOfShares": noShare.toString(),
      "perShareValue": perShare.toString(),
      "currency": _typeAheadController.text
    };
    print("PutData");
    print(body);
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Update Working");
      // print(jsonDecode(response.body));
      tabController?.animateTo(2);
    } else {
      print(response.body);
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

  ///ShareFinancialAndAdministrationDetail
  Future<void> fetchData(int id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ShareFinancialAndAdministrationDetail/ShareFinancialAndAdministrationDetail/${GlobalPermissionDPM.DPMid}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      setState(() {
        TotalFundValue.text = jsonResponse['valueOfFund'].toString();
        PerShareValue.text = jsonResponse['perShareValue'].toString();
        NoOfShares.text = jsonResponse['noOfShares'].toString();
        _typeAheadController.text = jsonResponse['currency'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // String _addCommas(String text) {
  //   final formatted = StringBuffer();
  //   final reversed = text.split('').reversed.toList();

  //   for (int i = 0; i < reversed.length; i++) {
  //     formatted.write(reversed[i]);

  //     if ((i + 1) % 2 == 0 && i != reversed.length - 1) {
  //       formatted.write(',');
  //     }
  //   }

  //   return formatted.toString().split('').reversed.join();
  // }

  // void _formatText() {
  //   final text = PerShareValue.text.replaceAll(',', '');

  //   if (text.isNotEmpty) {
  //     final formattedText = _addCommas(text);
  //     PerShareValue.value = TextEditingValue(
  //       text: formattedText,
  //       selection: TextSelection.collapsed(offset: formattedText.length),
  //     );
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // PerShareValue.addListener(_formatText);
    if (GlobalPermissionDPM
            .DPMdraftprogress["ShareFinancialAndAdministrationDetail"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionDPM.DPMid);
      print(fetchData(GlobalPermissionDPM.DPMid));
      print("ftechinggg----------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
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
                child: Text(S.of(context).PortfolioDetails,
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
                          alignment: Alignment.centerLeft,
                          child: Text("Price", style: TextController.BodyText),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 35,
                          child: Center(
                            child: Text(S.of(context).TotalValueOfShare,
                                style: TextController.BodyText),
                          ),
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 35, bottom: 10),
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  onChanged: (value) {
                                    calculatePerShareValue();
                                  },
                                  controller: PerShareValue,
                                  inputFormatters: <TextInputFormatter>[
                                    ThousandsSeparatorInputFormatter(),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        priceError = true;
                                      });
                                      return "";
                                    }
                                    if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                      setState(() {
                                        priceError = true;
                                      });
                                      return '';
                                    }

                                    setState(() {
                                      priceError = false;
                                    });
                                    return null;
                                  },
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    errorStyle: TextStyle(
                                      height: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                              if (priceError)
                                (RegExp(r'[a-zA-Z]')
                                        .hasMatch(PerShareValue.text))
                                    ? Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Please enter a valid number.",
                                          style: TextController.errorText,
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "This field is required.",
                                          style: TextController.errorText,
                                        ),
                                      ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 400,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      setState(() {
                                        valueError = true;
                                      });
                                      return "";
                                    }

                                    if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                      setState(() {
                                        valueError = true;
                                      });
                                      return '';
                                    }
                                    setState(() {
                                      valueError = false;
                                    });

                                    return null;
                                  },
                                  readOnly: true,
                                  textAlignVertical: TextAlignVertical.center,
                                  controller: TotalFundValue,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).TypeHere,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    errorStyle: TextStyle(
                                      height: 0.0,
                                    ),
                                  ),
                                ),
                              ),
                              if (valueError)
                                (RegExp(r'[a-zA-Z]')
                                        .hasMatch(TotalFundValue.text))
                                    ? Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Please enter a valid number.",
                                          style: TextController.errorText,
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Text(
                                          "This field is required.",
                                          style: TextController.errorText,
                                        ),
                                      ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0, top: 45),
                          child:
                              Text("Quantity", style: TextController.BodyText),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 35, bottom: 10),
                              width: 400,
                              height: 35,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: TextFormField(
                                onChanged: (value) {
                                  calculatePerShareValue();
                                },
                                controller: NoOfShares,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  ThousandsSeparatorInputFormatter(),
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    setState(() {
                                      quantityError = true;
                                    });
                                    return "";
                                  } // Check if the input contains alphabets
                                  if (RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                    setState(() {
                                      quantityError = true;
                                    });
                                    return '';
                                  }
                                  setState(() {
                                    quantityError = false;
                                  });

                                  return null;
                                },
                                style: TextController.BodyText,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none,
                                  errorStyle: TextStyle(
                                    height: 0.0,
                                  ),
                                ),
                              ),
                            ),
                            if (quantityError)
                              (RegExp(r'[a-zA-Z]').hasMatch(NoOfShares.text))
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Please enter a valid number.",
                                        style: TextController.errorText,
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "This field is required.",
                                        style: TextController.errorText,
                                      ),
                                    ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 400,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: _typeAheadController,
                                    style: TextController.BodyText,
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        enabledBorder: InputBorder.none,
                                        hintStyle: TextController.labelText,
                                        hintText: S.of(context).Currency)),
                                suggestionsCallback: (pattern) {
                                  // Return a filtered list of suggestions based on the search pattern.
                                  return currencies
                                      .where((item) => item
                                          .toLowerCase()
                                          .contains(pattern.toLowerCase()))
                                      .toList();
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(
                                      suggestion,
                                      style: TextController.BodyText,
                                    ),
                                  );
                                },
                                onSuggestionSelected: (suggestion) {
                                  // Update the selected item when a suggestion is selected.
                                  setState(() {
                                    _selectedItem = suggestion;
                                    _typeAheadController.text = suggestion;
                                  });
                                },
                              ),
                            ),
                            if (currencyError)
                              Container(
                                // margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "This field is required.",
                                  style: TextController.errorText,
                                ),
                              )
                          ],
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
                            if (_formKey.currentState != null) {
                              setState(() {
                                currencyError = _typeAheadController.text == "";
                              });
                              if (_formKey.currentState!.validate() &&
                                  !currencyError) {
                                _formKey.currentState?.save();

                                if (GlobalPermissionDPM.DPMdraftprogress[
                                        "ShareFinancialAndAdministrationDetail"] ==
                                    true) {
                                  PutData(GlobalPermissionDPM.DPMid);
                                } else {
                                  if (GlobalPermissionDPM.DPMid != 0) {
                                    fundFinanicialDetail();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Please fill Product Detail  first",
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
