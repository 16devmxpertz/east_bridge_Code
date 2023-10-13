import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/GlobalPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class OtherInfoPOA extends StatefulWidget {
  OtherInfoPOA({@required controller}) {
    tabController = controller;
  }

  @override
  State<OtherInfoPOA> createState() => _OtherInfoPOAState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class _OtherInfoPOAState extends State<OtherInfoPOA>
    with TickerProviderStateMixin {
  String btn = "Next";
  // OtherInfo({@required controller}) {
  //   tabController = controller;
  // }
  final _formKey = GlobalKey<FormState>();

  TextEditingController _employerName = new TextEditingController();
  TextEditingController _employerAddress = new TextEditingController();
  TextEditingController _employerPhone = new TextEditingController();
  TextEditingController _duration = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();
  TextEditingController _typeAheadController2 = new TextEditingController();
  TextEditingController _specify = new TextEditingController();
  TextEditingController _specify2 = new TextEditingController();

  String nationality = "";
  String residency = "";
  String? accountType;
  String? clientType;
  String selectedValue = "";
  String selectedValue2 = "";
  bool investingError = false;
  bool nationalityError = false;
  bool residencyError = false;
  bool accountTypeError = false;
  bool clientTypeError = false;
  bool attorneyError = false;
  bool _specify2Error = false;

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

  String? _selectedItem;
  String _selectedItem2 = '';

  @override
  void initState() {
    super.initState();
    // getdata(9043);

    print("Init Runnng");
    if (GlobalPOA.poadraftprogress["OtherInfoPOA"] == true) {
      print("ftechinggg----------");
      getdata(GlobalPOA.poalclientid);
    }
  }

  Future getdata(int clientId) async {
    print("getting");
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/OtherInfoPOA/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // await Future.delayed(Duration(seconds: 2));

      setState(() {
        accountType = data["accountType"];
        clientType = data["clientType"];
        selectedValue = data["investing"];
        selectedValue2 = data["isPOA"] == "" ? "No" : "Yes";
      });
      _typeAheadController.text = data["nationality"];
      _typeAheadController2.text = data["residency"];
      _specify2.text = data["isPOA"];

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
    var url = Uri.parse('${GlobalPermission.urlLink}/api/OtherInfoPOA/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPOA.poalclientid,
        "investing": selectedValue,
        "nationality": _typeAheadController.text,
        "residency": _typeAheadController2.text,
        "accountType": accountType,
        "clientType": clientType,
        "IsPOA": _specify2.text == "" ? "No" : _specify2.text
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        GlobalPOA.getdraftprogresspoa(GlobalPOA.poalclientid);
        tabController?.animateTo(9);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    } catch (e) {
      print(e.toString());
    }
  }

  void putdata(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/OtherInfoPOA/${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "investing": selectedValue,
        "nationality": _typeAheadController.text,
        "residency": _typeAheadController2.text,
        "accountType": accountType,
        "clientType": clientType,
        "IsPOA": _specify2.text == "" ? "No" : _specify2.text
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        tabController?.animateTo(9);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    } catch (e) {
      print(e.toString());
    }
  }

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

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu

    // @override
    // void initState(){
    //   super.initState();
    //   dateController.text=" ";
    // }

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Scaffold(
          body: Container(
              color: Colors.white,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Investing with east bridge capital? *",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Radio<String>(
                                          value: "Less Than 5 Million",
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              investingError = false;
                                              selectedValue =
                                                  value!; //<-- change this
                                            });
                                          },
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Less than 5 Million",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Radio<String>(
                                          value: "More Than 5 Million",
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              investingError = false;
                                              selectedValue =
                                                  value!; //<-- change this
                                            });
                                          },
                                        ),
                                        Flexible(
                                          child: Text(
                                            "More than 5 Million",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        Radio<String>(
                                          value: "Non Applicable",
                                          groupValue: selectedValue,
                                          onChanged: (value) {
                                            setState(() {
                                              investingError = false;
                                              selectedValue =
                                                  value!; //<-- change this
                                            });
                                          },
                                        ),
                                        Flexible(
                                          child: Text(
                                            "Non Applicable",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (investingError)
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
                              SizedBox(
                                width: 150,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nationality *",
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
                                                horizontal: 10),
                                            width: 270,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TypeAheadField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        onTap: () {
                                                          setState(() {
                                                            nationalityError =
                                                                false;
                                                          });
                                                        },
                                                        controller:
                                                            _typeAheadController,
                                                        style: TextController
                                                            .BodyText,
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
                                                                .TypeHere)),
                                                suggestionsCallback: (pattern) {
                                                  // Return a filtered list of suggestions based on the search pattern.
                                                  return citizenship
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
                                          ),
                                          if (nationalityError)
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
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Residency *",
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
                                                horizontal: 10),
                                            width: 270,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: TypeAheadField(
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                        onTap: () {
                                                          setState(() {
                                                            residencyError =
                                                                false;
                                                          });
                                                        },
                                                        controller:
                                                            _typeAheadController2,
                                                        style: TextController
                                                            .BodyText,
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
                                                                .Citizenship)),
                                                suggestionsCallback: (pattern) {
                                                  // Return a filtered list of suggestions based on the search pattern.
                                                  return citizenship
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
                                                    _selectedItem2 = suggestion;
                                                    _typeAheadController2.text =
                                                        suggestion;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          if (residencyError)
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
                                width: 90,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Account type *",
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
                                                horizontal: 10),
                                            width: 270,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: DropdownButton<String>(
                                              hint: Text("Select Here",
                                                  style:
                                                      TextController.labelText),
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
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (NewValue) {
                                                setState(
                                                  () {
                                                    accountType = NewValue!;
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
                                          if (accountType == "Other")
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
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
                                                  if (value!.isEmpty) {
                                                    return 'This field is required.';
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                                controller: _specify,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController
                                                    .BodyHeadingText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText: "Please Specify",
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle: TextController
                                                      .inputErrorText,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Client type *",
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
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 15,
                                                ),
                                                child: DropdownButton(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value: clientType,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: client
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items,
                                                          style: TextController
                                                              .BodyText),
                                                    );
                                                  }).toList(),
                                                  onChanged: (newValue) {
                                                    setState(() {
                                                      clientTypeError = false;
                                                      clientType = newValue!;
                                                    });
                                                  },
                                                ),
                                              )),
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
                                  ],
                                ),
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
                                children: [
                                  Flexible(
                                    child: Text(
                                      S
                                              .of(context)
                                              .Isthereapowerofattorneyontheaccount +
                                          "? *",
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Yes",
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  Radio<String>(
                                    value: "Yes",
                                    groupValue: selectedValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        attorneyError = false;
                                        selectedValue2 =
                                            value!; //<-- change this
                                      });
                                    },
                                  ),
                                  Flexible(
                                    child: Text(
                                      "No",
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  Radio<String>(
                                    value: "No",
                                    groupValue: selectedValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        attorneyError = false;
                                        selectedValue2 =
                                            value!; //<-- change this
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  if (selectedValue2 == "Yes")
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
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
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  _specify2Error = true;
                                                });
                                                return '';
                                              } else {
                                                setState(() {
                                                  _specify2Error = false;
                                                });
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            controller: _specify2,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style:
                                                TextController.BodyHeadingText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Please Specify",
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                            ),
                                          ),
                                        ),
                                        if (_specify2Error)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Text(
                                              "This field is required.",
                                              style: TextController.errorText,
                                            ),
                                          )
                                      ],
                                    )
                                ],
                              ),
                              if (attorneyError)
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "This field is required.",
                                    style: TextController.errorText,
                                  ),
                                ),
                            ],
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
                                      tabController?.animateTo(7);
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
                                        setState(() {
                                          investingError = selectedValue == "";
                                          nationalityError =
                                              _typeAheadController.text == "";
                                          residencyError =
                                              _typeAheadController2.text == "";
                                          accountTypeError =
                                              accountType == null;
                                          clientTypeError = clientType == null;
                                          attorneyError = selectedValue2 == "";
                                          // accountType ??= "";
                                          // // dropdownvalueIdType ??= "";
                                          // clientType ??= "";
                                        });

                                        if (_formKey.currentState!.validate() &&
                                            !investingError &&
                                            !nationalityError &&
                                            !residencyError &&
                                            !accountTypeError &&
                                            !clientTypeError &&
                                            !attorneyError) {
                                          _formKey.currentState?.save();
                                          if (GlobalPOA.poadraftprogress[
                                                  "OtherInfoPOA"] ==
                                              true) {
                                            putdata(GlobalPOA.poalclientid);
                                          } else {
                                            if (GlobalPOA.poalclientid != 0) {
                                              senddata();
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Please fill personal info first",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
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
                                      // if (selectedValue != "") {
                                      //   if (_typeAheadController.text != "") {
                                      //     if (_typeAheadController2.text != "") {
                                      //       if (accountType != "") {
                                      //         if (clientType != "") {
                                      //           if (selectedValue2 != "") {
                                      //             if ((_formKey.currentState!
                                      //                 .validate())) {
                                      //               _formKey.currentState?.save();
                                      //               employee();
                                      //             }
                                      //           } else {
                                      //             setState(() {
                                      //               attorneyError = true;
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
                                      //         residencyError = true;
                                      //       });
                                      //     }
                                      //   } else {
                                      //     setState(() {
                                      //       nationalityError = true;
                                      //     });
                                      //   }
                                      // } else {
                                      //   setState(() {
                                      //     investingError = true;
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
