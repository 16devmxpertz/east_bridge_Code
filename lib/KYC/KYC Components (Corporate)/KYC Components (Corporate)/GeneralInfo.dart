import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/AuthorizedR.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/BankInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientClassificationTabs/TabsClientClassification/InstitutionalClient.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientClassificationTabs/TabsClientClassification/RetailsClient.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/CustodianInfo.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/InvestmentPortfolioACorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/InvestmentPortfolioBCorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/OtherTab.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/otherInformation.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ClientClassificationTabs/TabsClientClassification/QualifiedClient.dart';
import 'RegisteredAddress.dart';

enum SingingCharacter { yes, no }

class Generalinfo extends StatefulWidget {
  Generalinfo({@required controller}) {
    tabController = controller;
  }

  @override
  State<Generalinfo> createState() => GeneralinfoState();
}

TabController? tabController;
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
var selectedDate = HijriCalendar.now();

String _selectedItem = ''; // To store the selected item

class GeneralinfoState extends State<Generalinfo> {
  final _formkey = GlobalKey<FormState>();

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
  bool draft = false;

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

  void initState() {
    super.initState();
    if (draft == true) {
      fetchData();
    }
  }

  String type = "POST";
  Future<void> fetchData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/GenralInformationCorporate/GenralInformationCorporate/1'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      // Request was successful
      Fatqa.CompanyName.value = CompanyName.text;
      Fatqa.CompanyNameAr.value = CompanyNameAr.text;
      var jsonResponse = json.decode(response.body);

//  "companyName": CompanyName.text,
//           "countryOfRegistration": dropdownvalueCountry,
//           "mainBusiness": MainBuissness.text,
//           "countryOfPracticingBusiness": dropdownvalue,
//           "dateOfIncorporationOrStartOfBusiness": dateController.text,
//           "commericalRegistrationNumber": CommercialRegistraction.text,
//           "fullName1": FullName1.text,
//           "fullName2": FullName2.text,
//           "fullName3": FullName3.text,
//           "fullName4": FullName4.text,
//           "citizenship1": Citizenship1.text,
//           "citizenship2": Citizenship2.text,
//           "citizenship3": Citizenship3.text,
//           "citizenship4": Citizenship4.text,
//           "percentageOfOwnership1": percentage1.text,
//           "percentageOfOwnership2": percentage2.text,
//           "percentageOfOwnership3": percentage3.text,
//           "percentageOfOwnership4": percentage4.text

      // Access the desired values from the jsonResponse and assign them to the respective controllers
      fullNameController.text = jsonResponse['fullName1'];
      citizenshipController.text = jsonResponse['citizenship'];
      percentageController.text = jsonResponse['percentage'];

      CompanyName.text = jsonResponse['companyName'];
      CountryOfRegistration.text = jsonResponse['countryOfRegistration'];
      MainBuissness.text = jsonResponse['mainBusiness'];
      CountryOfPracticingBuissness.text =
          jsonResponse['countryOfPracticingBusiness'];
      CommercialRegistraction.text = jsonResponse['commercialRegistration'];
      FullName1.text = jsonResponse['fullName1'];
      Citizenship1.text = jsonResponse['citizenship1'];
      percentage1.text = jsonResponse['percentage1'];
      dateController.text = jsonResponse['date'];

      FullName2.text = jsonResponse['fullName2'];
      Citizenship2.text = jsonResponse['citizenship2'];
      percentage2.text = jsonResponse['percentage2'];

      FullName3.text = jsonResponse['fullName3'];
      Citizenship3.text = jsonResponse['citizenship3'];
      percentage3.text = jsonResponse['percentage3'];

      FullName4.text = jsonResponse['fullName4'];
      Citizenship4.text = jsonResponse['citizenship4'];
      percentage4.text = jsonResponse['percentage4'];
      type = "PUT";
      // Update any other necessary UI elements or perform additional actions with the retrieved data

      // Print the values for verification
      print('Full Name: ${fullNameController.text}');
      print('Citizenship: ${citizenshipController.text}');
      print('Percentage: ${percentageController.text}');
    } else {
      // Request failed
      type = "POST";
      print('Request failed with status: ${response.statusCode}');
    }
  }

  void sendData() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermission.employeeId,
      "companyName": CompanyName.text,
      "countryOfRegistration": _typeAheadController.text,
      "mainBusiness": MainBuissness.text,
      "countryOfPracticingBusiness": _typeAheadController2.text,
      "dateOfIncorporationOrStartOfBusiness": dateController.text,
      "commericalRegistrationNumber": CommercialRegistraction.text,
      "companyNameArabic": CompanyNameAr.text,
      "dateOfIncorporationOrStartOfBusinessArabic": dateController.text
    };
    final response = await http.post(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/GeneralInformationPart1Corporate'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Request successful, handle the response
      print(jsonDecode(response.body));
      print("General Info Working");
      id = int.parse(response.body);

      Registered_Address.id.value = id;
      AuthorizedInfo.id.value = id;
      RetailClient.id.value = id;
      NestQaulifiedClient.id.value = id;
      InstitutionalClient.id.value = id;
      ContactInfoo.id.value = id;
      OtherInfoCorporate.id.value = id;
      CustodianInfo.id.value = id;
      BankInfo.id.value = id;
      InvestmentPortfolioACorporate.id.value = id;
      InvestmentPortfolioBCorporate.id.value = id;
      Fatqa.id.value = id;
      OtherTab.id.value = id;
      DocumentUploadCorporate.id.value = id;
      DocumentUploadCorporate.name.value = CompanyName.text;
      // GlobalPermission.corporateclientid = responseData;
      // GlobalPermission.getdraftprogresscorporate(responseData);
      tabController?.animateTo(1);
      // Process the responseData
    } else {
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      // Display or handle the error
    }
  }

  // void sendData() async {
  //   try {
  //     var headers = {
  //       'Content-Type': 'application/json',
  //     };

  //     var body = {
  //       "clientId": 0,
  //       "companyName": CompanyName.text,
  //       "countryOfRegistration": _typeAheadController.text,
  //       "mainBusiness": MainBuissness.text,
  //       "countryOfPracticingBusiness": _typeAheadController2.text,
  //       "dateOfIncorporationOrStartOfBusiness": dateController.text,
  //       "commericalRegistrationNumber": CommercialRegistraction.text,
  //       "fullName1": FullName1.text,
  //       "fullName2": FullName2.text,
  //       "fullName3": FullName3.text,
  //       "fullName4": FullName4.text,
  //       "citizenship1": Citizenship1.text,
  //       "citizenship2": Citizenship2.text,
  //       "citizenship3": Citizenship3.text,
  //       "citizenship4": Citizenship4.text,
  //       "percentageOfOwnership1": percentage1.text,
  //       "percentageOfOwnership2": percentage2.text,
  //       "percentageOfOwnership3": percentage3.text,
  //       "percentageOfOwnership4": percentage4.text
  //     };
  //     dynamic response;
  //     if (type == "POST") {
  //       response = await http.post(
  //           Uri.parse(
  //               '${GlobalPermission.urlLink}/api/GeneralInformationPart1Corporate'),
  //           headers: headers,
  //           body: jsonEncode(body));
  //     } else {
  //       response = await http.put(
  //           Uri.parse(
  //               '${GlobalPermission.urlLink}/api/GenralInformationCorporate/GenralInformationCorporate?ClientId=1'),
  //           headers: headers,
  //           body: jsonEncode(body));
  //     }

  //     if (response.statusCode == 200) {
  //       print(jsonDecode(response.body));
  //       id = int.parse(response.body);
  //       Registered_Address.id.value = id;
  //       AuthorizedInfo.id.value = id;
  //       RetailClient.id.value = id;
  //       NestQaulifiedClient.id.value = id;
  //       InstitutionalClient.id.value = id;
  //       ContactInfoo.id.value = id;
  //       OtherInfoCorporate.id.value = id;
  //       CustodianInfo.id.value = id;
  //       BankInfo.id.value = id;
  //       InvestmentPortfolioACorporate.id.value = id;
  //       InvestmentPortfolioBCorporate.id.value = id;
  //       Fatqa.id.value = id;
  //       OtherTab.id.value = id;
  //       DocumentUploadCorporate.id.value = id;
  //       print("-----------------Animate--------------------");
  //       // tabController?.animateTo(1);
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  //  void addRow() {
  //   String fullName = fullNameController.text;
  //   String citizenship = citizenshipController.text;
  //   String percentage = percentageController.text;

  //   List<String> newRow = [fullName, citizenship, percentage];

  //   setState(() {
  //     tableData.add(newRow);
  //   });

  //   fullNameController.clear();
  //   citizenshipController.clear();
  //   percentageController.clear();
  //}

  Widget build(BuildContext context) {
    SingingCharacter? _character = SingingCharacter.yes;
    int? selectedValue = 1;

    @override
    void initState() {
      super.initState();
      fetchData();
    }

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
                                                errorStyle: TextStyle(
                                                    height: 0.0 ),
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
                                                            DateTime(2023),
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
                        width: double.infinity,
                        // margin: EdgeInsets.symmetric(
                        //   horizontal: 15,
                        // ),
                        alignment: Alignment.topLeft,
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                            3: FlexColumnWidth(1),
                            // 0: FixedColumnWidth(315),
                            // 1: FixedColumnWidth(315),
                            // 2: FixedColumnWidth(315),
                            // 3: FixedColumnWidth(315),
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
                                        S.of(context).FullName,
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
                                        S.of(context).Citizenship,
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
                                        S.of(context).PercentageofOwnership,
                                        style: TextController.tableHeading,
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                )),
                              ],
                            ),
                            TableRow(
                              children: [
                                Center(
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: FullName2,
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z ]')),
                                      ],
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        isDense: true,
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'This field is required.';
                                      //   }
                                      //   return null; // Return null if the input is valid
                                      // },
                                    ),
                                  ),
                                ),
                                Center(
                                    child: Container(
                                  height: 50,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.center,
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            textAlign: TextAlign.center,
                                            controller: Citizenship2,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              hintStyle:
                                                  TextController.labelText,
                                            )),
                                    suggestionsCallback: (pattern) {
                                      // Return a filtered list of suggestions based on the search pattern.
                                      return _items
                                          .where((item) => item
                                              .toLowerCase()
                                              .contains(pattern.toLowerCase()))
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
                                        Citizenship2.text = suggestion;
                                      });
                                    },
                                  ),
                                )),
                                Center(
                                  child: Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: percentage2,
                                      style: TextController.BodyText,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        hintText: "%",
                                        hintStyle: TextController.labelText,
                                        errorStyle: TextController.errorText,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'This field is required.';
                                      //   }
                                      //   return null; // Return null if the input is valid
                                      // },
                                    ),
                                  ),
                                ),
                                Center(
                                  child: (table1 == true)
                                      ? Container(
                                          height: 50,
                                        )
                                      : Container(
                                          height: 50,
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      table1 = true;
                                                      // height1 = 600;
                                                    });
                                                  },
                                                  child: Text("Add"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors
                                                        .white, // Set background color to white
                                                    onPrimary: Colors
                                                        .black, // Set text color to black
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                            if (table1)
                              TableRow(
                                children: [
                                  Center(
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: FullName3,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                              textAlign: TextAlign.center,
                                              controller: Citizenship3,
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                hintStyle:
                                                    TextController.labelText,
                                              )),
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
                                          Citizenship3.text = suggestion;
                                        });
                                      },
                                    ),
                                  )),
                                  Center(
                                      child: Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: percentage3,
                                      style: TextController.BodyText,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "%",
                                        hintStyle: TextController.labelText,
                                        errorStyle: TextController.errorText,
                                      ),
                                    ),
                                  )),
                                  Center(
                                    child: Container(
                                      height: 50,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (!table2)
                                            Container(
                                              // margin: EdgeInsets.only(top: 15),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    table2 = true;
                                                    // height1 = 700;
                                                  });
                                                },
                                                child: Text("Add"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .white, // Set background color to white
                                                  onPrimary: Colors
                                                      .black, // Set text color to black
                                                ),
                                              ),
                                            ),
                                          Container(
                                            // margin: EdgeInsets.only(top: 15),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  table1 = false;
                                                });
                                              },
                                              child: Text("Remove"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .white, // Set background color to white
                                                onPrimary: Colors
                                                    .black, // Set text color to black
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        controller: FullName1,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      height: 50,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                                textAlign: TextAlign.center,
                                                controller: Citizenship1,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  hintStyle:
                                                      TextController.labelText,
                                                )),
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
                                            Citizenship1.text = suggestion;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: percentage1,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "%",
                                        hintStyle: TextController.labelText,
                                        errorStyle: TextController.errorText,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  )),
                                  Center(
                                    child: Container(
                                      height: 50,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (!table3)
                                            Container(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    table3 = true;
                                                    // height1 = 850;
                                                  });
                                                },
                                                child: Text("Add"),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors
                                                      .white, // Set background color to white
                                                  onPrimary: Colors
                                                      .black, // Set text color to black
                                                ),
                                              ),
                                            ),
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  table2 = false;
                                                });
                                              },
                                              child: Text("Remove"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .white, // Set background color to white
                                                onPrimary: Colors
                                                    .black, // Set text color to black
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: FullName4,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: TypeAheadField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        textAlign: TextAlign.center,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: Citizenship4,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          enabledBorder: InputBorder.none,
                                          hintStyle: TextController.labelText,
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
                                          Citizenship4.text = suggestion;
                                        });
                                      },
                                    ),
                                  )),
                                  Center(
                                      child: Container(
                                    height: 50,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: percentage4,
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "%",
                                        hintStyle: TextController.labelText,
                                        errorStyle: TextController.errorText,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  )),
                                  Center(
                                    child: Container(
                                      height: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  table3 = false;
                                                });
                                              },
                                              child: Text("Remove"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors
                                                    .white, // Set background color to white
                                                onPrimary: Colors
                                                    .black, // Set text color to black
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                  tabController?.animateTo(0);
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
                                    color: ColorSelect.tabBorderColor),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (_formkey.currentState != null) {
                                    setState(() {
                                      CountryofRegistrationError =
                                          _typeAheadController.text == "";
                                      CountryofPracticingBusinessError =
                                          _typeAheadController2.text == "";

                                      if ((_items.contains(
                                          _typeAheadController.text))) {
                                        CountryofRegistrationWrong = false;
                                      } else {
                                        CountryofRegistrationWrong = true;
                                      }
                                      if ((_items.contains(
                                          _typeAheadController2.text))) {
                                        CountryofPracticingBusinessWrong =
                                            false;
                                      } else {
                                        CountryofPracticingBusinessWrong = true;
                                      }
                                      // if (_items.contains(
                                      //         _typeAheadController.text) &&
                                      //     _items.contains(
                                      //         _typeAheadController2.text)) {
                                      //   CountryofRegistrationWrong = false;
                                      //   CountryofPracticingBusinessWrong =
                                      //       false;
                                      // } else {
                                      //   CountryofRegistrationWrong = true;
                                      //     CountryofPracticingBusinessWrong =
                                      //         true;

                                      // }
                                    });
                                    if (_formkey.currentState!.validate() &&
                                        !(CountryofPracticingBusinessError &&
                                            CountryofRegistrationError)) {
                                      _formkey.currentState!.save();

                                      sendData();
                                    }
                                  } else {
                                    // Handle the case when _formKey.currentState is null
                                  }
                                },
                                child: Text(
                                  S.of(context).Next,
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
          ),
        ),
      ),
    );
  }

  // void openFile(PlatformFile file) {
  //   OpenFile.open();
  // }
}
