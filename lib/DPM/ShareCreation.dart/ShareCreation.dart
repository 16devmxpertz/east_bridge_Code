import 'dart:convert';

import 'package:east_bridge/DPM/DPMGlobal.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/dropdownValuesGlobal.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class ShareCreation extends StatefulWidget {
  ShareCreation({@required controller}) {
    tabController = controller;
  }

  @override
  State<ShareCreation> createState() => ShareCreationState();
}

TabController? tabController;

class ShareCreationState extends State<ShareCreation> {
  TextEditingController FundProductCode = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int id;
  bool isButtonClickable = true;

  bool codeError = false;
  bool nameError = false;

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

  String ICdropdownvalue = "";
  String InvestmentTypedropdownvalue = "";
  String Cateogrydropdownvalue = "";
  String AllotmentType = "";
  TextEditingController Country = new TextEditingController();
  String SubCategoryDropdown = "";

  String FixedIncomedropdownvalue = "";
  String Statusdropdownvalue = "";
  String Derivativesdropdownvalue = "";

  // bool lockingError = false;
  // bool fromError = false;
  // bool toError = false;

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
    'Public Equity',
    'Private Equity',
    'Corporate Sukuks',
    'Private Sukuks',
  ];

  var Derivatives = [
    'Options',
    'Futures',
    'Swap',
  ];

  var Subcateogry = [
    'Corporate Sukuks',
    'Private Sukuks',
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
    'Zimbabwe',
  ];

  String _selectedItem = ''; // To store the selected item

  void fundDetail() async {
    print("data sending");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DPMShareDetailandClassification/ShareDetailandClassification');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "shareId": GlobalPermissionDPM.DPMid,
      "productCode": FundProductCode.text,
      "productName": FundProductName.text,
      "productDescription": Description.text,
      "industryCategory": ICdropdownvalue,
      "industryTypes": InvestmentTypedropdownvalue,
      "category": Cateogrydropdownvalue,
      "productAllotment": AllotmentType,
      "country": Country.text,
      "subCategory": SubCategoryDropdown
    };

    print(body);

    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("send Working");
      // print(jsonDecode(response.body));
      id = int.parse(response.body);
      GlobalPermissionDPM.DPMid = id;
      await GlobalPermissionDPM.getdraftprogressfund(GlobalPermissionDPM.DPMid);
      tabController?.animateTo(1);
      // return id;
    } else {
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

  void PutData(int id) async {
    print("data updating");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DPMShareDetailandClassification/ShareDetailandClassification?ShareId=$id');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "shareId": GlobalPermissionDPM.DPMid,
      "productCode": FundProductCode.text,
      "productName": FundProductName.text,
      "productDescription": Description.text,
      "industryCategory": ICdropdownvalue,
      "industryTypes": InvestmentTypedropdownvalue,
      "category": Cateogrydropdownvalue,
      "productAllotment": AllotmentType,
      "country": Country.text,
      "subCategory": SubCategoryDropdown
    };

    print(body);

    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Update Working");
      // print(jsonDecode(response.body));

      tabController!.animateTo(1);
      // return id;
    } else {
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

  Future<void> fetchData(int id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/DPMShareDetailandClassification/ShareDetailandClassification/$id'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Data is Fetching");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      setState(() {
        FundProductName.text = jsonResponse['productName'];
        FundProductCode.text = jsonResponse['productCode'];

        Description.text = jsonResponse['productDescription'];
        ICdropdownvalue = jsonResponse['industryCategory'];
        InvestmentTypedropdownvalue = jsonResponse['industryTypes'];
        Cateogrydropdownvalue = jsonResponse['category'];
        AllotmentType = jsonResponse['productAllotment'];
        Country.text = jsonResponse['country'];
        SubCategoryDropdown = jsonResponse['subCategory'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    print("initttt");
    if (GlobalPermissionDPM.DPMdraftprogress["ShareDetailandClassification"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionDPM.DPMid);
      print(GlobalPermissionDPM.DPMdraftprogress);
      print("ftechinggg----------");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
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
                          // Text(
                          //   S.of(context).lockingPeriod + "\n(In Month)",
                          //   style: TextController.BodyText,
                          // ),
                        ],
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 15, bottom: 10),
                                  width: 400,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: TextFormField(
                                    controller: FundProductCode,
                                    style: TextController.BodyText,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        setState(() {
                                          codeError = true;
                                        });
                                        return "";
                                      } else {
                                        setState(() {
                                          codeError = false;
                                        });
                                      }
                                      return null;
                                    },
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
                                if (codeError)
                                  Container(
                                    // margin: EdgeInsets.only(top: 5),
                                    child: Text(
                                      "This field is required.",
                                      style: TextController.errorText,
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(
                              height: 5,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Container(
                                //   width: 400,
                                //   height: 35,
                                //   margin: const EdgeInsets.only(
                                //       top: 15, bottom: 10),
                                //   padding: EdgeInsets.symmetric(horizontal: 10),
                                //   alignment: Alignment.centerLeft,
                                //   decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       border: Border.all(
                                //           color: ColorSelect.textField)),
                                //   child: TextFormField(
                                //     inputFormatters: [
                                //       FilteringTextInputFormatter.allow(
                                //           RegExp(r'[0-9]')),
                                //     ],
                                //     controller: lockingPeriod,
                                //     validator: (value) {
                                //       if (value!.isEmpty) {
                                //         setState(() {
                                //           lockingError = true;
                                //         });
                                //         return "";
                                //       } else {
                                //         setState(() {
                                //           lockingError = false;
                                //         });
                                //       }
                                //       return null;
                                //     },
                                //     style: TextController.BodyText,
                                //     textAlignVertical: TextAlignVertical.center,
                                //     decoration: InputDecoration(
                                //       isDense: true,
                                //       hintText: S.of(context).TypeHere,
                                //       hintStyle: TextController.labelText,
                                //       border: InputBorder.none,
                                //       errorStyle: TextStyle(
                                //         height: 0.0,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // if (lockingError)
                                //   Container(
                                //     // margin: EdgeInsets.only(top: 5),
                                //     child: Text(
                                //       "This field is required.",
                                //       style: TextController.errorText,
                                //     ),
                                //   )
                              ],
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
                            // Text(
                            //   S.of(context).FromDate,
                            //   style: TextController.BodyText,
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              // child: Text(
                              //   S.of(context).ToDate,
                              //   style: TextController.BodyText,
                              // ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    width: 400,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      controller: FundProductName,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            nameError = true;
                                          });
                                          return "";
                                        } else {
                                          setState(() {
                                            nameError = false;
                                          });
                                        }
                                        return null;
                                      },
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
                                  if (nameError)
                                    Container(
                                      // margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "This field is required.",
                                        style: TextController.errorText,
                                      ),
                                    )
                                ],
                              ),
                            ),
                            // Container(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           // Flexible(
                            //           //   // child: Container(
                            //           //   //   margin:
                            //           //   //       const EdgeInsets.only(top: 15),
                            //           //   //   padding: const EdgeInsets.symmetric(
                            //           //   //     horizontal: 10,
                            //           //   //   ),
                            //           //   //   width: 200,
                            //           //   //   height: 35,
                            //           //   //   alignment: Alignment.centerLeft,
                            //           //   //   decoration: BoxDecoration(
                            //           //   //       color: Colors.white,
                            //           //   //       border: Border.all(
                            //           //   //           color:
                            //           //   //               ColorSelect.textField)),
                            //           //   //   child: TextFormField(
                            //           //   //     textAlignVertical:
                            //           //   //         TextAlignVertical.center,
                            //           //   //     style: TextController.BodyText,
                            //           //   //     controller: FromDate,
                            //           //   //     readOnly: true,
                            //           //   //     validator: (value) {
                            //           //   //       if (value!.isEmpty) {
                            //           //   //         setState(() {
                            //           //   //           fromError = true;
                            //           //   //         });
                            //           //   //         return "";
                            //           //   //       } else {
                            //           //   //         setState(() {
                            //           //   //           fromError = false;
                            //           //   //         });
                            //           //   //         // return "";
                            //           //   //       }
                            //           //   //     },
                            //           //   //     decoration: InputDecoration(
                            //           //   //         suffixIcon: Icon(
                            //           //   //           Icons.calendar_month_outlined,
                            //           //   //           size: 15,
                            //           //   //         ),
                            //           //   //         isDense: true,
                            //           //   //         errorStyle: TextStyle(
                            //           //   //           height: 0.0,
                            //           //   //         ),
                            //           //   //         hintText:
                            //           //   //             S.of(context).DateFormat,
                            //           //   //         hintStyle:
                            //           //   //             TextController.labelText,
                            //           //   //         border: InputBorder.none),
                            //           //   //     //readOnly: true,
                            //           //   //     onTap: () async {
                            //           //   //       DateTime? datepicked =
                            //           //   //           await showDatePicker(
                            //           //   //               context: context,
                            //           //   //               initialDate:
                            //           //   //                   DateTime.now(),
                            //           //   //               firstDate: DateTime(1700),
                            //           //   //               lastDate: DateTime(3000));
                            //           //   //       if (datepicked != null) {
                            //           //   //         print(
                            //           //   //             datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                            //           //   //         String formattedDate =
                            //           //   //             DateFormat('dd-MM-yyyy')
                            //           //   //                 .format(datepicked!);
                            //           //   //         HijriCalendar? picked =
                            //           //   //             HijriCalendar.fromDate(
                            //           //   //                 datepicked!);
                            //           //   //         WidgetsBinding.instance
                            //           //   //             .addPostFrameCallback((_) =>
                            //           //   //                 setState((FromDate
                            //           //   //                             .text =
                            //           //   //                         formattedDate)
                            //           //   //                     as VoidCallback));
                            //           //   //         WidgetsBinding.instance
                            //           //   //             .addPostFrameCallback((_) =>
                            //           //   //                 setState((FromDateHijri
                            //           //   //                             .text =
                            //           //   //                         picked
                            //           //   //                             .toString())
                            //           //   //                     as VoidCallback));
                            //           //   //         // format date in required form here we use yyyy-MM-dd that means time is remove
                            //           //   //       } else {
                            //           //   //         print("Date is not selected");
                            //           //   //       }
                            //           //   //     },
                            //           //   //   ),
                            //           //   // ),
                            //           // ),
                            //           SizedBox(
                            //             width: 30,
                            //           ),
                            //           // Flexible(
                            //           //   child: Container(
                            //           //     margin:
                            //           //         const EdgeInsets.only(top: 15),
                            //           //     padding: const EdgeInsets.symmetric(
                            //           //       horizontal: 15,
                            //           //     ),
                            //           //     width: 200,
                            //           //     height: 35,
                            //           //     alignment: Alignment.centerLeft,
                            //           //     decoration: BoxDecoration(
                            //           //         color: Colors.white,
                            //           //         border: Border.all(
                            //           //             color:
                            //           //                 ColorSelect.textField)),
                            //           //     child: TextFormField(
                            //           //       textAlignVertical:
                            //           //           TextAlignVertical.center,
                            //           //       style: TextController.BodyText,
                            //           //       controller: FromDateHijri,
                            //           //       decoration: InputDecoration(
                            //           //           suffixIcon: Icon(
                            //           //             Icons.calendar_month_outlined,
                            //           //             size: 15,
                            //           //           ),
                            //           //           isDense: true,
                            //           //           hintText:
                            //           //               S.of(context).DateFormat,
                            //           //           hintStyle:
                            //           //               TextController.labelText,
                            //           //           border: InputBorder.none),
                            //           //       readOnly: true,
                            //           //     ),
                            //           //   ),
                            //           // ),
                            //         ],
                            //       ),
                            //       if (fromError)
                            //         Container(
                            //           // margin: EdgeInsets.only(top: 5),
                            //           child: Text(
                            //             "This field is required.",
                            //             style: TextController.errorText,
                            //           ),
                            //         )
                            //     ],
                            //   ),
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Flexible(
                                    //   child: Container(
                                    //     margin: const EdgeInsets.only(top: 15),
                                    //     padding: const EdgeInsets.symmetric(
                                    //       horizontal: 10,
                                    //     ),
                                    //     width: 200,
                                    //     height: 35,
                                    //     alignment: Alignment.centerLeft,
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         border: Border.all(
                                    //             color: ColorSelect.textField)),
                                    //     child: TextFormField(
                                    //       textAlignVertical:
                                    //           TextAlignVertical.center,
                                    //       style: TextController.BodyText,
                                    //       controller: ToDate,
                                    //       readOnly: true,
                                    //       validator: (value) {
                                    //         if (value!.isEmpty) {
                                    //           setState(() {
                                    //             toError = true;
                                    //           });
                                    //           return "";
                                    //         } else {
                                    //           setState(() {
                                    //             toError = false;
                                    //           });
                                    //         }
                                    //         return null;
                                    //       },
                                    //       decoration: InputDecoration(
                                    //           suffixIcon: Icon(
                                    //             Icons.calendar_month_outlined,
                                    //             size: 15,
                                    //           ),
                                    //           isDense: true,
                                    //           errorStyle: TextStyle(
                                    //             height: 0.0,
                                    //           ),
                                    //           hintText:
                                    //               S.of(context).DateFormat,
                                    //           hintStyle:
                                    //               TextController.labelText,
                                    //           border: InputBorder.none),
                                    //       //readOnly: true,
                                    //       onTap: () async {
                                    //         DateTime? datepicked =
                                    //             await showDatePicker(
                                    //                 context: context,
                                    //                 initialDate: DateTime.now(),
                                    //                 firstDate: DateTime(1700),
                                    //                 lastDate: DateTime(3000));
                                    //         if (datepicked != null) {
                                    //           print(
                                    //               datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                    //           String formattedDate =
                                    //               DateFormat('dd-MM-yyyy')
                                    //                   .format(datepicked!);
                                    //           HijriCalendar? picked =
                                    //               HijriCalendar.fromDate(
                                    //                   datepicked!);
                                    //           WidgetsBinding.instance
                                    //               .addPostFrameCallback((_) =>
                                    //                   setState((ToDate.text =
                                    //                           formattedDate)
                                    //                       as VoidCallback));
                                    //           WidgetsBinding.instance
                                    //               .addPostFrameCallback((_) =>
                                    //                   setState((ToDateHijri
                                    //                               .text =
                                    //                           picked.toString())
                                    //                       as VoidCallback));
                                    //           // format date in required form here we use yyyy-MM-dd that means time is remove
                                    //         } else {
                                    //           print("Date is not selected");
                                    //         }
                                    //       },
                                    //     ),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    // Flexible(
                                    //   child: Container(
                                    //     margin: const EdgeInsets.only(top: 15),
                                    //     padding: const EdgeInsets.symmetric(
                                    //       horizontal: 15,
                                    //     ),
                                    //     width: 200,
                                    //     height: 35,
                                    //     alignment: Alignment.centerLeft,
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         border: Border.all(
                                    //             color: ColorSelect.textField)),
                                    //     child: TextFormField(
                                    //       textAlignVertical:
                                    //           TextAlignVertical.center,
                                    //       style: TextController.BodyText,
                                    //       controller: ToDateHijri,
                                    //       decoration: InputDecoration(
                                    //           suffixIcon: Icon(
                                    //             Icons.calendar_month_outlined,
                                    //             size: 15,
                                    //           ),
                                    //           isDense: true,
                                    //           hintText:
                                    //               S.of(context).DateFormat,
                                    //           hintStyle:
                                    //               TextController.labelText,
                                    //           border: InputBorder.none),
                                    //       readOnly: true,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // if (toError)
                                //   Container(
                                //     margin: EdgeInsets.only(top: 5),
                                //     child: Text(
                                //       "This field is required.",
                                //       style: TextController.errorText,
                                //     ),
                                //   )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    S.of(context).PortfolioClassification,
                    style: TextController.BodyHeadingText,
                  ),
                ),
                Container(
                  height: 300,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                              "Investment Type",
                              style: TextController.BodyText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 20),
                            child: Text(
                              S.of(context).Category,
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
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                  iconEnabledColor: ColorSelect.east_dark_blue,
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
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                  value: InvestmentTypedropdownvalue.isNotEmpty
                                      ? InvestmentTypedropdownvalue
                                      : null,
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor: ColorSelect.east_dark_blue,
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
                                        InvestmentTypedropdownvalue = NewValue!;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                  iconEnabledColor: ColorSelect.east_dark_blue,
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
                                      groupValue: AllotmentType,
                                      onChanged: (value) {
                                        setState(() {
                                          AllotmentType =
                                              value!; //<-- change this
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
                                      groupValue: AllotmentType,
                                      onChanged: (value) {
                                        setState(() {
                                          AllotmentType =
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
                                margin:
                                    const EdgeInsets.only(top: 25, bottom: 20),
                                child: Text(
                                  S.of(context).Country,
                                  style: TextController.BodyText,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 25, bottom: 20),
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
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                              controller: Country,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  hintStyle:
                                                      TextController.labelText,
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
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
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
                                  iconEnabledColor: ColorSelect.east_dark_blue,
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
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 35,
                    width: 140,
                    decoration: BoxDecoration(
                      color: ColorSelect.east_blue,
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                            if (GlobalPermissionDPM.DPMdraftprogress[
                                    "ShareDetailandClassification"] ==
                                true) {
                              PutData(GlobalPermissionDPM.DPMid);
                            } else {
                              fundDetail();
                            }
                          }
                        } else {
                          // Handle case where _formKey.currentState is null
                        }
                        // print("idddddddd" + id);
                      },
                      // Switch tabs
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
        ),
      ),
    );
  }
}
