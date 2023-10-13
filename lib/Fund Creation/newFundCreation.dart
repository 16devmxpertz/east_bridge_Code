import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/AgreementPDF.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Fund%20Creation/FundPDFAgreement.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/dropdownValuesGlobal.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FundCreationStateNew extends StatefulWidget {
  FundCreationStateNew({@required controller}) {
    tabController = controller;
  }

  @override
  State<FundCreationStateNew> createState() => _FundCreationStateNewState();
}

TabController? tabController;

class _FundCreationStateNewState extends State<FundCreationStateNew> {
  TextEditingController subscriptionPeriod = new TextEditingController();

  TextEditingController FundProductCode = new TextEditingController();
  TextEditingController FundProductName = new TextEditingController();
  TextEditingController Description = new TextEditingController();
  TextEditingController bussinessPhone = new TextEditingController();
  TextEditingController addressForCorrespondense = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController Mobile = new TextEditingController();
  TextEditingController radioTwo = new TextEditingController();
  TextEditingController radioThree = new TextEditingController();
  TextEditingController radioOne = new TextEditingController();
  TextEditingController dateController = new TextEditingController();

  String industryCatagory = "";
  String FundType = "";
  String Status = "";

  String SubCategoryDropdown = "";
  String _selectedItem = "";
  String ICdropdownvalue = "";
  String InvestmentTypedropdownvalue = "";
  String Cateogrydropdownvalue = "";
  String FundAllotment = "";
  TextEditingController Country = new TextEditingController();

  TextEditingController FromDate = new TextEditingController();
  TextEditingController ToDate = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int id = 0;

  var Subcateogry = [
    "",
  ];

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  var cateogry = [
    'Large Cap',
    'Medium Cap',
    'Small Cap',
  ];

  var status = [
    'Open Ended',
    'Closed Ended',
  ];

  var type = [
    'Public Equity',
    'Private Equity',
  ];

  var InvestmentTypes = [
    'International Equities',
    'Public Equities',
    'Fixed Income',
    'Money Market',
    'Private Equity',
    'Venture Capital',
    'Real Estate',
    'REIT (Real Estate Investment Trust)',
    'Derivatives',
  ];

  var citizenship = [
    'Albania',
    'Algeria',
    'Andorra',
    'Angola',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaijan',
    'The Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Cabo Verde',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Colombia',
    'Comoros',
    'Congo, Democratic Republic of the',
    'Congo, Republic of the',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Cyprus',
    'Czech Republic',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'East Timor (Timor-Leste)',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Fiji',
    'Finland',
    'France',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Greece',
    'Grenada',
    'Guatemala',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Israel',
    'Italy',
    'Ivory Coast (Côte d Ivoire)',
    'Jamaica',
    'Japan',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Korea, North',
    'Korea, South',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macedonia',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Poland',
    'Portugal',
    'Qatar',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Singapore',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Tuvalu',
    'Uganda',
    'Ukraine',
    'United Arab Emirates (UAE)',
    'United Kingdom (UK)',
    'United States of America (USA)',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican City (Holy See)',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Zambia',
    'Zimbabwe',
  ];

  var industry = [
    'Banking & Financial Services',
    'Information Technology',
    'Engineering & Capital Goods',
    'Oil & Gas',
    'Pharmaceuticals',
    'Automotive',
    'Chemicals',
    'Utilities',
    'Metals & Mining',
    'Cement & Construction',
    'Miscellaneous',
    'Tobacco',
    'Manufacturing',
    'Telecommunication',
    'Consumer Non-durables',
    'Services',
    'Conglomerates',
    'Retail & Real Estate',
    'Food & Beverages',
    'Media & Entertainment',
    'Consumer Durables',
    'Tourism',
  ];

  void fundDetail() async {
    print("data sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundDetailandClassification/FundDetailandClassification');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "fundId": GlobalPermission.employeeId,
      "fundCode": FundProductCode.text,
      "fundName": FundProductName.text,
      "fundDescription": Description.text,
      "fromDate": FromDate.text,
      "toDate": ToDate.text,
      "subscriptionPeriod": int.parse(subscriptionPeriod.text),
      "industryCategory": ICdropdownvalue ?? "Default",
      "industryTypes": InvestmentTypedropdownvalue,
      "category": Cateogrydropdownvalue,
      "fundAllotment": FundAllotment,
      "country": Country.text,
      "subCategory": SubCategoryDropdown
    };
    print(body);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      setState(() {
        id = int.parse(response.body);
        FundFinancial.id.value = id;
        GlobalPermissionFund.Fundclientid = id;
      });
      print("Fund1  Working");
      // id = response.body;

      await GlobalPermissionFund.getdraftprogressfund(id);

      FundPDFAgreementUpload.name.value = FundProductName.text;

      tabController!.animateTo(1);

      // return id;
    } else {
      print(response.statusCode);
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

  void PutData(int Id) async {
    print("data Updating");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundDetailandClassification/FundDetailandClassification?FundId=$Id');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "fundId": Id,
      "fundCode": FundProductCode.text,
      "fundName": FundProductName.text,
      "fundDescription": Description.text,
      "fromDate": FromDate.text,
      "toDate": ToDate.text,
      "subscriptionPeriod": int.parse(subscriptionPeriod.text),
      "industryCategory": ICdropdownvalue ?? "Default",
      "industryTypes": InvestmentTypedropdownvalue,
      "category": Cateogrydropdownvalue,
      "fundAllotment": FundAllotment,
      "country": Country.text,
      "subCategory": SubCategoryDropdown
    };
    print(body);

    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Fund1  Updating");
      print("PUTTTTTT");
      print(body);

      // id = response.body;

      // FundFinancial.id.value = id;
      // GlobalPermissionFund.Fundclientid = id;
      // await GlobalPermissionFund.getdraftprogressfund(id);
      // Fees.id.value = id;

      // FundBankInfo.id.value = id;

      // FundAgreementFinal.id.value = id;
      // FundCreationAgreement.id.value = id;
      // FundCreationAgreement.name.value = FundProductName.text;

      tabController!.animateTo(1);

      // return id;
    } else {
      print(response.statusCode);
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

  Future<void> fetchData(int Id) async {
    print("data fechingg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FundDetailandClassification/fundDetailandClassification/$Id'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Fund1 Get Working");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        // nameOfContracts.text = jsonResponse['nameOfContract'];

        FundProductCode.text = jsonResponse['fundCode'];
        FundProductName.text = jsonResponse['fundName'];
        Description.text = jsonResponse['fundDescription'];
        FromDate.text = jsonResponse['fromDate'];
        ToDate.text = jsonResponse['toDate'];
        subscriptionPeriod.text = jsonResponse['subscriptionPeriod'].toString();

        ICdropdownvalue = jsonResponse['industryCategory'].toString();
        InvestmentTypedropdownvalue = jsonResponse['industryTypes'].toString();
        Cateogrydropdownvalue = jsonResponse['category'].toString();
        Country.text = jsonResponse['country'].toString();
        FundAllotment = jsonResponse['fundAllotment'].toString();
        SubCategoryDropdown = jsonResponse['subCategory'].toString();

//
      });
    } else {
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
    }
  }

  void updateSubscriptionPeriod() {
    if (FromDate.text.isNotEmpty && ToDate.text.isNotEmpty) {
      DateTime startDate = DateFormat('dd-MM-yyyy').parse(FromDate.text);
      DateTime endDate = DateFormat('dd-MM-yyyy').parse(ToDate.text);

      int daysDifference = endDate.difference(startDate).inDays;
      setState(() {
        int x = daysDifference + 1;
        if (x < 0) {
          subscriptionPeriod.text = "0";
        } else {
          subscriptionPeriod.text = x.toString();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("Init  working");
    print("ftechinggg----------");

    if (GlobalPermissionFund.Funddraftprogress["FundDetailandClassification"] ==
        true) {
      print(GlobalPermissionFund.Fundclientid);
      print("ftechinggg----------");
      setState(() {
        FundProductCode.text = GlobalPermissionFund.Fundclientid.toString();
      });

      fetchData(GlobalPermissionFund.Fundclientid);
      print(GlobalPermissionFund.Funddraftprogress);
      print("ftechinggg----------");
    } else {
      print("not fetchinggg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Text(
                      S.of(context).FundDetails,
                      style: TextController.BodyHeadingText,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorSelect.textField)),
                    height: 250,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).FundProductCode,
                                style: TextController.BodyText,
                              ),
                            ),
                            Container(
                              height: 130,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).Description,
                                style: TextController.BodyText,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15, bottom: 15),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: FundProductCode,
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 130,
                                padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  controller: Description,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 5,
                                  textAlignVertical: TextAlignVertical.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).FundProductName,
                                style: TextController.BodyText,
                              ),
                            ),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).FromDate,
                                style: TextController.BodyText,
                              ),
                            ),
                            Container(
                              height: 35,
                              margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).ToDate,
                                style: TextController.BodyText,
                              ),
                            ),
                            Container(
                              height: 35,
                            ),
                            Container(
                              height: 35,
                              // margin: const EdgeInsets.only(top: 15),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                S.of(context).subscriptionPeriod,
                                style: TextController.BodyText,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  controller: FundProductName,
                                  textAlignVertical: TextAlignVertical.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  controller: FromDate,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  // readOnly: true,
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                      ),
                                      hintText: S.of(context).DateFormat,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? datepicked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(3000));
                                    if (datepicked != null) {
                                      print(
                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(datepicked!);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          FromDate.text = formattedDate;
                                        });
                                      });
                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 15),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  controller: ToDate,
                                  readOnly: true,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      suffixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                      ),
                                      hintText: S.of(context).DateFormat,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                  //readOnly: true,
                                  onTap: () async {
                                    DateTime? datepicked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(3000));
                                    if (datepicked != null) {
                                      print(
                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(datepicked!);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          ToDate.text = formattedDate;
                                        });
                                      });
                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                    } else {
                                      print("Date is not selected");
                                    }
                                    // updateSubscriptionPeriod();
                                  },
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorSelect.east_blue)),
                                  child: Text(
                                    "Calculate",
                                    style: TextController.btnText,
                                  ),
                                  onPressed: () {
                                    updateSubscriptionPeriod();
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                width: 400,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  controller: subscriptionPeriod,
                                  keyboardType: TextInputType.number,
                                  readOnly: true,
                                  textAlignVertical: TextAlignVertical.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                      errorStyle: TextController.inputErrorText,
                                      isDense: true,
                                      hintText: S.of(context).inDays,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(
                      S.of(context).FundClassification,
                      style: TextController.BodyHeadingText,
                    ),
                  ),
                  Container(
                    height: 300,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ColorSelect.textField)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 20),
                              child: Text(
                                S.of(context).IndustryCategory,
                                style: TextController.BodyText,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 20),
                              child: Text(
                                "Investment Type",
                                style: TextController.BodyText,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25, bottom: 20),
                              child: Text(
                                S.of(context).Category,
                                style: TextController.BodyText,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 20),
                              child: Text(
                                S.of(context).FundAllotment,
                                style: TextController.BodyText,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  width: 400,
                                  height: 44,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value: ICdropdownvalue.isNotEmpty
                                        ? ICdropdownvalue
                                        : null,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: industry.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextController.BodyText,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (NewValue) {
                                      setState(
                                        () {
                                          ICdropdownvalue = NewValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  width: 400,
                                  height: 44,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value:
                                        InvestmentTypedropdownvalue.isNotEmpty
                                            ? InvestmentTypedropdownvalue
                                            : null,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: DropdownValuesGlobal
                                        .dropDown["Investment Types"]
                                        ?.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextController.BodyText,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (NewValue) {
                                      setState(
                                        () {
                                          InvestmentTypedropdownvalue =
                                              NewValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  width: 400,
                                  height: 44,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value: Cateogrydropdownvalue.isNotEmpty
                                        ? Cateogrydropdownvalue
                                        : null,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: DropdownValuesGlobal
                                        .dropDown[InvestmentTypedropdownvalue]
                                        ?.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextController.BodyText,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (NewValue) {
                                      setState(
                                        () {
                                          Cateogrydropdownvalue = NewValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          S.of(context).Cash,
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "Cash",
                                        groupValue: FundAllotment,
                                        onChanged: (value) {
                                          setState(() {
                                            FundAllotment =
                                                value!; //<-- change this
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        height: 60,
                                      ),
                                      Flexible(
                                        child: Text(
                                          S.of(context).cashKind,
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                      Radio<String>(
                                        value: "Cash & Kind",
                                        groupValue: FundAllotment,
                                        onChanged: (value) {
                                          setState(() {
                                            FundAllotment =
                                                value!; //<-- change this
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 25, bottom: 20),
                                  child: Text(
                                    S.of(context).Country,
                                    style: TextController.BodyText,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 25, bottom: 20),
                                  child: Text(
                                    "Sub Category",
                                    style: TextController.BodyText,
                                  ),
                                ),
                              ),
                              // Flexible(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(top: 25, bottom: 20),
                              //     child: Text(
                              //       "International Equities",
                              //       style: TextController.BodyText,
                              //     ),
                              //   ),
                              // ),
                              // Flexible(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(top: 25, bottom: 20),
                              //     child: Text(
                              //       "Derivatives",
                              //       style: TextController.BodyText,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: 400,
                                  height: 44,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                                controller: Country,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    hintText:
                                                        S.of(context).Country)),
                                        suggestionsCallback: (pattern) {
                                          // Return a filtered list of suggestions based on the search pattern.
                                          return citizenship
                                              .where((item) => item
                                                  .toLowerCase()
                                                  .contains(
                                                      pattern.toLowerCase()))
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
                                            Country.text = suggestion;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                  ),
                                  width: 400,
                                  height: 44,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: DropdownButton<String>(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value: SubCategoryDropdown.isNotEmpty
                                        ? SubCategoryDropdown
                                        : null,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: DropdownValuesGlobal
                                        .dropDown[Cateogrydropdownvalue]
                                        ?.map(
                                      (String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items,
                                            style: TextController.BodyText,
                                          ),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (NewValue) {
                                      setState(
                                        () {
                                          SubCategoryDropdown = NewValue!;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Flexible(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(top: 10, bottom: 10),
                              //     padding: const EdgeInsets.only(
                              //       left: 15,
                              //     ),
                              //     width: 400,
                              //     height: 44,
                              //     alignment: Alignment.centerLeft,
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         border: Border.all(
                              //             color: ColorSelect.textField)),
                              //     child: DropdownButton<String>(
                              //       hint: Text("Select Here",
                              //           style: TextController.labelText),
                              //       value: Statusdropdownvalue.isNotEmpty
                              //           ? Statusdropdownvalue
                              //           : null,
                              //       isExpanded: true,
                              //       underline: Container(),
                              //       iconEnabledColor: ColorSelect.east_dark_blue,
                              //       items: status.map(
                              //         (String items) {
                              //           return DropdownMenuItem(
                              //             value: items,
                              //             child: Text(
                              //               items,
                              //               style: TextController.BodyText,
                              //             ),
                              //           );
                              //         },
                              //       ).toList(),
                              //       onChanged: (NewValue) {
                              //         setState(
                              //           () {
                              //             Statusdropdownvalue = NewValue!;
                              //           },
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Flexible(
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(top: 10, bottom: 10),
                              //     padding: const EdgeInsets.only(
                              //       left: 15,
                              //     ),
                              //     width: 400,
                              //     height: 44,
                              //     alignment: Alignment.centerLeft,
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         border: Border.all(
                              //             color: ColorSelect.textField)),
                              //     child: DropdownButton<String>(
                              //       hint: Text("Select Here",
                              //           style: TextController.labelText),
                              //       value: Derivativesdropdownvalue.isNotEmpty
                              //           ? Derivativesdropdownvalue
                              //           : null,
                              //       isExpanded: true,
                              //       underline: Container(),
                              //       iconEnabledColor: ColorSelect.east_dark_blue,
                              //       items: Derivatives.map(
                              //         (String items) {
                              //           return DropdownMenuItem(
                              //             value: items,
                              //             child: Text(
                              //               items,
                              //               style: TextController.BodyText,
                              //             ),
                              //           );
                              //         },
                              //       ).toList(),
                              //       onChanged: (NewValue) {
                              //         setState(
                              //           () {
                              //             Derivativesdropdownvalue = NewValue!;
                              //           },
                              //         );
                              //       },
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 300,
                  //   width: double.infinity,
                  //   margin: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 20),
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 20, vertical: 20),
                  //   decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       border: Border.all(color: ColorSelect.textField)),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Container(
                  //             height: 35,
                  //             margin:
                  //                 const EdgeInsets.only(top: 10, bottom: 10),
                  //             alignment: Alignment.centerLeft,
                  //             child: Text(
                  //               S.of(context).IndustryCategory,
                  //               style: TextController.BodyText,
                  //             ),
                  //           ),
                  //           Container(
                  //             height: 35,
                  //             margin:
                  //                 const EdgeInsets.only(top: 10, bottom: 10),
                  //             alignment: Alignment.centerLeft,
                  //             child: Text(
                  //               S.of(context).FundType,
                  //               style: TextController.BodyText,
                  //             ),
                  //           ),
                  //           Container(
                  //             height: 35,
                  //             margin:
                  //                 const EdgeInsets.only(top: 10, bottom: 10),
                  //             alignment: Alignment.centerLeft,
                  //             child: Text(
                  //               S.of(context).FundAllotment,
                  //               style: TextController.BodyText,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Flexible(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                  //               margin:
                  //                   const EdgeInsets.only(top: 10, bottom: 10),
                  //               width: 400,
                  //               height: 35,
                  //               alignment: Alignment.centerLeft,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   border: Border.all(
                  //                       color: ColorSelect.textField)),
                  //               child: DropdownButton<String>(
                  //                 hint: Text("Select Here",
                  //                     style: TextController.labelText),
                  //                 value: industryCatagory.isNotEmpty
                  //                     ? industryCatagory
                  //                     : null,
                  //                 isExpanded: true,
                  //                 underline: Container(),
                  //                 iconEnabledColor: ColorSelect.east_dark_blue,
                  //                 items: industry.map(
                  //                   (String items) {
                  //                     return DropdownMenuItem(
                  //                       value: items,
                  //                       child: Text(
                  //                         items,
                  //                         style: TextController.BodyText,
                  //                       ),
                  //                     );
                  //                   },
                  //                 ).toList(),
                  //                 onChanged: (NewValue) {
                  //                   setState(
                  //                     () {
                  //                       industryCatagory = NewValue!;
                  //                     },
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //             Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                  //               margin:
                  //                   const EdgeInsets.only(top: 10, bottom: 0),
                  //               width: 400,
                  //               height: 35,
                  //               alignment: Alignment.centerLeft,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   border: Border.all(
                  //                       color: ColorSelect.textField)),
                  //               child: DropdownButton<String>(
                  //                 hint: Text("Select Here",
                  //                     style: TextController.labelText),
                  //                 value: FundType.isNotEmpty ? FundType : null,
                  //                 isExpanded: true,
                  //                 underline: Container(),
                  //                 iconEnabledColor: ColorSelect.east_dark_blue,
                  //                 items: type.map(
                  //                   (String items) {
                  //                     return DropdownMenuItem(
                  //                       value: items,
                  //                       child: Text(
                  //                         items,
                  //                         style: TextController.BodyText,
                  //                       ),
                  //                     );
                  //                   },
                  //                 ).toList(),
                  //                 onChanged: (NewValue) {
                  //                   setState(
                  //                     () {
                  //                       FundType = NewValue!;
                  //                     },
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //             Container(
                  //               height: 35,
                  //               margin: const EdgeInsets.only(
                  //                 top: 20,
                  //               ),
                  //               alignment: Alignment.centerLeft,
                  //               child: Row(
                  //                 crossAxisAlignment: CrossAxisAlignment.center,
                  //                 children: [
                  //                   Flexible(
                  //                     child: Text(
                  //                       S.of(context).Cash,
                  //                       style: TextController.BodyText,
                  //                     ),
                  //                   ),
                  //                   Radio<String>(
                  //                     value: "Cash",
                  //                     groupValue: FundAllotment,
                  //                     onChanged: (value) {
                  //                       setState(() {
                  //                         FundAllotment =
                  //                             value!; //<-- change this
                  //                       });
                  //                     },
                  //                   ),
                  //                   SizedBox(
                  //                     height: 60,
                  //                   ),
                  //                   Flexible(
                  //                     child: Text(
                  //                       S.of(context).cashKind,
                  //                       style: TextController.BodyText,
                  //                     ),
                  //                   ),
                  //                   Radio<String>(
                  //                     value: "Cash & Kind",
                  //                     groupValue: FundAllotment,
                  //                     onChanged: (value) {
                  //                       setState(() {
                  //                         FundAllotment =
                  //                             value!; //<-- change this
                  //                       });
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),

                  //       Flexible(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Flexible(
                  //               child: Container(
                  //                 height: 35,
                  //                 margin: const EdgeInsets.only(
                  //                     top: 20, bottom: 10),
                  //                 child: Text(
                  //                   S.of(context).Status,
                  //                   style: TextController.BodyText,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 10),
                  //               margin:
                  //                   const EdgeInsets.only(top: 10, bottom: 10),
                  //               width: 400,
                  //               height: 35,
                  //               alignment: Alignment.centerLeft,
                  //               decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   border: Border.all(
                  //                       color: ColorSelect.textField)),
                  //               child: DropdownButton<String>(
                  //                 hint: Text("Select Here",
                  //                     style: TextController.labelText),
                  //                 value: Status.isNotEmpty ? Status : null,
                  //                 isExpanded: true,
                  //                 underline: Container(),
                  //                 iconEnabledColor: ColorSelect.east_dark_blue,
                  //                 items: status.map(
                  //                   (String items) {
                  //                     return DropdownMenuItem(
                  //                       value: items,
                  //                       child: Text(
                  //                         items,
                  //                         style: TextController.BodyText,
                  //                       ),
                  //                     );
                  //                   },
                  //                 ).toList(),
                  //                 onChanged: (NewValue) {
                  //                   setState(
                  //                     () {
                  //                       Status = NewValue!;
                  //                     },
                  //                   );
                  //                 },
                  //               ),
                  //             ),
                  //             // Container(
                  //             //   margin:
                  //             //       const EdgeInsets.only(top: 10, bottom: 10),
                  //             //   padding: const EdgeInsets.symmetric(
                  //             //     horizontal: 15,
                  //             //   ),
                  //             //   width: 400,
                  //             //   height: 44,
                  //             //   alignment: Alignment.centerLeft,
                  //             //   decoration: BoxDecoration(
                  //             //       color: Colors.white,
                  //             //       border: Border.all(
                  //             //           color: ColorSelect.textField)),
                  //             //   child: DropdownButtonHideUnderline(
                  //             //     child: Theme(
                  //             //       data: Theme.of(context)
                  //             //           .copyWith(focusColor: Colors.white),
                  //             //       child: DropdownButtonFormField(
                  //             //         hint: Text(
                  //             //           S.of(context).SelectHere,
                  //             //           style: TextController.labelText,
                  //             //         ),
                  //             //         isExpanded: true,
                  //             //         icon:
                  //             //             const Icon(Icons.keyboard_arrow_down),
                  //             //         decoration: InputDecoration(
                  //             //           enabledBorder: InputBorder.none,
                  //             //           border: InputBorder.none,
                  //             //           hoverColor: Colors.white,
                  //             //         ),
                  //             //         items: status.map((String items) {
                  //             //           return DropdownMenuItem(
                  //             //             value: items,
                  //             //             child: Text(items,
                  //             //                 style: TextController.BodyText),
                  //             //           );
                  //             //         }).toList(),
                  //             //         onChanged: (String? newValue) {
                  //             //           setState(() {
                  //             //             dropdownvalue2 = newValue!;
                  //             //           });
                  //             //         },
                  //             //       ),
                  //             //     ),
                  //             //   ),
                  //             // ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        // alignment: Alignment.centerRight,
                        height: 35,
                        width: 140,
                        color: ColorSelect.east_blue,
                        child: TextButton(
                          onPressed: () {
                            // print("=================");
                            // tabController!.animateTo(1);
                            // print("=================");

                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();

                              if (GlobalPermissionFund.Funddraftprogress[
                                      "FundDetailandClassification"] ==
                                  true) {
                                PutData(GlobalPermissionFund.Fundclientid);
                              } else {
                                fundDetail();
                              }
                            }
                          }, // Switch tabs
                          child: Text(
                            S.of(context).Next,
                            style: TextController.btnText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
