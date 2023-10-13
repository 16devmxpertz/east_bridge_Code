import 'dart:convert';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20POA/GlobalPOA.dart';
import 'package:east_bridge/KYC/KYC%20Components/FATCA.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/Personalnfo.dart';
import 'package:east_bridge/KYC/KYC%20Components/cscpickerstate.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:pinput/pinput.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class PostalAddressPOA extends StatefulWidget {
  PostalAddressPOA({
    @required controller,
  }) {
    tabController = controller;
    // _formKey = formKey;
  }

  @override
  State<PostalAddressPOA> createState() => _PostalAddressPOAState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<FormState> intlKey = GlobalKey<FormState>();
String? countryValue;
String? stateValue;
String? cityValue;

class _PostalAddressPOAState extends State<PostalAddressPOA> {
  String btn = "Next";
  bool isstate = false;
  bool iscity = false;
  bool isstate2 = false;
  bool iscity2 = false;
  // var vallll = CscCountry.India as String ;
  // PostalAddressPOA({@required controller}) {
  //   tabController = controller;
  // }
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String statement = "";
  String statement2 = "";

  TextEditingController _po = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _mobile = new TextEditingController();
  TextEditingController _fax = new TextEditingController();
  TextEditingController _residencePhone = new TextEditingController();
  TextEditingController _buildingNum = new TextEditingController();
  TextEditingController _streetName = new TextEditingController();
  TextEditingController _zipCode = new TextEditingController();
  TextEditingController _secondaryNum = new TextEditingController();
  TextEditingController district = new TextEditingController();
  TextEditingController _po2 = new TextEditingController();
  TextEditingController _email2 = new TextEditingController();
  TextEditingController _mobile2 = new TextEditingController();
  TextEditingController _fax2 = new TextEditingController();
  TextEditingController _residencePhone2 = new TextEditingController();
  TextEditingController _buildingNum2 = new TextEditingController();
  TextEditingController _streetName2 = new TextEditingController();
  TextEditingController _zipCode2 = new TextEditingController();
  TextEditingController _secondaryNum2 = new TextEditingController();
  TextEditingController district2 = new TextEditingController();
  TextEditingController countryValuenew = new TextEditingController();
  TextEditingController cityValuenew = new TextEditingController();
  TextEditingController stateValuenew = new TextEditingController();
  TextEditingController countryValuenew2 = new TextEditingController();
  TextEditingController cityValuenew2 = new TextEditingController();
  TextEditingController stateValuenew2 = new TextEditingController();
  String? countryValue2;
  String? stateValue2;
  String? cityValue2;
  String selectedValue = "";
  String? dropdownvalue;

  String countrycode = "";
  String countrycode2 = "";
  String FaxCode2 = "";
  String secondarycountrycode = "";
  String mobile2countrycode = "";
  String secondary2countrycode = "";
  bool statementError = false;
  bool statementError1 = false;

  bool statement2Error = false;
  bool isYes = false;
  bool showCountryError = false;
  bool showStateError = false;

  bool showCityError = false;
  bool showCountryError1 = false;
  bool showStateError1 = false;

  bool showCityError1 = false;

  bool po1er = false;
  bool landline1er = false;
  bool mobile1er = false;
  bool street1er = false;
  bool district1er = false;
  bool email1er = false;
  bool fax1er = false;
  bool building1er = false;
  bool secondary1er = false;
  bool zip1er = false;

  bool po2er = false;
  bool landline2er = false;
  bool mobile2er = false;
  bool street2er = false;
  bool district2er = false;
  bool email2er = false;
  bool fax2er = false;
  bool building2er = false;
  bool secondary2er = false;
  bool zip2er = false;
  List<String> dropdownlistcountry = ["Loading..."];
  List<String> dropdownliststate = [""];
  List<String> dropdownlistcity = [""];

  String _selectedItem = '';
  // final digitsOnly = _zipCode.text.replaceAll(RegExp(r'[^0-9]'), '');

  var data = {};

  Future getdata(int clientId) async {
    print("getting");
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PostalAddressPOA/postaladdresspoa/${clientId}');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);

      setState(() {
        print("111111");
        statement = data["wishToRecive"];
        print("22222");
        print(statement);
        selectedValue = data["sameAsRegisterAddress"];
        statement2 = data["currentWishToRecive"];
      });

      _po.text = data["poBox"];
      _email.text = data["eMail"];
      _residencePhone.text = data["landlinePhoneNo"];
      _fax.text = data["fax"];
      countryValuenew.text = data["country"];
      stateValuenew.text = data["state"];

      cityValuenew.text = data["city"];
      _mobile.text = data["mobile"];
      _buildingNum.text = data["buildingNo"];
      _streetName.text = data["streetName"];
      _zipCode.text = data["zipCode"];
      _secondaryNum.text = data["secondaryNumber"];
      district.text = data["district"];

      _po2.text = data["currentPoBox"];
      _email2.text = data["currentEMail"];
      _residencePhone2.text = data["currentLandlinePhoneNo"];
      _fax2.text = data["currentFax"];
      _mobile2.text = data["currentMobile"];
      _buildingNum2.text = data["currentBuildingNo"];
      _streetName2.text = data["currentStreetName"];
      _zipCode2.text = data["currentZipCode"];
      _secondaryNum2.text = data["currentSecondaryNumber"];
      district2.text = data["currentDistrict"];
      countryValuenew2.text = data["currentCountry"];
      stateValuenew2.text = data["currentState"];

      cityValuenew2.text = data["currentCity"];
      setState(() {
        secondarycountrycode = data["secondryCode1"];
        countrycode = data["mobileCode1"];
        secondary2countrycode = data["seondryCode2"];
        mobile2countrycode = data["mobileCode2"];
      });
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

  Future<void> fetchData() async {
    await getdata(9043);
    setState(() {
      // Set your state variables here
    });
  }

  @override
  void initState() {
    super.initState();
    print("Init Runing");
    setSate() {
      countryValue = "India";
    }

    // getdata(9043);
    // fetchData();
    print("YESSSSSSSSSSSS");
    print("NOOOOOOOOOO");
    print('Country Value: $countryValue');
    print('State Value: $stateValue');
    print('City Value: $cityValue');
    if (GlobalPOA.poadraftprogress["PostalAddressPOA"] == true) {
      print("ftechinggg----------");
      getdata(GlobalPOA.poalclientid);
    }
  }

  void senddata() async {
    setState(() {
      btn = "Loading...";
    });
    print("Sendinggggg");
    print(countrycode);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PostalAddressPOA/postaladdresspoa/');

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPOA.poalclientid,
      "wishToRecive": statement,
      "country": countryValuenew.text,
      "poBox": _po.text,
      "eMail": _email.text,
      "state": stateValuenew.text,
      "landlinePhoneNo": _residencePhone.text,
      "fax": _fax.text,
      "city": cityValuenew.text,
      "mobile": _mobile.text,
      "buildingNo": _buildingNum.text,
      "streetName": _streetName.text,
      "zipCode": _zipCode.text,
      "secondaryNumber": _secondaryNum.text,
      "district": district.text,
      "sameAsRegisterAddress": selectedValue,
      "currentWishToRecive": statement2,
      "currentCountry": countryValuenew2.text,
      "currentPoBox": _po2.text,
      "currentEMail": _email2.text,
      "currentState": stateValuenew2.text,
      "currentLandlinePhoneNo": _residencePhone2.text,
      "currentFax": _fax2.text,
      "currentCity": cityValuenew2.text,
      "currentMobile": _mobile2.text,
      "currentBuildingNo": _buildingNum2.text,
      "currentStreetName": _streetName2.text,
      "currentZipCode": _zipCode2.text,
      "currentSecondaryNumber": _secondaryNum2.text,
      "currentDistrict": district2.text,
      "secondryCode1": secondarycountrycode,
      "mobileCode1": countrycode,
      "seondryCode2": secondary2countrycode,
      "mobileCode2": mobile2countrycode
    };
    print(body);
    var response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      print("sta20000");
      GlobalPOA.getdraftprogresspoa(GlobalPOA.poalclientid);

      FATCA.country.value = countryValuenew.text;
      FATCA.city.value = cityValuenew.text;
      FATCA.state.value = stateValuenew.text;
      FATCA.buildingNum.value = _buildingNum.text;
      FATCA.streetNAme.value = _streetName.text;
      FATCA.district.value = district.text;
      FATCA.postalCode.value = _zipCode.text;
      tabController?.animateTo(3);
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
  }

//PUT------------------
  void putdata(int clientId) async {
    setState(() {
      btn = "Loading...";
    });
    print("MobileCode");
    print(countrycode);
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PostalAddressPOA/postaladdresspoaPut?ClientId=${clientId}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": clientId,
        "wishToRecive": statement,
        "country": countryValuenew.text,
        "poBox": _po.text,
        "eMail": _email.text,
        "state": stateValuenew.text,
        "landlinePhoneNo": _residencePhone.text,
        "fax": _fax.text,
        "city": cityValuenew.text,
        "mobile": _mobile.text,
        "buildingNo": _buildingNum.text,
        "streetName": _streetName.text,
        "zipCode": _zipCode.text,
        "secondaryNumber": _secondaryNum.text,
        "district": district.text,
        "sameAsRegisterAddress": selectedValue,
        "currentWishToRecive": statement2,
        "currentCountry": countryValuenew2.text,
        "currentPoBox": _po2.text,
        "currentEMail": _email2.text,
        "currentState": stateValuenew2.text,
        "currentLandlinePhoneNo": _residencePhone2.text,
        "currentFax": _fax2.text,
        "currentCity": cityValuenew2.text,
        "currentMobile": _mobile2.text,
        "currentBuildingNo": _buildingNum2.text,
        "currentStreetName": _streetName2.text,
        "currentZipCode": _zipCode2.text,
        "currentSecondaryNumber": _secondaryNum2.text,
        "currentDistrict": district2.text,
        "secondryCode1": secondarycountrycode,
        "mobileCode1": countrycode,
        "seondryCode2": secondary2countrycode,
        "mobileCode2": mobile2countrycode
      };
      print(body);
      var response =
          await http.put(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        FATCA.country.value = countryValuenew.text;
        FATCA.city.value = cityValuenew.text;
        FATCA.state.value = stateValuenew.text;
        FATCA.buildingNum.value = _buildingNum.text;
        FATCA.streetNAme.value = _streetName.text;
        FATCA.district.value = district.text;
        FATCA.postalCode.value = _zipCode.text;
        tabController?.animateTo(3);
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
  }

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu

    String? numberValidator(String? value) {
      if (value == null) {
        return "";
      }
      final n = num.tryParse(value);
      if (n == null) {
        return '"$value" is not a valid number';
      }
    }

    return Container(
      height: 400,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).NationalAddress,
                              style: TextController.SubHeadingText,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "(If the client is resident of the kingdom)",
                              style: TextController.SubHeadingText,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "We wish to receive a statement via: *",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  S.of(context).EMail,
                                  style: TextController.BodyText,
                                ),
                                Radio<String>(
                                  value: "EMail",
                                  groupValue: statement,
                                  onChanged: (value) {
                                    setState(() {
                                      statement = value!;
                                      statementError = false;
                                      print(statement);

                                      //<-- change this
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  S.of(context).Mail,
                                  style: TextController.BodyText,
                                ),
                                Radio<String>(
                                  value: "Mail",
                                  groupValue: statement,
                                  onChanged: (value) {
                                    setState(() {
                                      statement = value!;
                                      if (statement == 'Mail') {
                                        countryValue = 'SA';
                                        statementError = false;
                                        // Set country value to Saudi Arabia
                                      } //<-- change this
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  "We do not wish to receive a statement",
                                  style: TextController.BodyText,
                                ),
                                Radio<String>(
                                  value: "We do not wish to receive statement",
                                  groupValue: statement,
                                  onChanged: (value) {
                                    setState(() {
                                      statement = value!;
                                      statementError = false;
                                      //<-- change this
                                    });
                                  },
                                ),
                              ],
                            ),
                            if (statementError)
                              Text(
                                "Select any option",
                                style: TextController.errorText,
                              )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).Country + " *",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  S.of(context).State + " *",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  S.of(context).City + " *",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  S.of(context).StreetName + " *",
                                  style: TextController.BodyText,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  S.of(context).District + " *",
                                  style: TextController.BodyText,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 270,
                                    child: FormField<String>(
                                      builder: (FormFieldState<String> field) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  height: 35,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  child: TypeAheadField(
                                                    textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                            onTap: () {},
                                                            controller:
                                                                countryValuenew,
                                                            style:
                                                                TextController
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
                                                                    .Country)),
                                                    suggestionsCallback:
                                                        (pattern) {
                                                      print("error");
                                                      return GlobalPermission
                                                          .countries
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
                                                      countryValuenew.text =
                                                          suggestion;
                                                      print(
                                                          "selectetd countryy uis ${countryValuenew.text}");
                                                      setState(() {
                                                        stateValuenew.text = "";
                                                        cityValuenew.text = "";
                                                        isstate = false;
                                                        iscity = false;

                                                        if (countryValuenew
                                                                .text ==
                                                            "") {
                                                          print("state false");
                                                          isstate = false;
                                                        } else {
                                                          print("state ture");
                                                          isstate = true;
                                                        }
                                                      });
                                                      setState(() {
                                                        _selectedItem =
                                                            suggestion;
                                                        countryValuenew.text =
                                                            suggestion;
                                                        print("fdgfdgdfg-");
                                                      });

                                                      GlobalPermission.getState(
                                                          countryValuenew.text);
                                                    },
                                                  ),
                                                ),
                                                if (showCountryError)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'Select Country',
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  height: 35,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  child: TypeAheadField(
                                                    textFieldConfiguration:
                                                        TextFieldConfiguration(
                                                            enabled: isstate,
                                                            onTap: () {},
                                                            controller:
                                                                stateValuenew,
                                                            style:
                                                                TextController
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
                                                                    .State)),
                                                    suggestionsCallback:
                                                        (pattern) {
                                                      // Return a filtered list of suggestions based on the search pattern.
                                                      return GlobalPermission
                                                          .states
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
                                                      stateValuenew.text =
                                                          suggestion;
                                                      cityValuenew.text = "";
                                                      print(
                                                          "Select ted satted is ${stateValuenew.text}");
                                                      setState(() {
                                                        if (stateValuenew
                                                                .text ==
                                                            "") {
                                                          iscity = false;
                                                        } else {
                                                          print("city ture");
                                                          iscity = true;
                                                        }
                                                      });
                                                      setState(() {
                                                        _selectedItem =
                                                            suggestion;
                                                        stateValuenew.text =
                                                            suggestion;
                                                      });
                                                      GlobalPermission.getCity(
                                                          countryValuenew.text,
                                                          stateValuenew.text);
                                                    },
                                                  ),
                                                ),
                                                if (showStateError)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'Select State',
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  height: 35,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  child: TypeAheadField(
                                                      textFieldConfiguration:
                                                          TextFieldConfiguration(
                                                              enabled: iscity,
                                                              onTap: () {
                                                                // setState(
                                                                //     () async {

                                                                // });
                                                              },
                                                              controller:
                                                                  cityValuenew,
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
                                                                      .of(
                                                                          context)
                                                                      .City)),
                                                      suggestionsCallback:
                                                          (pattern) {
                                                        // Return a filtered list of suggestions based on the search pattern.
                                                        return GlobalPermission
                                                            .cities
                                                            .where((item) => item
                                                                .toLowerCase()
                                                                .contains(pattern
                                                                    .toLowerCase()))
                                                            .toList();
                                                      },
                                                      itemBuilder: (context,
                                                          suggestion) {
                                                        return ListTile(
                                                          title: Text(
                                                            suggestion,
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                          ),
                                                        );
                                                      },
                                                      onSuggestionSelected:
                                                          (suggestion) {
                                                        // Update the selected item when a suggestion is selected.
                                                        setState(
                                                          () {
                                                            _selectedItem =
                                                                suggestion;
                                                            cityValuenew.text =
                                                                suggestion;
                                                          },
                                                        );
                                                      }),
                                                ),
                                                if (showCityError)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'Select City',
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            // Show state error below state dropdown

                                            // Show city error below city dropdown
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 270,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: _streetName,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                street1er = true;
                                              });
                                              return "";
                                            } else {
                                              setState(() {
                                                street1er = false;
                                              });
                                            }
                                            return null;
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(height: 0.0),
                                          ),
                                        ),
                                      ),
                                      if (street1er)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required.",
                                            style: TextController.errorText,
                                          ),
                                        )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 270,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          controller: district,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                district1er = true;
                                              });
                                              return "";
                                            } else {
                                              setState(() {
                                                district1er = false;
                                              });
                                            }
                                            return null;
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle: TextStyle(height: 0.0),
                                          ),
                                        ),
                                      ),
                                      if (district1er)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "This field is required.",
                                            style: TextController.errorText,
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).PO + " *",
                                            style: TextController.BodyText,
                                          ),
                                          Container(
                                            width: 90,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  height: 35,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  child: TextFormField(
                                                    controller: _po,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        setState(() {
                                                          po1er = true;
                                                        });
                                                        return "";
                                                      } else {
                                                        setState(() {
                                                          po1er = false;
                                                        });
                                                      }
                                                      return null;
                                                    },
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style:
                                                        TextController.BodyText,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                          height: 0.0),
                                                    ),
                                                  ),
                                                ),
                                                if (po1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required.",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Landline/Phone\nNo. *",
                                            style: TextController.BodyText,
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField),
                                                  ),
                                                  child: IntlPhoneField(
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
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
                                                        AutovalidateMode
                                                            .disabled,
                                                    showDropdownIcon: false,
                                                    pickerDialogStyle:
                                                        PickerDialogStyle(
                                                      width: 400,
                                                    ),
                                                    showCountryFlag: false,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller: _residencePhone,
                                                    dropdownTextStyle:
                                                        TextController.BodyText,
                                                    style:
                                                        TextController.BodyText,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      counterText: "",
                                                      hintText: S
                                                          .of(context)
                                                          .ResPhLabel,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                        fontFamily: 'Gotham',
                                                        fontSize: 7.0,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.01,
                                                      ),
                                                    ),
                                                    onCountryChanged:
                                                        (country) {
                                                      print(
                                                          'Country changed to: ' +
                                                              country.name);
                                                    },
                                                  ),
                                                ),
                                                if (landline1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).Mobile + " *",
                                            style: TextController.BodyText,
                                          ),
                                          SizedBox(
                                            width: 95,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField),
                                                  ),
                                                  child: IntlPhoneField(
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
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
                                                        AutovalidateMode
                                                            .disabled,
                                                    showDropdownIcon: false,
                                                    pickerDialogStyle:
                                                        PickerDialogStyle(
                                                      width: 400,
                                                    ),
                                                    showCountryFlag: false,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller: _mobile,
                                                    dropdownTextStyle:
                                                        TextController.BodyText,
                                                    style:
                                                        TextController.BodyText,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      counterText: "",
                                                      hintText: S
                                                          .of(context)
                                                          .ResPhLabel,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                        fontFamily: 'Gotham',
                                                        fontSize: 7.0,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.01,
                                                      ),
                                                    ),
                                                    onCountryChanged:
                                                        (country) {
                                                      print(
                                                          'Country changed to: ' +
                                                              country.name);
                                                    },
                                                  ),
                                                ),
                                                if (mobile1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).ZipCode + " *",
                                            style: TextController.BodyText,
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  height: 35,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField),
                                                  ),
                                                  child: TextFormField(
                                                    controller: _zipCode,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    style:
                                                        TextController.BodyText,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        setState(() {
                                                          zip1er = true;
                                                        });
                                                        return "";
                                                      } else {
                                                        setState(() {
                                                          zip1er = false;
                                                        });
                                                      }
                                                      return null;

                                                      // if (digitsOnly.length <
                                                      //         5 ||
                                                      //     digitsOnly.length >
                                                      //         9) {
                                                      //   return 'Invalid Zip Code';
                                                      // }
                                                      // return null;
                                                    },
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                          height: 0.0),
                                                    ),
                                                  ),
                                                ),
                                                if (zip1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: (_zipCode.text
                                                                    .length <
                                                                5 &&
                                                            _zipCode.text
                                                                .isNotEmpty &&
                                                            _zipCode.length > 9)
                                                        ? Text(
                                                            "Invalid Zip Code",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          )
                                                        : Text(
                                                            "This field is required.",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 20),
                                    //   child: Row(
                                    //     // mainAxisAlignment:
                                    //     //     MainAxisAlignment.spaceBetween,
                                    //     children: [
                                    //       Align(
                                    //         alignment: Alignment.topLeft,
                                    //         child: Text(
                                    //           S.of(context).Mobile,
                                    //           style: TextController.BodyText,
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         width: 10,
                                    //       ),
                                    //       Flexible(
                                    //         child: Padding(
                                    //           padding: const EdgeInsets.only(),
                                    //           child: Container(
                                    //             decoration: BoxDecoration(
                                    //                 color: Colors.white,
                                    //                 border: Border.all(
                                    //                     color: ColorSelect
                                    //                         .textField)),
                                    //             width: 190,
                                    //             height: 35,
                                    //             child: Row(
                                    //               children: [
                                    //                 CountryCodePicker(
                                    //                   flagWidth: 20,
                                    //                   showFlag: false,
                                    //                   onChanged: print,
                                    //                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    //                   initialSelection: 'sa',
                                    //                   favorite: const [
                                    //                     '+39',
                                    //                     'FR'
                                    //                   ],

                                    //                   showFlagDialog: false,

                                    //                   //Get the country information relevant to the initial selection
                                    //                 ),
                                    //                 Flexible(
                                    //                   child: Container(
                                    //                     width: 230,
                                    //                     height: 35,
                                    //                     alignment: Alignment
                                    //                         .centerLeft,
                                    //                     child: Padding(
                                    //                       padding:
                                    //                           const EdgeInsets
                                    //                                   .only(
                                    //                               left: 0,
                                    //                               bottom: 10),
                                    //                       child: TextFormField(
                                    //                         controller: _mobile,
                                    //                         keyboardType:
                                    //                             TextInputType
                                    //                                 .number,
                                    //                         validator:
                                    //                             numberValidator,
                                    //                         inputFormatters: <
                                    //                             TextInputFormatter>[
                                    //                           FilteringTextInputFormatter
                                    //                               .digitsOnly
                                    //                         ],
                                    //                         decoration: InputDecoration(
                                    //                             hintText: S
                                    //                                 .of(context)
                                    //                                 .MobLabel,
                                    //                             hintStyle:
                                    //                                 TextController
                                    //                                     .labelText,
                                    //                             border:
                                    //                                 InputBorder
                                    //                                     .none),
                                    //                       ),
                                    //                     ),
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),

                                    //       /*Container(
                                    //     width: 270,
                                    //     height: 35,
                                    //     alignment: Alignment.centerLeft,
                                    //     decoration: BoxDecoration(
                                    //         color: Colors.white,
                                    //         border: Border.all(
                                    //             color: ColorSelect.textField)),
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.only(
                                    //           left: 15, bottom: 10),
                                    //       child: TextFormField(
                                    //         keyboardType: TextInputType.number,
                                    //         controller: _residencePhone,
                                    //         validator: (value) {
                                    //           if (value!.isEmpty) {
                                    //             return;
                                    //           }
                                    //         },
                                    //         decoration: InputDecoration(
                                    //             hintText: S.of(context).MobLabel,
                                    //             hintStyle:
                                    //                 TextController.labelText,
                                    //             border: InputBorder.none),
                                    //       ),
                                    //     ),
                                    //   ),*/
                                    //     ],
                                    //   ),
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).EMail + " *",
                                            style: TextController.BodyText,
                                          ),
                                          SizedBox(
                                            width: 80,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  // width: MediaQuery.of(context).size.width *
                                                  //     0.2,
                                                  height: 35,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
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
                                                    controller: _email,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        setState(() {
                                                          email1er = true;
                                                        });
                                                        return "";
                                                      } else if (!RegExp(
                                                              "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                          .hasMatch(value)) {
                                                        setState(() {
                                                          email1er = true;
                                                        });
                                                        return "";
                                                      } else {
                                                        setState(() {
                                                          email1er = false;
                                                        });
                                                      }
                                                      return null;
                                                    },
                                                    style:
                                                        TextController.BodyText,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                          height: 0.0),
                                                    ),
                                                  ),
                                                ),
                                                if (email1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: ((RegExp(
                                                                "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                            .hasMatch(
                                                                _email.text)))
                                                        ? Text(
                                                            "Invalid Email",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          )
                                                        : Text(
                                                            "This field is required.",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Text(
                                            S.of(context).Fax,
                                            style: TextController.BodyText,
                                          ),
                                          SizedBox(
                                            width: 110,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField),
                                                  ),
                                                  child: IntlPhoneField(
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
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
                                                        AutovalidateMode
                                                            .disabled,
                                                    showDropdownIcon: false,
                                                    pickerDialogStyle:
                                                        PickerDialogStyle(
                                                      width: 400,
                                                    ),
                                                    showCountryFlag: false,
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller: _fax,
                                                    dropdownTextStyle:
                                                        TextController.BodyText,
                                                    style:
                                                        TextController.BodyText,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      counterText: "",
                                                      hintText: S
                                                          .of(context)
                                                          .ResPhLabel,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                        fontFamily: 'Gotham',
                                                        fontSize: 7.0,
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.01,
                                                      ),
                                                    ),
                                                    onCountryChanged:
                                                        (country) {
                                                      print(
                                                          'Country changed to: ' +
                                                              country.name);
                                                    },
                                                  ),
                                                ),
                                                if (fax1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              S.of(context).BuildingNo + " *",
                                              style: TextController.BodyText,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 270,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  height: 35,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  child: TextFormField(
                                                    style:
                                                        TextController.BodyText,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        setState(() {
                                                          building1er = true;
                                                        });
                                                        return "";
                                                      } else {
                                                        setState(() {
                                                          building1er = false;
                                                        });
                                                      }
                                                      return null;
                                                    },
                                                    inputFormatters: <
                                                        TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly
                                                    ],
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    controller: _buildingNum,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none,
                                                      errorStyle: TextStyle(
                                                          height: 0.0),
                                                    ),
                                                  ),
                                                ),
                                                if (building1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required.",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              width: 75,
                                              child: Text(
                                                S.of(context).SecondaryNumber,
                                                style: TextController.BodyText,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 55,
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField)),
                                                  width: 270,
                                                  height: 35,
                                                  child: Row(
                                                    children: [
                                                      // CountryCodePicker(
                                                      //   flagWidth: 20,
                                                      //   showFlag: false,
                                                      //   onChanged: (value) {
                                                      //     setState(() {
                                                      //       print(
                                                      //           "------------=-=-=-=-=-=");
                                                      //       secondarycountrycode =
                                                      //           value.toString();
                                                      //     });
                                                      //   },
                                                      //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                      //   initialSelection: 'sa',
                                                      //   favorite: const [
                                                      //     '+39',
                                                      //     'FR'
                                                      //   ],

                                                      //   showFlagDialog: false,

                                                      //   //Get the country information relevant to the initial selection
                                                      // ),
                                                      Flexible(
                                                        child: Container(
                                                          width: 270,
                                                          height: 35,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                          ),
                                                          child: TextFormField(
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            controller:
                                                                _secondaryNum,
                                                            inputFormatters: <
                                                                TextInputFormatter>[
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly
                                                            ],
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                setState(() {
                                                                  secondary1er =
                                                                      true;
                                                                });
                                                                return "";
                                                              } else {
                                                                setState(() {
                                                                  secondary1er =
                                                                      false;
                                                                });
                                                              }
                                                              return null;
                                                            },
                                                            style:
                                                                TextController
                                                                    .BodyText,
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              hintText: S
                                                                  .of(context)
                                                                  .TypeHere,
                                                              hintStyle:
                                                                  TextController
                                                                      .labelText,
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              errorStyle:
                                                                  TextStyle(
                                                                      height:
                                                                          0.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (secondary1er)
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      "This field is required.",
                                                      style: TextController
                                                          .errorText,
                                                    ),
                                                  )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  S.of(context).current2,
                                  style: TextController.SubHeadingText,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text("Yes"),
                                Radio(
                                  value: "Yes",
                                  groupValue: selectedValue,
                                  onChanged: (Value) {
                                    setState(() {
                                      isYes = false;
                                      statementError1 = false;
                                      selectedValue = Value!; //<-- change this
                                    });
                                  },
                                ),
                                Text("No"),
                                Radio(
                                  value: "No",
                                  groupValue: selectedValue,
                                  onChanged: (Value) {
                                    setState(() {
                                      isYes = true;
                                      statementError1 = false;
                                      selectedValue = Value!; //<-- change this
                                    });
                                  },
                                ),
                              ],
                            ),
                            if (statementError1)
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Select any option",
                                  style: TextController.errorText,
                                ),
                              )
                          ],
                        ),

                        // -------------------=========-------------------------------------
                        if (isYes)
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "We wish to receive a statement via: *",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        S.of(context).EMail,
                                        style: TextController.BodyText,
                                      ),
                                      Radio<String>(
                                        value: "EMail",
                                        groupValue: statement2,
                                        onChanged: (value) {
                                          setState(() {
                                            statement2Error = false;
                                            statement2 =
                                                value!; //<-- change this
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        S.of(context).Mail,
                                        style: TextController.BodyText,
                                      ),
                                      Radio<String>(
                                        value: "Mail",
                                        groupValue: statement2,
                                        onChanged: (value) {
                                          setState(() {
                                            statement2Error = false;
                                            statement2 =
                                                value!; //<-- change this
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        "We do not wish to receive a statement",
                                        style: TextController.BodyText,
                                      ),
                                      Radio<String>(
                                        value:
                                            "We do not wish to receive statement",
                                        groupValue: statement2,
                                        onChanged: (value) {
                                          setState(() {
                                            statement2Error = false;
                                            statement2 =
                                                value!; //<-- change this
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  if (statement2Error)
                                    Text(
                                      "Select any option",
                                      style: TextController.errorText,
                                    )
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        S.of(context).Country + " *",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        S.of(context).State + " *",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        S.of(context).City + " *",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        S.of(context).StreetName + " *",
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        S.of(context).District + " *",
                                        style: TextController.BodyText,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 270,
                                          child: FormField<String>(
                                            builder:
                                                (FormFieldState<String> field) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: double.infinity,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(
                                                              onTap: () {},
                                                              controller:
                                                                  countryValuenew2,
                                                              style:
                                                                  TextController
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
                                                                      .Country)),
                                                          suggestionsCallback:
                                                              (pattern) {
                                                            print("error");
                                                            return GlobalPermission
                                                                .countries
                                                                .where((item) => item
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        pattern
                                                                            .toLowerCase()))
                                                                .toList();
                                                          },
                                                          itemBuilder: (context,
                                                              suggestion) {
                                                            return ListTile(
                                                              title: Text(
                                                                suggestion,
                                                                style:
                                                                    TextController
                                                                        .BodyText,
                                                              ),
                                                            );
                                                          },
                                                          onSuggestionSelected:
                                                              (suggestion) {
                                                            // Update the selected item when a suggestion is selected.
                                                            countryValuenew2
                                                                    .text =
                                                                suggestion;
                                                            print(
                                                                "selectetd countryy uis ${countryValuenew2.text}");
                                                            setState(() {
                                                              stateValuenew2
                                                                  .text = "";
                                                              cityValuenew2
                                                                  .text = "";
                                                              isstate2 = false;
                                                              iscity2 = false;

                                                              if (countryValuenew2
                                                                      .text ==
                                                                  "") {
                                                                print(
                                                                    "state false");
                                                                isstate2 =
                                                                    false;
                                                              } else {
                                                                print(
                                                                    "state ture");
                                                                isstate2 = true;
                                                              }
                                                            });
                                                            setState(() {
                                                              _selectedItem =
                                                                  suggestion;
                                                              countryValuenew2
                                                                      .text =
                                                                  suggestion;
                                                              print(
                                                                  "fdgfdgdfg-");
                                                            });

                                                            GlobalPermission
                                                                .getState(
                                                                    countryValuenew2
                                                                        .text);
                                                          },
                                                        ),
                                                      ),
                                                      if (showCountryError1)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            'Select Country',
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: double.infinity,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(
                                                              enabled: isstate2,
                                                              onTap: () {},
                                                              controller:
                                                                  stateValuenew2,
                                                              style:
                                                                  TextController
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
                                                                      .State)),
                                                          suggestionsCallback:
                                                              (pattern) {
                                                            // Return a filtered list of suggestions based on the search pattern.
                                                            return GlobalPermission
                                                                .states
                                                                .where((item) => item
                                                                    .toLowerCase()
                                                                    .contains(
                                                                        pattern
                                                                            .toLowerCase()))
                                                                .toList();
                                                          },
                                                          itemBuilder: (context,
                                                              suggestion) {
                                                            return ListTile(
                                                              title: Text(
                                                                suggestion,
                                                                style:
                                                                    TextController
                                                                        .BodyText,
                                                              ),
                                                            );
                                                          },
                                                          onSuggestionSelected:
                                                              (suggestion) {
                                                            // Update the selected item when a suggestion is selected.
                                                            stateValuenew2
                                                                    .text =
                                                                suggestion;
                                                            cityValuenew2.text =
                                                                "";
                                                            print(
                                                                "Select ted satted is ${stateValuenew2.text}");
                                                            setState(() {
                                                              if (stateValuenew2
                                                                      .text ==
                                                                  "") {
                                                                iscity2 = false;
                                                              } else {
                                                                print(
                                                                    "city ture");
                                                                iscity2 = true;
                                                              }
                                                            });
                                                            setState(() {
                                                              _selectedItem =
                                                                  suggestion;
                                                              stateValuenew2
                                                                      .text =
                                                                  suggestion;
                                                            });
                                                            GlobalPermission.getCity(
                                                                countryValuenew2
                                                                    .text,
                                                                stateValuenew2
                                                                    .text);
                                                          },
                                                        ),
                                                      ),
                                                      if (showStateError1)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            'Select State',
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: double.infinity,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TypeAheadField(
                                                            textFieldConfiguration:
                                                                TextFieldConfiguration(
                                                                    enabled:
                                                                        iscity2,
                                                                    onTap: () {
                                                                      // setState(
                                                                      //     () async {

                                                                      // });
                                                                    },
                                                                    controller:
                                                                        cityValuenew2,
                                                                    style: TextController
                                                                        .BodyText,
                                                                    decoration: InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        enabledBorder:
                                                                            InputBorder
                                                                                .none,
                                                                        hintStyle:
                                                                            TextController
                                                                                .labelText,
                                                                        hintText: S
                                                                            .of(
                                                                                context)
                                                                            .City)),
                                                            suggestionsCallback:
                                                                (pattern) {
                                                              // Return a filtered list of suggestions based on the search pattern.
                                                              return GlobalPermission
                                                                  .cities
                                                                  .where((item) => item
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          pattern
                                                                              .toLowerCase()))
                                                                  .toList();
                                                            },
                                                            itemBuilder:
                                                                (context,
                                                                    suggestion) {
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
                                                              setState(
                                                                () {
                                                                  _selectedItem =
                                                                      suggestion;
                                                                  cityValuenew2
                                                                          .text =
                                                                      suggestion;
                                                                },
                                                              );
                                                            }),
                                                      ),
                                                      if (showCityError1)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            'Select City',
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        ),
                                                    ],
                                                  ),

                                                  // Show state error below state dropdown

                                                  // Show city error below city dropdown
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 270,
                                              height: 35,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                controller: _streetName2,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      street2er = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      street2er = false;
                                                    });
                                                  }
                                                  return null;
                                                },
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
                                            if (street2er)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 270,
                                              height: 35,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .textField)),
                                              child: TextFormField(
                                                controller: district2,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      district2er = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      district2er = false;
                                                    });
                                                  }
                                                  return null;
                                                },
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
                                            if (district2er)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required.",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).PO + " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                Container(
                                                  width: 90,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        height: 35,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          controller: _po2,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              setState(() {
                                                                po2er = true;
                                                              });
                                                              return "";
                                                            } else {
                                                              setState(() {
                                                                po2er = false;
                                                              });
                                                            }
                                                            return null;
                                                          },
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .TypeHere,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                                    height:
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                      if (po2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required.",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Landline/Phone\nNo. *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField),
                                                        ),
                                                        child: IntlPhoneField(
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          disableLengthCheck:
                                                              true,
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
                                                              AutovalidateMode
                                                                  .disabled,
                                                          showDropdownIcon:
                                                              false,
                                                          pickerDialogStyle:
                                                              PickerDialogStyle(
                                                            width: 400,
                                                          ),
                                                          showCountryFlag:
                                                              false,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          controller:
                                                              _residencePhone2,
                                                          dropdownTextStyle:
                                                              TextController
                                                                  .BodyText,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            counterText: "",
                                                            hintText: S
                                                                .of(context)
                                                                .ResPhLabel,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Gotham',
                                                              fontSize: 7.0,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.01,
                                                            ),
                                                          ),
                                                          onCountryChanged:
                                                              (country) {
                                                            print(
                                                                'Country changed to: ' +
                                                                    country
                                                                        .name);
                                                          },
                                                        ),
                                                      ),
                                                      if (landline2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).Mobile + " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                SizedBox(
                                                  width: 95,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField),
                                                        ),
                                                        child: IntlPhoneField(
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          disableLengthCheck:
                                                              true,
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
                                                              AutovalidateMode
                                                                  .disabled,
                                                          showDropdownIcon:
                                                              false,
                                                          pickerDialogStyle:
                                                              PickerDialogStyle(
                                                            width: 400,
                                                          ),
                                                          showCountryFlag:
                                                              false,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          controller: _mobile2,
                                                          dropdownTextStyle:
                                                              TextController
                                                                  .BodyText,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            counterText: "",
                                                            hintText: S
                                                                .of(context)
                                                                .ResPhLabel,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Gotham',
                                                              fontSize: 7.0,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.01,
                                                            ),
                                                          ),
                                                          onCountryChanged:
                                                              (country) {
                                                            print(
                                                                'Country changed to: ' +
                                                                    country
                                                                        .name);
                                                          },
                                                        ),
                                                      ),
                                                      if (mobile2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).ZipCode + " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        height: 35,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField),
                                                        ),
                                                        child: TextFormField(
                                                          controller: _zipCode2,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          style: TextController
                                                              .BodyText,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              setState(() {
                                                                zip2er = true;
                                                              });
                                                              return "";
                                                            } else {
                                                              setState(() {
                                                                zip2er = false;
                                                              });
                                                            }
                                                            return null;
                                                          },
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly,
                                                          ],
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .TypeHere,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                                    height:
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                      if (zip2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: (_zipCode2.text
                                                                          .length <
                                                                      5 &&
                                                                  _zipCode2.text
                                                                      .isNotEmpty &&
                                                                  _zipCode2
                                                                          .length >
                                                                      9)
                                                              ? Text(
                                                                  "Invalid Zip Code",
                                                                  style: TextController
                                                                      .errorText,
                                                                )
                                                              : Text(
                                                                  "This field is required.",
                                                                  style: TextController
                                                                      .errorText,
                                                                ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 20),
                                          //   child: Row(
                                          //     // mainAxisAlignment:
                                          //     //     MainAxisAlignment.spaceBetween,
                                          //     children: [
                                          //       Align(
                                          //         alignment: Alignment.topLeft,
                                          //         child: Text(
                                          //           S.of(context).Mobile,
                                          //           style: TextController.BodyText,
                                          //         ),
                                          //       ),
                                          //       SizedBox(
                                          //         width: 10,
                                          //       ),
                                          //       Flexible(
                                          //         child: Padding(
                                          //           padding: const EdgeInsets.only(),
                                          //           child: Container(
                                          //             decoration: BoxDecoration(
                                          //                 color: Colors.white,
                                          //                 border: Border.all(
                                          //                     color: ColorSelect
                                          //                         .textField)),
                                          //             width: 190,
                                          //             height: 35,
                                          //             child: Row(
                                          //               children: [
                                          //                 CountryCodePicker(
                                          //                   flagWidth: 20,
                                          //                   showFlag: false,
                                          //                   onChanged: print,
                                          //                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                          //                   initialSelection: 'sa',
                                          //                   favorite: const [
                                          //                     '+39',
                                          //                     'FR'
                                          //                   ],

                                          //                   showFlagDialog: false,

                                          //                   //Get the country information relevant to the initial selection
                                          //                 ),
                                          //                 Flexible(
                                          //                   child: Container(
                                          //                     width: 230,
                                          //                     height: 35,
                                          //                     alignment: Alignment
                                          //                         .centerLeft,
                                          //                     child: Padding(
                                          //                       padding:
                                          //                           const EdgeInsets
                                          //                                   .only(
                                          //                               left: 0,
                                          //                               bottom: 10),
                                          //                       child: TextFormField(
                                          //                         controller: _mobile,
                                          //                         keyboardType:
                                          //                             TextInputType
                                          //                                 .number,
                                          //                         validator:
                                          //                             numberValidator,
                                          //                         inputFormatters: <
                                          //                             TextInputFormatter>[
                                          //                           FilteringTextInputFormatter
                                          //                               .digitsOnly
                                          //                         ],
                                          //                         decoration: InputDecoration(
                                          //                             hintText: S
                                          //                                 .of(context)
                                          //                                 .MobLabel,
                                          //                             hintStyle:
                                          //                                 TextController
                                          //                                     .labelText,
                                          //                             border:
                                          //                                 InputBorder
                                          //                                     .none),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ],
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),

                                          //       /*Container(
                                          //     width: 270,
                                          //     height: 35,
                                          //     alignment: Alignment.centerLeft,
                                          //     decoration: BoxDecoration(
                                          //         color: Colors.white,
                                          //         border: Border.all(
                                          //             color: ColorSelect.textField)),
                                          //     child: Padding(
                                          //       padding: const EdgeInsets.only(
                                          //           left: 15, bottom: 10),
                                          //       child: TextFormField(
                                          //         keyboardType: TextInputType.number,
                                          //         controller: _residencePhone,
                                          //         validator: (value) {
                                          //           if (value!.isEmpty) {
                                          //             return;
                                          //           }
                                          //         },
                                          //         decoration: InputDecoration(
                                          //             hintText: S.of(context).MobLabel,
                                          //             hintStyle:
                                          //                 TextController.labelText,
                                          //             border: InputBorder.none),
                                          //       ),
                                          //     ),
                                          //   ),*/
                                          //     ],
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).EMail + " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                SizedBox(
                                                  width: 80,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        // width: MediaQuery.of(context).size.width *
                                                        //     0.2,
                                                        height: 35,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          controller: _email2,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              setState(() {
                                                                email2er = true;
                                                              });
                                                              return "";
                                                            } else {
                                                              setState(() {
                                                                email2er =
                                                                    false;
                                                              });
                                                            }
                                                            return null;
                                                          },
                                                          style: TextController
                                                              .BodyText,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .TypeHere,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                                    height:
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                      if (email2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: ((RegExp(
                                                                      "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                                  .hasMatch(_email
                                                                      .text)))
                                                              ? Text(
                                                                  "Invalid Email",
                                                                  style: TextController
                                                                      .errorText,
                                                                )
                                                              : Text(
                                                                  "This field is required.",
                                                                  style: TextController
                                                                      .errorText,
                                                                ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  S.of(context).Fax,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                SizedBox(
                                                  width: 110,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField),
                                                        ),
                                                        child: IntlPhoneField(
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          disableLengthCheck:
                                                              true,
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
                                                              AutovalidateMode
                                                                  .disabled,
                                                          showDropdownIcon:
                                                              false,
                                                          pickerDialogStyle:
                                                              PickerDialogStyle(
                                                            width: 400,
                                                          ),
                                                          showCountryFlag:
                                                              false,
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          controller: _fax2,
                                                          dropdownTextStyle:
                                                              TextController
                                                                  .BodyText,
                                                          style: TextController
                                                              .BodyText,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            counterText: "",
                                                            hintText: S
                                                                .of(context)
                                                                .ResPhLabel,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Gotham',
                                                              fontSize: 7.0,
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              height: 0.01,
                                                            ),
                                                          ),
                                                          onCountryChanged:
                                                              (country) {
                                                            print(
                                                                'Country changed to: ' +
                                                                    country
                                                                        .name);
                                                          },
                                                        ),
                                                      ),
                                                      if (fax2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    S.of(context).BuildingNo +
                                                        " *",
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: 270,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          style: TextController
                                                              .BodyText,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              setState(() {
                                                                building2er =
                                                                    true;
                                                              });
                                                              return "";
                                                            } else {
                                                              setState(() {
                                                                building2er =
                                                                    false;
                                                              });
                                                            }
                                                            return null;
                                                          },
                                                          inputFormatters: <
                                                              TextInputFormatter>[
                                                            FilteringTextInputFormatter
                                                                .digitsOnly
                                                          ],
                                                          textAlignVertical:
                                                              TextAlignVertical
                                                                  .center,
                                                          controller:
                                                              _buildingNum2,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .TypeHere,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            errorStyle:
                                                                TextStyle(
                                                                    height:
                                                                        0.0),
                                                          ),
                                                        ),
                                                      ),
                                                      if (building2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required.",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Row(
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Container(
                                                    width: 75,
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .SecondaryNumber,
                                                      style: TextController
                                                          .BodyText,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 55,
                                                ),
                                                Flexible(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        width: 270,
                                                        height: 35,
                                                        child: Row(
                                                          children: [
                                                            // CountryCodePicker(
                                                            //   flagWidth: 20,
                                                            //   showFlag: false,
                                                            //   onChanged: (value) {
                                                            //     setState(() {
                                                            //       print(
                                                            //           "------------=-=-=-=-=-=");
                                                            //       secondary2countrycode =
                                                            //           value
                                                            //               .toString();
                                                            //     });
                                                            //   },
                                                            //   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                            //   initialSelection:
                                                            //       'sa',
                                                            //   favorite: const [
                                                            //     '+39',
                                                            //     'FR'
                                                            //   ],

                                                            //   showFlagDialog: false,

                                                            //   //Get the country information relevant to the initial selection
                                                            // ),
                                                            Flexible(
                                                              child: Container(
                                                                width: 270,
                                                                // width: MediaQuery.of(context).size.width *
                                                                //     0.2,
                                                                height: 35,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child:
                                                                    TextFormField(
                                                                  textAlignVertical:
                                                                      TextAlignVertical
                                                                          .center,
                                                                  maxLength: 12,
                                                                  inputFormatters: <
                                                                      TextInputFormatter>[
                                                                    FilteringTextInputFormatter
                                                                        .digitsOnly
                                                                  ],
                                                                  controller:
                                                                      _secondaryNum2,
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      setState(
                                                                          () {
                                                                        secondary2er =
                                                                            true;
                                                                      });
                                                                      return "";
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        secondary2er =
                                                                            false;
                                                                      });
                                                                    }
                                                                    return null;
                                                                  },
                                                                  style: TextController
                                                                      .BodyText,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    isDense:
                                                                        true,
                                                                    hintText: S
                                                                        .of(context)
                                                                        .TypeHere,
                                                                    hintStyle:
                                                                        TextController
                                                                            .labelText,
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    counterText:
                                                                        "",
                                                                    errorStyle:
                                                                        TextStyle(
                                                                            height:
                                                                                0.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      if (secondary2er)
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "This field is required.",
                                                            style:
                                                                TextController
                                                                    .errorText,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
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
                                    tabController?.animateTo(1);
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
                                  onPressed: () async {
                                    print(_formKey.currentState);
                                    print("POstaaaal");
                                    // print(_formKey.currentState!.validate());
                                    if (_formKey.currentState != null) {
                                      setState(() {
                                        statementError = statement == "";
                                        statementError1 = selectedValue == "";
                                        showCountryError =
                                            countryValuenew.text == "";
                                        showStateError =
                                            stateValuenew.text == "";
                                        showCityError = cityValuenew.text == "";
                                        landline1er =
                                            _residencePhone.text == "";
                                        mobile1er = _mobile.text == "";

                                        if (selectedValue == "No") {
                                          statement2Error = statement2 == "";
                                          showCountryError1 =
                                              countryValuenew2.text == "";
                                          showStateError1 =
                                              stateValuenew2.text == "";
                                          showCityError1 =
                                              cityValuenew2.text == "";
                                          landline2er =
                                              _residencePhone2.text == "";
                                          mobile2er = _mobile2.text == "";
                                        }
                                      });
                                      print("RUnnn");
                                      if ((_formKey.currentState!.validate()) &&
                                          (!statementError &&
                                              !mobile1er &&
                                              !landline1er &&
                                              !statementError1 &&
                                              !showCountryError &&
                                              !showStateError &&
                                              !showCityError &&
                                              !statement2Error)) {
                                        _formKey.currentState?.save();
                                        if (GlobalPOA.poadraftprogress[
                                                "PostalAddressPOA"] ==
                                            true) {
                                          putdata(GlobalPOA.poalclientid);
                                        } else {
                                          if (GlobalPOA.poalclientid != 0) {
                                            senddata();
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please fill personal info first",
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
            )),
      ),
    );
  }
}
