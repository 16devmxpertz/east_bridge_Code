import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/DocumentUpload.dart';
import 'package:east_bridge/KYC/KYC%20Components/FATCA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/IndividualClientList.dart';
import 'package:east_bridge/KYC/KYC%20Components/InvestmentPortfolioB.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

enum SingingCharacter { yes, no }

class PersonalInfo extends StatefulWidget {
  //const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
  PersonalInfo({
    @required controller,
    type,
  }) {
    tabController = controller;

    Type = type;
    // _formKey = formKey;
  }
}

int customerId = 0;

// String resident = "";
// String dropdownvalueMaritalStatus = "";
// String dropdownvalueIdType = "";
// String dropdownvalueEducationL = "";

TabController? tabController;

class _PersonalInfoState extends State<PersonalInfo> {
  String btn = "Next";

  //DateTime? datepicked;
  // ignore: unused_field
  //final GlobalKey<newInd> _scaffoldKey = GlobalKey<newInd>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String resident = "";
  String? dropdownvalueMaritalStatus;
  String? dropdownvalueIdType;
  String dropdownvalueEducationL = "";

  String? Type;
  TextEditingController _firstName = new TextEditingController();
  TextEditingController _fatherName = new TextEditingController();
  TextEditingController _grandFatherName = new TextEditingController();
  TextEditingController _FamilyName = new TextEditingController();
  TextEditingController _firstNameArabic = new TextEditingController();
  TextEditingController _fatherNameArabic = new TextEditingController();
  TextEditingController _grandFatherNameArabic = new TextEditingController();
  TextEditingController _FamilyNameArabic = new TextEditingController();
  TextEditingController _numDependents = new TextEditingController();
  TextEditingController citizenshipId = new TextEditingController();
  TextEditingController citizenshipIdType = new TextEditingController();
  TextEditingController citizenshipIdNo = new TextEditingController();

  TextEditingController define = new TextEditingController();
  TextEditingController idNum = new TextEditingController();
  TextEditingController passportId = new TextEditingController();
  TextEditingController placeOfBirth = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController ExpHijridateController = new TextEditingController();
  TextEditingController PassportExpdateController = new TextEditingController();
  TextEditingController PassportExpHijridateController =
      new TextEditingController();
  TextEditingController DOBdateController = new TextEditingController();
  TextEditingController DOBHijridateController = new TextEditingController();
  TextEditingController _typeAheadController = new TextEditingController();
  var selectedDate = HijriCalendar.now();

  int? dependents;
  int x = 1;

  bool genderError = false;

  bool dobError = false;

  bool holderError = false;
  String holder = "";
  String gender = "";
  bool firstNameEn = false;
  bool fatherNameEn = false;
  bool grandNameEn = false;
  bool lastNameEn = false;
  bool firstNameAr = false;
  bool fatherNameAr = false;
  bool grandNameAr = false;
  bool lastNameAr = false;
  bool idNumError = false;
  bool idNumNationalError = false;
  bool idNumIqamaError = false;
  bool idNumDiplomaticError = false;
  bool defineerror = false;
  bool passportError = false;
  bool placeOfBirthError = false;
  bool PassportExpdateControllerError = false;
  bool IDxerr = false;
  Future<String> randomFun() async {
    return _firstName.text;
  }

  DateTime? datepicked;

  bool isButtonClickable = true;

  Future<int> register() async {
    setState(() {
      btn = "Loading...";
    });
    try {
      dependents = int.parse(_numDependents.text);
    } catch (e) {
      dependents = 0;
    }
    print("Dependentssssssss");
    print(dependents);
    print('${GlobalPermission.urlLink}/api/PersonalInfo/personalinfo');
    var url =
        Uri.parse('${GlobalPermission.urlLink}/api/PersonalInfo/personalinfo');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": GlobalPermission.employeeId,
        "firstNameArabic": _firstNameArabic.text,
        "firstName": _firstName.text,
        "fatherNameArabic": _fatherNameArabic.text,
        "grandFatherNameArabic": _grandFatherNameArabic.text,
        "familyNameArabic": _FamilyNameArabic.text,
        "citizenshipIdNo": citizenshipIdNo.text,
        "passportId": passportId.text,
        "passportExpiryDate": PassportExpdateController.text,
        "passportExpiryDateHijri": PassportExpHijridateController.text,
        "fatherName": _fatherName.text,
        "grandFatherName": _grandFatherName.text,
        "familyName": _FamilyName.text,
        "numDependents": dependents,
        "citizenship": _typeAheadController.text,
        "gender": gender,
        "holder": holder,
        "define": define.text,
        "maritalStatus": dropdownvalueMaritalStatus,
        "idType": dropdownvalueIdType,
        "idExpDate": dateController.text,
        "idExpDateHijri": ExpHijridateController.text,
        "idNum": idNum.text,
        "pob": placeOfBirth.text,
        "dob": DOBdateController.text,
        "dobHijri": DOBHijridateController.text,
        "educationLevel": dropdownvalueEducationL,
        "citizenshipIdType": citizenshipIdType.text,
        "citizenResidentNonResident": resident
      };

      print(body);
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        int responseData = jsonDecode(response.body);
        GlobalIndividual.individualclientid = responseData;
        GlobalIndividual.getdraftprogressindividual(responseData);

        // PostalAddress.id.value = id;
        // CC2.id.value = id;
        // IncomeNetWorth.id.value = id;
        // EmployerInfo.id.value = id;
        // BankInfoInv.id.value = id;
        // CustodianInfo.id.value = id;

        // FATCA.id.value = id;
        // GeneralInfo.id.value = id;
        // InvestmentPortfolioA.id.value = id;
        // InvestmentPortfolioB.id.value = id;
        // OtherInfoIndividual.id.value = id;
        // ProfessionalExp.id.value = id;
        // ANBAccountIndividual.id.value = id;
        DocumentUpload.name.value = _firstName.text + "~Individual";

        FATCA.firstNAme.value = _firstName.text;
        FATCA.fatherName.value = _fatherName.text;
        FATCA.grandFatherName.value = _grandFatherName.text;
        FATCA.familyName.value = _FamilyName.text;
        FATCA.firstNameArabic.value = _firstNameArabic.text;
        FATCA.fatherNameArabic.value = _fatherNameArabic.text;
        FATCA.grandFatherNameArabic.value = _grandFatherNameArabic.text;
        FATCA.familyNameArabic.value = _FamilyNameArabic.text;
        FATCA.placeOfBirth.value = placeOfBirth.text;
        FATCA.dob.value = DOBdateController.text;
        FATCA.dobHijri.value = DOBHijridateController.text;
        InvestmentPortfolioB.clientName.value = _firstName.text;
        FATCA.clientName.value = _firstName.text;
        FATCA.clientNameAr.value = _firstNameArabic.text;
        DocumentUpload.idname.value = dropdownvalueIdType!;

        tabController?.animateTo(1);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    return 0;
  }

  Future<int> putData(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    print("Updatuingg");
    try {
      dependents = int.parse(_numDependents.text);
    } catch (e) {
      dependents = 0;
    }
    print("Dependentssssssss");
    print(dependents);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PersonalInfo/personalinfoUpdate?ClientId=${clientId}');
    print(url);

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "firstNameArabic": _firstNameArabic.text,
        "firstName": _firstName.text,
        "fatherNameArabic": _fatherNameArabic.text,
        "grandFatherNameArabic": _grandFatherNameArabic.text,
        "familyNameArabic": _FamilyNameArabic.text,
        "citizenshipIdNo": citizenshipIdNo.text,
        "passportId": passportId.text,
        "passportExpiryDate": PassportExpdateController.text,
        "passportExpiryDateHijri": PassportExpHijridateController.text,
        "fatherName": _fatherName.text,
        "grandFatherName": _grandFatherName.text,
        "familyName": _FamilyName.text,
        "numDependents": dependents,
        "citizenship": _typeAheadController.text,
        "gender": gender,
        "holder": holder,
        "define": define.text,
        "maritalStatus": dropdownvalueMaritalStatus,
        "idType": dropdownvalueIdType,
        "idExpDate": dateController.text,
        "idExpDateHijri": ExpHijridateController.text,
        "idNum": idNum.text,
        "pob": placeOfBirth.text,
        "dob": DOBdateController.text,
        "dobHijri": DOBHijridateController.text,
        "educationLevel": dropdownvalueEducationL,
        "citizenshipIdType": citizenshipIdType.text,
        "citizenResidentNonResident": resident
      };

      print(body);
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        // GlobalIndividual.individualclientid = int.parse(response.body);

        // PostalAddress.id.value = id;
        // CC2.id.value = id;
        // IncomeNetWorth.id.value = id;
        // EmployerInfo.id.value = id;
        // BankInfoInv.id.value = id;
        // CustodianInfo.id.value = id;
        // DocumentUpload.id.value = id;
        // FATCA.id.value = id;
        // GeneralInfo.id.value = id;
        // InvestmentPortfolioA.id.value = id;
        // InvestmentPortfolioB.id.value = id;
        // OtherInfoIndividual.id.value = id;
        // ProfessionalExp.id.value = id;
        // ANBAccountIndividual.id.value = id;
        DocumentUpload.name.value = _firstName.text + "~Individual";
        print("NAMEEEEEEEE");
        print(DocumentUpload.name.value);

        FATCA.firstNAme.value = _firstName.text;
        FATCA.fatherName.value = _fatherName.text;
        FATCA.grandFatherName.value = _grandFatherName.text;
        FATCA.familyName.value = _FamilyName.text;
        FATCA.firstNameArabic.value = _firstNameArabic.text;
        FATCA.fatherNameArabic.value = _fatherNameArabic.text;
        FATCA.grandFatherNameArabic.value = _grandFatherNameArabic.text;
        FATCA.familyNameArabic.value = _FamilyNameArabic.text;
        FATCA.placeOfBirth.value = placeOfBirth.text;
        FATCA.dob.value = DOBdateController.text;
        FATCA.dobHijri.value = DOBHijridateController.text;
        InvestmentPortfolioB.clientName.value = _firstName.text;
        FATCA.clientName.value = _firstName.text;
        FATCA.clientNameAr.value = _firstNameArabic.text;
        DocumentUpload.idname.value = dropdownvalueIdType!;

        tabController?.animateTo(1);
        setState(() {
          btn = "Next";
        });
      } else {
        setState(() {
          btn = "Next";
        });
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
    } catch (e) {
      print(e.toString());
    }
    return 0;
  }

  String? numberValidator(String? value) {
    if (value == null) {
      return "";
    }
    final n = num.tryParse(value);
    if (n == null) {
      return '"$value" is not a valid number';
    }
    //return "null";
  }

  // List of items in our dropdown menu
  var items = [
    'Natifconal ID',
    'Iqama ID',
    'Diplomatic ID',
    'Passport',
  ];
  String str = "Iqama ID";

  var idtype = [
    'National ID',
    'Iqama ID',
    'Diplomatic ID',
  ];

  var educationLevel = [
    'Secondary',
    'Higher Secondary',
    'Undergraduate',
    'Postgraduate',
    'Phd',
  ];

  var maritalStatus = [
    'Single',
    'Married',
    'Divorced',
    'Separated',
    'Widowed',
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
    '',
  ];

  String _selectedItem = ''; // To store the selected item

  @override
  void initState() {
    super.initState();
    print("Init Runnng-----");
    print(GlobalIndividual.individualclientid);
    if (GlobalIndividual.individualdraftprogress["Personalnfo"] == true) {
      print("ftechinggg----------");
      getdata(GlobalIndividual.individualclientid);
    }
    print(holder);
    // getdata();
    setState(() {
      dependents = int.tryParse(_numDependents.text);
    });
  }

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PersonalInfo/personalinfo/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);

      _firstName.text = data["firstName"];
      _firstNameArabic.text = data["firstNameArabic"];
      _fatherNameArabic.text = data["fatherNameArabic"];
      _grandFatherNameArabic.text = data["grandFatherNameArabic"];
      _FamilyNameArabic.text = data["familyNameArabic"];
      citizenshipId.text = data["citizenshipIdNo"];
      passportId.text = data["passportId"];
      PassportExpdateController.text = data["passportExpiryDate"];
      PassportExpHijridateController.text = data["passportExpiryDateHijri"];
      _fatherName.text = data["fatherName"];
      _grandFatherName.text = data["grandFatherName"];
      _FamilyName.text = data["familyName"];
      _numDependents.text = data["numDependents"].toString();
      // citizenshipId.text = data["citizenship"];

      define.text = data["define"];
      dateController.text = data["idExpDate"];
      ExpHijridateController.text = data["idExpDateHijri"];
      idNum.text = data["idNum"];
      placeOfBirth.text = data["pob"];
      DOBdateController.text = data["dob"];
      DOBHijridateController.text = data["dobHijri"];
      _typeAheadController.text = data["citizenship"];
      setState(() {
        dropdownvalueIdType = data["idType"];
        resident = data["citizenResidentNonResident"];
        dropdownvalueMaritalStatus = data["maritalStatus"];
        dropdownvalueEducationL = data["educationLevel"] ?? Null;
        gender = data["gender"];
        holder = data["holder"];
      });
      setState(() {});
      print("IDDDDDDDDD");
      print(data["idType"]);

      print("DOBBBBBBBBBBBBBBB");
      print(data["dob"]);
    } else {
      print(response.statusCode);
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
    }
  }

  bool citizenshipError = false;
  bool citizenshipWrong = false;
  bool myBool = false;

  bool residentError = false;

  bool idTypeError = false;
  bool MaritalStatusError = false;
  bool _isRowEnabled = true;
  void _handleRadioValueChange(String value) {
    setState(() {
      resident = value;

      // Set _isRowEnabled based on selected radio button
      _isRowEnabled = resident == 'Non Residents/GCC';
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
          height: 600,
          color: Colors.white,
          child: Scaffold(
            body: Container(
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                S.of(context).ClientName,
                                style: TextController.SubHeadingText,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                S.of(context).InAccordancen,
                                style: TextController.SubHeadingText,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).Name + " *",
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      "(In English)",
                                      style: TextController.BodyText,
                                    ),
                                  ],
                                ),
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              firstNameEn = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              firstNameEn = false;
                                            });
                                          }
                                          return null;
                                        },
                                        controller: _firstName,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FirstName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (firstNameEn)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        controller: _fatherName,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              fatherNameEn = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              fatherNameEn = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FatherName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (fatherNameEn)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        controller: _grandFatherName,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              grandNameEn = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              grandNameEn = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText:
                                              S.of(context).GrandFatherName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (grandNameEn)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[a-zA-Z ]')),
                                        ],
                                        controller: _FamilyName,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              lastNameEn = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              lastNameEn = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FamilyName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (lastNameEn)
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
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).Name + " *",
                                      style: TextController.BodyText,
                                    ),
                                    Text(
                                      S.of(context).InArabic,
                                      style: TextController.BodyText,
                                    ),
                                  ],
                                ),
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: _firstNameArabic,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[\u0600-\u06FF\s]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              firstNameAr = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              firstNameAr = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FirstName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (firstNameAr)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: _fatherNameArabic,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[\u0600-\u06FF\s]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              fatherNameAr = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              fatherNameAr = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FatherName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (fatherNameAr)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: _grandFatherNameArabic,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return;
                                        //   }
                                        // },
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[\u0600-\u06FF\s]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              grandNameAr = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              grandNameAr = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText:
                                              S.of(context).GrandFatherName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (grandNameAr)
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
                                      width: double.infinity,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        controller: _FamilyNameArabic,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyText,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[\u0600-\u06FF\s]')),
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            setState(() {
                                              lastNameAr = true;
                                            });
                                            return "";
                                          } else {
                                            setState(() {
                                              lastNameAr = false;
                                            });
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).FamilyName,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle: TextStyle(height: 0.0),
                                        ),
                                      ),
                                    ),
                                    if (lastNameAr)
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
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).NumberOfDependentsn,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: _numDependents,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.number,
                                          // validator: numberValidator,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText:
                                                  S.of(context).NoDepLabel,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).Citizenship + " *",
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: TypeAheadField(
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                          onTap: () {
                                                            setState(
                                                              () {
                                                                citizenshipError =
                                                                    false;
                                                              },
                                                            );
                                                          },
                                                          controller:
                                                              _typeAheadController,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration: InputDecoration(
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              hintText: S
                                                                  .of(context)
                                                                  .Citizenship)),
                                                  suggestionsCallback:
                                                      (pattern) {
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
                                                      _selectedItem =
                                                          suggestion;
                                                      _typeAheadController
                                                          .text = suggestion;
                                                      if (_typeAheadController
                                                              .text ==
                                                          "Saudi Arabia") {
                                                        // setState(() {
                                                        //   dropdownvalueIdType =
                                                        //       "National ID";
                                                        // });
                                                        // setState(() {
                                                        //   resident =
                                                        //       "Citizen/Residents";
                                                        // });
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (citizenshipError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required.",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (citizenshipWrong)
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).CitizenshipID + " Type",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: citizenshipIdType,
                                          // keyboardType: TextInputType.number,
                                          // validator: numberValidator,
                                          // inputFormatters: <TextInputFormatter>[
                                          //   FilteringTextInputFormatter
                                          //       .digitsOnly
                                          // ],
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).CitizenshipNo,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: citizenshipIdNo,
                                          // keyboardType: TextInputType.number,
                                          // validator: numberValidator,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  children: [
                                    Container(
                                      width: 160,
                                      child: Text(
                                        S.of(context).Holdern + " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).Yes,
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "Yes",
                                                groupValue: holder,
                                                onChanged: (value) {
                                                  setState(() {
                                                    myBool = false;
                                                    holderError = false;
                                                    holder =
                                                        value!; //<-- change this
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                S.of(context).No,
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "No",
                                                groupValue: holder,
                                                onChanged: (value) {
                                                  setState(() {
                                                    myBool = true;
                                                    holderError = false;
                                                    defineerror = false;
                                                    holder =
                                                        value!; //<-- change this
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          if (holderError)
                                            Text(
                                              "Select any option",
                                              style: TextController.errorText,
                                            )
                                        ],
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).Define,
                                        style: TextController.BodyText,
                                      ),
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
                                                          TextAlignVertical
                                                              .center,
                                                      onTap: () {
                                                        setState(
                                                          () {
                                                            defineerror = false;
                                                          },
                                                        );
                                                      },
                                                      controller: define,
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
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                );
                                              },
                                              onSuggestionSelected:
                                                  (suggestion) {
                                                // Update the selected item when a suggestion is selected.
                                                setState(() {
                                                  _selectedItem = suggestion;
                                                  define.text = suggestion;
                                                  // if (_typeAheadController
                                                  //         .text ==
                                                  //     "Saudi Arabia") {
                                                  //   setState(() {
                                                  //     dropdownvalueIdType =
                                                  //         "National ID";
                                                  //   });
                                                  //   setState(() {
                                                  //     resident =
                                                  //         "Citizen/Residents";
                                                  //   });
                                                  // }
                                                });
                                              },
                                            ),
                                          ),
                                          if (defineerror)
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
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).MaritalStatus + " *",
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
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
                                              value: dropdownvalueMaritalStatus,
                                              isExpanded: true,
                                              underline: Container(),
                                              iconEnabledColor:
                                                  ColorSelect.east_dark_blue,
                                              items: maritalStatus.map(
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
                                                    dropdownvalueMaritalStatus =
                                                        NewValue!;
                                                    MaritalStatusError = false;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          if (MaritalStatusError)
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

                                    // ---------------------------
                                    // Flexible(
                                    //   child: Container(
                                    //     padding: EdgeInsets.symmetric(
                                    //         horizontal: 10),
                                    //     width: double.infinity,
                                    //     height: 35,
                                    //     alignment: Alignment.centerLeft,
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         border: Border.all(
                                    //             color: ColorSelect.textField)),
                                    //     child: DropdownButtonHideUnderline(
                                    //       child: Theme(
                                    //         data: Theme.of(context).copyWith(
                                    //             focusColor: Colors.white),
                                    //         child: DropdownButtonFormField(
                                    //           hint: Text(
                                    //             S.of(context).SelectHere,
                                    //             style: TextController.labelText,
                                    //           ),
                                    //           isExpanded: true,
                                    //           validator: (value) {
                                    //             if (value!.isEmpty) {
                                    //               return "";
                                    //             }
                                    //           },
                                    //           icon: const Icon(
                                    //               Icons.keyboard_arrow_down),
                                    //           decoration: InputDecoration(
                                    //               enabledBorder:
                                    //                   InputBorder.none,
                                    //               border: InputBorder.none,
                                    //               filled: false,
                                    //               fillColor: Colors.white),
                                    //           items: maritalStatus
                                    //               .map((String maritalStatus) {
                                    //             return DropdownMenuItem(
                                    //               value: maritalStatus,
                                    //               child: Text(maritalStatus,
                                    //                   style: TextController
                                    //                       .BodyText),
                                    //             );
                                    //           }).toList(),
                                    //           onChanged: (String? newValue) {
                                    //             setState(() {
                                    //               dropdownvalueMaritalStatus =
                                    //                   newValue!;
                                    //             });
                                    //           },
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Citizen/Residents",
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "Citizen/Residents",
                                                groupValue: resident,
                                                onChanged: (value) {
                                                  setState(() {
                                                    // setState(() {
                                                    //   _typeAheadController
                                                    //           .text =
                                                    //       "Saudi Arabia";
                                                    // });
                                                    residentError = false;
                                                    resident =
                                                        value!; //<-- change this
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Non Residents/GCC",
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "Non Residents/GCC",
                                                groupValue: resident,
                                                onChanged: (value) {
                                                  // if (_typeAheadController
                                                  //         .text ==
                                                  //     "Saudi Arabia") {
                                                  //   setState(() {
                                                  //     _typeAheadController
                                                  //         .text = "";
                                                  //   });
                                                  // }
                                                  setState(() {
                                                    residentError = false;
                                                    resident =
                                                        value!; //<-- change this
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          if (residentError)
                                            Text(
                                              "Select Option",
                                              style: TextController.errorText,
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
                            height: 10,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).IDType + " *",
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: DropdownButton(
                                              hint: Text("Select Here",
                                                  style:
                                                      TextController.labelText),
                                              value: dropdownvalueIdType,
                                              isExpanded: true,
                                              underline: Container(),
                                              iconEnabledColor:
                                                  ColorSelect.east_dark_blue,
                                              items: idtype.map(
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
                                                    idTypeError = false;
                                                    dropdownvalueIdType =
                                                        NewValue!;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          if (idTypeError)
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

                                    // --------------------------------------------
                                    // Flexible(
                                    //   child: Container(
                                    //     width: 270,
                                    //     height: 44,
                                    //     alignment: Alignment.centerLeft,
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         border: Border.all(
                                    //             color: ColorSelect.textField)),
                                    //     child: Center(
                                    //       child: Padding(
                                    //         padding:
                                    //             const EdgeInsets.only(left: 15),
                                    //         child: DropdownButtonHideUnderline(
                                    //           child: Theme(
                                    //             data: Theme.of(context)
                                    //                 .copyWith(
                                    //                     focusColor:
                                    //                         Colors.white),
                                    //             child: DropdownButtonFormField(
                                    //               hint: Text(
                                    //                 S.of(context).SelectHere,
                                    //                 style: TextController
                                    //                     .labelText,
                                    //               ),
                                    //               isExpanded: true,
                                    //               icon: const Icon(Icons
                                    //                   .keyboard_arrow_down),
                                    //               validator: (value) {
                                    //                 if (value!.isEmpty) {
                                    //                   return "";
                                    //                 }
                                    //               },
                                    //               decoration: InputDecoration(
                                    //                   enabledBorder:
                                    //                       InputBorder.none,
                                    //                   border: InputBorder.none,
                                    //                   filled: false,
                                    //                   fillColor: Colors.white),
                                    //               items: idtype
                                    //                   .map((String idtype) {
                                    //                 return DropdownMenuItem(
                                    //                   value: idtype,
                                    //                   child: Text(idtype,
                                    //                       style: TextController
                                    //                           .BodyText),
                                    //                 );
                                    //               }).toList(),
                                    //               onChanged:
                                    //                   (String? newValue) {
                                    //                 setState(() {
                                    //                   dropdownvalueIdType =
                                    //                       newValue!;
                                    //                 });
                                    //               },
                                    //             ),
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).IDExpiryDate + " *",
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: GestureDetector(
                                              onTap: () async {
                                                DateTime? datepicked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now()
                                                      .add(Duration(days: 90)),
                                                  firstDate: DateTime.now()
                                                      .add(Duration(days: 90)),
                                                  lastDate: DateTime(3000),
                                                );
                                                if (datepicked != null) {
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(datepicked);
                                                  HijriCalendar? picked =
                                                      HijriCalendar.fromDate(
                                                          datepicked);
                                                  setState(() {
                                                    dateController.text =
                                                        formattedDate;
                                                    ExpHijridateController
                                                            .text =
                                                        picked.toString();
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: dateController,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      IDxerr = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      IDxerr = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  errorStyle:
                                                      TextStyle(height: 0.0),
                                                  suffixIcon: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15,
                                                  ),
                                                  hintText:
                                                      S.of(context).DateFormat,
                                                  hintStyle: TextController
                                                      .labelTextDate,
                                                  border: InputBorder.none,
                                                ),
                                                enabled:
                                                    false, // Disable text editing
                                              ),
                                            ),
                                          ),
                                          if (IDxerr)
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).IDExpiryDateHijri,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
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
                                          child: TextField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: ExpHijridateController,
                                            style: TextController.BodyText,
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
                                                border: InputBorder.none),
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
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              // HijriDatePicker(),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).IDNumber + " *",
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              maxLength: 10,
                                              keyboardType:
                                                  TextInputType.number,
                                              // validator: numberValidator,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              controller: idNum,
                                              validator: (value) {
                                                if (_typeAheadController.text ==
                                                        "Saudi Arabia" ||
                                                    resident ==
                                                        "Citizen/Residents") {
                                                  if (value!.isNotEmpty) {
                                                    if (dropdownvalueIdType ==
                                                        "National ID") {
                                                      if ((!value.startsWith(
                                                              '1')) ||
                                                          (value.length !=
                                                              10)) {
                                                        setState(() {
                                                          idNumNationalError =
                                                              true;
                                                          idNumError = false;
                                                        });
                                                        return '';
                                                      } else {
                                                        setState(() {
                                                          idNumNationalError =
                                                              false;
                                                          idNumError = false;
                                                        });
                                                      }
                                                    } else if (dropdownvalueIdType ==
                                                        "Iqama ID") {
                                                      if ((!value.startsWith(
                                                              '2')) ||
                                                          (value.length !=
                                                              10)) {
                                                        setState(() {
                                                          idNumIqamaError =
                                                              true;
                                                          idNumError = false;
                                                        });
                                                        return '';
                                                      } else {
                                                        setState(() {
                                                          idNumIqamaError =
                                                              false;
                                                          idNumError = false;
                                                        });
                                                      }
                                                    } else if (dropdownvalueIdType ==
                                                        "Diplomatic ID") {
                                                      if ((value.length !=
                                                          10)) {
                                                        setState(() {
                                                          idNumDiplomaticError =
                                                              true;
                                                          idNumError = false;
                                                        });
                                                        return '';
                                                      } else {
                                                        setState(() {
                                                          idNumDiplomaticError =
                                                              false;
                                                          idNumError = false;
                                                        });
                                                      }
                                                    }
                                                  } else {
                                                    setState(() {
                                                      idNumError = true;
                                                    });
                                                    return '';
                                                  }
                                                }
                                                setState(() {
                                                  idNumNationalError = false;
                                                  idNumIqamaError = false;
                                                  idNumDiplomaticError = false;
                                                  idNumError = false;
                                                });
                                                return null;
                                              },
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                counterText: "",
                                                isDense: true,
                                                hintText:
                                                    S.of(context).IdNumLablel,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0),
                                              ),
                                            ),
                                          ),
                                          if (idNumError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "This field is required.",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (idNumNationalError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Invalid National ID",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (idNumIqamaError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Invalid Iqama ID",
                                                style: TextController.errorText,
                                              ),
                                            ),
                                          if (idNumDiplomaticError)
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              child: Text(
                                                "Invalid Diplomatic ID",
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
                            height: 10,
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).Passport,
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              controller: passportId,
                                              validator: (value) {
                                                if (resident ==
                                                        "Non Residents/GCC" &&
                                                    value!.isEmpty) {
                                                  // If the value is empty
                                                  setState(() {
                                                    passportError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    passportError = false;
                                                  });
                                                }
                                                return null;
                                                // } else if (resident ==
                                                //         "Non Residents/GCC" &&
                                                //     !(RegExp(
                                                //             r'^[A-Z][1-9][0-9]\d{4}\s?$')
                                                //         .hasMatch(value!))) {
                                                //   // If resident is "Non Residents/GCC" and value doesn't match the expected format
                                                //   return 'Enter Valid Passport ID';
                                                // }
                                                // Return null if the input is valid
                                                // Return null if the input is valid
                                              },
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).IdNumLablel,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle:
                                                    TextStyle(height: 0.0),
                                              ),
                                            ),
                                          ),
                                          if (passportError)
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
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).PassportExpiryDate,
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: GestureDetector(
                                              onTap: () async {
                                                DateTime? datepicked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now()
                                                      .add(Duration(days: 90)),
                                                  firstDate: DateTime.now()
                                                      .add(Duration(days: 90)),
                                                  lastDate: DateTime(3000),
                                                );
                                                if (datepicked != null) {
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(datepicked);
                                                  HijriCalendar? picked =
                                                      HijriCalendar.fromDate(
                                                          datepicked);
                                                  setState(() {
                                                    PassportExpdateController
                                                        .text = formattedDate;
                                                    PassportExpHijridateController
                                                            .text =
                                                        picked.toString();
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller:
                                                    PassportExpdateController,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty &&
                                                      passportId
                                                          .text.isNotEmpty) {
                                                    setState(() {
                                                      PassportExpdateControllerError =
                                                          true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      PassportExpdateControllerError =
                                                          false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  suffixIcon: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15,
                                                  ),
                                                  errorStyle: TextStyle(
                                                    height: 0,
                                                  ),
                                                  hintText:
                                                      S.of(context).DateFormat,
                                                  hintStyle: TextController
                                                      .labelTextDate,
                                                  border: InputBorder.none,
                                                ),
                                                enabled:
                                                    false, // Disable text editing
                                              ),
                                            ),
                                          ),
                                          if (PassportExpdateControllerError)
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).PassportExpiryDateHijri,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
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
                                          child: TextField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller:
                                                PassportExpHijridateController,
                                            style: TextController.BodyText,
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
                                                border: InputBorder.none),
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
                                            //             setState((PassportExpHijridateController
                                            //                         .text =
                                            //                     picked
                                            //                         .toString())
                                            //                 as VoidCallback));
                                            //   }
                                            // },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).Gender + " *",
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                S.of(context).Male,
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "Male",
                                                groupValue: gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender =
                                                        value!; //<-- change this
                                                    genderError = false;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                S.of(context).Female,
                                                style: TextController.BodyText,
                                              ),
                                              Radio<String>(
                                                value: "Female",
                                                groupValue: gender,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gender =
                                                        value!; //<-- change this
                                                    genderError = false;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          if (genderError)
                                            Text(
                                              "Select Gender",
                                              style: TextController.errorText,
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
                            height: 10,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).PlaceOfBirthn,
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: TextFormField(
                                              controller: placeOfBirth,
                                              style: TextController.BodyText,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  setState(() {
                                                    placeOfBirthError = true;
                                                  });
                                                  return "";
                                                } else {
                                                  setState(() {
                                                    placeOfBirthError = false;
                                                  });
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  hintStyle:
                                                      TextController.labelText,
                                                  border: InputBorder.none,
                                                  errorStyle:
                                                      TextStyle(height: 0)),
                                            ),
                                          ),
                                          if (placeOfBirthError)
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).DateOfBirthn,
                                        style: TextController.BodyText,
                                      ),
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
                                            width: double.infinity,
                                            height: 35,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField)),
                                            child: GestureDetector(
                                              onTap: () async {
                                                DateTime? datepicked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(1900),
                                                  lastDate: DateTime.now(),
                                                );
                                                if (datepicked != null) {
                                                  String formattedDate =
                                                      DateFormat('dd-MM-yyyy')
                                                          .format(datepicked);
                                                  HijriCalendar? picked =
                                                      HijriCalendar.fromDate(
                                                          datepicked);
                                                  setState(() {
                                                    DOBdateController.text =
                                                        formattedDate;
                                                    DOBHijridateController
                                                            .text =
                                                        picked.toString();
                                                  });
                                                } else {
                                                  print("Date is not selected");
                                                }
                                              },
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: DOBdateController,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      dobError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      dobError = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  suffixIcon: Icon(
                                                    Icons
                                                        .calendar_month_outlined,
                                                    size: 15,
                                                  ),
                                                  hintText:
                                                      S.of(context).DateFormat,
                                                  hintStyle: TextController
                                                      .labelTextDate,
                                                  border: InputBorder.none,
                                                  errorStyle: TextStyle(
                                                    height: 0,
                                                  ),
                                                ),
                                                enabled:
                                                    false, // Disable text editing
                                              ),
                                            ),
                                          ),
                                          if (dobError)
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
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).DOBHijrin,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
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
                                          child: TextField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: DOBHijridateController,
                                            style: TextController.BodyText,
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
                                                border: InputBorder.none),
                                            readOnly: true,
                                            onTap: () async {
                                              // final HijriCalendar? picked =
                                              //     HijriCalendar.fromDate(
                                              //         datepicked!);
                                              //   await showHijriDatePicker(
                                              // context: context,
                                              // initialDate: selectedDate,
                                              // lastDate: new HijriCalendar()
                                              //   ..hYear = 1445
                                              //   ..hMonth = 9
                                              //   ..hDay = 25,
                                              // firstDate: new HijriCalendar()
                                              //   ..hYear = 1438
                                              //   ..hMonth = 12
                                              //   ..hDay = 25,
                                              // initialDatePickerMode:
                                              //     DatePickerMode.day,

                                              // if (datepicked != null &&
                                              //     picked != null) {
                                              //   //print(picked);
                                              //   WidgetsBinding.instance
                                              //       .addPostFrameCallback((_) =>
                                              //           setState((DOBHijridateController
                                              //                       .text =
                                              //                   picked
                                              //                       .toString())
                                              //               as VoidCallback)
                                              //               );
                                              // }
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: Text(
                                        S.of(context).EducationLevel,
                                        style: TextController.BodyText,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                    Flexible(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        width: double.infinity,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: DropdownButton(
                                          hint: Text("Select Here",
                                              style: TextController.labelText),
                                          value: dropdownvalueEducationL!
                                                  .isNotEmpty
                                              ? dropdownvalueEducationL
                                              : null,
                                          isExpanded: true,
                                          underline: Container(),
                                          iconEnabledColor:
                                              ColorSelect.east_dark_blue,
                                          items: educationLevel.map(
                                            (String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              );
                                            },
                                          ).toList(),
                                          onChanged: (NewValue) {
                                            setState(
                                              () {
                                                if (NewValue != null &&
                                                    NewValue.isNotEmpty) {
                                                  dropdownvalueEducationL =
                                                      NewValue;
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    // -----------------------

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
                                    //               style:
                                    //                   TextController.labelText,
                                    //             ),
                                    //             isExpanded: true,
                                    //             validator: (value) {
                                    //               if (value!.isEmpty) {
                                    //                 return "";
                                    //               }
                                    //             },
                                    //             icon: const Icon(
                                    //                 Icons.keyboard_arrow_down),
                                    //             decoration: InputDecoration(
                                    //                 enabledBorder:
                                    //                     InputBorder.none,
                                    //                 border: InputBorder.none,
                                    //                 filled: false,
                                    //                 fillColor: Colors.white),
                                    //             items: educationLevel.map(
                                    //                 (String educationLevel) {
                                    //               return DropdownMenuItem(
                                    //                 value: educationLevel,
                                    //                 child: Text(educationLevel,
                                    //                     style: TextController
                                    //                         .BodyText),
                                    //               );
                                    //             }).toList(),
                                    //             onChanged: (newValue) {
                                    //               setState(() {
                                    //                 dropdownvalueEducationL =
                                    //                     newValue.toString();
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
                          Container(
                            margin: EdgeInsets.only(
                              top: 50,
                            ),
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
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  IndividualClientList()));
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
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorSelect.east_blue),
                                    ),
                                    onPressed: () async {
                                      print(_formKey.currentState);
                                      print("POstaaaal");
                                      print("presonal");
                                      print(_formKey.currentState!.validate());
                                      // if (gender == "") {
                                      //   setState(() {
                                      //     genderError = true;
                                      //   });
                                      // } else {
                                      //   print("---------gender Error");
                                      // }
                                      if (_formKey.currentState != null) {
                                        setState(() {
                                          genderError = gender == "";
                                          dobError =
                                              DOBdateController.text == "";

                                          citizenshipError =
                                              _typeAheadController.text == "";
                                          holderError = holder == "";
                                          residentError = resident == "";
                                          idTypeError =
                                              dropdownvalueIdType == null;
                                          MaritalStatusError =
                                              dropdownvalueMaritalStatus ==
                                                  null;
                                          if (holder == "Yes") {
                                            defineerror = define.text == "";
                                          }

                                          if (citizenship.contains(
                                              _typeAheadController.text)) {
                                            citizenshipWrong = false;
                                          } else {
                                            citizenshipWrong = true;
                                          }

                                          // dropdownvalueEducationL ??= "";
                                          // dropdownvalueIdType ??= "";
                                          // dropdownvalueMaritalStatus ??= "";
                                        });

                                        if (resident == "Citizen/Residents" &&
                                            dropdownvalueIdType ==
                                                "Diplomatic ID") {
                                          Fluttertoast.showToast(
                                            msg: "Select Valid ID Type",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        } else if (resident ==
                                                "Non Residents/GCC" &&
                                            dropdownvalueIdType ==
                                                "National ID") {
                                          Fluttertoast.showToast(
                                            msg:
                                                "National ID is not valid for Non-Residents",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 3,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        } else if (_formKey.currentState!
                                                .validate() &&
                                            !defineerror &&
                                            (!idTypeError &&
                                                !MaritalStatusError &&
                                                !dobError &&
                                                !genderError &&
                                                !citizenshipError &&
                                                !holderError &&
                                                !citizenshipWrong)) {
                                          if (x <= 0) {
                                            print("retunnnnn");
                                            return;
                                          } else {
                                            x--;
                                          }

                                          print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                          if (GlobalIndividual
                                                      .individualdraftprogress[
                                                  "Personalnfo"] ==
                                              true) {
                                            putData(GlobalIndividual
                                                .individualclientid);
                                          } else {
                                            register();
                                          }
                                          x++;
                                        }
                                      } else {
                                        // Handle case where _formKey.currentState is null
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
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          )),
    );
  }
}
