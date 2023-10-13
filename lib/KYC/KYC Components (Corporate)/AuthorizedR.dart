import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/DPM/PortfolioCreation/ShareCreation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'RegisteredAddress.dart';

enum SingingCharacter { yes, no }

class AuthorizedInfo extends StatefulWidget {
  AuthorizedInfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<AuthorizedInfo> createState() => AuthorizedInfoState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;

class AuthorizedInfoState extends State<AuthorizedInfo> {
  String btn = "Next";
  bool BROError = false;
  bool BusinessPhoneError = false;
  bool NumberOfEmployesError = false;
  bool PaidUpCapitalError = false;
  bool AnnualTurnOverError = false;

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

// 1st Table
  List<List<TextEditingController>> authorizedrepresntative = [];

  List<List<TextEditingController>> dands = [];
  List<List<String>> dandsfinal = [];
  List<List<String>> authorizedrepresntativefinal = [];

// other fields
  TextEditingController BusinessPhone = new TextEditingController();
  TextEditingController NumberOfEmployes = new TextEditingController();
  TextEditingController PaidUpCapital = new TextEditingController();
  TextEditingController AnnualTurnOver = new TextEditingController();
  TextEditingController BRO = new TextEditingController();

  String _selectedItem = '';

  bool table1 = false;
  bool table2 = false;
  bool table3 = false;
  bool table4 = false;
  bool table21 = false;
  bool table22 = false;
  bool table23 = false;
  bool table24 = false;
  bool table25 = false;
  bool table26 = false;
  bool table27 = false;
  bool table28 = false;
  bool table29 = false;

  bool CountryofPracticingBusinessError = false;
  bool table1Error = false;
  bool table2Error = false;
  final _formKey = GlobalKey<FormState>();

  double height1 = 500;

  SingingCharacter? _character = SingingCharacter.yes;
  int? selectedValue = 1;

  String dropdownvalue = "";
//
//         List<dynamic> responseListtax =
//             responseData['taxrecidenceinformation'] ?? [];
//         for (int i = 0; i < responseListtax.length; i++) {
//           List<TextEditingController> x = [];
//           for (int j = 0; j < 3; j++) {
//             TextEditingController t = new TextEditingController();
//             t.text = responseListtax[i][j];
//             x.add(t);
//           }
//           setState(() {
//             taxrecidenceinformation.add(x);
//           });
//         }

  void fetchauth(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporatePart2/GetAuthorizedRepresentativesCorporate/${Id}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData);
      List<dynamic> responseList = responseData;
      for (int i = 0; i < responseList.length; i++) {
        List<TextEditingController> x = [];
        for (int j = 0; j < 5; j++) {
          TextEditingController t = new TextEditingController();
          t.text = responseList[i][j].toString();
          x.add(t);
        }
        setState(() {
          authorizedrepresntative.add(x);
        });
      }
      print("nexttt..");
      fetchdands(Id);
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  void fetchdands(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporateDirectorExecutives/GetAuthorizedRepresentativesCorporate/${Id}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      List<dynamic> responseList = responseData;
      for (int i = 0; i < responseList.length; i++) {
        List<TextEditingController> x = [];
        for (int j = 0; j < 2; j++) {
          TextEditingController t = new TextEditingController();
          t.text = responseList[i][j].toString();
          x.add(t);
        }
        setState(() {
          dands.add(x);
        });
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  void fetchData(int Id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedRepresentativesCorporate/${Id}');

    var headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print("fetchinggg1");
      print(responseData);
      BusinessPhone.text = responseData["businessPhone"];

      print("fetchinggg1");
      NumberOfEmployes.text = responseData["numberOfEmployes"].toString();
      print("fetchinggg1");
      PaidUpCapital.text = responseData["paidUpCapital"].toString();
      AnnualTurnOver.text = responseData["annualTurnOver"].toString();
      BRO.text = responseData["bro"].toString();
      print("nect");
      fetchauth(Id);
      // Now your UI elements are updated with the fetched data.
    } else {
      print(response.body);
    }
  }

  void addNewRowauthorized() {
    List<TextEditingController> li = [];
    for (int i = 0; i < 5; i++) {
      TextEditingController tt = new TextEditingController();
      li.add(tt);
    }

    setState(() {
      authorizedrepresntative.add(li);
    });
  }

  void addNewRowdands() {
    List<TextEditingController> li = [];
    for (int i = 0; i < 3; i++) {
      TextEditingController tt = new TextEditingController();
      li.add(tt);
    }

    setState(() {
      dands.add(li);
    });
  }

  void deleteRowauthorized() {
    setState(() {
      authorizedrepresntative.removeLast();
    });
  }

  void deleterowRowdands() {
    setState(() {
      dands.removeLast();
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      dands.clear();
      authorizedrepresntative.clear();
    });

    print(GlobalPermissionCorporate.corporateclientid);
    if (GlobalPermissionCorporate
            .corporatedraftprogress["AuthorizedRepresentativesCorporate"] ==
        true) {
      fetchData(GlobalPermissionCorporate.corporateclientid);
    } else {
      addNewRowauthorized();
      addNewRowdands();
    }
  }

  @override
  void senddands() async {
    print("sendinggg..");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporateDirectorExecutives/AuthorizedCorporateDirectorExecutives');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "table1": authorizedrepresntativefinal,
      "table2": dandsfinal,
      "bro": BRO.text,
      "businessPhone": BusinessPhone.text,
      "numberOfEmployes": int.parse(NumberOfEmployes.text),
      "paidUpCapital": int.parse(PaidUpCapital.text),
      "annualTurnOver": int.parse(AnnualTurnOver.text),
    };
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      GlobalPermissionCorporate.getdraftprogresscorporate(
          GlobalPermissionCorporate.corporateclientid);
      tabController?.animateTo(3);
      setState(() {
        btn = "Next";
      });
    } else {
      setState(() {
        btn = "Next";
      });
      print(response.statusCode);
      print(response.body);
    }
  }

  void sendDataauth() async {
    print("sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporatePart2/AuthorizedCorporatePart2Controller');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "table1": authorizedrepresntativefinal,
        "table2": dandsfinal,
        "bro": BRO.text,
        "businessPhone": BusinessPhone.text,
        "numberOfEmployes": int.parse(NumberOfEmployes.text),
        "paidUpCapital": int.parse(PaidUpCapital.text),
        "annualTurnOver": int.parse(AnnualTurnOver.text),
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        senddands();
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void sendData() async {
    setState(() {
      btn = "Loading...";
    });
    print("sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedRepresentativesCorporate/AuthorizedRepresentativesCorporate');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermissionCorporate.corporateclientid,
        "table1": authorizedrepresntativefinal,
        "table2": dandsfinal,
        "bro": BRO.text,
        "businessPhone": BusinessPhone.text,
        "numberOfEmployes": int.parse(NumberOfEmployes.text),
        "paidUpCapital": int.parse(PaidUpCapital.text),
        "annualTurnOver": int.parse(AnnualTurnOver.text),
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("Authorized Is Working");
        sendDataauth();
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
        print(response.body);
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void Updatedands(int Id) async {
    print("sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporateDirectorExecutives/UpdateAuthorizedCorporateDirectorExecutives');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "table1": authorizedrepresntativefinal,
      "table2": dandsfinal,
      "bro": BRO.text,
      "businessPhone": BusinessPhone.text,
      "numberOfEmployes": int.parse(NumberOfEmployes.text),
      "paidUpCapital": int.parse(PaidUpCapital.text),
      "annualTurnOver": int.parse(AnnualTurnOver.text),
    };
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      GlobalPermissionCorporate.getdraftprogresscorporate(
          GlobalPermissionCorporate.corporateclientid);
      tabController?.animateTo(3);
      setState(() {
        btn = "Next";
      });
    } else {
      setState(() {
        btn = "Next";
      });
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
    }
  }

  void UpdateDataauth(int id) async {
    print("sendinggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedCorporatePart2/UpdateAuthorizedRepresentativesCorporate');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "table1": authorizedrepresntativefinal,
      "table2": dandsfinal,
      "bro": BRO.text,
      "businessPhone": BusinessPhone.text,
      "numberOfEmployes": int.parse(NumberOfEmployes.text),
      "paidUpCapital": int.parse(PaidUpCapital.text),
      "annualTurnOver": int.parse(AnnualTurnOver.text),
    };
    var response =
        await http.put(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("lebel up");
      Updatedands(id);
    } else {
      setState(() {
        btn = "Next";
      });
      print(response.statusCode);
      print(response.body);
    }
  }

  void PutData(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    print("updatingggg");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/AuthorizedRepresentativesCorporate/AuthorizedRepresentativesCorporate?ClientId=$Id');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": Id,
        "table1": authorizedrepresntativefinal,
        "table2": dandsfinal,
        "bro": BRO.text,
        "businessPhone": BusinessPhone.text,
        "numberOfEmployes": int.parse(NumberOfEmployes.text),
        "paidUpCapital": int.parse(PaidUpCapital.text),
        "annualTurnOver": int.parse(AnnualTurnOver.text),
      };

      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print("updatingggg Done");
        UpdateDataauth(Id);
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  var _items = [
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
    ''
  ];

  @override
  Widget build(BuildContext context) {
    // @override
    // void initState() {
    //   super.initState();
    //   dateController.text = " ";
    // }

    return Material(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Authorized Representative",
                    style: TextController.SubHeadingText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                // 0: FixedColumnWidth(400),
                                // 1: FixedColumnWidth(400),
                                // 2: FixedColumnWidth(400),
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                        height: 70,
                                        color: ColorSelect.east_grey,
                                        child: Center(
                                            child: Text(
                                          "Full Name *",
                                          style: TextController.tableHeading,
                                        ))),
                                    Container(
                                        height: 70,
                                        color: ColorSelect.east_grey,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Center(
                                              child: Text(
                                            "Citizenship *",
                                            style: TextController.tableHeading,
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
                                          "Citizenship ID *",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        )),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      color: ColorSelect.east_grey,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          "Position/Title",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        )),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      color: ColorSelect.east_grey,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                            child: Text(
                                          "Contact/Phone Number *",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                for (int i = 0;
                                    i < authorizedrepresntative.length;
                                    i++)
                                  TableRow(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          controller: authorizedrepresntative[i]
                                              [0],
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return "This field is required.";
                                          //   }
                                          //   return null;
                                          // },
                                          textAlign: TextAlign.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                            errorStyle:
                                                TextController.inputErrorText,
                                            enabledBorder: InputBorder.none,
                                            hintStyle: TextController.labelText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TypeAheadField(
                                          textFieldConfiguration:
                                              TextFieldConfiguration(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textAlign: TextAlign.center,
                                            controller:
                                                authorizedrepresntative[i][1],
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                              enabledBorder: InputBorder.none,
                                            ),
                                          ),
                                          suggestionsCallback: (pattern) {
                                            // Return a filtered list of suggestions based on the search pattern.
                                            return _items
                                                .where((item) => item
                                                    .toLowerCase()
                                                    .contains(
                                                        pattern.toLowerCase()))
                                                .toList();
                                          },
                                          itemBuilder: (context, suggestion) {
                                            return ListTile(
                                              title: Text(suggestion),
                                            );
                                          },
                                          onSuggestionSelected: (suggestion) {
                                            // Update the selected item when a suggestion is selected.
                                            setState(() {
                                              _selectedItem = suggestion;
                                              authorizedrepresntative[i][1]
                                                  .text = suggestion;
                                            });
                                          },
                                        ),

                                        //   TextFormField(
                                        //     style: TextController.BodyText,
                                        //     textAlignVertical:
                                        //         TextAlignVertical.center,
                                        //     textAlign: TextAlign.center,
                                        //     controller: authorizedrepresntative[i]
                                        //         [1],
                                        //     decoration: InputDecoration(
                                        //       isDense: true,
                                        //       errorStyle:
                                        //           TextController.inputErrorText,
                                        //       border: InputBorder.none,
                                        //     ),
                                        //     validator: (value) {
                                        //       if (value!.isEmpty) {
                                        //         return 'This field is required.';
                                        //       }
                                        //       return null; // Return null if the input is valid
                                        //     },
                                        //   ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          style: TextController.BodyText,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          controller: authorizedrepresntative[i]
                                              [3],
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'This field is required.';
                                          //   }
                                          //   return null; // Return null if the input is valid
                                          // },
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          style: TextController.BodyText,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          controller: authorizedrepresntative[i]
                                              [4],
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'This field is required.';
                                          //   }
                                          //   return null; // Return null if the input is valid
                                          // },
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextController.BodyText,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          controller: authorizedrepresntative[i]
                                              [2],
                                          decoration: InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'This field is required.';
                                          //   }
                                          //   return null; // Return null if the input is valid
                                          // },
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            if (table1Error)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "This field is required.",
                                  style: TextController.errorText,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: addNewRowauthorized,
                          child: Text('Add Row'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (authorizedrepresntative.length != 0)
                          ElevatedButton(
                            onPressed: deleteRowauthorized,
                            child: Text('Delete Row'),
                          ),
                      ],
                    ),
                  ),

                  //

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        S
                            .of(context)
                            .AuthorizedRepresentativesshouldcompleteaseparateindividualKYCform,
                        style: TextController.BodyText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          S.of(context).DirectorSeniorExecutives,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),

                  ///

                  Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        child: Column(
                          children: [
                            Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                // 0: FixedColumnWidth(400),
                                // 1: FixedColumnWidth(400),
                                // 2: FixedColumnWidth(400),
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                  children: [
                                    Container(
                                        height: 70,
                                        color: ColorSelect.east_grey,
                                        child: Center(
                                            child: Text(
                                          "Full Name *",
                                          style: TextController.tableHeading,
                                        ))),
                                    Container(
                                        height: 70,
                                        color: ColorSelect.east_grey,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Center(
                                              child: Text(
                                            "Position/Title *",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          )),
                                        )),
                                  ],
                                ),
                                for (int i = 0; i < dands.length; i++)
                                  TableRow(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          controller: dands[i][0],
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                            errorStyle:
                                                TextController.inputErrorText,
                                            enabledBorder: InputBorder.none,
                                            hintStyle: TextController.labelText,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 50,
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          textAlign: TextAlign.center,
                                          controller: dands[i][1],
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            isDense: true,
                                            errorStyle:
                                                TextController.inputErrorText,
                                            enabledBorder: InputBorder.none,
                                            hintStyle: TextController.labelText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                            if (table2Error)
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  "This field is required.",
                                  style: TextController.errorText,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: addNewRowdands,
                          child: Text('Add Row'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        if (dands.length != 0)
                          ElevatedButton(
                            onPressed: deleterowRowdands,
                            child: Text('Delete Row'),
                          ),
                      ],
                    ),
                  ),

                  ////////

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            S.of(context).BRO + " *" + " :",
                            style: TextController.BodyText,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: 780,
                              height: 35,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: ColorSelect.textField)),
                              child: TextFormField(
                                style: TextController.BodyText,
                                textAlignVertical: TextAlignVertical.center,
                                controller: BRO,
                                decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).TypeHere,
                                    errorStyle: TextController.inputErrorText,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     setState(() {
                                //       BROError = true;
                                //     });
                                //     return '';
                                //   } else {
                                //     setState(() {
                                //       BROError = false;
                                //     });
                                //   }
                                //   return null; // Return null if the input is valid
                                // },
                              ),
                            ),
                            // if (BROError)
                            //   Container(
                            //     margin: EdgeInsetsDirectional.only(top: 10),
                            //     child: Text(
                            //       "This field is required.",
                            //       style: TextController.errorText,
                            //     ),
                            //   )
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
                            Container(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text(
                                S.of(context).BusinessPhone + " *",
                                style: TextController.BodyText,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: IntlPhoneField(
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      disableLengthCheck: true,
                                      // dropdownDecoration : BoxDecoration(
                                      //   shape : BoxShape.rectangle,
                                      // ),
                                      // initialCountryCode: "",
                                      // validator: (value) {
                                      //   if (value!.number == "") {
                                      //     print(
                                      //         "++++++++++++++++");
                                      //     return 'Enter a valid phone number';
                                      //   }
                                      //   return null;
                                      // },

                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      showDropdownIcon: false,
                                      pickerDialogStyle: PickerDialogStyle(
                                        width: 400,
                                      ),
                                      showCountryFlag: false,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: BusinessPhone,
                                      dropdownTextStyle:
                                          TextController.BodyText,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        counterText: "",
                                        hintText: S.of(context).ResPhLabel,
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        errorStyle: TextStyle(
                                          fontFamily: 'Gotham',
                                          fontSize: 7.0,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          height: 0.01,
                                        ),
                                      ),
                                      onCountryChanged: (country) {
                                        print('Country changed to: ' +
                                            country.name);
                                      },
                                    ),
                                  ),
                                  if (BusinessPhoneError)
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 10),
                                      child: Text(
                                        "This field is required.",
                                        style: TextController.errorText,
                                      ),
                                    )
                                ],
                              ),
                            ),
                            // Flexible(
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         border: Border.all(
                            //             color: ColorSelect.textField)),
                            //     width: 270,
                            //     height: 35,
                            //     child: Row(
                            //       children: [
                            //         CountryCodePicker(
                            //           flagWidth: 20,
                            //           showFlag: false,
                            //           onChanged: print,
                            //           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            //           initialSelection: 'sa',
                            //           favorite: const ['+39', 'FR'],

                            //           showFlagDialog: false,

                            //           //Get the country information relevant to the initial selection
                            //         ),
                            //         Flexible(
                            //           child: Container(
                            //             width: 230,
                            //             height: 35,
                            //             padding: EdgeInsets.symmetric(
                            //                 horizontal: 10),
                            //             alignment: Alignment.centerLeft,
                            //             child: TextFormField(
                            //               controller: BusinessPhone,
                            //               textAlignVertical:
                            //                   TextAlignVertical.center,
                            //               style: TextController.BodyHeadingText,
                            //               keyboardType: TextInputType.number,
                            //               maxLength: 12,
                            //               validator: (value) {
                            //                 if (value!.isEmpty) {
                            //                   return 'This field is required.';
                            //                 }
                            //                 if (value.isNotEmpty &&
                            //                     (value.length < 4 ||
                            //                         value.length > 12)) {
                            //                   return 'Invalid Number';
                            //                 }
                            //                 return null; // Return null if the input is valid
                            //               },
                            //               inputFormatters: <TextInputFormatter>[
                            //                 FilteringTextInputFormatter
                            //                     .digitsOnly
                            //               ],
                            //               decoration: InputDecoration(
                            //                 counterText: "",
                            //                 isDense: true,
                            //                 hintText: S.of(context).ResPhLabel,
                            //                 hintStyle: TextController.labelText,
                            //                 border: InputBorder.none,
                            //                 errorStyle:
                            //                     TextController.inputErrorText,
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "Number Of\nEmployees *",
                                style: TextController.BodyText,
                              ),
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
                                    child: TextFormField(
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      maxLength: 9,
                                      controller: NumberOfEmployes,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            NumberOfEmployesError = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            NumberOfEmployesError = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: S.of(context).number,
                                        errorStyle: TextStyle(height: 0.0),
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                  if (NumberOfEmployesError)
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 10),
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
                        width: 10,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                "Paid-Up\nCapital *",
                                style: TextController.BodyText,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      maxLength: 10,
                                      controller: PaidUpCapital,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            PaidUpCapitalError = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            PaidUpCapitalError = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Enter Here",
                                        errorStyle: TextStyle(height: 0.0),
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                  if (PaidUpCapitalError)
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 10),
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
                        width: 10,
                      ),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "Annual Turn\nOver *",
                                style: TextController.BodyText,
                              ),
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
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            AnnualTurnOverError = true;
                                          });
                                          return '';
                                        } else {
                                          setState(() {
                                            AnnualTurnOverError = false;
                                          });
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      maxLength: 10,
                                      controller: AnnualTurnOver,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        errorStyle: TextStyle(height: 0.0),
                                        hintText: "Enter Here",
                                        hintStyle: TextController.labelText,
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                  if (AnnualTurnOverError)
                                    Container(
                                      margin:
                                          EdgeInsetsDirectional.only(top: 5),
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
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
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
                              tabController?.animateTo(1);
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
                              setState(() {
                                table1Error = false;
                              });
                              authorizedrepresntativefinal.clear();
                              for (List li in authorizedrepresntative) {
                                List<String> x = [];
                                for (int j = 0; j < 5; j++) {
                                  x.add(li[j].value.text);
                                  if (li[j].value.text == "") {
                                    setState(() {
                                      table1Error = true;
                                    });
                                  }
                                }
                                authorizedrepresntativefinal.add(x);
                              }

                              dandsfinal.clear();
                              for (List li in dands) {
                                setState(() {
                                  table2Error = false;
                                });
                                List<String> x = [];
                                for (int j = 0; j < 2; j++) {
                                  x.add(li[j].value.text);
                                  if (li[j].value.text == "") {
                                    table2Error = true;
                                  }
                                }
                                dandsfinal.add(x);
                              }
                              if (_formKey.currentState != null) {
                                setState(() {
                                  BusinessPhoneError = BusinessPhone.text == "";
                                });
                              }
                              if (_formKey.currentState!.validate() &&
                                  !table1Error &&
                                  !BusinessPhoneError &&
                                  !table2Error) {
                                // if (authorizedrepresntativefinal.isEmpty) {
                                //   setState(() {
                                //     table1Error = true;
                                //   });
                                // }
                                if (GlobalPermissionCorporate
                                            .corporatedraftprogress[
                                        "AuthorizedRepresentativesCorporate"] ==
                                    true) {
                                  print("Update data workingggg");
                                  PutData(GlobalPermissionCorporate
                                      .corporateclientid);
                                } else {
                                  if (GlobalPermissionCorporate
                                          .corporateclientid !=
                                      0) {
                                    sendData();
                                    _formKey.currentState?.save();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill general info first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                                //AuthorizedRepresentative();

                                // tabController?.animateTo(3);
                              }
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
    );
  }
}
