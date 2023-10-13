import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CorporateClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/InvestmentPortfolioBCorporate.dart';
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

class Generalinfo extends StatefulWidget {
  Generalinfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<Generalinfo> createState() => GeneralinfoState();
}

TabController? tabController;

class GeneralinfoState extends State<Generalinfo> {
  String btn = "Next";
  final _formkey = GlobalKey<FormState>();

  TextEditingController _typeAheadController = TextEditingController();

  TextEditingController _typeAheadController2 = TextEditingController();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController citizenshipController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  TextEditingController CompanyName = new TextEditingController();
  TextEditingController CompanyNameAr = new TextEditingController();
  TextEditingController CountryOfRegistration = new TextEditingController();
  TextEditingController MainBuissness = new TextEditingController();
  TextEditingController CountryOfPracticingBuissness =
      new TextEditingController();
  TextEditingController CommercialRegistraction = new TextEditingController();
  TextEditingController FullName1 = new TextEditingController();
  TextEditingController Citizenship1 = new TextEditingController();
  TextEditingController percentage1 = new TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController dateControllerHijri = TextEditingController();

  TextEditingController FullName2 = new TextEditingController();
  TextEditingController Citizenship2 = new TextEditingController();
  TextEditingController percentage2 = new TextEditingController();

  TextEditingController FullName3 = new TextEditingController();
  TextEditingController Citizenship3 = new TextEditingController();
  TextEditingController percentage3 = new TextEditingController();

  TextEditingController FullName4 = new TextEditingController();
  TextEditingController Citizenship4 = new TextEditingController();
  TextEditingController percentage4 = new TextEditingController();
  List<List<TextEditingController>> rows = [];
  List<List<String>> rowsFinal = [];

  var selectedDate = HijriCalendar.now();

  String _selectedItem = ''; // To store the selected item

  bool CompanyNameError = false;
  bool CompanyNameArError = false;
  bool MainBuissnessError = false;
  bool dateError = false;
  bool dateHijriError = false;
  bool CommercialRegistractionNewError = false;
  bool CountryofRegistrationError = false;
  bool CountryofRegistrationWrong = false;
  bool CountryofPracticingBusinessError = false;
  bool CountryofPracticingBusinessWrong = false;

  late final id;
  String? numberValidator(String? value) {
    if (value == null) {
      return "";
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    return null; // Return null to indicate no validation error
  }

  double height1 = 500;
  bool table1 = false;
  bool table2 = false;
  bool table3 = false;

  @override
  int selectedValue = 0;
  Generalinfo({@required controller}) {
    tabController = controller;
  }

  // DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  String? dropdownvalue;
  String? dropdownvalueCountry;

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
  void initState() {
    super.initState();

    rows.clear();
    setState(() {
      FullName1.text = "";
      Citizenship1.text = "";
      percentage1.text = "";
    });
    if (GlobalPermissionCorporate
            .corporatedraftprogress["GenralInformationPart1Corporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
    } else {}

    print(GlobalPermissionCorporate.corporatedraftprogress);
  }

  void addNewRowd() {
    List<TextEditingController> li = [];
    for (int i = 0; i < 3; i++) {
      TextEditingController tt = new TextEditingController();
      li.add(tt);
    }

    setState(() {
      rows.add(li);
    });
  }

  void deleteRow() {
    setState(() {
      rows.removeLast();
    });
  }

  Future<void> fetchData(int id) async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GeneralInformationPart1Corporate/${id}'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Successfull");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        List<dynamic> responseList = jsonResponse['rowData'] ?? [];
        for (int i = 0; i < responseList.length; i++) {
          List<TextEditingController> x = [];
          for (int j = 0; j < 3; j++) {
            TextEditingController t = new TextEditingController();
            t.text = responseList[i][j];
            x.add(t);
          }
          setState(() {
            rows.add(x);
          });
        }
        print("11------");
        CompanyName.text = jsonResponse['companyName'];
        _typeAheadController.text = jsonResponse['countryOfRegistration'];
        _typeAheadController2.text =
            jsonResponse['countryOfPracticingBusiness'];
        MainBuissness.text = jsonResponse['mainBusiness'];

        CommercialRegistraction.text =
            jsonResponse['commericalRegistrationNumber'];
        dateController.text =
            jsonResponse['dateOfIncorporationOrStartOfBusiness'];

        print("11------");
        CompanyNameAr.text = jsonResponse['companyNameArabic'];
        dateControllerHijri.text =
            jsonResponse['dateOfIncorporationOrStartOfBusinessArabic'];
        List<dynamic> x = jsonResponse['rowData'];
        for (var i in x) {
          rowsFinal.add(i);
        }

        print("11------");

        print(dateControllerHijri.text);
      });
      // Update any other necessary UI elements or perform additional actions with the retrieved data
      print(jsonResponse);
      // Print the values for verification
    } else {
      // Request failed

      print('Request failed with status: ${response.statusCode}');
    }
  }

  void sendData() async {
    setState(() {
      btn = "Loading...";
    });
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "companyName": CompanyName.text,
      "countryOfRegistration": _typeAheadController.text,
      "mainBusiness": MainBuissness.text,
      "countryOfPracticingBusiness": _typeAheadController2.text,
      "dateOfIncorporationOrStartOfBusiness": dateController.text,
      "commericalRegistrationNumber": CommercialRegistraction.text,
      "companyNameArabic": CompanyNameAr.text,
      "rowData": rowsFinal,
      "dateOfIncorporationOrStartOfBusinessArabic": dateControllerHijri.text
    };

    print(body);
    final response = await http.post(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/GeneralInformationPart1Corporate'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      DocumentUploadCorporate.name.value = CompanyName.text + "~Corporate";

      Fatqa.CompanyName.value = CompanyName.text;
      InvestmentPortfolioBCorporate.NameofClient.value = CompanyName.text;
      Fatqa.CompanyNameAr.value = CompanyNameAr.text;
      // Request successful, handle the response
      print("dfgsdgfsdg");
      int responseData = int.parse(response.body);

      print(responseData);
      GlobalPermissionCorporate.corporateclientid = responseData;
      GlobalPermissionCorporate.getdraftprogresscorporate(responseData);
      tabController?.animateTo(1);
      setState(() {
        btn = "Next";
      });
      // Process the responseData
    } else {
      setState(() {
        btn = "Next";
      });
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  void putdata(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": Id,
      "companyName": CompanyName.text,
      "countryOfRegistration": _typeAheadController.text,
      "mainBusiness": MainBuissness.text,
      "countryOfPracticingBusiness": _typeAheadController2.text,
      "dateOfIncorporationOrStartOfBusiness": dateController.text,
      "commericalRegistrationNumber": CommercialRegistraction.text,
      "companyNameArabic": CompanyNameAr.text,
      "rowData": rowsFinal,
      "dateOfIncorporationOrStartOfBusinessArabic": dateControllerHijri.text
    };
    print(body);
    final response = await http.put(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/GeneralInformationPart1Corporate/${Id}'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Request successful, handle the response
      DocumentUploadCorporate.name.value = CompanyName.text + "~Corporate";
      print("Successfull");
      tabController?.animateTo(1);
      setState(() {
        btn = "Next";
      });

      // Process the responseData
    } else {
      setState(() {
        btn = "Next";
      });
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.yes;
    int? selectedValue = 1;

    if (table1 == true || table2 == true || table3 == true) {
      height1 = 800;
    } else {
      height1 = 500;
    }
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: height1,
          padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).CompanyName,
                            style: TextController.SubHeadingText,
                          ),
                          Flexible(
                            child: Text(
                              S.of(context).InAccordance,
                              style: TextController.SubHeadingText,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S.of(context).CompanyName +
                                            "\n(In English)" +
                                            " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              controller: CompanyName,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).ABCPvtLmt,
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    CompanyNameError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    CompanyNameError = false;
                                                  });
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          if (CompanyNameError)
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
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S.of(context).MainBusiness + " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              controller: MainBuissness,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    MainBuissnessError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    MainBuissnessError = false;
                                                  });
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).BuisnessName,
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                            ),
                                          ),
                                          if (MainBuissnessError)
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
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S
                                                .of(context)
                                                .DateofIncorporationorStartofBusiness +
                                            "\n(Gegorian)" +
                                            " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 300,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              readOnly: true,

                                              controller: dateController,
                                              style: TextController.BodyText,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    dateError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    dateError = false;
                                                  });
                                                }
                                                return null;
                                              },
                                              textAlignVertical:
                                                  TextAlignVertical.center,

                                              decoration: InputDecoration(
                                                isDense: true,
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 15,
                                                ),
                                                hintText:
                                                    S.of(context).DateFormat,
                                                hintStyle: TextController
                                                    .labelTextDate,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                              //readOnly: true,
                                              onTap: () async {
                                                DateTime? datepicked =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1500),
                                                        lastDate:
                                                            DateTime.now());
                                                if (datepicked != null) {
                                                  print(
                                                      datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(datepicked!);
                                                  HijriCalendar? picked =
                                                      HijriCalendar.fromDate(
                                                          datepicked!);
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((_) =>
                                                          setState((dateController
                                                                      .text =
                                                                  formattedDate)
                                                              as VoidCallback));
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((_) =>
                                                          setState((dateControllerHijri
                                                                      .text =
                                                                  picked
                                                                      .toString())
                                                              as VoidCallback));
                                                  // format date in required form here we use yyyy-MM-dd that means time is remove
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                            ),
                                          ),
                                          if (dateError)
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
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S
                                                .of(context)
                                                .DateofIncorporationorStartofBusinessAr +
                                            " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 300,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              style: TextController.BodyText,
                                              textAlignVertical:
                                                  TextAlignVertical.center,

                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    dateHijriError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    dateHijriError = false;
                                                  });
                                                }
                                                return null;
                                              },

                                              controller: dateControllerHijri,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                suffixIcon: Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 15,
                                                ),
                                                hintText:
                                                    S.of(context).DateFormat,
                                                hintStyle: TextController
                                                    .labelTextDate,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
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
                                              //             setState((ExpHijridateController
                                              //                         .text =
                                              //                     picked
                                              //                         .toString())
                                              //                 as VoidCallback));
                                              //   }
                                              // },
                                            ),
                                          ),
                                          if (dateHijriError)
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
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S.of(context).CompanyNameAR + " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              controller: CompanyNameAr,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'[\u0600-\u06FF\s]')),
                                              ],
                                              decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).ABCPvtLmt,
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    CompanyNameArError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    CompanyNameArError = false;
                                                  });
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          if (CompanyNameArError)
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
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S.of(context).CountryofRegistration +
                                            " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
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
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller:
                                                    _typeAheadController,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    errorStyle: TextController
                                                        .inputErrorText,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    hintText:
                                                        S.of(context).TypeHere),
                                              ),
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
                                                  _typeAheadController.text =
                                                      suggestion;
                                                });
                                              },
                                            ),
                                          ),
                                          if (CountryofRegistrationError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (CountryofRegistrationWrong)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Invalid citizenship",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        S
                                                .of(context)
                                                .CountryofPracticingBusiness +
                                            " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
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
                                                              hintText: S
                                                                  .of(context)
                                                                  .TypeHere)),
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
                                          if (CountryofPracticingBusinessError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (CountryofPracticingBusinessWrong)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Invalid citizenship",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        width: 200,
                                        child: Text(
                                          S
                                                  .of(context)
                                                  .CommericalRegistrationNumberoritsEquivalent +
                                              " *",
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              controller:
                                                  CommercialRegistraction,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                hintText:
                                                    S.of(context).TypeHere,
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    CommercialRegistractionNewError =
                                                        true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    CommercialRegistractionNewError =
                                                        false;
                                                  });
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          if (CommercialRegistractionNewError)
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          S
                              .of(context)
                              .NamesofNaturalPersonswhoownorcontrol25ormoreoftheshares,
                          style: TextController.BodyText,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                              child: Table(
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
                                },
                                children: [
                                  TableRow(
                                    children: [
                                      Container(
                                          height: 70,
                                          color: ColorSelect.east_grey,
                                          child: Center(
                                              child: Text(
                                            S.of(context).FullName,
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
                                              S.of(context).Citizenship,
                                              style:
                                                  TextController.tableHeading,
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
                                              S
                                                  .of(context)
                                                  .PercentageofOwnership,
                                              style:
                                                  TextController.tableHeading,
                                              maxLines: 3,
                                            )),
                                          )),
                                    ],
                                  ),
                                  for (int i = 0; i < rows.length; i++)
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
                                            controller: rows[i][0],
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                              enabledBorder: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
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
                                            controller: rows[i][1],
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                              enabledBorder: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
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
                                            inputFormatters: <
                                                TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            textAlign: TextAlign.center,
                                            controller: rows[i][2],
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              isDense: true,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                              enabledBorder: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
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
                              onPressed: addNewRowd,
                              child: Text('Add Row'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            if (rows.length != 0)
                              ElevatedButton(
                                onPressed: deleteRow,
                                child: Text('Delete Row'),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        // padding: const EdgeInsets.only(right: 910),
                        child: Text(
                          S
                              .of(context)
                              .Shareholdershaving25ownershipormoreshouldcompleteaseparateKYCform,
                          style: TextController.BodyText,
                        ),
                      ),
                      Row(
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
                                // tabController?.animateTo(11);
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        new CorporateClientList()));
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
                              border:
                                  Border.all(color: ColorSelect.tabBorderColor),
                            ),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorSelect.east_blue),
                              ),
                              onPressed: () {
                                rowsFinal.clear();
                                for (List li in rows) {
                                  List<String> x = [];
                                  for (int j = 0; j < 3; j++) {
                                    x.add(li[j].value.text);
                                  }
                                  rowsFinal.add(x);
                                }
                                if (_formkey.currentState != null) {
                                  setState(() {
                                    CountryofRegistrationError =
                                        _typeAheadController.text == "";
                                    CountryofPracticingBusinessError =
                                        _typeAheadController2.text == "";

                                    if ((_items
                                        .contains(_typeAheadController.text))) {
                                      CountryofRegistrationWrong = false;
                                    } else {
                                      CountryofRegistrationWrong = true;
                                    }
                                    if ((_items.contains(
                                        _typeAheadController2.text))) {
                                      CountryofPracticingBusinessWrong = false;
                                    } else {
                                      CountryofPracticingBusinessWrong = true;
                                    }
                                  });
                                  if (_formkey.currentState!.validate() &&
                                      !(CountryofPracticingBusinessError &&
                                          CountryofRegistrationError)) {
                                    _formkey.currentState!.save();

                                    if (GlobalPermissionCorporate
                                                .corporatedraftprogress[
                                            "GenralInformationPart1Corporate"] ==
                                        true) {
                                      putdata(GlobalPermissionCorporate
                                          .corporateclientid);
                                    } else {
                                      sendData();
                                    }
                                  }
                                } else {
                                  // Handle the case when _formKey.currentState is null
                                }
                              },
                              child: Text(
                                btn,
                                style: TextController.btnText,
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
          ),
        ),
      ),
    );
  }

  // void openFile(PlatformFile file) {
  //   OpenFile.open();
  // }
}
