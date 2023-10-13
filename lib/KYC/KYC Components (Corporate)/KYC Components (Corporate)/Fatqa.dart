import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'RegisteredAddress.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}

enum ActiveNFEOption {
  ActiveNFE,
  ActiveNFEGovernmentEntity,
  ActiveNFEInternationalOrganisation,
  ActiveNFEOtherThan15to17,
}

ActiveNFEOption selectedActiveNFEOption = ActiveNFEOption.ActiveNFE;

enum NonUsOption {
  SaudiFinancial,
  Participating,
  RegisteredDeemed,
  CertifiedDeemed,
  NonParticipating,
}

NonUsOption selectedOption = NonUsOption.SaudiFinancial;

enum NonUsEntityOption {
  Excepted,
  Active,
  Passive,
}

enum FinancialInstitutionOption {
  FINonParticipatingCountry,
  OtherEntity,
  Depository,
}

FinancialInstitutionOption selectedFIOption =
    FinancialInstitutionOption.FINonParticipatingCountry;

NonUsEntityOption selectedEntityOption = NonUsEntityOption.Excepted;

enum SingingCharacter { yes, no }

class Fatqa extends StatefulWidget {
  Fatqa({@required controller, required String textValue}) {
    tabController = controller;
  }

  @override
  State<Fatqa> createState() => FatqaState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> buildingnumber = ValueNotifier("");
  static ValueNotifier<String> streetname = ValueNotifier("");
  static ValueNotifier<String> zipcode = ValueNotifier("");
  static ValueNotifier<String> district = ValueNotifier("");
  static ValueNotifier<String> secondarynumber = ValueNotifier("");
  static ValueNotifier<String> country = ValueNotifier("");
  static ValueNotifier<String> state = ValueNotifier("");
  static ValueNotifier<String> city = ValueNotifier("");
  static ValueNotifier<String> SecondaryNuma = ValueNotifier("");
  static ValueNotifier<String> faxa = ValueNotifier("");
  static ValueNotifier<String> POboxa = ValueNotifier("");
  static ValueNotifier<String> CompanyName = ValueNotifier("");
  static ValueNotifier<String> CompanyNameAr = ValueNotifier("");
}

//Bool

bool TermsandConditionsError = false;
bool nonUs = false;
bool _UsEntityUsSpecified = false;
bool _UsEntityUsNotSpecified = false;
bool NonUsSaudiFinancial = false;
bool NonUsParticipating = false;
bool NonUsRegisteredDeemed = false;
bool NonUsCertifiedDeemed = false;
bool NonUsNonParticipating = false;
bool ExemptEntitiesOwner = false;

bool NonUsEntityExcepted = false;
bool NonUsEntityActive = false;
bool NonUsEntityPassive = false;

// bool FINonParticipatingCountry = false;
bool FIOtherEntity = false;
bool FIDepository = false;

bool ActiveNFE = false;
bool ActiveNFEGovermentEntity = false;
bool ActiveNFEInternationalOrganisation = false;
bool ActiveNFEOtherThan15to17 = false;

bool PassiveNFE = false;

bool Addendum1 = false;
bool ControllingPerson = false;

bool TermsandConditions = false;

bool capacityError = false;
bool declareError = false;
bool? isChecked = false;

bool showCountryError = false;
bool showStateError = false;

bool showCityError = false;
bool showCountryError1 = false;
bool showStateError1 = false;
bool sameAddressError = false;

bool showCityError1 = false;

bool showCSCPicker = false;

//Registered address Controllers:

String selectedValue = "";
String selectedValue2 = "";
String? countryValue = "";
String? cityValue = "";
String? stateValue = "";
String? currentCountryValue = "";
String? currentCityValue = "";
String? currentStateValue = "";

//CompanyName
TextEditingController CompanyName = new TextEditingController();
TextEditingController ArabiccompanyName = TextEditingController();
TextEditingController currentCountryValue1 = TextEditingController();
TextEditingController currentCityValue1 = TextEditingController();
TextEditingController currentStateValue1 = TextEditingController();
TextEditingController _city = TextEditingController();
TextEditingController BuldingNumber = new TextEditingController();
TextEditingController District = new TextEditingController();

TextEditingController StreetName = new TextEditingController();
TextEditingController postalcode = TextEditingController();
TextEditingController ZipCode = new TextEditingController();

TextEditingController BuldingNumber2 = new TextEditingController();
TextEditingController District2 = new TextEditingController();
TextEditingController StreetName2 = new TextEditingController();
TextEditingController postalcode2 = TextEditingController();
TextEditingController ZipCode2 = new TextEditingController();

TextEditingController OfficailPhoneNumber = new TextEditingController();
TextEditingController SecondaryPhoneNumber = new TextEditingController();
TextEditingController Fax = new TextEditingController();
TextEditingController POBox = new TextEditingController();
TextEditingController OfficailPhoneNumber2 = new TextEditingController();
TextEditingController SecondaryPhoneNumber2 = new TextEditingController();
TextEditingController Fax2 = new TextEditingController();
TextEditingController POBox2 = new TextEditingController();

///

String? dropdownvalue;

TextEditingController _CountryorJurisdiction1 = TextEditingController();
TextEditingController _CountryorJurisdiction2 = TextEditingController();
TextEditingController _CountryorJurisdiction3 = TextEditingController();

TextEditingController _TaxIdNumber1 = TextEditingController();
TextEditingController _TaxIdNumber2 = TextEditingController();
TextEditingController _TaxIdNumber3 = TextEditingController();

TextEditingController _NoTinReason1 = TextEditingController();
TextEditingController _NoTinReason2 = TextEditingController();
TextEditingController _NoTinReason3 = TextEditingController();

TextEditingController _UsEntityandUsFinancial = TextEditingController();

TextEditingController _NonUsFinancialInstitution1 = TextEditingController();
TextEditingController _NonUsFinancialInstitution2 = TextEditingController();
TextEditingController _NonUsFinancialInstitution3 = TextEditingController();

TextEditingController _ActiveNFEName = TextEditingController();

TextEditingController _nameOfControllingPerson1 = TextEditingController();
TextEditingController _nameOfControllingPerson2 = TextEditingController();
TextEditingController _nameOfControllingPerson3 = TextEditingController();
TextEditingController _nameOfControllingPerson4 = TextEditingController();
TextEditingController _nameOfControllingPerson5 = TextEditingController();

TextEditingController _addressOfControllingPerson1 = TextEditingController();
TextEditingController _addressOfControllingPerson2 = TextEditingController();
TextEditingController _addressOfControllingPerson3 = TextEditingController();
TextEditingController _addressOfControllingPerson4 = TextEditingController();
TextEditingController _addressOfControllingPerson5 = TextEditingController();

TextEditingController _dobOfControllingPerson1 = TextEditingController();
TextEditingController _dobOfControllingPerson2 = TextEditingController();
TextEditingController _dobOfControllingPerson3 = TextEditingController();
TextEditingController _dobOfControllingPerson4 = TextEditingController();
TextEditingController _dobOfControllingPerson5 = TextEditingController();

TextEditingController _pobOfControllingPerson1 = TextEditingController();
TextEditingController _pobOfControllingPerson2 = TextEditingController();
TextEditingController _pobOfControllingPerson3 = TextEditingController();
TextEditingController _pobOfControllingPerson4 = TextEditingController();
TextEditingController _pobOfControllingPerson5 = TextEditingController();

TextEditingController name = new TextEditingController();
TextEditingController date = new TextEditingController();
TextEditingController dateHijri = new TextEditingController();

TextEditingController _nationalityOfControllingPerson1 =
    TextEditingController();
TextEditingController _nationalityOfControllingPerson2 =
    TextEditingController();
TextEditingController _nationalityOfControllingPerson3 =
    TextEditingController();
TextEditingController _nationalityOfControllingPerson4 =
    TextEditingController();
TextEditingController _nationalityOfControllingPerson5 =
    TextEditingController();

TextEditingController _taxResidencyOfControllingPerson1 =
    TextEditingController();
TextEditingController _taxResidencyOfControllingPerson2 =
    TextEditingController();
TextEditingController _taxResidencyOfControllingPerson3 =
    TextEditingController();
TextEditingController _taxResidencyOfControllingPerson4 =
    TextEditingController();
TextEditingController _taxResidencyOfControllingPerson5 =
    TextEditingController();

TextEditingController _tinOfControllingPerson1 = TextEditingController();
TextEditingController _tinOfControllingPerson2 = TextEditingController();
TextEditingController _tinOfControllingPerson3 = TextEditingController();
TextEditingController _tinOfControllingPerson4 = TextEditingController();
TextEditingController _tinOfControllingPerson5 = TextEditingController();

//int controllers
TextEditingController _ownershipOfControllingPerson1 = TextEditingController();
TextEditingController _ownershipOfControllingPerson2 = TextEditingController();
TextEditingController _ownershipOfControllingPerson3 = TextEditingController();
TextEditingController _ownershipOfControllingPerson4 = TextEditingController();
TextEditingController _ownershipOfControllingPerson5 = TextEditingController();
//ArabiccompanyName
TextEditingController CountryofIncorporation = TextEditingController();
List<Map<String, TextEditingController>> rowDataList = [{}];

bool checkbox1 = false;
bool checkbox2 = false;
bool checkbox3 = false;
bool checkbox15 = false;
bool checkbox16 = false;
bool checkbox17 = false;
bool checkbox18 = false;
bool checkbox33 = false;
bool checkbox9 = false;
bool checkbox10 = false;

List<TableRow> rows = [];

String _selectedItem = '';

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

class FatqaState extends State<Fatqa> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    setState(() {
      print(Fatqa.country.value);
      currentCountryValue1.text = Fatqa.country.value;
      ArabiccompanyName.text = Fatqa.CompanyNameAr.value;
      CompanyName.text = Fatqa.CompanyName.value;
      BuldingNumber.text = Fatqa.buildingnumber.value;
      District.text = Fatqa.district.value;
      StreetName.text = Fatqa.streetname.value;
      postalcode.text = Fatqa.POboxa.value;
      ZipCode.text = Fatqa.zipcode.value;

      currentStateValue1.text = Fatqa.state.value;
      currentCityValue1.text = Fatqa.city.value;
    });
  }

  void showHtmlAlert(BuildContext context, String htmlContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appendix'),
          content: SingleChildScrollView(
            child: Html(data: htmlContent),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void addNewRow() {
    setState(() {
      rowDataList.add({});
    });
  }

  //BuldingNumber

   void Fatca() async {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": Fatqa.id.value,
        "CountryorJurisdiction1": _CountryorJurisdiction1.text,
        "CountryorJurisdiction2": _CountryorJurisdiction2.text,
        "CountryorJurisdiction3": _CountryorJurisdiction3.text,
        "TaxIdNumber1": _TaxIdNumber1.text,
        "TaxIdNumber2": _TaxIdNumber2.text,
        "TaxIdNumber3": _TaxIdNumber3.text,
        "NoTinReason1": _NoTinReason1.text,
        "NoTinReason2": _NoTinReason2.text,
        "NoTinReason3": _NoTinReason3.text,
        "UsEntityandUsFinancial": _UsEntityandUsFinancial.text,
        "NonUsFinancialInstitution1": _NonUsFinancialInstitution1.text,
        "NonUsFinancialInstitution2": _NonUsFinancialInstitution2.text,
        "NonUsFinancialInstitution3": _NonUsFinancialInstitution3.text,
        "ActiveNFEName": _ActiveNFEName.text,
        "nameOfControllingPerson1": _nameOfControllingPerson1.text,
        "nameOfControllingPerson2": _nameOfControllingPerson2.text,
        "nameOfControllingPerson3": _nameOfControllingPerson3.text,
        "nameOfControllingPerson4": _nameOfControllingPerson4.text,
        "nameOfControllingPerson5": _nameOfControllingPerson5.text,
        "adressofControllingPerson1": _addressOfControllingPerson1.text,
        "adressofControllingPerson2": _addressOfControllingPerson2.text,
        "adressofControllingPerson3": _addressOfControllingPerson3.text,
        "adressofControllingPerson4": _addressOfControllingPerson4.text,
        "adressofControllingPerson5": _addressOfControllingPerson5.text,
        "dobOfControllingPerson1": _dobOfControllingPerson1.text,
        "dobOfControllingPerson2": _dobOfControllingPerson2.text,
        "dobOfControllingPerson3": _dobOfControllingPerson3.text,
        "dobOfControllingPerson4": _dobOfControllingPerson4.text,
        "dobOfControllingPerson5": _dobOfControllingPerson5.text,
        "pobOfControllingPerson1": _pobOfControllingPerson1.text,
        "pobOfControllingPerson2": _pobOfControllingPerson2.text,
        "pobOfControllingPerson3": _pobOfControllingPerson3.text,
        "pobOfControllingPerson4": _pobOfControllingPerson4.text,
        "pobOfControllingPerson5": _pobOfControllingPerson5.text,
        "nationalityOfControllingPerson1":
            _nationalityOfControllingPerson1.text,
        "nationalityOfControllingPerson2":
            _nationalityOfControllingPerson2.text,
        "nationalityOfControllingPerson3":
            _nationalityOfControllingPerson3.text,
        "nationalityOfControllingPerson4":
            _nationalityOfControllingPerson4.text,
        "nationalityOfControllingPerson5":
            _nationalityOfControllingPerson5.text,
        "taxResidencyOfControllingPerson1":
            _taxResidencyOfControllingPerson1.text,
        "taxResidencyOfControllingPerson2":
            _taxResidencyOfControllingPerson2.text,
        "taxResidencyOfControllingPerson3":
            _taxResidencyOfControllingPerson3.text,
        "taxResidencyOfControllingPerson4":
            _taxResidencyOfControllingPerson4.text,
        "taxResidencyOfControllingPerson5":
            _taxResidencyOfControllingPerson5.text,
        "tinOfControllingPerson1": _tinOfControllingPerson1.text,
        "tinOfControllingPerson2": _tinOfControllingPerson2.text,
        "tinOfControllingPerson3": _tinOfControllingPerson3.text,
        "tinOfControllingPerson4": _tinOfControllingPerson4.text,
        "tinOfControllingPerson5": _tinOfControllingPerson5.text,
        //bool
        "UsEntityUsSpecified": _UsEntityUsSpecified,
        "UsEntityUsNotSpecified": _UsEntityUsNotSpecified,
        "NonUsSaudiFinancial": NonUsSaudiFinancial,
        "NonUsParticipating": NonUsParticipating,
        "NonUsRegisteredDeemed": NonUsRegisteredDeemed,
        "NonUsCertifiedDeemed": NonUsCertifiedDeemed,
        "NonUsNonParticipating": NonUsNonParticipating,
        "ExemptEntitiesOwner": ExemptEntitiesOwner,
        "NonUsEntityExcepted": NonUsEntityExcepted,
        "NonUsEntityActive": NonUsEntityActive,
        "NonUsEntityPassive": NonUsEntityPassive,
        "FINonParticipatingCountry":
            FinancialInstitutionOption.FINonParticipatingCountry,
        "FIOtherEntity": FIOtherEntity,
        "FIDepository": FIDepository,
        "ActiveNFE": ActiveNFE,
        "ActiveNFEGovermentEntity": ActiveNFEGovermentEntity,
        "ActiveNFEInternationalOrganisation":
            ActiveNFEInternationalOrganisation,
        "ActiveNFEOtherThan15to17": ActiveNFEOtherThan15to17,
        "PassiveNFE": PassiveNFE,
        "Addendum1": Addendum1,
        "ControllingPerson": ControllingPerson,
        "TermsandConditions": TermsandConditions,
        //int
        "ownershipOfControllingPerson1":
            int.tryParse(_ownershipOfControllingPerson1.text) ?? 0,
        "ownershipOfControllingPerson2":
            int.tryParse(_ownershipOfControllingPerson2.text) ?? 0,
        "ownershipOfControllingPerson3":
            int.tryParse(_ownershipOfControllingPerson3.text) ?? 0,
        "ownershipOfControllingPersons4":
            int.tryParse(_ownershipOfControllingPerson4.text) ?? 0,
        "ownershipOfControllingPerson5":
            int.tryParse(_ownershipOfControllingPerson5.text) ?? 0
      };

      final response = await http.post(
        Uri.parse('https://eastbridge.online/apicore/api/Fatca/FatcaApi/'),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response
        var responseData = jsonDecode(response.body);
        print("Successful");

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

    var items = [
      'Account Holder',
      'Power Of Autorney',
      'Gaurdian',
      'Other',
    ];

    var items2 = [
      'Account Holder',
      'Power Of Attorney',
      'Guardian',
      'Other',
    ];

  @override
  Widget build(BuildContext context) {
    String htmlContent = '''
<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=Generator content="Microsoft Word 15 (filtered)">
<style>
<!--
 / Font Definitions /
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 / Style Definitions /
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:20.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
@page WordSection1
	{size:12.0in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
 / List Definitions /
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=EN-US style='word-wrap:break-word'>

<div class=WordSection1>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='background:white;border-collapse:collapse'>
 <tr>
  <td width=1169 colspan=2 style='width:876.75pt;background:#FCFCFC;padding:
  12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:13.0pt;font-family:"Arial",sans-serif;color:#333333'>Foreign
  Account Tax Compliance Act (FATCA) Definitions - Entities</span></b></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:13.0pt;font-family:"Arial",sans-serif;color:#333333'>US
  Entities &amp; US Financial Institutions</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>1.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Specified US Person This classification covers a
  privately-owned US corporation; a US partnership; a US trust; an individual
  who is a US citizen; an individual who is not a US citizen but who is
  resident in the US for tax purposes; or the estate of either of the
  above-mentioned category of individual. Example: A privately-owned US
  corporation operating in the KSA pursuant to a license from the KSA
  Government, or the KSA branch of a privately-owned US corporation licensed in
  the KSA by the Saudi Arabian General Investment Authority (SAGIA).</span></p>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>2.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>US Person who is not a Specified US Person This classification
  covers the US itself; any State or Territory of the US; the US Government;
  any wholly-owned agency of the US Government; a US bank; a US corporation
  whose stock is regularly traded on an established stock exchange; or a US
  regulated investment company.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Non-US
  Financial Institutions</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>3.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>KSA Financial Institution or Financial Institution means (i)
  any Financial Institution organized under the laws of the Kingdom of Saudi
  Arabia, but excluding any branch of such Financial Institution that is
  located outside the Kingdom of Saudi Arabia, and (ii) any branch of a
  Financial Institution not organized under the laws of the Kingdom of Saudi
  Arabia, if such branch is located in the Kingdom of Saudi Arabia</span></p>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>4.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Participating Non-US Financial Institution<br>
  This classification is also known as a Participating Foreign Financial
  Institution or PFFI.<br>
  This classification covers a non-US financial institution that is organized
  in a country which has not entered into an intergovernmental agreement with
  the US regarding FATCA, but where the financial institution itself has
  entered into an agreement with the US IRS regarding FATCA.</span></p>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>5.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Deemed-Compliant Non-US Financial Institution<br>
  This classification is also known as a Deemed-Compliant Foreign Financial
  Institution or Deemed-Compliant FFI.<br>
  This classification covers a non-US financial institution that is organized
  in a country which has not entered into an intergovernmental agreement with
  the US regarding FATCA, but where: (i) the financial institution has
  registered itself with the US IRS to declare its status; or<br>
  (ii) the financial institution is not required to register with the US IRS
  and has certified itself accordingly.<br>
  The type of non-US financial institution described at item (i) above is a
  Registered Deemed-Compliant Non-US Financial Institution (also known as a
  Registered Deemed-Compliant Foreign Financial Institution or Registered
  Deemed-Compliant FFI).<br>
  The type of non-US financial institution described at item (ii) above is a
  Certified Deemed-Compliant Non-US Financial Institution (also known as a
  Certified Deemed-Compliant Foreign Financial Institution or Certified
  Deemed-Compliant FFI).</span></p>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>6.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Non-Participating Non-US Financial Institution<br>
  This classification is also known as a Non-Participating Foreign Financial
  Institution or Non-Participating FFI.<br>
  This classification covers a non-US financial institution that is organized
  in a country which has not entered into an intergovernmental agreement with
  the US regarding FATCA, where the non-US financial institution itself is not
  (i) a Participating Non-US Financial Institution, (ii) a Registered
  Deemed-Compliant Non-US Financial Institution, or (iii) a Certified
  Deemed-Compliant Non-US Financial Institution.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Excepted
  NFFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>7.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Excepted Non-Financial Non-US Entity<br>
  This classification is also known as an Excepted Non-Financial Foreign Entity
  or Excepted NFFE.<br>
  This classification covers an entity that meets the following criteria:<br>
  (i) it is not a US entity;<br>
  (ii) it is not a financial institution; and<br>
  (iii) it is classified as an ‘Excepted NFFE’ under US Treasury Regulations.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Exempt
  Entities</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>8.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Exempt Beneficial Owner<br>
  This classification covers a governmental entity (other than a US
  governmental entity); an international organization; a central bank (other
  than the US Federal Reserve); a non-US retirement fund; or a non-US
  investment entity that is wholly-owned by any of the aforementioned</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Active
  NFFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>9.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;
  </span></span><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>Active Non-Financial Non-US Entity<br>
  This classification is also known as an Active Non-Financial Foreign Entity
  or Active NFFE.<br>
  This classification covers an entity that meets the following criteria:<br>
  (i) it is not a US entity;<br>
  (ii) it is not a financial institution; and<br>
  (iii) it meets any one of the following further criteria:<br>
  (1) It holds less than 50% of its assets in shares, properties, bonds or
  similar investment assets, and it derives less than 50% of its gross income
  from the distribution of dividends, rental income, interest or other
  investment income; or<br>
  (2) It is a listed company whose stock is regularly traded on an established
  securities market, or it is related to an entity whose stock is regularly
  traded on an established securities market; or<br>
  (3) It is organized in a US Territory, and all of its owners are bona fide
  residents of that US Territory; or<br>
  (4) It is a government (other than the US Government); a government of a US
  Territory; an international organization; a central bank of issue (other than
  of the US); or an entity wholly owned by one or more of the above; or<br>
  (5) Its activities consist substantially of holding shares of, or providing
  financing to, subsidiaries that engage in trades or businesses other than the
  business of a financial institution; and it does not function (or hold itself
  out as) an investment fund; or<br>
  (6) It is in its set-up phase (with no prior operating history), is investing
  capital into assets with the intention of operating a business other than the
  business of a financial institution, and less than twenty-four (24) months
  have passed since it was initially organized; or<br>
  (7) It was not a financial institution in the past five (5) years, and is in
  the process of liquidating its assets or is reorganizing with the intent to
  continue or recommence operations in a business other than that of a
  financial institution; or<br>
  (8) It engages primarily in financing and hedging transactions with or for
  related entities that are not financial institutions, and it does not provide
  financing or hedging services to any entity to which it is not related; or<br>
  (9) It meets all of the following criteria:<br>
  (i) It is established in its country of residence exclusively for religious,
  charitable, scientific, artistic, cultural, or educational purposes; or it is
  a professional organization, chamber of commerce or labor organization; and<br>
  (ii) It is exempt from income tax in its country of residence; and<br>
  (iii) It has no shareholders who have a proprietary or beneficial interest in
  its income or assets; and<br>
  (iv) The laws of its country of residence or its formation documents do not
  permit:<br>
  (a) any of its income or assets to be distributed to, or applied for the
  benefit of, a private person or non-charitable entity other than pursuant to
  the conduct of its charitable activities, or as payment of reasonable
  compensation for services rendered, or as payment representing the fair
  market value of property which it has purchased; and<br>
  (b) upon its liquidation or dissolution, all of its assets be distributed to
  a governmental entity or other non-profit organization, or escheat to the
  government of its country of residence or any political subdivision thereof.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Passive
  NFFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal style='margin-right:22.5pt;margin-left:58.5pt;text-indent:
  -.25in;line-height:18.0pt'><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#2C2A29'>10.<span style='font:7.0pt "Times New Roman"'>&nbsp;&nbsp; </span></span><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#2C2A29'>Passive
  Non-Financial Non-US Entity<br>
  This classification is also known as a Passive Non-Financial Foreign Entity
  or Passive NFFE.<br>
  This classification covers an entity that meets the following criteria:<br>
  (i) it is not a US entity;<br>
  (ii) it is not a financial institution; and<br>
  (iii) it does not meet the criteria to be either an Excepted NFFE or an
  Active NFFE.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Direct
  Reporting NFFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#333333'>A Passive NFFE can elect to directly report to the IRS
  information about its direct or indirect Substantial US Owners. These types
  of Passive NFFEs are known as Direct Reporting NFFEs. In order to report
  directly to the IRS, Direct Reporting NFFEs will be required to register with
  the IRS to obtain a Global Intermediary Identification Number (GIIN).</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Sponsored
  Direct Reporting NFFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#333333'>An Entity will be allowed to sponsor one or more Direct
  Reporting NFFEs, this entity will be known as a Sponsored Direct Reporting
  NFFE</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Global
  Intermediary Identification Number (GIIN)</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#333333'>A GIIN is the identification number used to identify the FFI
  for FATCA registration purposes and U.S. information reporting purposes</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Intergovernmental
  Agreement (IGA)</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#333333'>Intergovernmental agreements are intended to enable FFIs to
  identify and report to the IRS U.S. persons that hold assets abroad and for
  certain non-financial foreign entities (NFFEs) to identify their substantial
  U.S. owners. In order to comply with the rules, FFIs are required to enter
  into an FFI agreement with the U.S. Treasury or comply with intergovernmental
  agreements (IGAs) entered into by their local jurisdictions. U.S. withholding
  agents (USWAs) must document all of their relationships with foreign entities
  in order to assist with the enforcement of the rules</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal align=center style='text-align:center'><b><span
  style='font-size:12.0pt;font-family:"Arial",sans-serif;color:#333333'>Non-financial
  foreign entity (NFFE)</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='font-size:12.0pt;font-family:"Arial",sans-serif;
  color:#333333'>The term NFFE means a foreign entity that is not a financial
  institution (including a territory NFFE). The term also means a foreign
  entity treated as an NFFE pursuant to a Model 1 IGA or Model 2 IGA</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal>&nbsp;</p>

</div>

</body>

</html>
''';

    String htmlContent2 = '''

<html>

<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<meta name=Generator content="Microsoft Word 15 (filtered)">
<style>
<!--
 / Font Definitions /
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
 / Style Definitions /
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:8.0pt;
	margin-left:0in;
	line-height:107%;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-link:"Header Char";
	margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-link:"Footer Char";
	margin:0in;
	font-size:12.0pt;
	font-family:"Calibri",sans-serif;}
span.HeaderChar
	{mso-style-name:"Header Char";
	mso-style-link:Header;}
span.FooterChar
	{mso-style-name:"Footer Char";
	mso-style-link:Footer;}
.MsoChpDefault
	{font-family:"Calibri",sans-serif;}
.MsoPapDefault
	{margin-bottom:8.0pt;
	line-height:107%;}
 / Page Definitions /
 @page WordSection1
	{size:595.0pt 842.0pt;
	margin:96.55pt 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
 / List Definitions /
 ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>

</head>

<body lang=EN-US style='word-wrap:break-word'>

<div class=WordSection1>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='background:white;border-collapse:collapse'>
 <tr>
  <td width=1169 colspan=2 style='width:876.75pt;background:#FCFCFC;padding:
  12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b>COMMON REPORTING STANDARD (CRS) DEFINITIONS</b></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Account Holder</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>Account Holder means the person
  listed or identified as the holder of a Financial Account by the Financial
  Institution that maintains the account. A person, other than a Financial Institution,
  holding a Financial Account for the benefit or account of another person as
  agent, custodian, nominee, signatory, investment advisor, or intermediary, is
  not treated as holding the account for purposes of the Common Reporting
  Standard, and such other person is treated as holding the account.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Tax Residency</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>Tax residency is the country
  where you are resident/registered for tax purposes. Each country has its own
  rules for defining tax residence. For more information on tax residence,
  please consult your tax advisor or check the OECD information readily
  available on the internet.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Entity</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Entity” means a legal
  person or a legal arrangement, such as a corporation, organization,
  partnership, trust or foundation. This term covers any person other than an
  individual (i.e. a natural person).</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Financial Institution</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Financial Institution”
  means a “Custodial Institution”, a “Depository Institution”, an “Investment
  Entity”, or a “Specified Insurance Company”. Please see the relevant domestic
  guidance and the CRS for further classification definitions that apply to
  Financial Institutions</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Depository Institution</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Depository
  Institution” means any Entity that accepts deposits in the ordinary course of
  a banking or similar business.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Custodial Institution</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Custodial Institution”
  means any Entity that holds, as a substantial portion of its business,
  Financial Assets for the account of others. This is where the Entity’s gross
  income attributable to the holding of Financial Assets and related financial
  services equals or exceeds 20% of the Entity’s gross income during the
  shorter of: (i) the three-year period that ends on 31 December (or the final
  day of a non-calendar year accounting period) prior to the year in which the
  determination is being made; or (ii) the period during which the Entity has
  been in existence.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Controlling Person(s)</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>“Controlling Persons” are the
  natural person(s) who exercise control over an entity. Where that entity is
  treated as a Passive Non-Financial Entity (“Passive NFE”) then a Financial
  Institution is required to determine whether or not these Controlling Persons
  are Reportable Persons. This definition corresponds to the term “beneficial
  owner” described in Recommendation 10 and the Interpretative Note on
  Recommendation 10 of the Financial Action Task Force Recommendations (as
  adopted in February 2012). In the case of a trust, the Controlling Person(s)
  are the settlor(s), the trustee(s), the protector(s) (if any), the
  beneficiary(is) or class(es) of beneficiaries, or any other natural person(s)
  exercising ultimate effective control over the trust (including through a
  chain of control or ownership). Under the CRS the settlor(s), the trustee(s),
  the protector(s) (if any), and the beneficiary(ies) or class(es) of
  beneficiaries, are always treated as Controlling Persons of a trust,
  regardless of whether or not any of them exercises control over the
  activities of the trust.<br>
  Where the settlor(s) of a trust is an Entity then the CRS requires Financial
  Institutions to also identify the Controlling Persons of the settlor(s) and
  when required report them as Controlling Persons of the trust. In the case of
  a legal arrangement other than a trust, “Controlling Person(s) means persons
  in equivalent or similar positions FATF Recommendations on Controlling
  Persons:<br>
  Identify the beneficial owners of the customer and take reasonable measures
  to verify the identity of such persons, through the following information.
  For legal persons: The identity of the natural persons (if any – as ownership
  interests can be so diversified that there are no natural persons (whether
  acting alone or together) exercising control of the legal person or
  arrangement through ownership) who ultimately have a controlling ownership
  interest in a legal person; and to the extent that there is doubt under (a)
  as to whether the person(s) with the controlling ownership interest are the
  beneficial owner(s) or where no natural person exerts control through
  ownership interests, the identity of the natural persons (if any) exercising
  control of the legal person or arrangement through other means. Where no
  natural person is identified under (a) or (b) above, financial institutions
  should identify and take reasonable measures to verify the identity of the
  relevant natural person who holds the position of senior managing official.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Active NFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>An NFE is an Active NFE if it
  meets any of the criteria listed below. In summary, those criteria refer to:</span></p>
  <ul style='margin-top:0in' type=disc>
   <li class=MsoNormal><span style='color:black'>active NFEs by reason of
       income and assets;</span></li>
   <li class=MsoNormal><span style='color:black'>publicly traded NFEs;</span></li>
   <li class=MsoNormal><span style='color:black'>Governmental Entities,
       International Organizations, Central Banks, or their wholly owned
       Entities;</span></li>
   <li class=MsoNormal><span style='color:black'>holding NFEs that are members
       of a nonfinancial group;</span></li>
   <li class=MsoNormal><span style='color:black'>start-up NFEs;</span></li>
   <li class=MsoNormal><span style='color:black'>NFEs that are liquidating or
       emerging from bankruptcy;</span></li>
   <li class=MsoNormal><span style='color:black'>treasury centers that are
       members of a nonfinancial group; or</span></li>
   <li class=MsoNormal><span style='color:black'>non-profit NFEs.</span></li>
  </ul>
  <p class=MsoNormal><span style='color:black'><br>
  An entity will be classified as Active NFE if it meets any of the following
  criteria:<br>
  a) less than 50% of the NFE’s gross income for the preceding calendar year or
  other appropriate reporting period is passive income and less than 50% of the
  assets held by the NFE during the preceding calendar year or other
  appropriate reporting period are assets that produce or are held for the
  production of passive income;<br>
  b) the stock of the NFE is regularly traded on an established securities
  market or the NFE is a Related Entity of an Entity the stock of which is
  regularly traded on an established securities market;<br>
  c) the NFE is a Governmental Entity, an International Organization, a Central
  Bank, or an Entity wholly owned by one or more of the foregoing;<br>
  d) substantially all of the activities of the NFE consist of holding (in
  whole or in part) the outstanding stock of, or providing financing and
  services to, one or more subsidiaries that engage in trades or businesses other
  than the business of a Financial Institution, except that an Entity does not
  qualify for this status if the Entity functions (or holds itself out) as an
  investment fund, such as a private equity fund, venture capital fund,
  leveraged buyout fund, or any investment vehicle whose purpose is to acquire
  or fund companies and then hold interests in those companies as capital
  assets for investment purposes;<br>
  e) the NFE is not yet operating a business and has no prior operating
  history, (a “ start-up NFE”) but is investing capital into assets with the
  intent to operate a business other than that of a Financial Institution,
  provided that the NFE does not qualify for this exception after the date that
  is 24 months after the date of the initial organization of the NFE;<br>
  f) the NFE was not a Financial Institution in the past five years, and is in
  the process of liquidating its assets or is reorganizing with the intent to
  continue or recommence operations in a business other than that of a
  Financial Institution;<br>
  g) the NFE primarily engages in financing and hedging transactions with, or
  for, Related Entities that are not Financial Institutions, and does not
  provide financing or hedging services to any Entity that is not a Related
  Entity, provided that the group of any such Related Entities is primarily
  engaged in a business other than that of a Financial Institution; or<br>
  h) the NFE meets all of the following requirements (a “non-profit NFE”):<br>
  i) it is established and operated in its jurisdiction of residence
  exclusively for religious, charitable, scientific, artistic, cultural,
  athletic, or educational purposes; or it is established and operated in its
  jurisdiction of residence and it is a professional organization, business
  league, chamber of commerce, labor organization, agricultural or
  horticultural organization, civic league or an organization operated
  exclusively for the promotion of social welfare; ii) it is exempt from income
  tax in its jurisdiction of residence;<br>
  iii) it has no shareholders or members who have a proprietary or beneficial
  interest in its income or assets;<br>
  iv) the applicable laws of the NFE’s jurisdiction of residence or the NFE’s
  formation documents do not permit any income or assets of the NFE to be
  distributed to, or applied for the benefit of, a private person or
  non-charitable Entity other than pursuant to the conduct of the NFE’s
  charitable activities, or as payment of reasonable compensation for services
  rendered, or as payment representing the fair market value of property which
  the NFE has purchased; and<br>
  v) the applicable laws of the NFE’s jurisdiction of residence or the NFE’s
  formation documents require that, upon the NFE’s liquidation or dissolution,
  all of its assets be distributed to a Governmental Entity or other non-profit
  organization, or escheat to the government of the NFE’s jurisdiction of
  residence or any political subdivision.<br>
  Note: Certain entities (such as U.S. Territory NFFEs) may qualify for Active
  NFFE status under FATCA but not Active NFE status under the CRS.<br>
  Related Entity - An Entity is a “Related Entity” of another Entity if either
  Entity controls the other Entity, or the two Entities are under common
  control. For this purpose, control includes direct or indirect ownership of
  more than 50% of the vote and value in an Entity.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Passive NFE</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>Under the CRS a “Passive NFE”
  means any NFE that is not an Active NFE. An Investment Entity located in a
  Non-Participating Jurisdiction and managed by another Financial Institution
  is also treated as a Passive NFE for purposes of the CRS.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Specified Insurance Company</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Specified Insurance
  Company” means any Entity that is an insurance company (or the holding
  company of an insurance company) that issues, or is obligated to make
  payments with respect to, a Cash Value Insurance Contract or an Annuity
  Contract.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Participating Jurisdiction
  Financial Institution</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term “Participating
  Jurisdiction Financial Institution means (i) any Financial Institution that
  is tax resident in a Participating Jurisdiction, but excludes any branch of
  that Financial Institution that is located outside of that jurisdiction, and
  (ii) any branch of a Financial Institution that is not tax resident in a
  Participating Jurisdiction, if that branch is located in such Participating
  Jurisdiction.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Non-Reporting Financial
  Institution</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>A &quot;Non-Reporting Financial
  Institution” means any Financial Institution that is:</span></p>
  <ul style='margin-top:0in' type=disc>
   <li class=MsoNormal><span style='color:black'>a Governmental Entity,
       International Organization or Central Bank, other than with respect to a
       payment that is derived from an obligation held in connection with a
       commercial financial activity of a type engaged in by a Specified
       Insurance Company, Custodial Institution, or Depository Institution;</span></li>
   <li class=MsoNormal><span style='color:black'>a Broad Participation
       Retirement Fund; a Narrow Participation Retirement Fund; a Pension Fund
       of a Governmental Entity, International Organization or Central Bank; or
       a Qualified Credit Card Issuer;</span></li>
   <li class=MsoNormal><span style='color:black'>an Exempt Collective
       Investment Vehicle; or</span></li>
   <li class=MsoNormal><span style='color:black'>a Trustee-Documented Trust: a
       trust where the trustee of the trust is a Reporting Financial
       Institution and reports all information required to be reported with
       respect to all Reportable Accounts of the trust;</span></li>
   <li class=MsoNormal><span style='color:black'>any other defined in a
       countries domestic law as a Non-Reporting Financial Institution.</span></li>
  </ul>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Related Entity</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>Related Entity means an entity
  related to another entity because (i) either entity controls the other
  entity; (ii) the two entities are under common control; or (iii) the two
  entities are Investment Entities are under common management, and such
  management fulfils the due diligence obligations of such Investment Entities.
  For this purpose, control includes direct or indirect ownership of more than
  50 % of the vote and value in an Entity.</span></p>
  </td>
 </tr>
 <tr>
  <td width=1169 colspan=2 style='width:876.75pt;background:#FCFCFC;padding:
  12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>COMMON FATCA &amp; CRS
  DEFINITIONS</span></b></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>TAX Identification Number
  (TIN)</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>A Taxpayer Identification /
  Information Number (TIN) is a unique combination of letters and/or numbers
  assigned to the person or you/your entity. Some countries do not issue a TIN,
  but may rely on other issued numbers such as social security/insurance numbers
  or company registration numbers for entities. You may need to provide these
  if requested. The OECD has published a list of the acceptable Taxpayer
  Identification Number (TIN) formats and their alternatives.<br>
  For US Persons and/or tax residents, a US TIN can be one of the following:</span></p>
  <ul style='margin-top:0in' type=disc>
   <li class=MsoNormal><span style='color:black'>Social Security Number (SSN)</span></li>
   <li class=MsoNormal><span style='color:black'>Individuals Tax Identification
       Number (ITIN)</span></li>
   <li class=MsoNormal><span style='color:black'>Tax Identification Number for
       Pending US Adoptions (ATIN)</span></li>
  </ul>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Beneficial Owner</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>The term beneficial owner means
  the person who is the owner of the income for tax purposes and who
  beneficially owns that income. Thus, a person receiving income in a capacity
  as a nominee, agent or custodian for another person is not the beneficial
  owner of the income.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#F0F0F0;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Change in Circumstance</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#F0F0F0;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>A change in circumstance is one
  that either results in the change of or conflicts with a person’s current
  status. These circumstances can include a change in the account holder’s
  status, account, or any other related account.</span></p>
  </td>
 </tr>
 <tr>
  <td width=390 style='width:292.25pt;background:#FCFCFC;padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><b><span style='color:black'>Self-Certification Forms</span></b></p>
  </td>
  <td style='border:none;border-left:dotted #6A6A6A 1.5pt;background:#FCFCFC;
  padding:12.0pt 12.0pt 12.0pt 12.0pt'>
  <p class=MsoNormal><span style='color:black'>A completed self-certification
  form is used to confirm your FATCA classification &amp; Tax residency status
  under the CRS.</span></p>
  </td>
 </tr>
</table>

<p class=MsoNormal><span lang=AR-SA dir=RTL style='font-family:"Arial",sans-serif'>&nbsp;</span></p>

<p class=MsoNormal>&nbsp;</p>

</div>

</body>

</html>
''';
    //

   

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "Account Holder Information",
                      style: TextController.MainHeadingText,
                    )),
                    Text(
                      "A. Company Name",
                      style: TextController.SubHeadingText,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Company Name\n(English)",
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
                                  child: TextFormField(
                                    style: TextController.BodyText,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: CompanyName,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "ABC Holding",
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Company Name\n(Arabic)",
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
                                  child: TextFormField(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[\u0600-\u06FF\s]')),
                                    ],
                                    style: TextController.BodyText,
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: ArabiccompanyName,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "ABC Holding",
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(child: Container()),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Text(
                        "B. Country Of Incorporation",
                        style: TextController.SubHeadingText,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).Country,
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 270,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  controller: CountryofIncorporation,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).City,
                                style: TextController.BodyText,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 270,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyText,
                                  controller: _city,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(child: Container()),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "C. Current Residence Address",
                        style: TextController.SubHeadingText,
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).BuildingNo,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: BuldingNumber,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "District",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: District,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).StreetName,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: StreetName,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Postal Code",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        controller: postalcode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).ZipCode,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: ZipCode,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     border: Border.all(
                                      //         color: ColorSelect.textField)),
                                      // child: Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 15, bottom: 10),
                                      //   child: TextFormField(
                                      //     controller: Fax2,
                                      //     decoration: InputDecoration(
                                      //
                                      //         hintStyle:
                                      //             TextController.labelText,
                                      //         border: InputBorder.none),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 130,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).Country,
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      S.of(context).State,
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      S.of(context).City,
                                      style: TextController.BodyText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(
                              children: [
                                // CSCPicker (Hidden by default)
                                Visibility(
                                  visible: showCSCPicker,
                                  child: Container(
                                    width: 290,
                                    height: 170,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CSCPicker(
                                            layout: Layout.vertical,
                                            flagState: CountryFlag.DISABLE,
                                            onCountryChanged: (value) {
                                              setState(() {
                                                currentCountryValue = value;
                                                showCountryError = false;
                                              });
                                            },
                                            onStateChanged: (value) {
                                              setState(() {
                                                currentStateValue = value;
                                                showStateError = false;
                                              });
                                            },
                                            onCityChanged: (value) {
                                              setState(() {
                                                currentCityValue = value;
                                                showCityError = false;
                                              });
                                            },
                                          ),
                                          if (showCountryError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Select a country, state & city',
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          // Show state error below state dropdown
                                          if (showStateError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Select a state',
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          // Show city error below city dropdown
                                          if (showCityError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                'Select a city',
                                                style: TextController.errorText,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // TextFormFields (Initially shown, hidden when checkbox is checked)
                                Visibility(
                                  visible: !showCSCPicker,
                                  child: Container(
                                    width: 290,
                                    height: 170,
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, bottom: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 270,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
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
                                              controller: currentCountryValue1,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 270,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
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
                                              controller: currentStateValue1,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: 270,
                                            height: 35,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
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
                                              controller: currentCityValue1,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // Checkbox to toggle visibility
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 800),
                      child: Row(
                        children: [
                          Checkbox(
                            value: showCSCPicker,
                            onChanged: (newValue) {
                              setState(() {
                                showCSCPicker = newValue!;
                              });
                            },
                          ),
                          Text(
                              "If you want to change the address, Please click here!"), // Add a label for the checkbox
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "D. Mailing Address",
                        style: TextController.SubHeadingText,
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).BuildingNo,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: BuldingNumber2,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).District,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: District2,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).StreetName,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        controller: StreetName2,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).PostalCode,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        style: TextController.BodyText,
                                        controller: postalcode2,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).ZipCode,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        controller: ZipCode2,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 270,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, bottom: 10),
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: Fax2,
                                          decoration: InputDecoration(
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 130,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).Country,
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      S.of(context).State,
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      S.of(context).City,
                                      style: TextController.BodyText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: 290,
                              height: 170,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CSCPicker(
                                      layout: Layout.vertical,
                                      flagState: CountryFlag.DISABLE,
                                      onCountryChanged: (value) {
                                        setState(() {
                                          currentCountryValue = value;
                                          showCountryError = false;
                                        });
                                      },
                                      onStateChanged: (value) {
                                        setState(() {
                                          currentStateValue = value;
                                          showStateError = false;
                                        });
                                      },
                                      onCityChanged: (value) {
                                        setState(() {
                                          currentCityValue = value;
                                          showCityError = false;
                                        });
                                      },
                                    ),
                                    if (showCountryError)
                                      Text(
                                        'Select a country, state & city',
                                        style: TextController.errorText,
                                      ),
                                    // Show state error below state dropdown
                                    if (showStateError)
                                      Text(
                                        'Select a state',
                                        style: TextController.errorText,
                                      ),
                                    // Show city error below city dropdown
                                    if (showCityError)
                                      Text(
                                        'Select a city',
                                        style: TextController.errorText,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      "Part 2: Tax Residence Information",
                      style: TextController.MainHeadingText,
                    )),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, right: 20, bottom: 20),
                        child: TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                // In the builder method, return the dialog widget
                                return AlertDialog(
                                  title: Text(
                                    'Questions',
                                    style: TextController.BodyText,
                                  ),
                                  content: Container(
                                    width: 900,
                                    // width: double.infinity,
                                    child: Table(
                                      border: TableBorder.all(
                                          color: ColorSelect.tabBorderColor),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      columnWidths: {
                                        // 0: FixedColumnWidth(1000),
                                        // 1: FixedColumnWidth(1000),
                                        // 2: FixedColumnWidth(1000),
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1),
                                        2: FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                            decoration: BoxDecoration(
                                              color: ColorSelect.east_grey,
                                            ),
                                            children: [
                                              Container(
                                                  // height: 50,
                                                  padding: EdgeInsets.all(10),
                                                  child: Center(
                                                      child: Text(
                                                    "Please complete the following table indicating (1) the country (or countries) in which the Account Holder is a resident for tax purposes and (2) the Account Holder’s Taxpayer Identification Number or functional equivalent (hereafter referred to as 'TIN') for each country indicated.",
                                                    style:
                                                        TextController.BodyText,
                                                  ))),
                                            ]),
                                        TableRow(children: [
                                          Container(
                                              // height: 50,
                                              padding: EdgeInsets.all(10),
                                              child: Center(
                                                  child: Text(
                                                "If a TIN is unavailable please provide the below appropriate reason :",
                                                style: TextController.BodyText,
                                              ))),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                              // height: 50,
                                              child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Reason A - The country/jurisdiction where the Account Holder is resident does not issue TINs to its residents",
                                              style: TextController.BodyText,
                                            ),
                                          )),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                              // height: 50,
                                              child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Reason B - The Account Holder is otherwise unable to obtain a TIN or equivalent number (Please explain why you are unable to obtain a TIN in the below table if you have selected this reason)",
                                              style: TextController.BodyText,
                                            ),
                                          )),
                                        ]),
                                        TableRow(children: [
                                          Container(
                                              // height: 50,
                                              child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              "Reason C - No TIN is required. (Note. Only select this reason if the domestic law of the relevant country/jurisdiction does not require the collection of the TIN issued by such country/jurisdiction",
                                              style: TextController.BodyText,
                                            ),
                                          )),
                                        ]),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Close'),
                                      onPressed: () {
                                        // Close the dialog box when the "Close" button is pressed
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            '   Tax Residence Information (Click to Know More)',
                            style: TextController.BodyHeadingText1,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
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
                          TableRow(children: [
                            Container(
                                height: 70,
                                color: ColorSelect.east_grey,
                                child: Center(
                                    child: Text(
                                  "Country/Jurisdiction of tax residence",
                                  style: TextController.tableHeading,
                                ))),
                            Container(
                                height: 70,
                                color: ColorSelect.east_grey,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Center(
                                      child: Text(
                                    "Tax Identification Number (TIN)",
                                    style: TextController.tableHeading,
                                    maxLines: 3,
                                  )),
                                )),
                            Container(
                                height: 70,
                                color: ColorSelect.east_grey,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Center(
                                      child: Text(
                                    "If no TIN available type the reason",
                                    style: TextController.tableHeading,
                                    maxLines: 3,
                                  )),
                                )),
                          ]),
                          TableRow(children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     border: Border.all(
                                //         color:
                                //             ColorSelect.textField)),
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _CountryorJurisdiction1,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      errorStyle: TextController.inputErrorText,
                                      enabledBorder: InputBorder.none,
                                      hintStyle: TextController.labelText,
                                    ),
                                  ),
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
                                      _CountryorJurisdiction1.text = suggestion;
                                    });
                                  },
                                ),
                              ),

                              // TextFormField(
                              //   controller: _CountryorJurisdiction1,
                              //   decoration: InputDecoration(),
                              // ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _TaxIdNumber1,
                                decoration: InputDecoration(),
                                validator: (value) {
                                  if (_TaxIdNumber1 == null) {
                                    return 'This field is required.';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _NoTinReason1,
                                decoration: InputDecoration(),
                                validator: (value) {
                                  if (_NoTinReason1 == null) {
                                    return 'This field is required.';
                                  }
                                  return null; // Return null if the input is valid
                                },
                              ),
                            )),
                          ]),
                          TableRow(children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     border: Border.all(
                                //         color:
                                //             ColorSelect.textField)),
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _CountryorJurisdiction2,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      errorStyle: TextController.inputErrorText,
                                      enabledBorder: InputBorder.none,
                                      hintStyle: TextController.labelText,
                                    ),
                                  ),
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
                                      _CountryorJurisdiction2.text = suggestion;
                                    });
                                  },
                                ),
                              ),
                              // TextFormField(
                              //   controller: _CountryorJurisdiction2,
                              //   decoration: InputDecoration(),
                              // ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _TaxIdNumber2,
                                validator: (value) {
                                  if (_TaxIdNumber2 == null) {
                                    return 'This field is required.';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(),
                              ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _NoTinReason2,
                                validator: (value) {
                                  if (_NoTinReason2 == null) {
                                    return 'This field is required.';
                                  }
                                  return null; // Return null if the input is valid
                                },
                                decoration: InputDecoration(),
                              ),
                            )),
                          ]),
                          TableRow(children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                // decoration: BoxDecoration(
                                //     color: Colors.white,
                                //     border: Border.all(
                                //         color:
                                //             ColorSelect.textField)),
                                child: TypeAheadField(
                                  textFieldConfiguration:
                                      TextFieldConfiguration(
                                    textAlignVertical: TextAlignVertical.center,
                                    controller: _CountryorJurisdiction3,
                                    style: TextController.BodyText,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      errorStyle: TextController.inputErrorText,
                                      enabledBorder: InputBorder.none,
                                      hintStyle: TextController.labelText,
                                    ),
                                  ),
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
                                      _CountryorJurisdiction3.text = suggestion;
                                    });
                                  },
                                ),
                              ),

                              // TextFormField(
                              //   controller: _CountryorJurisdiction3,
                              //   decoration: InputDecoration(),
                              // ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _TaxIdNumber3,
                                decoration: InputDecoration(),
                              ),
                            )),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: _NoTinReason3,
                                decoration: InputDecoration(),
                              ),
                            )),
                          ]),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        "   If the Account Holder is tax resident in more than three countries/jurisdictions, please use a separate sheet",
                        style: TextController.BodyText,
                      ),
                    ),

                    // First, create a text widget that you want to be clickable
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // In the builder method, return the dialog widget
                              return AlertDialog(
                                title: Text(
                                  'Questions',
                                  style: TextController.BodyText,
                                ),
                                content: Table(
                                  border: TableBorder.all(
                                      color: ColorSelect.tabBorderColor),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth(1000),
                                    1: FixedColumnWidth(1000),
                                    2: FixedColumnWidth(1000),
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: ColorSelect.east_grey,
                                        ),
                                        children: [
                                          Container(
                                              height: 50,
                                              child: Center(
                                                  child: Text(
                                                "   WHY HAVE I / WE RECEIVED THIS FORM?",
                                                style: TextController
                                                    .BodyHeadingText1,
                                              ))),
                                        ]),
                                    TableRow(children: [
                                      Container(
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "You have received this form because you are an Entity holding an investment account with East Bridge Capital (the “EBC”), a Financial Institution established in the Kingdom of Saudi Arabia (“KSA”).",
                                            style: TextController.BodyText,
                                          ))),
                                    ]),
                                    TableRow(children: [
                                      Container(
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "The concept of an ‘Entity’ covers all legal persons (such as a company, a financial institution or a governmental body) and all legal arrangements (such as a joint enterprise, a trust or a waqf). However, it excludes individuals (also known as natural persons).",
                                            style: TextController.BodyText,
                                          ))),
                                    ]),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      // Close the dialog box when the "Close" button is pressed
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          '   WHY HAVE I / WE RECEIVED THIS FORM?',
                          style: TextController.BodyHeadingText1,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // In the builder method, return the dialog widget
                              return AlertDialog(
                                title: Text(
                                  'Questions',
                                  style: TextController.BodyText,
                                ),
                                content: Table(
                                  border: TableBorder.all(
                                      color: ColorSelect.tabBorderColor),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FixedColumnWidth(1200),
                                    1: FixedColumnWidth(1200),
                                    2: FixedColumnWidth(1200),
                                  },
                                  children: [
                                    TableRow(children: [
                                      Container(
                                          height: 50,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "WHAT MUST I / WE DO WITH THIS FORM?",
                                            style: TextController.internet,
                                          )),
                                    ]),
                                    TableRow(children: [
                                      Container(
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "Please review and respond to Parts 3 and 4 in the questionnaires below on pages 3 and 4 of this form. All Entities holding an account with EBC must provide a response to Only One Question in each questionnaire",
                                            style: TextController.BodyText,
                                          ))),
                                    ]),
                                    TableRow(children: [
                                      Container(
                                          height: 50,
                                          child: Center(
                                              child: Text(
                                            "In addition, if you tick Question 11, 12 or 19 in the questionnaires, also please review and complete to Addendum 1. Only Entities who tick “YES” in response to Question 11, 12 or 19 are required to respond to Addendum 1.",
                                            style: TextController.BodyText,
                                          ))),
                                    ]),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Close'),
                                    onPressed: () {
                                      // Close the dialog box when the "Close" button is pressed
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          'WHAT MUST I/WE DO WITH THE FORM?',
                          style: TextController.BodyHeadingText1,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20, left: 10),
                      child: Container(
                        height: 120,
                        width: 1200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "   FATCA Classification \n(only tick one classification where applicable)",
                                style: TextController.MainHeadingText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                child: Table(
                                  border: TableBorder.all(
                                      color: ColorSelect.tabBorderColor),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    // 0: FixedColumnWidth(200),
                                    // 1: FixedColumnWidth(500),
                                    // 2: FixedColumnWidth(100),
                                    // 3: FixedColumnWidth(550),
                                    0: FlexColumnWidth(1),
                                    1: FlexColumnWidth(4),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Container(
                                          // height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Center(
                                                child: Text(
                                              textAlign: TextAlign.center,
                                              "US Entity & US Financial \n \nInstitutions",
                                              style:
                                                  TextController.tableHeading,
                                            )),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(0.5),
                                              2: FlexColumnWidth(3),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child: Text(
                                                      "1. Are you a Specified US Person?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "1",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                    // Checkbox(
                                                    //   value:
                                                    //       _UsEntityUsSpecified,
                                                    //   onChanged: (value1) {
                                                    //     setState(() {
                                                    //       _UsEntityUsSpecified =
                                                    //           value1!;
                                                    //       _UsEntityUsNotSpecified =
                                                    //           !value1; // Disable the other checkbox
                                                    //     });
                                                    //   },
                                                    // ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    height: 35,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField)),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _UsEntityandUsFinancial,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              hintText: S
                                                                  .of(context)
                                                                  .USTIN,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child: Text(
                                                      "2. Are you a US Person who is not a Specified US Person?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "2",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Container(
                                        //   // height: 100,
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.start,
                                        //     children: [
                                        //       Padding(
                                        //         padding: const EdgeInsets.only(
                                        //             top: 20,
                                        //             left: 10,
                                        //             right: 10,
                                        //             bottom: 10),
                                        //         child: Text(
                                        //           "1. Are you a Specified US Person?",
                                        //           style: TextController.BodyText,
                                        //           maxLines: 3,
                                        //         ),
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets.all(10),
                                        //         child: Text(
                                        //           "2. Are you a US Person who is not a Specified US Person?",
                                        //           style: TextController.BodyText,
                                        //           maxLines: 3,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        // Container(
                                        //   // height: 100,
                                        //   child: Container(
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 10, vertical: 5),
                                        //     child: Column(
                                        //       children: [
                                        //         Container(
                                        //           height: 50,
                                        //           child: Checkbox(
                                        //             value: _UsEntityUsSpecified,
                                        //             onChanged: (value1) {
                                        //               setState(() {
                                        //                 _UsEntityUsSpecified =
                                        //                     value1!;
                                        //                 _UsEntityUsNotSpecified =
                                        //                     !value1; // Disable the other checkbox
                                        //               });
                                        //             },
                                        //           ),
                                        //         ),
                                        //         Checkbox(
                                        //           value: _UsEntityUsNotSpecified,
                                        //           onChanged: (value2) {
                                        //             setState(() {
                                        //               _UsEntityUsNotSpecified =
                                        //                   value2!;
                                        //               _UsEntityUsSpecified =
                                        //                   !value2; // Disable the other checkbox
                                        //             });
                                        //           },
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                        // Container(
                                        //   // height: 100,
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.only(
                                        //         top: 25,
                                        //         bottom: 65,
                                        //         left: 15,
                                        //         right: 15),
                                        //     child: Container(
                                        //       width: 200,
                                        //       height: 35,
                                        //       alignment: Alignment.centerLeft,
                                        //       decoration: BoxDecoration(
                                        //           color: Colors.white,
                                        //           border: Border.all(
                                        //               color:
                                        //                   ColorSelect.textField)),
                                        //       child: Padding(
                                        //         padding: const EdgeInsets.only(
                                        //             left: 15, bottom: 10),
                                        //         child: TextFormField(
                                        //           controller:
                                        //               _UsEntityandUsFinancial,
                                        //           decoration: InputDecoration(
                                        //               hintText:
                                        //                   S.of(context).USTIN,
                                        //               hintStyle: TextController
                                        //                   .labelText,
                                        //               border: InputBorder.none),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          // height: 250,
                                          child: Center(
                                              child: Text(
                                            textAlign: TextAlign.center,
                                            "Non US Financial Institutions",
                                            style: TextController.tableHeading,
                                          )),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(0.5),
                                              2: FlexColumnWidth(3),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "3. Are you a Saudi Financial Institution or a Financial Institution organized in a country with an inter governmental agreement with the US regarding FATCA?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "3",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    height: 35,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField)),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _NonUsFinancialInstitution1,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              hintText: S
                                                                  .of(context)
                                                                  .GIIN,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "4. Are you a Participating Non-US Financial Institution?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "4",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    height: 35,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField)),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _NonUsFinancialInstitution2,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              hintText: S
                                                                  .of(context)
                                                                  .GIIN,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "5. Are you a Registered Deemed-Compliant Non-US Financial Institution?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "5",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    height: 35,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField)),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          _NonUsFinancialInstitution3,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                      decoration:
                                                          InputDecoration(
                                                              isDense: true,
                                                              hintText: S
                                                                  .of(context)
                                                                  .GIIN,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              border:
                                                                  InputBorder
                                                                      .none),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "6. Are you a Certified Deemed-Compliant Non-US Financial Institution?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "6",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "7. Are you a Non-Participating Non- US Financial Institution?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "7",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          // height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Center(
                                                child: Text(
                                              textAlign: TextAlign.center,
                                              "ExemptEntities",
                                              style:
                                                  TextController.tableHeading,
                                            )),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(0.5),
                                              2: FlexColumnWidth(3),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                    ),
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      "8. Are you an Exempt Beneficial Owner?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "8",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          // height: 250,
                                          child: Center(
                                              child: Text(
                                            textAlign: TextAlign.center,
                                            "Non-US Entity that is not \n\n Financial Institutions",
                                            style: TextController.tableHeading,
                                          )),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(0.5),
                                              2: FlexColumnWidth(3),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "9. Are you an Excepted Non-Financial Non-US Entity? \n (This classification is also commonly known as an Excepted NFFE)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "9",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "10. Are you an Active Non-Financial Non-US Entity? \n (This classification is also commonly known as an Active NFFE)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "10",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          // height: 250,
                                          child: Center(
                                              child: Text(
                                            textAlign: TextAlign.center,
                                            "Passive Non-US Entity that is not \n\n Financial Institutions",
                                            style: TextController.tableHeading,
                                          )),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(3),
                                              1: FlexColumnWidth(0.5),
                                              2: FlexColumnWidth(3),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5,
                                                    ),
                                                    child: Text(
                                                      "11. Are you a Passive Non-Financial Non-US Entity? \n (This classification is also commonly known as an Passive NFFE) (if you have ticked this question, please complete Addendum 1)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    child: Radio(
                                                      value: "11",
                                                      groupValue: selectedValue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   width: double.infinity,
                              //   margin: EdgeInsets.symmetric(
                              //     vertical: 20,
                              //     horizontal: 10,
                              //   ),
                              //   child: Table(
                              //     border: TableBorder.all(
                              //         color: ColorSelect.tabBorderColor),
                              //     defaultVerticalAlignment:
                              //         TableCellVerticalAlignment.middle,
                              //     columnWidths: {
                              //       // 0: FixedColumnWidth(200),
                              //       // 1: FixedColumnWidth(500),
                              //       // 2: FixedColumnWidth(100),
                              //       // 3: FixedColumnWidth(550),
                              //       0: FlexColumnWidth(2),
                              //       1: FlexColumnWidth(5),
                              //       2: FlexColumnWidth(1),
                              //       3: FlexColumnWidth(5.5),
                              //     },
                              //     children: [
                              //       TableRow(children: [
                              //         Container(
                              //           // height: 100,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(10),
                              //             child: Center(
                              //                 child: Text(
                              //               "US Entity & US Financial \n \nInstitutions",
                              //               style: TextController.tableHeading,
                              //             )),
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 100,
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     top: 20,
                              //                     left: 10,
                              //                     right: 10,
                              //                     bottom: 10),
                              //                 child: Text(
                              //                   "1. Are you a Specified US Person?",
                              //                   style: TextController.BodyText,
                              //                   maxLines: 3,
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(10),
                              //                 child: Text(
                              //                   "2. Are you a US Person who is not a Specified US Person?",
                              //                   style: TextController.BodyText,
                              //                   maxLines: 3,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 100,
                              //           child: Container(
                              //             padding: EdgeInsets.symmetric(
                              //                 horizontal: 10, vertical: 5),
                              //             child: Column(
                              //               children: [
                              //                 Container(
                              //                   height: 50,
                              //                   child: Checkbox(
                              //                     value: _UsEntityUsSpecified,
                              //                     onChanged: (value1) {
                              //                       setState(() {
                              //                         _UsEntityUsSpecified =
                              //                             value1!;
                              //                         _UsEntityUsNotSpecified =
                              //                             !value1; // Disable the other checkbox
                              //                       });
                              //                     },
                              //                   ),
                              //                 ),
                              //                 Checkbox(
                              //                   value: _UsEntityUsNotSpecified,
                              //                   onChanged: (value2) {
                              //                     setState(() {
                              //                       _UsEntityUsNotSpecified =
                              //                           value2!;
                              //                       _UsEntityUsSpecified =
                              //                           !value2; // Disable the other checkbox
                              //                     });
                              //                   },
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 100,
                              //           child: Padding(
                              //             padding: const EdgeInsets.only(
                              //                 top: 25,
                              //                 bottom: 65,
                              //                 left: 15,
                              //                 right: 15),
                              //             child: Container(
                              //               width: 200,
                              //               height: 35,
                              //               alignment: Alignment.centerLeft,
                              //               decoration: BoxDecoration(
                              //                   color: Colors.white,
                              //                   border: Border.all(
                              //                       color:
                              //                           ColorSelect.textField)),
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 15, bottom: 10),
                              //                 child: TextFormField(
                              //                   controller:
                              //                       _UsEntityandUsFinancial,
                              //                   decoration: InputDecoration(
                              //                       hintText:
                              //                           S.of(context).USTIN,
                              //                       hintStyle: TextController
                              //                           .labelText,
                              //                       border: InputBorder.none),
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       ]),
                              //       TableRow(children: [
                              //         Container(
                              //           // height: 250,
                              //           child: Center(
                              //               child: Text(
                              //             "Non US Financial Institutions",
                              //             style: TextController.tableHeading,
                              //           )),
                              //         ),
                              //         Container(
                              //           padding: EdgeInsets.symmetric(
                              //             horizontal: 5,
                              //           ),
                              //           // height: 257,
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Container(
                              //                 // margin: EdgeInsets.symmetric(
                              //                 //   vertical: 20,
                              //                 //   horizontal: 5,
                              //                 // ),
                              //                 height: 40,
                              //                 alignment: Alignment.centerLeft,
                              //                 child: Text(
                              //                   "3. Are you a Saudi Financial Institution or a Financial Institution organized in a country with an inter governmental agreement with the US regarding FATCA?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.centerLeft,
                              //                 // margin: EdgeInsets.symmetric(
                              //                 //   vertical: 20,
                              //                 //   horizontal: 5,
                              //                 // ),
                              //                 child: Text(
                              //                   "4. Are you a Participating Non-US Financial Institution?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.centerLeft,
                              //                 // margin: EdgeInsets.symmetric(
                              //                 //   vertical: 20,
                              //                 //   horizontal: 5,
                              //                 // ),
                              //                 child: Text(
                              //                   "5. Are you a Registered Deemed-Compliant Non-US Financial Institution?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.centerLeft,
                              //                 // margin: EdgeInsets.symmetric(
                              //                 //   vertical: 20,
                              //                 //   horizontal: 5,
                              //                 // ),
                              //                 child: Text(
                              //                   "6. Are you a Certified Deemed-Compliant Non-US Financial Institution?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.centerLeft,
                              //                 // margin: EdgeInsets.symmetric(
                              //                 //   vertical: 20,
                              //                 //   horizontal: 5,
                              //                 // ),
                              //                 child: Text(
                              //                   "7. Are you a Non-Participating Non- US Financial Institution?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 250,
                              //           padding: EdgeInsets.symmetric(
                              //               horizontal: 10),
                              //           child: Column(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: [
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.center,
                              //                 child: CheckboxListTile(
                              //                   value: selectedOption ==
                              //                       NonUsOption.SaudiFinancial,
                              //                   onChanged: (bool? value) {
                              //                     setState(() {
                              //                       selectedOption = NonUsOption
                              //                           .SaudiFinancial;
                              //                     });
                              //                   },
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.center,
                              //                 child: CheckboxListTile(
                              //                   value: selectedOption ==
                              //                       NonUsOption.Participating,
                              //                   onChanged: (bool? value) {
                              //                     setState(() {
                              //                       selectedOption = NonUsOption
                              //                           .Participating;
                              //                     });
                              //                   },
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.center,
                              //                 child: CheckboxListTile(
                              //                   value: selectedOption ==
                              //                       NonUsOption
                              //                           .RegisteredDeemed,
                              //                   onChanged: (bool? value) {
                              //                     setState(() {
                              //                       selectedOption = NonUsOption
                              //                           .RegisteredDeemed;
                              //                     });
                              //                   },
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.center,
                              //                 child: CheckboxListTile(
                              //                   value: selectedOption ==
                              //                       NonUsOption.CertifiedDeemed,
                              //                   onChanged: (bool? value) {
                              //                     setState(() {
                              //                       selectedOption = NonUsOption
                              //                           .CertifiedDeemed;
                              //                     });
                              //                   },
                              //                 ),
                              //               ),
                              //               Container(
                              //                 height: 40,
                              //                 alignment: Alignment.center,
                              //                 child: CheckboxListTile(
                              //                   value: selectedOption ==
                              //                       NonUsOption
                              //                           .NonParticipating,
                              //                   onChanged: (bool? value) {
                              //                     setState(() {
                              //                       selectedOption = NonUsOption
                              //                           .NonParticipating;
                              //                     });
                              //                   },
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           padding: EdgeInsets.symmetric(
                              //             horizontal: 5,
                              //           ),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //             children: [
                              //               Container(
                              //                 height: 40,
                              //                 padding: EdgeInsets.symmetric(
                              //                     horizontal: 15),
                              //                 child: Container(
                              //                   width: 540,
                              //                   // height: 46,
                              //                   alignment: Alignment.centerLeft,
                              //                   decoration: BoxDecoration(
                              //                       color: Colors.white,
                              //                       border: Border.all(
                              //                           color: ColorSelect
                              //                               .textField)),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 15, bottom: 10),
                              //                     child: TextFormField(
                              //                       controller:
                              //                           _NonUsFinancialInstitution1,
                              //                       decoration: InputDecoration(
                              //                           hintText:
                              //                               S.of(context).GIIN,
                              //                           hintStyle:
                              //                               TextController
                              //                                   .labelText,
                              //                           border:
                              //                               InputBorder.none),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 15, right: 15, top: 20),
                              //                 child: Container(
                              //                   width: 550,
                              //                   // height: 46,
                              //                   alignment: Alignment.centerLeft,
                              //                   decoration: BoxDecoration(
                              //                       color: Colors.white,
                              //                       border: Border.all(
                              //                           color: ColorSelect
                              //                               .textField)),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 15, bottom: 10),
                              //                     child: TextFormField(
                              //                       controller:
                              //                           _NonUsFinancialInstitution2,
                              //                       decoration: InputDecoration(
                              //                           hintText:
                              //                               S.of(context).GIIN,
                              //                           hintStyle:
                              //                               TextController
                              //                                   .labelText,
                              //                           border:
                              //                               InputBorder.none),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     bottom: 70,
                              //                     left: 15,
                              //                     top: 10),
                              //                 child: Container(
                              //                   width: 500,
                              //                   // height: 46,
                              //                   alignment: Alignment.centerLeft,
                              //                   decoration: BoxDecoration(
                              //                       color: Colors.white,
                              //                       border: Border.all(
                              //                           color: ColorSelect
                              //                               .textField)),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets.only(
                              //                             left: 15, bottom: 10),
                              //                     child: TextFormField(
                              //                       controller:
                              //                           _NonUsFinancialInstitution3,
                              //                       decoration: InputDecoration(
                              //                           hintText:
                              //                               S.of(context).GIIN,
                              //                           hintStyle:
                              //                               TextController
                              //                                   .labelText,
                              //                           border:
                              //                               InputBorder.none),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //       ]),
                              //       TableRow(children: [
                              //         Container(
                              //           // height: 50,
                              //           child: Center(
                              //               child: Text(
                              //             "ExemptEntities",
                              //             style: TextController.tableHeading,
                              //           )),
                              //         ),
                              //         Container(
                              //           // height: 50,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(15),
                              //             child: Text(
                              //               "8. Are you an Exempt Beneficial Owner?",
                              //               style: TextController.BodyText,
                              //             ),
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 50,
                              //           child: Checkbox(
                              //               value: ExemptEntitiesOwner,
                              //               onChanged: (value8) {
                              //                 setState(() {
                              //                   ExemptEntitiesOwner = value8!;
                              //                 });
                              //               }),
                              //         ),
                              //         Container(
                              //             // height: 50,
                              //             ),
                              //       ]),
                              //       TableRow(children: [
                              //         Container(
                              //           // height: 240,
                              //           child: Center(
                              //               child: Text(
                              //             "Non-US Entity that is not \n\n Financial Institutions",
                              //             style: TextController.tableHeading,
                              //           )),
                              //         ),
                              //         Container(
                              //           // height: 240,
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 15,
                              //                     right: 15,
                              //                     bottom: 15,
                              //                     top: 25),
                              //                 child: Text(
                              //                   "9. Are you an Excepted Non-Financial Non-US Entity? \n \n (This classification is also commonly known as an Excepted NFFE)",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(15),
                              //                 child: Text(
                              //                   "10. Are you an Active Non-Financial Non-US Entity? (This classification is also\n\n commonly known as an Active NFFE)",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(15),
                              //                 child: Text(
                              //                   "11. Are you a Passive Non-Financial Non-US Entity?",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //               Padding(
                              //                 padding: const EdgeInsets.all(15),
                              //                 child: Text(
                              //                   "(This classification is also commonly known as an Passive NFFE)\n \n (if you have ticked this question, please complete Addendum 1)",
                              //                   style: TextController.BodyText,
                              //                 ),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           // height: 240,
                              //           child: Column(
                              //             children: [
                              //               CheckboxListTile(
                              //                 value: selectedEntityOption ==
                              //                     NonUsEntityOption.Excepted,
                              //                 onChanged: (bool? value) {
                              //                   setState(() {
                              //                     selectedEntityOption =
                              //                         NonUsEntityOption
                              //                             .Excepted;
                              //                   });
                              //                 },
                              //               ),
                              //               CheckboxListTile(
                              //                 value: selectedEntityOption ==
                              //                     NonUsEntityOption.Active,
                              //                 onChanged: (bool? value) {
                              //                   setState(() {
                              //                     selectedEntityOption =
                              //                         NonUsEntityOption.Active;
                              //                   });
                              //                 },
                              //               ),
                              //               CheckboxListTile(
                              //                 value: selectedEntityOption ==
                              //                     NonUsEntityOption.Passive,
                              //                 onChanged: (bool? value) {
                              //                   setState(() {
                              //                     selectedEntityOption =
                              //                         NonUsEntityOption.Passive;
                              //                   });
                              //                 },
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         Container(
                              //           height: 240,
                              //         ),
                              //       ]),
                              //     ],
                              //   ),
                              // ),

                              //Till this copy
                              Container(
                                margin: EdgeInsets.only(left: 11, right: 11),
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: TextButton(
                                        onPressed: () {
                                          showHtmlAlert(context, htmlContent);
                                        },
                                        child: const Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              color: Colors
                                                  .black, // Set the desired text color
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    'Further details about the classifications of account-holder under FATCA is set out in ',
                                              ),
                                              TextSpan(
                                                text: 'Appendix 1',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  // Add any other styles you want for the bold part
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' to this form. If you do not know, or are unsure of, the classification to which you as an Entity belong, please obtain the advice of a licensed tax advisor in the KSA.',
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 11, right: 11),
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: ColorSelect.east_grey,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                      "CRS Classification (only tick one classification where applicable)"),
                                )),
                              ),

                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                child: Table(
                                  border: TableBorder.all(
                                      color: ColorSelect.tabBorderColor),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    // 0: FixedColumnWidth(200),
                                    // 1: FixedColumnWidth(1045),
                                    // 2: FixedColumnWidth(100),
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(10.5),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "Financial Institutions (FI)",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(6),
                                              1: FlexColumnWidth(1),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "12. Are you Financial Institution or Investment Entity located in a Non- Participating Country /Jurisdiction and managed by another Financial Institution (if you have ticked this question, please complete Addendum 1)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "1",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "13. Are you Financial Institution - Other Investment Entity?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "2",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "14. Are you a Financial Institution - Depository Institution, Custodial Institution or Specified Insurance Company?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "3",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "Active Non-Financial Entity (NFE)",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(6),
                                              1: FlexColumnWidth(1),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "15. Are you an Active NFE – A corporation that is publicly traded or a Related Entity of a publicly traded corporation? (please provide the name of the securities market in which the corporation is traded)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "4",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 800,
                                                      // height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField)),
                                                      child: TextFormField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextController
                                                            .BodyText,
                                                        // controller:
                                                        //     BuldingNumber,
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .TypeHere,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "16. Are you an Active NFE – A Governmental Entity or Central Bank?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "5",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "17. Are you an Active NFE – An International Organization?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "6",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "18. Are you an Active NFE Other than 15 through 17 above?",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "7",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: Text(
                                              "Passive Non-Financial Entity (NFE)",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Table(
                                            border: TableBorder.all(
                                                width: 0,
                                                color:
                                                    ColorSelect.tabBorderColor),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            columnWidths: {
                                              0: FlexColumnWidth(6),
                                              1: FlexColumnWidth(1),
                                            },
                                            children: [
                                              TableRow(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Text(
                                                      "19. Are you a Passive NFE ? (if you have ticked this question, please complete Addendum 1)",
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Radio(
                                                      value: "8",
                                                      groupValue:
                                                          selectedValue2,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedValue2 =
                                                              value!; //<-- change this
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // ======================================================================================== //

                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(20),
                                child: Table(
                                  border: TableBorder.all(
                                      color: ColorSelect.tabBorderColor),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    // 0: FixedColumnWidth(200),
                                    // 1: FixedColumnWidth(1045),
                                    // 2: FixedColumnWidth(100),
                                    0: FlexColumnWidth(2),
                                    1: FlexColumnWidth(10),
                                    2: FlexColumnWidth(1),
                                  },
                                  children: [
                                    // TableRow(children: [
                                    //   Container(
                                    //     // height: 100,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(10),
                                    //       child: Center(
                                    //         child: Text(
                                    //           "Financial Institutions (FI)",
                                    //           style: TextController.tableHeading,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),

                                    //   Container(
                                    //       // height: 160,
                                    //       child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             top: 20,
                                    //             left: 10,
                                    //             right: 10,
                                    //             bottom: 10),
                                    //         child: Text(
                                    //           "12. Are you Financial Institution or Investment Entity located in a Non- Participating Country /Jurisdiction and managed by another Financial Institution (if you have ticked this question, please complete Addendum 1)",
                                    //           style: TextController.BodyText,
                                    //           maxLines: 3,
                                    //         ),
                                    //       ),
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             top: 20,
                                    //             left: 10,
                                    //             right: 10,
                                    //             bottom: 10),
                                    //         child: Text(
                                    //           "13. Are you Financial Institution - Other Investment Entity?",
                                    //           style: TextController.BodyText,
                                    //           maxLines: 3,
                                    //         ),
                                    //       ),
                                    //       Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             top: 20,
                                    //             left: 10,
                                    //             right: 10,
                                    //             bottom: 10),
                                    //         child: Text(
                                    //           "14. Are you a Financial Institution - Depository Institution, Custodial Institution or Specified Insurance Company?",
                                    //           style: TextController.BodyText,
                                    //           maxLines: 3,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   )),
                                    //   Container(
                                    //     // height: 160,
                                    //     child: Column(
                                    //       children: [
                                    //         Checkbox(
                                    //           value: checkbox1,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox1 = value!;
                                    //               checkbox2 = false;
                                    //               checkbox3 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //         Checkbox(
                                    //           value: checkbox2,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox2 = value!;
                                    //               checkbox1 = false;
                                    //               checkbox3 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //         Checkbox(
                                    //           value: checkbox3,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox3 = value!;
                                    //               checkbox1 = false;
                                    //               checkbox2 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   //
                                    // ]),

                                    // TableRow(children: [
                                    //   Container(
                                    //     // height: 300,
                                    //     child: Center(
                                    //         child: Text(
                                    //       "Active Non-Financial\n \nEntity (NFE)",
                                    //       style: TextController.tableHeading,
                                    //     )),
                                    //   ),
                                    //   Container(
                                    //     // height: 300,
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 10,
                                    //               right: 20,
                                    //               top: 20,
                                    //               bottom: 20),
                                    //           child: Column(
                                    //             children: [
                                    //               Text(
                                    //                 "15. Are you an Active NFE – A corporation that is publicly traded or a Related Entity of a publicly traded corporation? (please provide the name of the securities market in which the corporation is traded)",
                                    //                 style:
                                    //                     TextController.BodyText,
                                    //               ),
                                    //               Padding(
                                    //                 padding:
                                    //                     const EdgeInsets.only(
                                    //                         top: 25,
                                    //                         bottom: 9,
                                    //                         left: 15,
                                    //                         right: 15),
                                    //                 child: Container(
                                    //                   width: 800,
                                    //                   // height: 35,
                                    //                   alignment:
                                    //                       Alignment.centerLeft,
                                    //                   decoration: BoxDecoration(
                                    //                       color: Colors.white,
                                    //                       border: Border.all(
                                    //                           color: ColorSelect
                                    //                               .textField)),
                                    //                   child: Padding(
                                    //                     padding:
                                    //                         const EdgeInsets.only(
                                    //                             left: 15,
                                    //                             bottom: 10),
                                    //                     child: TextFormField(
                                    //                       controller:
                                    //                           BuldingNumber,
                                    //                       decoration: InputDecoration(
                                    //                           hintText: S
                                    //                               .of(context)
                                    //                               .TypeHere,
                                    //                           hintStyle:
                                    //                               TextController
                                    //                                   .labelText,
                                    //                           border: InputBorder
                                    //                               .none),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 10,
                                    //               right: 20,
                                    //               top: 20,
                                    //               bottom: 20),
                                    //           child: Text(
                                    //             "16. Are you an Active NFE – A Governmental Entity or Central Bank?",
                                    //             style: TextController.BodyText,
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 10,
                                    //               right: 20,
                                    //               top: 20,
                                    //               bottom: 20),
                                    //           child: Text(
                                    //             "17. Are you an Active NFE – An International Organization?",
                                    //             style: TextController.BodyText,
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               left: 10,
                                    //               right: 20,
                                    //               top: 20,
                                    //               bottom: 20),
                                    //           child: Text(
                                    //             "18. Are you an Active NFE Other than 15 through 17 above?",
                                    //             style: TextController.BodyText,
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   Container(
                                    //     // height: 300,
                                    //     child: Column(
                                    //       children: [
                                    //         Checkbox(
                                    //           value: checkbox15,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox15 = value!;
                                    //               checkbox16 = false;
                                    //               checkbox17 = false;
                                    //               checkbox18 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //         Checkbox(
                                    //           value: checkbox16,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox16 = value!;
                                    //               checkbox15 = false;
                                    //               checkbox17 = false;
                                    //               checkbox18 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //         Checkbox(
                                    //           value: checkbox17,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox17 = value!;
                                    //               checkbox16 = false;
                                    //               checkbox15 = false;
                                    //               checkbox18 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //         Checkbox(
                                    //           value: checkbox18,
                                    //           onChanged: (value) {
                                    //             setState(() {
                                    //               checkbox18 = value!;
                                    //               checkbox16 = false;
                                    //               checkbox17 = false;
                                    //               checkbox15 = false;
                                    //             });
                                    //           },
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    //   ////////////
                                    // ]),

                                    // TableRow(children: [
                                    //   Container(
                                    //     // height: 50,
                                    //     child: Center(
                                    //         child: Text(
                                    //       "Passive Non-Financial \n \nEntity (NFE)",
                                    //       style: TextController.tableHeading,
                                    //     )),
                                    //   ),
                                    //   Container(
                                    //     // height: 50,
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.all(15),
                                    //       child: Text(
                                    //         "19. Are you a Passive NFE ? (if you have ticked this question, please complete Addendum 1)",
                                    //         style: TextController.BodyText,
                                    //       ),
                                    //     ),
                                    //   ),
                                    //   Container(
                                    //     // height: 50,
                                    //     child: Checkbox(
                                    //         value: PassiveNFE,
                                    //         onChanged: (value1) {
                                    //           setState(() {
                                    //             PassiveNFE = value1!;
                                    //           });
                                    //         }),
                                    //   ),
                                    // ]),
                                  ],
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                padding: const EdgeInsets.all(10),
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 50),
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: TextButton(
                                          onPressed: () {
                                            showHtmlAlert(
                                                context, htmlContent2);
                                          },
                                          child: const Text.rich(
                                            TextSpan(
                                              style: TextStyle(
                                                color: Colors
                                                    .black, // Set the desired text color
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Further details about the classifications of account-holder under CRS is set out in ',
                                                ),
                                                TextSpan(
                                                  text: 'Appendix 2',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    // Add any other styles you want for the bold part
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' to this form. If you do not know, or are unsure, of the classification to which you as an Entity belong, please obtain the advice of a licensed tax advisor in the KSA.',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          //delete
                          Container(
                              padding: EdgeInsets.all(20),
                              width: double.infinity,
                              child: Center(
                                  child: Text(
                                "Addendum 1",
                                style: TextController.MainHeadingText,
                              ))),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, right: 20, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NFFEs/NFEs Passive and Entity Investment of Persons Controlling.\n \n Please provide in full the details requested below with respect to any of your owners who are Controlling Persons. A Controlling Person is either a citizen\n or a resident of any jurisdiction/country for tax purposes, who in either case holds more than a 5% stake in the entity by vote or value",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                    width:
                                        10), // add some spacing between the label and checkbox
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Should put in dailog

                          // *end
                          Container(
                            width: double.infinity,
                            child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              columnWidths: {
                                // 0: FixedColumnWidth(50),
                                // 1: FixedColumnWidth(130),
                                // 2: FixedColumnWidth(130),
                                // 3: FixedColumnWidth(130),
                                // 4: FixedColumnWidth(130),
                                // 5: FixedColumnWidth(130),
                                // 6: FixedColumnWidth(130),
                                // 7: FixedColumnWidth(130),
                                // 8: FixedColumnWidth(130),
                                0: FixedColumnWidth(1),
                                1: FixedColumnWidth(1),
                                2: FixedColumnWidth(1),
                                3: FixedColumnWidth(1),
                                4: FixedColumnWidth(1),
                                5: FixedColumnWidth(1),
                                6: FixedColumnWidth(1),
                                7: FixedColumnWidth(1),
                                8: FixedColumnWidth(1),
                              },
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: ColorSelect.east_grey,
                                    ),
                                    children: [
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "No",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Name of Controlling Person",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Address",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Date Of Birth",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Place Of Birth",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Nationality",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Tax Residency",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Text(
                                            "Ownership in %",
                                            style: TextController.tableHeading,
                                          ))),
                                      Container(
                                          height: 70,
                                          child: Center(
                                              child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              "TIN of Controlling Person",
                                              style:
                                                  TextController.tableHeading,
                                            ),
                                          ))),
                                    ]),
                                for (int i = 0; i < rowDataList.length; i++)
                                  TableRow(children: [
                                    Container(height: 50, child: Center()),
                                    Container(
                                      height: 50,
                                      child: Center(
                                        child: TextFormField(
                                          controller: rowDataList[i]['name'] ??=
                                              TextEditingController(),
                                          validator: (value) {
                                            if (selectedValue2 == "1" &&
                                                    value!.isEmpty ||
                                                selectedValue == "11" &&
                                                    value!.isEmpty ||
                                                selectedValue2 == "8" &&
                                                    value!.isEmpty) {
                                              return 'This field is required.';
                                            }
                                            return null; // Return null if the input is valid
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['address'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['DOB'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['POB'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['Nationality'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['TaxResidency'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['Ownership'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 50,
                                        child: Center(
                                          child: TextFormField(
                                            controller: rowDataList[i]
                                                    ['TinOfCPerson'] ??=
                                                TextEditingController(),
                                            validator: (value) {
                                              if (selectedValue2 == "1" &&
                                                      value!.isEmpty ||
                                                  selectedValue == "11" &&
                                                      value!.isEmpty ||
                                                  selectedValue2 == "8" &&
                                                      value!.isEmpty) {
                                                return 'This field is required.';
                                              }
                                              return null; // Return null if the input is valid
                                            },
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              errorStyle:
                                                  TextController.inputErrorText,
                                            ),
                                          ),
                                        )),
                                  ]),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: addNewRow,
                            child: Text('Add Row'),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            S.of(context).DateOfBirth,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Place of birth",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    width: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Country of tax residency",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 270,
                                          height: 35,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            controller: OfficailPhoneNumber2,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ), //delete

                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      height: 45,
                      margin: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: ColorSelect.east_grey,
                        border: Border.all(
                          color: ColorSelect.tabBorderColor,
                        ),
                      ),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              "Section D - Declaration and Signature",
                              style: TextController.SubHeadingText,
                            ),
                          )),
                    ),

                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  S.of(context).NameOfSignatory,
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: ColorSelect.textField,
                                        width: 1,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: name,
                                      style: TextController.BodyText,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field is required.';
                                        }
                                        return null; // Return null if the input is valid
                                      },
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: S.of(context).TypeHere,
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
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Capacity Of Signatory",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 20,
                                ),

                                Flexible(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    width: double.infinity,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: DropdownButton<String>(
                                      hint: Text("Select Here",
                                          style: TextController.labelText),
                                      value: dropdownvalue,
                                      isExpanded: true,
                                      underline: Container(),
                                      iconEnabledColor:
                                          ColorSelect.east_dark_blue,
                                      items: items.map(
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
                                      onChanged: (newValue) {
                                        setState(
                                          () {
                                            capacityError = false;
                                            dropdownvalue = newValue!;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // Flexible(
                                //   child: Column(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.start,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Container(
                                //         width: 200,
                                //         height: 35,
                                //         decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             border: Border.all(
                                //                 color:
                                //                     ColorSelect.textField)),
                                //         padding: EdgeInsets.symmetric(
                                //           horizontal: 10,
                                //         ),
                                //         child: DropdownButtonHideUnderline(
                                //           child: Theme(
                                //             data: Theme.of(context).copyWith(
                                //                 focusColor: Colors.white),
                                //             child: DropdownButtonFormField(
                                //               alignment: AlignmentDirectional
                                //                   .centerStart,
                                //               hint: Text(
                                //                 S.of(context).SelectHere,
                                //                 style:
                                //                     TextController.labelText,
                                //               ),
                                //               value: dropdownvalue,
                                //               isExpanded: true,
                                //               icon: const Icon(
                                //                   Icons.keyboard_arrow_down),
                                //               decoration: InputDecoration(
                                //                 enabledBorder:
                                //                     InputBorder.none,
                                //                 border: InputBorder.none,
                                //                 hoverColor: Colors.white,
                                //               ),
                                //               items:
                                //                   items.map((String items) {
                                //                 return DropdownMenuItem(
                                //                   value: items,
                                //                   child: Text(items,
                                //                       style: TextController
                                //                           .BodyText),
                                //                 );
                                //               }).toList(),
                                //               onChanged: (String? newValue) {
                                //                 setState(() {
                                //                   capacityError = false;
                                //                   dropdownvalue = newValue!;
                                //                 });
                                //               },
                                //             ),
                                //           ),
                                //         ),
                                //       ),
                                //       if (capacityError)
                                //         Text(
                                //           "Select any option",
                                //           style: TextController.errorText,
                                //         )
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  S.of(context).Date,
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Container(
                                      width: 200,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: date,
                                        style: TextController.BodyText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          suffixIcon: Icon(
                                            Icons.calendar_month_outlined,
                                            size: 15,
                                          ),
                                          hintText: S.of(context).DateFormat,
                                          hintStyle:
                                              TextController.labelTextDate,
                                          border: InputBorder.none,
                                          errorStyle:
                                              TextController.inputErrorText,
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required.';
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(datepicked);
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            HijriCalendar picked =
                                                HijriCalendar.fromDate(
                                                    datepicked);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState((date.text =
                                                            formattedDate)
                                                        as VoidCallback));
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState((dateHijri.text =
                                                            picked.toString())
                                                        as VoidCallback));
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      )),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).DateHijri,
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Flexible(
                                  child: Container(
                                      width: 200,
                                      height: 35,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: dateHijri,
                                        style: TextController.BodyText,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          suffixIcon: Icon(
                                            Icons.calendar_month_outlined,
                                            size: 15,
                                          ),
                                          hintText: S.of(context).DateFormat,
                                          hintStyle:
                                              TextController.labelTextDate,
                                          border: InputBorder.none,
                                          errorStyle:
                                              TextController.inputErrorText,
                                        ),
                                        readOnly: true,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "If a TIN is unavailable please provide the appropriate reason A, B or C where indicated below",
                                  style: TextController.SubHeadingText,
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        "Reason A - The country/jurisdiction where the Account Holder is resident does not issue TINs to its residents"),
                                    Text(
                                        "Reason B - The Account Holder is otherwise unable to obtain a TIN or equivalent number (Please explain why you are unable to obtain a TIN in the below table if you have selected this reason)"),
                                    Text(
                                        "Reason C - No TIN is required. (Note: Only select this reason if the domestic law of the relevant country/jurisdiction does not require the collection of the TIN issued by such country/jurisdiction")
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "If TIN is not available (Click Here)",
                          style: TextController.BodyHeadingText1,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        "I have read and I accept the Terms and Conditions "),
                                    content: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          S.of(context).termsAndCondtionsFatca,
                                          style: TextController.BodyText,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text(
                              "Declaration",
                              style: TextController.BodyText,
                            ),
                          ),
                          Checkbox(
                              value: TermsandConditions,
                              onChanged: (value1) {
                                setState(() {
                                  TermsandConditions = value1!;
                                  TermsandConditionsError = false;
                                });
                              }),
                        ],
                      ),
                    ),

                    if (TermsandConditionsError)
                      Text(
                        "Accept Terms & Condition",
                        style: TextController.errorText,
                      ),

                    SizedBox(
                      height: 50,
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
                              tabController?.animateTo(9);
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
                              // if (_formKey.currentState!.validate()) {
                              if (_formKey.currentState != null) {
                                setState(() {
                                  TermsandConditionsError =
                                      TermsandConditions == false;
                                  capacityError = dropdownvalue == null;
                                });
                                if (_formKey.currentState!.validate() &&
                                    !TermsandConditionsError &&
                                    !capacityError) {
                                  _formKey.currentState?.save();
                                  Fatca();
                                  tabController?.animateTo(11);
                                }
                              } else {
                                // Handle case where _formKey.currentState is null
                              }

                              // if (TermsandConditions) {
                              //   Fatca();
                              //   tabController?.animateTo(11);
                              // } else {
                              //   setState(() {
                              //     TermsandConditionsError = true;
                              //   });
                              // }
                              //  }
                            }, // Switch tabs
                            child: Text(
                              S.of(context).Next,
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
    );
  }
}
