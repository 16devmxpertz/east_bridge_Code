import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

class OtherTab extends StatefulWidget {
  OtherTab({@required controller}) {
    tabController = controller;
  }

  @override
  State<OtherTab> createState() => OtherTabState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

final _formKey = GlobalKey<FormState>();

TabController? tabController;

class OtherTabState extends State<OtherTab> {
  String btn = "Next";
  bool RiskQueError = false;
  bool NationalityError = false;
  bool ResidencyError = false;
  bool accountTypeError = false;
  bool clientTypeError = false;
  bool sourceOfWealthError = false;
  bool _specifyError = false;
  bool Q1specifyError = false;
  bool Q3specifyError = false;
  bool Q4specifyError = false;
  bool Q1Error = false;
  bool Q3Error = false;
  bool Q4Error = false;
  bool sourceOfincomeError = false;

  TextEditingController _text1 = new TextEditingController();
  TextEditingController _text2 = new TextEditingController();
  TextEditingController _text3 = new TextEditingController();
  TextEditingController _text4 = new TextEditingController();
  TextEditingController _text5 = new TextEditingController();
  TextEditingController _text6 = new TextEditingController();
  TextEditingController _text7 = new TextEditingController();

  String Q1 = "";
  String Q3 = "";
  String Q4 = "";
  TextEditingController Q1specify = new TextEditingController();
  TextEditingController Q3specify = new TextEditingController();
  TextEditingController Q4specify = new TextEditingController();

  TextEditingController _employerName = new TextEditingController();
  TextEditingController _employerAddress = new TextEditingController();
  TextEditingController _employerPhone = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _specify = new TextEditingController();
// TextEditingController sourceOfWealth = new TextEditingController();
  TextEditingController politicallyExposedPerson = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();
  TextEditingController _typeAheadController2 = new TextEditingController();

  String? nationality;
  String? residency;
  String? accountType;
  String? clientType;

  String selectedValue = "";
  String? sourceOfincome;

  // OtherInfo({@required controller}) {
  //   tabController = controller;
  // }

  String? _selectedItem;
  String? _selectedItem2;

  void employee() async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtherInformationACorporate/OtherInformationACorporate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        // "clientId": GlobalPermissionCorporate.corporateclientid,
        // "residency": residency,
        // "accountType": accountType,
        // "nationality": nationality,
        // "clientType": clientType,
        // "sourceOfWealth": sourceOfincome,
        // "investingWithEastBridge": selectedValue,
        // "isTherePOA": "string",
        // "isTheClientBoard": "string",
        // "isTheClientBeneficial": "string"
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "residency": _typeAheadController2.text,
        "accountType": accountType == "Other" ? _specify.text : accountType,
        "nationality": _typeAheadController.text,
        "clientType": clientType,
        "sourceOfWealth": sourceOfincome,
        "investingWithEastBridge": selectedValue,
        "isTherePOA": Q1 == "Yes" ? Q1specify.text : Q1,
        "isTheClientBoard": Q3 == "Yes" ? Q3specify.text : Q3,
        "isTheClientBeneficial": Q4 == "No" ? Q4specify.text : Q4
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        GlobalPermissionCorporate.getdraftprogresscorporate(
            GlobalPermissionCorporate.corporateclientid);
        tabController?.animateTo(12);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getEmployeeInformation(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtherInformationACorporate/OtherInformationACorporate/$Id');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        setState(() {
          _typeAheadController2.text = jsonResponse['residency'];
          accountType = accnt.contains(jsonResponse['accountType'])
              ? jsonResponse['accountType']
              : "Other";
          _specify.text =
              accountType == "Other" ? jsonResponse['accountType'] : "";
          _typeAheadController.text = jsonResponse['nationality'];
          clientType = jsonResponse['clientType'];
          sourceOfincome = jsonResponse['sourceOfWealth'];
          selectedValue = jsonResponse['investingWithEastBridge'];
          Q1 = jsonResponse['isTherePOA'] == "No"
              ? jsonResponse['isTherePOA']
              : "Yes";
          Q1specify.text = jsonResponse['isTherePOA'] != "No"
              ? jsonResponse['isTherePOA']
              : "";

          Q3 = jsonResponse['isTheClientBoard'] == "No"
              ? jsonResponse['isTheClientBoard']
              : "Yes";
          Q3specify.text = jsonResponse['isTheClientBoard'] != "No"
              ? jsonResponse['isTheClientBoard']
              : "";
          Q4 = jsonResponse['isTheClientBeneficial'] == "Yes"
              ? jsonResponse['isTheClientBeneficial']
              : "No";
          Q4specify.text = jsonResponse['isTheClientBeneficial'] != "Yes"
              ? jsonResponse['isTheClientBeneficial']
              : "";
        });

        print("Employee information retrieved successfully:");
        print(jsonResponse);
      } else {
        print(
            "Failed to retrieve employee information. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  void updateEmployee(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/OtherInformationACorporate/OtherInformationACorporate/$Id');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        // "clientId": Id,
        // "residency": residency,
        // "accountType": accountType,
        // "nationality": nationality,
        // "clientType": clientType,
        // "sourceOfWealth": sourceOfincome,
        // "investingWithEastBridge": "string",
        // "isTherePOA": "string",
        // "isTheClientBoard": "string",
        // "isTheClientBeneficial": "string"
        "clientId": Id,
        "residency": _typeAheadController2.text,
        "accountType": accountType == "Other" ? _specify.text : accountType,
        "nationality": _typeAheadController.text,
        "clientType": clientType,
        "sourceOfWealth": sourceOfincome,
        "investingWithEastBridge": selectedValue,
        "isTherePOA": Q1 == "Yes" ? Q1specify.text : Q1,
        "isTheClientBoard": Q3 == "Yes" ? Q3specify.text : Q3,
        "isTheClientBeneficial": Q4 == "No" ? Q4specify.text : Q4
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        tabController?.animateTo(12);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
        print(
            "Failed to update employee information. Status code: ${response.statusCode}");
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    if (GlobalPermissionCorporate
            .corporatedraftprogress["OtherInformationACorporate"] ==
        true) {
      print("ftechinggg----------");
      getEmployeeInformation(GlobalPermissionCorporate.corporateclientid);
      print(GlobalPermissionCorporate.corporatedraftprogress);
      print("ftechinggg----------");
    }
  }

  var incomesource = [
    'Salary',
    'Personal Business',
    'Pension',
    'Investment',
    'Inheritance',
    'Real Estate',
    'Marketable Securities',
    'Other'
  ];
  var items = [
    'Korea',
    'Iran',
    'Myanmar',
    'Albania',
    'Barbados',
    'Burkina Faso',
    'Haiti',
    'South Sudan',
    'Mozambique',
    'Jamaica',
    'Gibraltar',
    'Jordan',
    'Mali',
    'Nigeria',
    'Panama',
    'Philippines',
    'Senegal',
    'South Africa',
    'Syria',
    'Tanzania',
    'United Arab Emirates (UAE)',
    'Uganda',
    'Yemen',
    'Democratic Republic of the Congo',
    'Cayman Islands',
    'China',
    'Russia',
    'Egypt',
    'Ukraine',
    'Algeria',
    'Tunisia',
    'Pakistan',
    'Uzbekistan',
    'Thailand',
    'Indonesia',
    'Morocco',
    'Others'
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

  var accnt = [
    'Employee',
    'Minor',
    'Political',
    'Other',
  ];
  var client = [
    'Natural Person',
    'Authorized Person',
  ];

  var member = [
    'Yes',
    'No',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(25),
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Investing with East Bridge Capital? *",
                                    style: TextController.BodyText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Less than 5 million",
                                    style: TextController.BodyText,
                                  ),
                                  Radio<String>(
                                    value: "Less Than 5 Million",
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue =
                                            value!; //<-- change this
                                        RiskQueError = false;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "More than 5 million",
                                    style: TextController.BodyText,
                                  ),
                                  Radio<String>(
                                    value: "More Than 5 Million",
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        RiskQueError = false;
                                        selectedValue =
                                            value!; //<-- change this
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Non Applicable",
                                    style: TextController.BodyText,
                                  ),
                                  Radio<String>(
                                    value: "Non Applicable",
                                    groupValue: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        RiskQueError = false;
                                        selectedValue =
                                            value!; //<-- change this
                                      });
                                    },
                                  ),
                                ],
                              ),
                              if (RiskQueError)
                                Text(
                                  "Select any option",
                                  style: TextController.errorText,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nationality" + " *",
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   citizenshipError =
                                                    //       false;
                                                    // });
                                                  },
                                                  controller:
                                                      _typeAheadController,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      hintText: S
                                                          .of(context)
                                                          .Citizenship)),
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
                                              NationalityError = false;
                                              _selectedItem = suggestion;
                                              _typeAheadController.text =
                                                  suggestion;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    if (NationalityError)
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
                        SizedBox(
                          width: 50,
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Residency" + " *",
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   citizenshipError =
                                                    //       false;
                                                    // });
                                                  },
                                                  controller:
                                                      _typeAheadController2,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      hintText: "Residency")),
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
                                              _selectedItem2 = suggestion;
                                              _typeAheadController2.text =
                                                  suggestion;
                                              ResidencyError = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    if (ResidencyError)
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
                        SizedBox(
                          width: 50,
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Account Type" + " *",
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: DropdownButton<String>(
                                        hint: Text("Select Here",
                                            style: TextController.labelText),
                                        value: accountType,
                                        isExpanded: true,
                                        underline: Container(),
                                        iconEnabledColor:
                                            ColorSelect.east_dark_blue,
                                        items: accnt.map(
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
                                              accountType = NewValue!;
                                              accountTypeError = false;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    if (accountTypeError)
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
                              // Flexible(
                              //   child: Container(
                              //     width: 270,
                              //     height: 44,
                              //     alignment: Alignment.centerLeft,
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         border: Border.all(
                              //             color: ColorSelect.textField)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(
                              //         left: 15,
                              //       ),
                              //       child: DropdownButtonHideUnderline(
                              //         child: Theme(
                              //           data: Theme.of(context).copyWith(
                              //               focusColor: Colors.white),
                              //           child: DropdownButtonFormField(
                              //             hint: Text(
                              //               S.of(context).SelectHere,
                              //               style: TextController.labelText,
                              //             ),
                              //             isExpanded: true,
                              //             icon: const Icon(
                              //                 Icons.keyboard_arrow_down),
                              //             decoration: InputDecoration(
                              //               enabledBorder: InputBorder.none,
                              //               border: InputBorder.none,
                              //               hoverColor: Colors.white,
                              //             ),
                              //             items: accnt.map((String items) {
                              //               return DropdownMenuItem(
                              //                 value: items,
                              //                 child: Text(items,
                              //                     style: TextController
                              //                         .BodyText),
                              //               );
                              //             }).toList(),
                              //             onChanged: (String? newValue) {
                              //               setState(() {
                              //                 accountType = newValue!;
                              //                 accountTypeError = false;
                              //               });
                              //             },
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Client Type" + " *",
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: DropdownButton<String>(
                                        hint: Text("Select Here",
                                            style: TextController.labelText),
                                        value: clientType,
                                        isExpanded: true,
                                        underline: Container(),
                                        iconEnabledColor:
                                            ColorSelect.east_dark_blue,
                                        items: client.map(
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
                                              clientType = NewValue!;
                                              clientTypeError = false;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    if (clientTypeError)
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
                              // Flexible(
                              //   child: Container(
                              //     width: 270,
                              //     height: 44,
                              //     alignment: Alignment.centerLeft,
                              //     decoration: BoxDecoration(
                              //         color: Colors.white,
                              //         border: Border.all(
                              //             color: ColorSelect.textField)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(
                              //         left: 15,
                              //       ),
                              //       child: DropdownButtonHideUnderline(
                              //         child: Theme(
                              //           data: Theme.of(context).copyWith(
                              //               focusColor: Colors.white),
                              //           child: DropdownButtonFormField(
                              //             hint: Text(
                              //               S.of(context).SelectHere,
                              //               style: TextController.labelText,
                              //             ),
                              //             isExpanded: true,
                              //             icon: const Icon(
                              //                 Icons.keyboard_arrow_down),
                              //             decoration: InputDecoration(
                              //               enabledBorder: InputBorder.none,
                              //               border: InputBorder.none,
                              //               hoverColor: Colors.white,
                              //             ),
                              //             items: client.map((String items) {
                              //               return DropdownMenuItem(
                              //                 value: items,
                              //                 child: Text(items,
                              //                     style: TextController
                              //                         .BodyText),
                              //               );
                              //             }).toList(),
                              //             onChanged: (String? newValue) {
                              //               setState(() {
                              //                 clientType = newValue!;
                              //                 clientTypeError = false;
                              //               });
                              //             },
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
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
                                "Source of Wealth" + " *",
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Container(
                                  width: 270,
                                  height: 35,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField)),
                                  child: DropdownButton(
                                    hint: Text("Select Here",
                                        style: TextController.labelText),
                                    value: sourceOfincome,
                                    isExpanded: true,
                                    underline: Container(),
                                    iconEnabledColor:
                                        ColorSelect.east_dark_blue,
                                    items: incomesource.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                            style: TextController.BodyText),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        sourceOfincomeError = false;
                                        sourceOfincome = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        (accountType == "Other")
                            ? Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 270,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            controller: _specify,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _specifyError = true;
                                                });
                                                return "";
                                              } else {
                                                setState(() {
                                                  _specifyError = false;
                                                });
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                              isDense: true,
                                              hintText:
                                                  "Please Specify Account Type",
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        if (_specifyError)
                                          Container(
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
                              )
                            : Flexible(
                                child: Container(),
                              ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: 500,
                                child: Text(
                                  "Is the Client a Board of Director or an Audit Committee member or a Senior Executive in a Listed Company?" +
                                      " *",
                                  style: TextController.BodyTextCC,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Flexible(
                                    // flex: 1,
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).Yes,
                                        style: TextController.BodyText,
                                      ),
                                      value: "Yes",
                                      tileColor: Colors.white,
                                      groupValue: Q1,
                                      onChanged: (value) {
                                        setState(() {
                                          Q1 = value.toString();
                                          Q1Error = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    // flex: 1,
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).No,
                                        style: TextController.BodyText,
                                      ),
                                      value: "No",
                                      tileColor: Colors.white,
                                      groupValue: Q1,
                                      onChanged: (value) {
                                        setState(() {
                                          Q1 = value.toString();
                                          Q1Error = false;
                                          Q1specify.text = "";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (Q1 == "Yes")
                                ? Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty &&
                                                      Q1 == "Yes") {
                                                    setState(() {
                                                      Q1specifyError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      Q1specifyError = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                controller: Q1specify,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle: TextStyle(
                                                    height: 0.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (Q1specifyError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Flexible(child: Container()),
                          ],
                        ),
                        if (Q1Error)
                          Text(
                            "This field is required.",
                            style: TextController.errorText,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    "Is there a Power of Attorney for this account?" +
                                        " *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 2,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).Yes,
                                        style: TextController.BodyText,
                                      ),
                                      value: "Yes",
                                      tileColor: Colors.white,
                                      groupValue: Q3,
                                      onChanged: (value) {
                                        setState(() {
                                          Q3 = value.toString();
                                          Q3Error = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).No,
                                        style: TextController.BodyText,
                                      ),
                                      value: "No",
                                      tileColor: Colors.white,
                                      groupValue: Q3,
                                      onChanged: (value) {
                                        setState(() {
                                          Q3 = value.toString();
                                          Q3Error = false;
                                          Q3specify.text = "";
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (Q3 == "Yes")
                                ? Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty &&
                                                      Q3 == "Yes") {
                                                    setState(() {
                                                      Q3specifyError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      Q3specifyError = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                controller: Q3specify,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle:
                                                      TextStyle(height: 0.0),
                                                ),
                                              ),
                                            ),
                                            if (Q3specifyError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Flexible(child: Container()),
                          ],
                        ),
                        if (Q3Error)
                          Text(
                            "This field is required.",
                            style: TextController.errorText,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: SizedBox(
                                  width: 500,
                                  child: Text(
                                    S.of(context).GeneralInfoQ5 + " *",
                                    style: TextController.BodyTextCC,
                                    maxLines: 2,
                                  )),
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).Yes,
                                        style: TextController.BodyText,
                                      ),
                                      value: "Yes",
                                      tileColor: Colors.white,
                                      groupValue: Q4,
                                      onChanged: (value) {
                                        setState(() {
                                          Q4 = value.toString();
                                          Q4Error = false;
                                          Q4specify.text = "";
                                        });
                                      },
                                    ),
                                  ),
                                  Flexible(
                                    child: RadioListTile(
                                      title: Text(
                                        S.of(context).No,
                                        style: TextController.BodyText,
                                      ),
                                      value: "No",
                                      tileColor: Colors.white,
                                      groupValue: Q4,
                                      onChanged: (value) {
                                        setState(() {
                                          Q4 = value.toString();
                                          Q4Error = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (Q4 == "No")
                                ? Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value!.isEmpty &&
                                                      Q4 == "No") {
                                                    setState(() {
                                                      Q4specifyError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      Q4specifyError = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                controller: Q4specify,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle:
                                                      TextStyle(height: 0.0),
                                                ),
                                              ),
                                            ),
                                            if (Q4specifyError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : Flexible(child: Container()),
                          ],
                        ),
                        if (Q4Error)
                          Text(
                            "This field is required.",
                            style: TextController.errorText,
                          ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
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
                                tabController?.animateTo(10);
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
                                // tabController?.animateTo(12);
                                if (_formKey.currentState != null) {
                                  setState(() {
                                    RiskQueError = selectedValue == "";
                                    NationalityError =
                                        _typeAheadController.text == "";
                                    ResidencyError =
                                        _typeAheadController2.text == "";
                                    clientTypeError = clientType == null;
                                    accountTypeError = accountType == null;

                                    Q1Error = Q1 == "";
                                    Q3Error = Q3 == "";
                                    Q4Error = Q4 == "";
                                  });

                                  if (_formKey.currentState!.validate() &&
                                      !RiskQueError &&
                                      !ResidencyError &&
                                      !clientTypeError &&
                                      !NationalityError &&
                                      !accountTypeError &&
                                      !Q1Error &&
                                      !Q3Error &&
                                      !Q4Error) {
                                    if (GlobalPermissionCorporate
                                                .corporatedraftprogress[
                                            "OtherInformationACorporate"] ==
                                        true) {
                                      updateEmployee(GlobalPermissionCorporate
                                          .corporateclientid);
                                    } else {
                                      if (GlobalPermissionCorporate
                                              .corporateclientid !=
                                          0) {
                                        employee();
                                        _formKey.currentState?.save();
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

                                // if (selectedValue != null) {
                                //   if (_typeAheadController.text != "") {
                                //     if (_typeAheadController2.text != "") {
                                //       if (accountType != null) {
                                //         if (clientType != null) {
                                //           if (sourceOfWealth.text != "") {
                                //             if (Q1 != null) {
                                //               if (Q3 != null) {
                                //                 if (Q4 != null) {
                                //                   if (_formKey.currentState!
                                //                       .validate()) {
                                //                     employee();

                                //                     tabController
                                //                         ?.animateTo(12);
                                //                   }
                                //                 } else {
                                //                   setState(() {
                                //                     Q4Error = true;
                                //                   });
                                //                 }
                                //               } else {
                                //                 setState(() {
                                //                   Q3Error = true;
                                //                 });
                                //               }
                                //             } else {
                                //               setState(() {
                                //                 Q1Error = true;
                                //               });
                                //             }
                                //           } else {
                                //             setState(() {
                                //               sourceOfWealthError = true;
                                //             });
                                //           }
                                //         } else {
                                //           setState(() {
                                //             clientTypeError = true;
                                //           });
                                //         }
                                //       } else {
                                //         setState(() {
                                //           accountTypeError = true;
                                //         });
                                //       }
                                //     } else {
                                //       setState(() {
                                //         ResidencyError = true;
                                //       });
                                //     }
                                //   } else {
                                //     setState(() {
                                //       NationalityError = true;
                                //     });
                                //   }
                                // } else {
                                //   setState(() {
                                //     RiskQueError = true;
                                //   });
                                // }
                                // tabController?.animateTo(5);
                              }, // Switch tabs
                              child: Text(
                                btn,
                                style: TextController.btnText,
                              ),
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
      ),
    );
  }
}
