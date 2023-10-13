import 'dart:convert';

import 'package:east_bridge/Agreement%20Masters/CustomerAddAgreement.dart';

import 'package:east_bridge/Fund%20Creation/Fees.dart';
import 'package:east_bridge/Fund%20Creation/FundBankDetails.dart';
import 'package:east_bridge/Fund%20Creation/FundFinancialDetails.dart';
import 'package:east_bridge/NDPM/ShareCreation.dart/ShareDetails.dart';
import 'package:east_bridge/NDPM/ShareCreation.dart/ShareFeesDetail.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:hijri/hijri_calendar.dart';

import '../../generated/l10n.dart';

enum SingingCharacter { yes, no }

class ShareCreationNDPM extends StatefulWidget {
  ShareCreationNDPM({@required controller}) {
    tabController = controller;
  }

  @override
  State<ShareCreationNDPM> createState() => ShareCreationState();
}

enum RadioSelected { RadioOne, RadioTwo }

TabController? tabController;

class ShareCreationState extends State<ShareCreationNDPM> {
  ShareCreationNDPM({@required controller}) {
    tabController = controller;
  }

  String selectedValue = "";
  late final id;
  bool isButtonClickable = true;

  TextEditingController FundProductCode = new TextEditingController();
  TextEditingController FundProductName = new TextEditingController();
  TextEditingController Description = new TextEditingController();
  TextEditingController lockingPeriod = new TextEditingController();
  TextEditingController FromDate = new TextEditingController();
  TextEditingController FromDateHijri = new TextEditingController();

  TextEditingController ToDate = new TextEditingController();
  TextEditingController ToDateHijri = new TextEditingController();

  TextEditingController bussinessPhone = new TextEditingController();
  TextEditingController addressForCorrespondense = new TextEditingController();
  TextEditingController Email = new TextEditingController();
  TextEditingController Mobile = new TextEditingController();
  TextEditingController radioTwo = new TextEditingController();
  TextEditingController radioThree = new TextEditingController();
  TextEditingController radioOne = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();

  String dropdownvalue = "";
  String ICdropdownvalue = "";
  String Cateogrydropdownvalue = "";
  String FixedIncomedropdownvalue = "";
  String Statusdropdownvalue = "";
  String InvestmentTypedropdownvalue = "";
  String Derivativesdropdownvalue = "";

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
      'Public Credit',
      'Private Credit',
      'Corporate Sukuks',
      'Private Sukuks'
    ];
    var InvestmentTypes = [
      'Money Market',
      'Private Equity',
      'Venture Capital',
      'Real Estate',
      'REIT (Real Estate Investment Trust)',
    ];
    var Derivatives = [
      'Options',
      'Futures',
      'Swap',
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
      'Zimbabwe'
    ];

    String _selectedItem = ''; // To store the selected item

    void fundDetail() async {
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/NDPMShareDetailandClassification/NDPMShareDetailandClassification/');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "symbol": FundProductCode.text,
          "shareDescription": Description.text,
          "industryCategory": ICdropdownvalue,
          "category": Cateogrydropdownvalue,
          "fixedIncome": FixedIncomedropdownvalue,
          "status": Statusdropdownvalue,
          "allotmentType": selectedValue,
          "fromDate": FromDate.text,
          "toDate": ToDate.text,
          "fromDateHijri": FromDateHijri.text,
          "toDateHijri": ToDate.text,
          "internationalequity": _typeAheadController.text,
          "investmentType": InvestmentTypedropdownvalue,
          "derivative": Derivativesdropdownvalue
        };

        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
          id = int.parse(response.body);
          return id;
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
      dateController.text = " ";
    }

    return SingleChildScrollView(
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
                S.of(context).PortfolioDetails,
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
                height: 300,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 35,
                          margin: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            S.of(context).ProductCode,
                            style: TextController.BodyText,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          height: 130,
                          child: Text(
                            S.of(context).Description,
                            style: TextController.BodyText,
                          ),
                        ),
                        Text(
                          S.of(context).lockingPeriod + "\n(In Month)",
                          style: TextController.BodyText,
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            width: 400,
                            height: 35,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: TextFormField(
                              controller: FundProductCode,
                              style: TextController.BodyText,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none,
                                errorStyle: TextController.inputErrorText,
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 130,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: TextFormField(
                              controller: Description,
                              style: TextController.BodyText,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: null,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none,
                                errorStyle: TextController.inputErrorText,
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 35,
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              controller: lockingPeriod,
                              style: TextController.BodyText,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none,
                                errorStyle: TextController.inputErrorText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).ProductName,
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            S.of(context).FromDate,
                            style: TextController.BodyText,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Text(
                              S.of(context).ToDate,
                              style: TextController.BodyText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              width: 400,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: TextFormField(
                                controller: FundProductName,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextController.BodyText,
                                
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none,
                                  errorStyle: TextController.inputErrorText,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: 200,
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
                                    readOnly: true,

                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                        ),
                                        isDense: true,
                                        hintText: S.of(context).DateFormat,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none),
                                    //readOnly: true,
                                    onTap: () async {
                                      DateTime? datepicked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1700),
                                              lastDate: DateTime(3000));
                                      if (datepicked != null) {
                                        print(
                                            datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(datepicked!);
                                        HijriCalendar? picked =
                                            HijriCalendar.fromDate(datepicked!);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                setState((FromDate.text =
                                                        formattedDate)
                                                    as VoidCallback));
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                setState((FromDateHijri.text =
                                                        picked.toString())
                                                    as VoidCallback));
                                        // format date in required form here we use yyyy-MM-dd that means time is remove
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  width: 200,
                                  height: 35,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextController.BodyText,
                                    controller: FromDateHijri,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                        ),
                                        isDense: true,
                                        hintText: S.of(context).DateFormat,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none),
                                    readOnly: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: 200,
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

                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                        ),
                                        isDense: true,
                                        hintText: S.of(context).DateFormat,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none),
                                    //readOnly: true,
                                    onTap: () async {
                                      DateTime? datepicked =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1700),
                                              lastDate: DateTime(3000));
                                      if (datepicked != null) {
                                        print(
                                            datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(datepicked!);
                                        HijriCalendar? picked =
                                            HijriCalendar.fromDate(datepicked!);
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                setState((ToDate.text =
                                                        formattedDate)
                                                    as VoidCallback));
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) =>
                                                setState((ToDateHijri.text =
                                                        picked.toString())
                                                    as VoidCallback));
                                        // format date in required form here we use yyyy-MM-dd that means time is remove
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  width: 200,
                                  height: 35,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextController.BodyText,
                                    controller: ToDateHijri,
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                        ),
                                        isDense: true,
                                        hintText: S.of(context).DateFormat,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none),
                                    readOnly: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                S.of(context).PortfolioClassification,
                style: TextController.BodyHeadingText,
              ),
            ),
            Container(
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: Text(
                          S.of(context).IndustryCategory,
                          style: TextController.BodyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: Text(
                          S.of(context).FixedIncome,
                          style: TextController.BodyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 20),
                        child: Text(
                          "Investment Type",
                          style: TextController.BodyText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20),
                        child: Text(
                          S.of(context).AllotmentType,
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
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: industry.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      ICdropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 0),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: type.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      FixedIncomedropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 0),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: InvestmentTypes.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      InvestmentTypedropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
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
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!; //<-- change this
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 60,
                                ),
                                Flexible(
                                  child: Text(
                                    S.of(context).Kind,
                                    style: TextController.BodyText,
                                  ),
                                ),
                                Radio<String>(
                                  value: "Kind",
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!; //<-- change this
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
                            margin: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              S.of(context).Category,
                              style: TextController.BodyText,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              S.of(context).Status,
                              style: TextController.BodyText,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              "International Equities",
                              style: TextController.BodyText,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              "Derivatives",
                              style: TextController.BodyText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: cateogry.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      Cateogrydropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: status.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      Statusdropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            width: double.infinity,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                          controller: _typeAheadController,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              enabledBorder: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
                                              hintText: S.of(context).Country)),
                                  suggestionsCallback: (pattern) {
                                    // Return a filtered list of suggestions based on the search pattern.
                                    return citizenship
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
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            width: 400,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButtonHideUnderline(
                              child: Theme(
                                data: Theme.of(context)
                                    .copyWith(focusColor: Colors.white),
                                child: DropdownButtonFormField(
                                  hint: Text(
                                    S.of(context).SelectHere,
                                    style: TextController.labelText,
                                  ),
                                  isExpanded: true,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hoverColor: Colors.white,
                                  ),
                                  items: Derivatives.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items,
                                          style: TextController.BodyText),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      Derivativesdropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                height: 35,
                width: 140,
                decoration: BoxDecoration(
                  color: ColorSelect.east_blue,
                ),
                child: TextButton(
                  onPressed: () {
                    if (isButtonClickable) {
                      setState(() {
                        isButtonClickable =
                            false; // Disable the button after the first click
                      });
                      fundDetail();
                      // print("idddddddd" + id);
                      ShareDetailsNDPM.id.value = id;
                      ShareFeesDetailNDPM.id.value = id;
                      tabController!.animateTo(1);
                    } else {
                      setState(() {
                        isButtonClickable =
                            true; // Enable the button after all processes are completed
                      });
                    }
                  }, // Switch tabs
                  child: Text(
                    S.of(context).Next,
                    style: TextController.btnText,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
