import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

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

// 1st Table
TextEditingController FullName1 = new TextEditingController();
TextEditingController _typeAheadController1 = new TextEditingController();
TextEditingController CitizenshipID1 = new TextEditingController();
TextEditingController Position1 = new TextEditingController();
TextEditingController PhoneNumber1 = new TextEditingController();

// 2nd Table
TextEditingController FullName2 = new TextEditingController();
TextEditingController _typeAheadController2 = new TextEditingController();
TextEditingController CitizenshipID2 = new TextEditingController();
TextEditingController Position2 = new TextEditingController();
TextEditingController PhoneNumber2 = new TextEditingController();

// 3rd Table
TextEditingController FullName3 = new TextEditingController();
TextEditingController _typeAheadController3 = new TextEditingController();
TextEditingController CitizenshipID3 = new TextEditingController();
TextEditingController Position3 = new TextEditingController();
TextEditingController PhoneNumber3 = new TextEditingController();

// 4th Table
TextEditingController FullName4 = new TextEditingController();
TextEditingController _typeAheadController4 = new TextEditingController();
TextEditingController CitizenshipID4 = new TextEditingController();
TextEditingController Position4 = new TextEditingController();
TextEditingController PhoneNumber4 = new TextEditingController();

// 5th Table
TextEditingController FullName5 = new TextEditingController();
TextEditingController _typeAheadController5 = new TextEditingController();
TextEditingController CitizenshipID5 = new TextEditingController();
TextEditingController Position5 = new TextEditingController();
TextEditingController PhoneNumber5 = new TextEditingController();

// Director 1st Table
TextEditingController DirectorFullName1 = new TextEditingController();
TextEditingController DirectorPosition1 = new TextEditingController();

// Director 2nd Table
TextEditingController DirectorFullName2 = new TextEditingController();
TextEditingController DirectorPosition2 = new TextEditingController();

// Director 3rd Table
TextEditingController DirectorFullName3 = new TextEditingController();
TextEditingController DirectorPosition3 = new TextEditingController();

// Director 4th Table
TextEditingController DirectorFullName4 = new TextEditingController();
TextEditingController DirectorPosition4 = new TextEditingController();

// Director 5th Table
TextEditingController DirectorFullName5 = new TextEditingController();
TextEditingController DirectorPosition5 = new TextEditingController();

// Director 6th Table
TextEditingController DirectorFullName6 = new TextEditingController();
TextEditingController DirectorPosition6 = new TextEditingController();

// Director 7th Table
TextEditingController DirectorFullName7 = new TextEditingController();
TextEditingController DirectorPosition7 = new TextEditingController();

// Director 8th Table
TextEditingController DirectorFullName8 = new TextEditingController();
TextEditingController DirectorPosition8 = new TextEditingController();

// Director 9th Table
TextEditingController DirectorFullName9 = new TextEditingController();
TextEditingController DirectorPosition9 = new TextEditingController();

// Director 10th Table
TextEditingController DirectorFullName10 = new TextEditingController();
TextEditingController DirectorPosition10 = new TextEditingController();

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

bool CountryofPracticingBusinessError = false;

class AuthorizedInfoState extends State<AuthorizedInfo> {
final _formKey = GlobalKey<FormState>();

  double height1 = 500;

  SingingCharacter? _character = SingingCharacter.yes;
  int? selectedValue = 1;

  String dropdownvalue = "";
  @override
  Widget build(BuildContext context) {
    @override
    void AuthorizedRepresentative() async {
      var url = Uri.parse(
          'https://eastbridge.online/apicore/api/AuthorizedRepresentativesCorporate/AuthorizedRepresentativesCorporate/');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };

        var body = {
          "clientId": AuthorizedInfo.id.value,
          "fullName1": FullName1.text,
          "fullName2": FullName2.text,
          "fullName3": FullName3.text,
          "fullName4": FullName4.text,
          "citizenshhip1": _typeAheadController1.text,
          "citizenshhip2": _typeAheadController2.text,
          "citizenshhip3": _typeAheadController3.text,
          "citizenshhip4": _typeAheadController4.text,
          "citizenshipId1": CitizenshipID1.text,
          "citizenshipId2": CitizenshipID2.text,
          "citizenshipId3": CitizenshipID3.text,
          "citizenshipId4": CitizenshipID4.text,
          "position1": Position1.text,
          "position2": Position2.text,
          "position3": Position3.text,
          "position4": Position4.text,
          "phoneNumber1": PhoneNumber1.text,
          "phoneNumber2": PhoneNumber2.text,
          "phoneNumber3": PhoneNumber3.text,
          "phoneNumber4": PhoneNumber4.text,
          "directorFullName1": DirectorFullName1.text,
          "directorFullName2": DirectorFullName2.text,
          "directorFullName3": DirectorFullName3.text,
          "directorFullName4": DirectorFullName4.text,
          "directorPosition1": DirectorPosition1.text,
          "directorPosition2": DirectorPosition2.text,
          "directorPosition3": DirectorPosition3.text,
          "directorPosition4": DirectorPosition4.text,
          "businessPhone": BusinessPhone.text,
          "numberOfEmployes": NumberOfEmployes.text,
          "paidUpCapital": PaidUpCapital.text,
          "annualTurnOver": AnnualTurnOver.text,
          "bro": BRO.text
        };
        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print(jsonDecode(response.body));
          tabController?.animateTo(3);
        } else {
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
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Table(
                              columnWidths: {
                                // 0: FixedColumnWidth(300),
                                // 1: FixedColumnWidth(300),
                                // 2: FixedColumnWidth(300),
                                // 3: FixedColumnWidth(300),
                                // 4: FixedColumnWidth(250),
                                // 5: FixedColumnWidth(70),
                                0: FlexColumnWidth(1),
                                1: FlexColumnWidth(1),
                                2: FlexColumnWidth(1),
                                3: FlexColumnWidth(1),
                                4: FlexColumnWidth(1),
                                5: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: ColorSelect.east_grey,
                                  ),
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            S.of(context).FullName + " *",
                                            style: TextController.tableHeading,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            S.of(context).Citizenship + " *",
                                            style: TextController.tableHeading,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Center(
                                        child: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          S.of(context).CitizenshipID + " *",
                                          style: TextController.tableHeading,
                                        ),
                                      ),
                                    )),
                                    Center(
                                        child: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          S.of(context).Position + " *",
                                          style: TextController.tableHeading,
                                        ),
                                      ),
                                    )),
                                    Center(
                                        child: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          S.of(context).ContactInfoPhoneNumber +
                                              " *",
                                          style: TextController.tableHeading,
                                        ),
                                      ),
                                    )),
                                    Center(
                                        child: Container(
                                      height: 50,
                                    )),
                                  ],
                                ),

                                TableRow(
                                  children: [
                                    Center(
                                      child: Container(
                                        height: 60,
                                        child: TextFormField(
                                          textAlign: TextAlign.center,
                                          controller: FullName1,
                                          style: TextController.BodyText,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[a-zA-Z ]')),
                                          ],
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle: TextController
                                                  .inputErrorText),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                        ),
                                      ),
                                    ),
                              Center(
                                  child: Container(
                                      height: 60,
                                      child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TypeAheadField(
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                      onTap: () {
                                                        setState(() {
                                                          CountryofPracticingBusinessError =
                                                              false;
                                                        });
                                                      },
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _typeAheadController1,
                                                      style: TextController
                                                          .BodyText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                             )),
                                              suggestionsCallback: (pattern) {
                                                // Return a filtered list of suggestions based on the search pattern.
                                                return _items
                                                    .where((item) => item
                                                        .toLowerCase()
                                                        .contains(pattern
                                                            .toLowerCase()))
                                                    .toList();
                                              },
                                              itemBuilder:
                                                  (context, suggestion) {
                                                return ListTile(
                                                  title: Text(suggestion),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                // Update the selected item when a suggestion is selected.
                                                setState(() {
                                                  _selectedItem = suggestion;
                                                  _typeAheadController1.text =
                                                      suggestion;
                                                });
                                              },
                                            ),
                                          ),
                                    )),
                                    Center(
                                        child: Container(
                                      height: 60,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: CitizenshipID1,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    )),
                                    Center(
                                        child: Container(
                                      height: 60,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: Position1,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                      ),
                                    )),
                                    Center(
                                      child: Container(
                                        height: 60,
                                        width: 100,
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          maxLength: 12,
                                          controller: PhoneNumber1,
                                          style: TextController.BodyText,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: '',
                                              errorStyle: TextController
                                                  .inputErrorText),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                        ),
                                      ),
                                    ),
                                    (table1)
                                        ? Center(
                                            child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                          ))
                                        : Center(
                                            child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  table1 = true;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .white, // Set background color to white
                                                onPrimary: Colors
                                                    .black, // Set text color to black
                                              ),
                                              child: Text('Add'),
                                            ),
                                          ))
                                  ],
                                ),
                                if (table1)
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: FullName2,
                                                style: TextController.BodyText,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]')),
                                                ],
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'This field is required.';
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                                decoration: InputDecoration(
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: ''),
                                              ))),
                                      Center(
                                          child:  Container(
                                      height: 60,
                                      child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TypeAheadField(
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                      onTap: () {
                                                        setState(() {
                                                          CountryofPracticingBusinessError =
                                                              false;
                                                        });
                                                      },
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _typeAheadController2,
                                                      style: TextController
                                                          .BodyText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                             )),
                                              suggestionsCallback: (pattern) {
                                                // Return a filtered list of suggestions based on the search pattern.
                                                return _items
                                                    .where((item) => item
                                                        .toLowerCase()
                                                        .contains(pattern
                                                            .toLowerCase()))
                                                    .toList();
                                              },
                                              itemBuilder:
                                                  (context, suggestion) {
                                                return ListTile(
                                                  title: Text(suggestion),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                // Update the selected item when a suggestion is selected.
                                                setState(() {
                                                  _selectedItem = suggestion;
                                                  _typeAheadController2.text =
                                                      suggestion;
                                                });
                                              },
                                            ),
                                          ),
                                    ),),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: CitizenshipID2,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: Position2,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                        child: TextFormField(
                                          controller: PhoneNumber2,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          maxLength: 12,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          textAlign: TextAlign.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: '',
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (!table2)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table2 = true;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Add'),
                                                ),
                                              ),
                                            if (table1)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table1 = false;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Remove'),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (table2)
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: FullName3,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'This field is required.';
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]')),
                                                ],
                                                decoration: InputDecoration(
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: ''),
                                              ))),
                                      Center(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TypeAheadField(
                                              textFieldConfiguration:
                                                  TextFieldConfiguration(
                                                      onTap: () {
                                                        setState(() {
                                                          CountryofPracticingBusinessError =
                                                              false;
                                                        });
                                                      },
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _typeAheadController2,
                                                      style: TextController
                                                          .BodyText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                             )),
                                              suggestionsCallback: (pattern) {
                                                // Return a filtered list of suggestions based on the search pattern.
                                                return _items
                                                    .where((item) => item
                                                        .toLowerCase()
                                                        .contains(pattern
                                                            .toLowerCase()))
                                                    .toList();
                                              },
                                              itemBuilder:
                                                  (context, suggestion) {
                                                return ListTile(
                                                  title: Text(suggestion),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                // Update the selected item when a suggestion is selected.
                                                setState(() {
                                                  _selectedItem = suggestion;
                                                  _typeAheadController2.text =
                                                      suggestion;
                                                });
                                              },
                                            ),
                                          ),
                                    ),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: CitizenshipID3,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: Position3,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                        child: TextFormField(
                                          controller: PhoneNumber3,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          textAlign: TextAlign.center,
                                          maxLength: 12,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: '',
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (!table3)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table3 = true;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Add'),
                                                ),
                                              ),
                                            if (table2)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table2 = false;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Remove'),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                if (table3)
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: FullName4,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'This field is required.';
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]')),
                                                ],
                                                decoration: InputDecoration(
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: ''),
                                              ))),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        //controller: Citizenshhip4,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: CitizenshipID4,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: Position4,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                        child: TextFormField(
                                          controller: PhoneNumber4,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          textAlign: TextAlign.center,
                                          maxLength: 12,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: '',
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            if (!table4)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table4 = true;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Add'),
                                                ),
                                              ),
                                            if (table3)
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table3 = false;
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                  child: Text('Remove'),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                if (table4)
                                  TableRow(
                                    children: [
                                      Center(
                                          child: Container(
                                              height: 50,
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: FullName5,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'This field is required.';
                                                  }
                                                  return null; // Return null if the input is valid
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(
                                                          RegExp(r'[a-zA-Z ]')),
                                                ],
                                                decoration: InputDecoration(
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: ''),
                                              ))),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        //controller: Citizenshhip5,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: CitizenshipID5,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                          child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: Position5,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            counterText: ''),
                                      )),
                                      Center(
                                        child: TextFormField(
                                          controller: PhoneNumber5,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                          ],
                                          textAlign: TextAlign.center,
                                          maxLength: 12,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: '',
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
                                      ),
                                      Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              table4 = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .white, // Set background color to white
                                            onPrimary: Colors
                                                .black, // Set text color to black
                                          ),
                                          child: Text('Remove'),
                                        ),
                                      )),
                                    ],
                                  ),

                                //
                              ],
                            )),
                      ),
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
                      width: double.infinity,
                      alignment: Alignment.topLeft,
                      child: Table(
                        columnWidths: {
                          // 0: FixedColumnWidth(600),
                          // 1: FixedColumnWidth(600),
                          // 2: FixedColumnWidth(70),
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),
                          2: FlexColumnWidth(0.7),
                        },
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: ColorSelect.east_grey,
                            ),
                            children: [
                              Center(
                                  child: Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        S.of(context).FullName + " *",
                                        style: TextController.tableHeading,
                                      )))),
                              Center(
                                  child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    S.of(context).Position + " *",
                                    style: TextController.tableHeading,
                                  ),
                                ),
                              )),
                              Center(
                                  child: Container(
                                height: 50,
                              )),
                            ],
                          ),
                          TableRow(
                            children: [
                              Center(
                                child: Container(
                                  height: 60,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorFullName1,
                                    style: TextController.BodyText,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[a-zA-Z ]')),
                                    ],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                              ),
                              Center(
                                  child: Container(
                                height: 60,
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  controller: DirectorPosition1,
                                  style: TextController.BodyText,
                                  decoration: InputDecoration(
                                      border: InputBorder
                                          .none, // Remove the input border line
                                      errorStyle:
                                          TextController.inputErrorText),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                ),
                              )),
                              (table21)
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                      ),
                                    )
                                  : Center(
                                      child: Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            table21 = true;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors
                                              .white, // Set background color to white
                                          onPrimary: Colors
                                              .black, // Set text color to black
                                        ),
                                        child: Text('Add'),
                                      ),
                                    )),
                            ],
                          ),
                          if (table21)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName2,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table21 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition2,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table21 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (!table22)
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              table22 = true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .white, // Set background color to white
                                            onPrimary: Colors
                                                .black, // Set text color to black
                                          ),
                                          child: Text('Add'),
                                        ),
                                      ),
                                    if (table21)
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              table21 = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .white, // Set background color to white
                                            onPrimary: Colors
                                                .black, // Set text color to black
                                          ),
                                          child: Text('Remove'),
                                        ),
                                      ),
                                  ],
                                )),
                              ],
                            ),
                          if (table22)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName3,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table22 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition3,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table22 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (!table23)
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              table23 = true;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .white, // Set background color to white
                                            onPrimary: Colors
                                                .black, // Set text color to black
                                          ),
                                          child: Text('Add'),
                                        ),
                                      ),
                                    if (table22)
                                      Container(
                                        padding: EdgeInsets.only(top: 15),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              table22 = false;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .white, // Set background color to white
                                            onPrimary: Colors
                                                .black, // Set text color to black
                                          ),
                                          child: Text('Remove'),
                                        ),
                                      ),
                                  ],
                                )),
                              ],
                            ),
                          if (table23)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName4,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table23 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition4,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table23 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table24)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table24 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table23)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table23 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table24)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName5,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table24 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition5,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table24 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table25)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table25 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table24)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table24 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table25)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName6,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table25 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition6,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table25 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table26)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table26 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table25)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table25 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table26)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName7,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table26 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition7,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table26 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table27)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table27 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table26)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table26 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table27)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName8,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table27 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition8,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table27 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table28)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table28 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table27)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table27 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table28)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName9,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table28 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition9,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table28 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (!table29)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table29 = true;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Add'),
                                          ),
                                        ),
                                      if (table28)
                                        Container(
                                          padding: EdgeInsets.only(top: 15),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                table28 = false;
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .white, // Set background color to white
                                              onPrimary: Colors
                                                  .black, // Set text color to black
                                            ),
                                            child: Text('Remove'),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          if (table29)
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 60,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: DirectorFullName10,
                                      style: TextController.BodyText,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorStyle:
                                            TextController.inputErrorText,
                                      ),
                                      validator: (value) {
                                        if (table29 && value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    controller: DirectorPosition10,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the input border line
                                        errorStyle:
                                            TextController.inputErrorText),
                                    validator: (value) {
                                      if (table29 && value!.isEmpty) {
                                        return 'This field is required.';
                                      }
                                      return null; // Return null if the input is valid
                                    },
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 15),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          table29 = false;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors
                                            .white, // Set background color to white
                                        onPrimary: Colors
                                            .black, // Set text color to black
                                      ),
                                      child: Text('Remove'),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          //
                        ],
                      )),

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
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          width: 780,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required.';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
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
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                width: 270,
                                height: 35,
                                child: Row(
                                  children: [
                                    CountryCodePicker(
                                      flagWidth: 20,
                                      showFlag: false,
                                      onChanged: print,
                                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      initialSelection: 'sa',
                                      favorite: const ['+39', 'FR'],

                                      showFlagDialog: false,

                                      //Get the country information relevant to the initial selection
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 230,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          controller: BusinessPhone,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyHeadingText,
                                          keyboardType: TextInputType.number,
                                          maxLength: 12,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            if (value.isNotEmpty &&
                                                (value.length < 4 ||
                                                    value.length > 12)) {
                                              return 'Invalid Number';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: InputDecoration(
                                            counterText: "",
                                            isDense: true,
                                            hintText: S.of(context).ResPhLabel,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                "Number Of\nEmployees *",
                                style: TextController.BodyText,
                              ),
                            ),
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 270,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  maxLength: 9,
                                  controller: NumberOfEmployes,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: S.of(context).number,
                                    errorStyle: TextController.inputErrorText,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    counterText: '',
                                  ),
                                ),
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
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 270,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  style: TextController.BodyText,
                                  textAlignVertical: TextAlignVertical.center,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  maxLength: 10,
                                  controller: PaidUpCapital,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: "Enter Here",
                                    errorStyle: TextController.inputErrorText,
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    counterText: '',
                                  ),
                                ),
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
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: 270,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required.';
                                    }
                                    return null; // Return null if the input is valid
                                  },
                                  maxLength: 10,
                                  controller: AnnualTurnOver,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    errorStyle: TextController.inputErrorText,
                                    hintText: "Enter Here",
                                    hintStyle: TextController.labelText,
                                    border: InputBorder.none,
                                    counterText: '',
                                  ),
                                ),
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
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AuthorizedRepresentative();
                                _formKey.currentState?.save();
                                tabController?.animateTo(3);

                                // tabController?.animateTo(3);
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
