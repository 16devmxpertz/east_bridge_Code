// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class DataTransfer {
  static String data = '';
}

enum SingingCharacter { yes, no }

class Registered_Address extends StatefulWidget {
  Registered_Address({@required controller}) {
    tabController = controller;
  }

  @override
  State<Registered_Address> createState() => Registered_AddressState();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;
String? sameAddress;
String? currentCountryValue;
String? currentCityValue;
String? currentStateValue;
String? currentCountryValue2;
String? currentCityValue2;
String? currentStateValue2;

// Define a variable to track if all selections are made
bool selectionsComplete = true;

bool isYes = false;

TextEditingController BuldingNumber = new TextEditingController();
TextEditingController OfficailPhoneNumber = new TextEditingController();
TextEditingController StreetName = new TextEditingController();
TextEditingController SecondaryPhoneNumber = new TextEditingController();
TextEditingController ZipCode = new TextEditingController();
TextEditingController Fax = new TextEditingController();
TextEditingController POBox = new TextEditingController();
TextEditingController District = new TextEditingController();
TextEditingController BuldingNumber2 = new TextEditingController();
TextEditingController OfficailPhoneNumber2 = new TextEditingController();
TextEditingController StreetName2 = new TextEditingController();
TextEditingController SecondaryPhoneNumber2 = new TextEditingController();
TextEditingController ZipCode2 = new TextEditingController();
TextEditingController Fax2 = new TextEditingController();
TextEditingController POBox2 = new TextEditingController();
TextEditingController District2 = new TextEditingController();

class Registered_AddressState extends State<Registered_Address> {
  final _formKey = GlobalKey<FormState>();
  bool BuldingNumberError = false;
  bool OfficailPhoneNumberError = false;
  bool StreetNameError = false;
  bool SecondaryPhoneNumberError = false;
  bool ZipCodeError = false;
  bool DistrictError = false;
  bool POBoxError = false;

  bool BuldingNumberError2 = false;
  bool OfficailPhoneNumberError2 = false;
  bool StreetNameError2 = false;
  bool SecondaryPhoneNumberError2 = false;
  bool ZipCodeError2 = false;
  bool DistrictError2 = false;
  bool POBoxError2 = false;

  bool showCountryError = false;
  bool showStateError = false;

  bool showCityError = false;
  bool showCountryError1 = false;
  bool showStateError1 = false;
  bool sameAddressError = false;

  bool showCityError1 = false;

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

  List<dynamic> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url =
        'https://eastbridge.online/apicore/api/RegisteredAddressCorporate/RegisteredAddressCorporate/'; // Replace with your API endpoint

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Request successful, parse the response body
        setState(() {
          data = jsonDecode(response.body);
        });
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Request failed, handle the exception
      print('Exception occurred while fetching data: $e');
    }
  }

  // Function to check if all selections are made
  // void checkSelectionsComplete() {
  //   if (currentCountryValue != null &&
  //       currentStateValue != null &&
  //       currentCityValue != null) {
  //     setState(() {
  //       selectionsComplete = true;
  //     });
  //   } else {
  //     setState(() {
  //       selectionsComplete = false;
  //     });
  //   }
  // }

  void senddata() async {
    // int commercial = int.parse(CommercialRegistraction.text);
    //int percentageOwnership = int.parse(percentage.text);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": Registered_Address.id.value,
      "buldingNumber": BuldingNumber.text,
      "officialPhoneNumber": OfficailPhoneNumber.text,
      "country": currentCountryValue,
      "state": currentStateValue,
      "city": currentCityValue,
      "district": District.text,
      "streetName": StreetName.text,
      "fax": Fax.text,
      "poBox": POBox.text,
      "zipCode": ZipCode.text,
      "secondaryPhoneNumber": SecondaryPhoneNumber.text,
      "currentCountry": "currentCountryValue2",
      "currentOfficialPhoneNumber": OfficailPhoneNumber2.text,
      "currentBuldingNumber": BuldingNumber2.text,
      "currentState": "currentStateValue2",
      "currentCity": "currentCityValue2",
      "currentDistrict": District2.text,
      "currentStreetName": StreetName2.text,
      "currentFax": Fax2.text,
      "currentPOBox": POBox2.text,
      "currentZipCode": ZipCode2.text,
      "currentSecondaryPhoneNumber": SecondaryPhoneNumber2.text
    };
    final response = await http.post(
        Uri.parse(
            'https://eastbridge.online/apicore/api/RegisteredAddressCorporate/RegisteredAddressCorporate'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      print("Registered Address Working");
      tabController!.animateTo(2);
      // Request successful, handle the response
      // var responseData = jsonDecode(response.body);
      Fatqa.buildingnumber.value = BuldingNumber.text;
      Fatqa.district.value = District.text;
      Fatqa.streetname.value = StreetName.text;
      Fatqa.POboxa.value = POBox.text;
      Fatqa.zipcode.value = ZipCode.text;

      ContactInfoo.bn.value = BuldingNumber.text;
      ContactInfoo.street.value = StreetName.text;

      ContactInfoo.city.value = currentCityValue!;
      ContactInfoo.state.value = currentStateValue!;

      ContactInfoo.country.value = currentCountryValue!;

      // tabController!.animateTo(2);

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

  @override
  Widget build(BuildContext context) {
    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    @override
    void initState() {
      super.initState();
    }

    //Registered_AddressState

    return Material(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 40),
                  child: Row(
                    children: [
                      Text(
                        S.of(context).RegisteredAddress,
                        style: TextController.SubHeadingText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),

                //-------------------------------------------------

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            S.of(context).BuildingNo + " *",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
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
                                                controller: BuldingNumber,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    counterText: '',
                                                    hintText: S
                                                        .of(context)
                                                        .Building123,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle:
                                                        TextStyle(height: 0.0)),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      BuldingNumberError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      BuldingNumberError =
                                                          false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                              ),
                                            ),
                                            if (BuldingNumberError)
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
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Official Phone Number*",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField),
                                              ),
                                              width: 270,
                                              height: 35,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      width: 70,
                                                      child: CountryCodePicker(
                                                        textStyle:
                                                            TextController
                                                                .BodyText,
                                                        alignLeft: true,
                                                        showFlag: false,
                                                        onChanged: print,
                                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                        initialSelection: 'SA',
                                                        favorite: const [
                                                          'SA',
                                                          'IN'
                                                        ],

                                                        showFlagDialog: false,

                                                        //Get the country information relevant to the initial selection
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: TextFormField(
                                                        textAlignVertical:
                                                            TextAlignVertical
                                                                .center,
                                                        style: TextController
                                                            .BodyText,
                                                        controller:
                                                            OfficailPhoneNumber,
                                                        decoration: InputDecoration(
                                                            isDense: true,
                                                            hintText: S
                                                                .of(context)
                                                                .BusinessPhone,
                                                            hintStyle:
                                                                TextController
                                                                    .labelText,
                                                            border: InputBorder
                                                                .none,
                                                            counterText: '',
                                                            errorStyle:
                                                                TextStyle(
                                                                    height:
                                                                        0.0)),
                                                        // validator: (value) {
                                                        //   if (value!.isEmpty) {
                                                        //     setState(() {
                                                        //       OfficailPhoneNumberError =
                                                        //           true;
                                                        //     });
                                                        //   } else {
                                                        //     setState(() {
                                                        //       OfficailPhoneNumberError =
                                                        //           false;
                                                        //     });
                                                        //   }
                                                        // },
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            setState(() {
                                                              OfficailPhoneNumberError =
                                                                  true;
                                                            });
                                                            return "";
                                                          } else if (value
                                                                  .isNotEmpty &&
                                                              (value.length <
                                                                      4 ||
                                                                  value.length >
                                                                      12)) {
                                                            setState(() {
                                                              OfficailPhoneNumberError =
                                                                  true;
                                                            });
                                                            return "";
                                                          } else {
                                                            setState(() {
                                                              OfficailPhoneNumberError =
                                                                  false;
                                                            });
                                                          }
                                                          return null;
                                                        },
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  r'[0-9]')),
                                                        ],
                                                        maxLength: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (OfficailPhoneNumberError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: (OfficailPhoneNumber
                                                                .text.length <
                                                            4 &&
                                                        OfficailPhoneNumber
                                                            .text.isNotEmpty)
                                                    ? Text(
                                                        "Enter valid number",
                                                        style: TextController
                                                            .errorText,
                                                      )
                                                    : Text(
                                                        "This field is required",
                                                        style: TextController
                                                            .errorText,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            S.of(context).StreetName + " *",
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 270,
                                              height: 35,
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField),
                                              ),
                                              child: TextFormField(
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                style: TextController.BodyText,
                                                controller: StreetName,
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: S
                                                        .of(context)
                                                        .NameOfStreet,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle:
                                                        TextStyle(height: 0.0)),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      StreetNameError = true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      StreetNameError = false;
                                                    });
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            if (StreetNameError)
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
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            S.of(context).SecondaryNumber,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField),
                                              ),
                                              width: 270,
                                              height: 35,
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9]')),
                                                ],
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller:
                                                    SecondaryPhoneNumber,
                                                style: TextController.BodyText,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    setState(() {
                                                      SecondaryPhoneNumberError =
                                                          true;
                                                    });
                                                    return "";
                                                  } else {
                                                    setState(() {
                                                      SecondaryPhoneNumberError =
                                                          false;
                                                    });
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText: S
                                                        .of(context)
                                                        .Building123,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: '',
                                                    errorStyle:
                                                        TextStyle(height: 0.0)),
                                              ),
                                            ),
                                            if (SecondaryPhoneNumberError)
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
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              width: 30,
                            ),
                            Flexible(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      S.of(context).ZipCode + " *",
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
                                          width: 270,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp(r'[0-9]')),
                                            ],
                                            maxLength: 9,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: ZipCode,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              hintText: S.of(context).TypeHere,
                                              errorStyle:
                                                  TextStyle(height: 0.0),
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              counterText: "",
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  ZipCodeError = true;
                                                });
                                                return "";
                                              } else if (value.isNotEmpty &&
                                                  (value.length < 5 ||
                                                      value.length > 9)) {
                                                setState(() {
                                                  ZipCodeError = true;
                                                });
                                                return "";
                                              } else {
                                                setState(() {
                                                  ZipCodeError = false;
                                                });
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        if (ZipCodeError)
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: (ZipCode.text.length < 5 &&
                                                    ZipCode.text.isNotEmpty)
                                                ? Text(
                                                    "Invalid Zip Code",
                                                    style: TextController
                                                        .errorText,
                                                  )
                                                : Text(
                                                    "This field is required",
                                                    style: TextController
                                                        .errorText,
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
                                    child: Text(
                                      S.of(context).Fax,
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: 270,
                                      height: 35,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        controller: Fax,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]')),
                                        ],
                                        // validator: (value) {
                                        //   if (value!.isEmpty) {
                                        //     return 'This field is required.';
                                        //   }
                                        //   return null; // Return null if the input is valid
                                        // },
                                        style: TextController.BodyText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            errorStyle: TextStyle(height: 0.0),
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
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
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: Text(
                                S.of(context).PO + " *",
                                style: TextController.BodyText,
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 270,
                                    height: 35,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.textField)),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller: POBox,
                                      style: TextController.BodyText,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          errorStyle: TextStyle(height: 0.0),
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            POBoxError = true;
                                          });
                                          return "";
                                        } else {
                                          setState(() {
                                            POBoxError = false;
                                          });
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (POBoxError)
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
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    children: [
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                S.of(context).District + " *",
                                style: TextController.BodyText,
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
                                    width: 270,
                                    height: 35,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: ColorSelect.textField),
                                    ),
                                    child: TextFormField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: TextController.BodyText,
                                      controller: District,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          hintText: S.of(context).TypeHere,
                                          hintStyle: TextController.labelText,
                                          border: InputBorder.none,
                                          errorStyle:
                                             TextStyle(height:0.0)),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          setState(() {
                                            DistrictError = true;
                                          });
                                          return "";
                                        } else {
                                          setState(() {
                                            DistrictError = false;
                                          });
                                        }
                                          return null;
                                      },
                                    ),
                                  ),
                                  if (DistrictError)
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
                        child: Container(),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Container(),
                      ),
                    ],
                  ),
                ),

                //-------------------------------------------------
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         Container(
                //           padding: EdgeInsets.all(50),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 50, bottom: 40, left: 40, right: 40),
                //                     child: Text(
                //                       S.of(context).BuildingNo,
                //                       style: TextController.BodyText,
                //                     ),
                //                   ),
                //                   Container(
                //                     width: 270,
                //                     height: 35,
                //                     alignment: Alignment.centerLeft,
                //                     decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         border: Border.all(
                //                             color: ColorSelect.textField)),
                //                     child: Padding(
                //                       padding: const EdgeInsets.only(
                //                           left: 15, bottom: 10),
                //                       child: TextFormField(
                //                         controller: BuldingNumber,
                //                         decoration: InputDecoration(
                //                             hintText: S.of(context).Building123,
                //                             hintStyle: TextController.labelText,
                //                             border: InputBorder.none),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 50, bottom: 40, left: 40, right: 65),
                //                     child: Text(
                //                       S.of(context).StreetName,
                //                       style: TextController.BodyText,
                //                     ),
                //                   ),
                //                   Container(
                //                     width: 270,
                //                     height: 35,
                //                     alignment: Alignment.centerLeft,
                //                     decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         border: Border.all(
                //                             color: ColorSelect.textField)),
                //                     child: Padding(
                //                       padding: const EdgeInsets.only(
                //                           left: 15, bottom: 10),
                //                       child: TextFormField(
                //                         controller: StreetName,
                //                         decoration: InputDecoration(
                //                             hintText: S.of(context).NameOfStreet,
                //                             hintStyle: TextController.labelText,
                //                             border: InputBorder.none),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 50, bottom: 40, left: 40, right: 85),
                //                     child: Text(
                //                       S.of(context).ZipCode,
                //                       style: TextController.BodyText,
                //                     ),
                //                   ),
                //                   Container(
                //                     width: 270,
                //                     height: 45,
                //                     alignment: Alignment.centerLeft,
                //                     decoration: BoxDecoration(
                //                       color: Colors.white,
                //                     ),
                //                     child: SizedBox(
                //                       child: Pinput(
                //                         length: 5,
                //                         defaultPinTheme: PinTheme(
                //                             height: 50,
                //                             width: 40,
                //                             decoration: BoxDecoration(
                //                                 border: Border.all(
                //                                     color:
                //                                         ColorSelect.tabBorderColor),
                //                                 borderRadius:
                //                                     BorderRadius.circular(0.0),
                //                                 color: Colors.white)),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),

                //         Column(
                //           children: [
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(
                //                     top: 50,
                //                     bottom: 40,
                //                     left: 33,
                //                   ),
                //                   child: Text(
                //                     S.of(context).OfficialPhoneNumber,
                //                     style: TextController.BodyText,
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(left: 30),
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         border: Border.all(
                //                             color: ColorSelect.textField)),
                //                     width: 270,
                //                     height: 35,
                //                     child: Row(
                //                       children: [
                //                         CountryCodePicker(
                //                           onChanged: print,
                //                           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                //                           initialSelection: 'SA',
                //                           favorite: const ['SA', 'IN'],

                //                           showFlagDialog: false,

                //                           //Get the country information relevant to the initial selection
                //                         ),
                //                         Container(
                //                           width: 150,
                //                           height: 35,
                //                           alignment: Alignment.centerLeft,
                //                           child: Padding(
                //                             padding: const EdgeInsets.only(
                //                                 left: 15, bottom: 10),
                //                             child: TextFormField(
                //                               controller: OfficialPhoneNumber,
                //                               decoration: InputDecoration(
                //                                   hintText:
                //                                       S.of(context).BusinessPhone,
                //                                   hintStyle:
                //                                       TextController.labelText,
                //                                   border: InputBorder.none),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(
                //                       top: 50, bottom: 40, left: 30, right: 70),
                //                   child: Text(
                //                     S.of(context).SecondaryNumber,
                //                     style: TextController.BodyText,
                //                   ),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.only(),
                //                   child: Container(
                //                     decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         border: Border.all(
                //                             color: ColorSelect.textField)),
                //                     width: 270,
                //                     height: 35,
                //                     child: Row(
                //                       children: [
                //                         CountryCodePicker(
                //                           onChanged: print,
                //                           // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                //                           initialSelection: 'SA',
                //                           favorite: const ['SA', 'IN'],

                //                           showFlagDialog: false,

                //                           //Get the country information relevant to the initial selection
                //                         ),
                //                         Container(
                //                           width: 150,
                //                           height: 35,
                //                           alignment: Alignment.centerLeft,
                //                           child: Padding(
                //                             padding: const EdgeInsets.only(
                //                                 left: 15, bottom: 10),
                //                             child: TextFormField(
                //                               controller: secondaryPhoneNumber,
                //                               decoration: InputDecoration(
                //                                   hintText:
                //                                       S.of(context).BusinessPhone,
                //                                   hintStyle:
                //                                       TextController.labelText,
                //                                   border: InputBorder.none),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.only(
                //                       top: 50, bottom: 40, left: 40, right: 140),
                //                   child: Text(
                //                     S.of(context).Fax,
                //                     style: TextController.BodyText,
                //                   ),
                //                 ),
                //                 Container(
                //                   width: 270,
                //                   height: 35,
                //                   alignment: Alignment.centerLeft,
                //                   decoration: BoxDecoration(
                //                       color: Colors.white,
                //                       border:
                //                           Border.all(color: ColorSelect.textField)),
                //                   child: Padding(
                //                     padding:
                //                         const EdgeInsets.only(left: 15, bottom: 10),
                //                     child: TextFormField(
                //                       controller: Fax,
                //                       decoration: InputDecoration(
                //                           hintText: S.of(context).optional,
                //                           hintStyle: TextController.labelText,
                //                           border: InputBorder.none),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),

                //         Padding(
                //           padding: const EdgeInsets.all(1),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Row(
                //                 children: [
                //                   Padding(
                //                     padding:
                //                         const EdgeInsets.only(left: 40, right: 60),
                //                     child: Container(
                //                       height: 130,
                //                       child: Padding(
                //                         padding: const EdgeInsets.only(top: 20),
                //                         child: Column(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.spaceBetween,
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               S.of(context).Country,
                //                               style: TextController.BodyText,
                //                             ),
                //                             Text(
                //                               S.of(context).State,
                //                               style: TextController.BodyText,
                //                             ),
                //                             Text(
                //                               S.of(context).City,
                //                               style: TextController.BodyText,
                //                             ),
                //                           ],
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.only(top: 36),
                //                     child: Container(
                //                       width: 290,
                //                       height: 170,
                //                       alignment: Alignment.centerLeft,
                //                       child: Padding(
                //                         padding: const EdgeInsets.only(
                //                             left: 15, bottom: 10),
                //                         child: CSCPicker(
                //                           layout: Layout.vertical,
                //                           flagState: CountryFlag.DISABLE,
                //                           onCountryChanged: (value) {
                //                             setState(() {
                //                               countryValue = value;
                //                             });
                //                           },
                //                           onStateChanged: (value) {
                //                             setState(() {
                //                               stateValue = value;
                //                             });
                //                           },
                //                           onCityChanged: (value) {
                //                             setState(() {
                //                               cityValue = value;
                //                             });
                //                           },
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Row(
                //                 children: [
                //                   Padding(
                //                     padding: const EdgeInsets.only(
                //                         top: 40, bottom: 40, left: 40, right: 75),
                //                     child: Text(
                //                       S.of(context).PO,
                //                       style: TextController.BodyText,
                //                     ),
                //                   ),
                //                   Container(
                //                     width: 270,
                //                     height: 35,
                //                     alignment: Alignment.centerLeft,
                //                     decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         border: Border.all(
                //                             color: ColorSelect.textField)),
                //                     child: Padding(
                //                       padding: const EdgeInsets.only(
                //                           left: 15, bottom: 10),
                //                       child: TextFormField(
                //                         controller: POBox,
                //                         decoration: InputDecoration(
                //                             hintText:
                //                                 S.of(context).Enter5DigitsofZipCode,
                //                             hintStyle: TextController.labelText,
                //                             border: InputBorder.none),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ), //// this
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(
                //               bottom: 40, left: 90, right: 95),
                //           child: Text(
                //             S.of(context).District,
                //             style: TextController.BodyText,
                //           ),
                //         ),
                //         Container(
                //           width: 270,
                //           height: 35,
                //           alignment: Alignment.centerLeft,
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               border: Border.all(color: ColorSelect.textField)),
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 15, bottom: 10),
                //             child: TextFormField(
                //               controller: District,
                //               decoration: InputDecoration(
                //                   hintText: S.of(context).EnterDetails,
                //                   hintStyle: TextController.labelText,
                //                   border: InputBorder.none),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ],
                // ),

                //End of first Half
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            groupValue: sameAddress,
                            onChanged: (Value) {
                              setState(() {
                                isYes = false;
                                sameAddress = Value!; //<-- change this
                              });
                            },
                          ),
                          Text("No"),
                          Radio(
                            value: "No",
                            groupValue: sameAddress,
                            onChanged: (Value) {
                              setState(() {
                                isYes = true;
                                sameAddress = Value!; //<-- change this
                              });
                            },
                          ),
                        ],
                      ),
                      if (sameAddressError)
                        Text(
                          'Select any option',
                          style: TextController.errorText,
                        ),
                    ],
                  ),
                ),

                if (isYes)
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                child: Text(
                                                  S.of(context).BuildingNo +
                                                      " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 270,
                                                    height: 35,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .textField)),
                                                    child: TextFormField(
                                                      controller:
                                                          BuldingNumber2,
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      style: TextController
                                                          .BodyText,
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          counterText: '',
                                                          hintText: S
                                                              .of(context)
                                                              .Building123,
                                                          hintStyle:
                                                              TextController
                                                                  .labelText,
                                                          border:
                                                              InputBorder.none,
                                                          errorStyle:
                                                              TextController
                                                                  .inputErrorText),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          setState(() {
                                                            BuldingNumberError2 =
                                                                true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            BuldingNumberError2 =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                      ],
                                                    ),
                                                  ),
                                                  if (BuldingNumberError2)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "This field is required.",
                                                        style: TextController
                                                            .errorText,
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
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                child: Text(
                                                  S
                                                          .of(context)
                                                          .OfficialPhoneNumber +
                                                      " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField),
                                                    ),
                                                    width: 270,
                                                    height: 35,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Flexible(
                                                          child: Container(
                                                            width: 70,
                                                            child:
                                                                CountryCodePicker(
                                                              textStyle:
                                                                  TextController
                                                                      .BodyText,
                                                              alignLeft: true,
                                                              showFlag: false,
                                                              onChanged: print,
                                                              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                              initialSelection:
                                                                  'SA',
                                                              favorite: const [
                                                                'SA',
                                                                'IN'
                                                              ],

                                                              showFlagDialog:
                                                                  false,

                                                              //Get the country information relevant to the initial selection
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: 35,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child:
                                                                TextFormField(
                                                              textAlignVertical:
                                                                  TextAlignVertical
                                                                      .center,
                                                              style:
                                                                  TextController
                                                                      .BodyText,
                                                              controller:
                                                                  OfficailPhoneNumber2,
                                                              decoration: InputDecoration(
                                                                  isDense: true,
                                                                  hintText: S
                                                                      .of(
                                                                          context)
                                                                      .BusinessPhone,
                                                                  hintStyle:
                                                                      TextController
                                                                          .labelText,
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  counterText:
                                                                      '',
                                                                  errorStyle:
                                                                      TextController
                                                                          .inputErrorText),
                                                              // validator: (value) {
                                                              //   if (value!.isEmpty) {
                                                              //     setState(() {
                                                              //       OfficailPhoneNumberError =
                                                              //           true;
                                                              //     });
                                                              //   } else {
                                                              //     setState(() {
                                                              //       OfficailPhoneNumberError =
                                                              //           false;
                                                              //     });
                                                              //   }
                                                              // },
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  setState(() {
                                                                    OfficailPhoneNumberError2 =
                                                                        true;
                                                                  });
                                                                } else if (value
                                                                        .isNotEmpty &&
                                                                    (value.length <
                                                                            4 ||
                                                                        value.length >
                                                                            12)) {
                                                                  setState(() {
                                                                    OfficailPhoneNumberError2 =
                                                                        true;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    OfficailPhoneNumberError2 =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              inputFormatters: [
                                                                FilteringTextInputFormatter
                                                                    .allow(RegExp(
                                                                        r'[0-9]')),
                                                              ],
                                                              maxLength: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  if (OfficailPhoneNumberError2)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: (OfficailPhoneNumber2
                                                                      .text
                                                                      .length <
                                                                  4 &&
                                                              OfficailPhoneNumber2
                                                                  .text
                                                                  .isNotEmpty)
                                                          ? Text(
                                                              "Enter valid number",
                                                              style:
                                                                  TextController
                                                                      .errorText,
                                                            )
                                                          : Text(
                                                              "This field is required",
                                                              style:
                                                                  TextController
                                                                      .errorText,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                child: Text(
                                                  S.of(context).StreetName +
                                                      " *",
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 270,
                                                    height: 35,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField),
                                                    ),
                                                    child: TextFormField(
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      style: TextController
                                                          .BodyText,
                                                      controller: StreetName2,
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          hintText: S
                                                              .of(context)
                                                              .NameOfStreet,
                                                          hintStyle:
                                                              TextController
                                                                  .labelText,
                                                          border:
                                                              InputBorder.none,
                                                          errorStyle:
                                                              TextController
                                                                  .inputErrorText),
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          setState(() {
                                                            StreetNameError2 =
                                                                true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            StreetNameError2 =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  if (StreetNameError2)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "This field is required.",
                                                        style: TextController
                                                            .errorText,
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
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                child: Text(
                                                  S.of(context).SecondaryNumber,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .textField),
                                                    ),
                                                    width: 270,
                                                    height: 35,
                                                    child: TextFormField(
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                                r'[0-9]')),
                                                      ],
                                                      textAlignVertical:
                                                          TextAlignVertical
                                                              .center,
                                                      controller:
                                                          SecondaryPhoneNumber2,
                                                      style: TextController
                                                          .BodyText,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          setState(() {
                                                            SecondaryPhoneNumberError2 =
                                                                true;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            SecondaryPhoneNumberError2 =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                          isDense: true,
                                                          hintText: S
                                                              .of(context)
                                                              .Building123,
                                                          hintStyle:
                                                              TextController
                                                                  .labelText,
                                                          border:
                                                              InputBorder.none,
                                                          counterText: '',
                                                          errorStyle:
                                                              TextController
                                                                  .inputErrorText),
                                                    ),
                                                  ),
                                                  if (SecondaryPhoneNumberError2)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "This field is required.",
                                                        style: TextController
                                                            .errorText,
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
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 130,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  S.of(context).Country,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                Text(
                                                  S.of(context).State,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                                Text(
                                                  S.of(context).City,
                                                  style:
                                                      TextController.BodyText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Flexible(
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
                                                    flagState:
                                                        CountryFlag.DISABLE,
                                                    onCountryChanged: (value) {
                                                      setState(() {
                                                        currentCountryValue2 =
                                                            value;
                                                        showCountryError1 =
                                                            false;
                                                      });
                                                    },
                                                    onStateChanged: (value) {
                                                      setState(() {
                                                        currentStateValue2 =
                                                            value;
                                                        showStateError1 = false;
                                                      });
                                                    },
                                                    onCityChanged: (value) {
                                                      setState(() {
                                                        currentCityValue2 =
                                                            value;
                                                        showCityError1 = false;
                                                      });
                                                    },
                                                  ),
                                                  if (showCountryError1)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        'Select a country, state & city',
                                                        style: TextController
                                                            .errorText,
                                                      ),
                                                    ),
                                                  // Show state error below state dropdown
                                                  if (showStateError1)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        'Select a state',
                                                        style: TextController
                                                            .errorText,
                                                      ),
                                                    ),
                                                  // Show city error below city dropdown
                                                  if (showCityError1)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        'Select a city',
                                                        style: TextController
                                                            .errorText,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
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
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            S.of(context).ZipCode + " *",
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
                                                width: 270,
                                                height: 35,
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color: ColorSelect
                                                            .textField)),
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  maxLength: 9,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  controller: ZipCode2,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).TypeHere,
                                                    errorStyle: TextController
                                                        .inputErrorText,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    counterText: "",
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      setState(() {
                                                        ZipCodeError2 = true;
                                                      });
                                                    } else if (value
                                                            .isNotEmpty &&
                                                        (value.length < 5 ||
                                                            value.length > 9)) {
                                                      setState(() {
                                                        ZipCodeError2 = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        ZipCodeError2 = false;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                              if (ZipCodeError2)
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: (ZipCode2.text.length <
                                                              5 &&
                                                          ZipCode2
                                                              .text.isNotEmpty)
                                                      ? Text(
                                                          "Invalid Zip Code",
                                                          style: TextController
                                                              .errorText,
                                                        )
                                                      : Text(
                                                          "This field is required",
                                                          style: TextController
                                                              .errorText,
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
                                          child: Text(
                                            S.of(context).Fax,
                                            style: TextController.BodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Container(
                                            width: 270,
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
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              controller: Fax2,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(r'[0-9]')),
                                              ],
                                              // validator: (value) {
                                              //   if (value!.isEmpty) {
                                              //     return 'This field is required.';
                                              //   }
                                              //   return null; // Return null if the input is valid
                                              // },
                                              style: TextController.BodyText,
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      S.of(context).TypeHere,
                                                  errorStyle: TextController
                                                      .inputErrorText,
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
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    child: Text(
                                      S.of(context).PO + " *",
                                      style: TextController.BodyText,
                                    ),
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
                                          width: 270,
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
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: POBox2,
                                            style: TextController.BodyText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                errorStyle: TextController
                                                    .inputErrorText,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  POBoxError2 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  POBoxError2 = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        if (POBoxError2)
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
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Row(
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      S.of(context).District + " *",
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
                                          width: 270,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField),
                                          ),
                                          child: TextFormField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: TextController.BodyText,
                                            controller: District2,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none,
                                                errorStyle: TextController
                                                    .inputErrorText),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  DistrictError2 = true;
                                                });
                                              } else {
                                                setState(() {
                                                  DistrictError2 = false;
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        if (DistrictError2)
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
                              child: Container(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 40),
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
                              tabController?.animateTo(0);
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
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState != null) {
                                setState(() {
                                  // statementError = true;
                                  // statement2Error = true;
                                  // statementError1 = true;
                                  showCountryError =
                                      currentCountryValue == null;
                                  sameAddressError = sameAddress == null;
                                  if (isYes) {
                                    showCountryError1 =
                                        currentCountryValue2 == null;
                                  }
                                  // showCountryError1 = countryValue2 == "";

                                  if (currentCountryValue != null &&
                                      currentStateValue == null) {
                                    showStateError = true;
                                  }
                                  if (currentStateValue != null &&
                                      currentCityValue == null) {
                                    showCityError = true;
                                  } else {
                                    showCityError = false;
                                  }

                                  // if (sameAddress != "") {
                                  //   sameAddressError = true;
                                  // } else {
                                  //   sameAddressError = false;
                                  // }

                                  if (currentCountryValue2 != null &&
                                      currentStateValue2 == null) {
                                    showStateError1 = true;
                                  }
                                  if (currentStateValue2 != null &&
                                      currentCityValue2 == null) {
                                    showCityError1 = true;
                                  } else {
                                    showCityError1 = false;
                                  }

                                  // if (countryValue2 != "" &&
                                  //     stateValue2 == null) {
                                  //   showStateError1 = true;
                                  // }
                                  // if (stateValue2 != null) {
                                  //   showCityError1 = true;
                                  // }
                                });

                                if (_formKey.currentState!.validate() &&
                                    (!showCountryError &&
                                        !showStateError &&
                                        !showCityError &&
                                        !showCountryError1 &&
                                        !showStateError1 &&
                                        !showCityError1 &&
                                        !sameAddressError)) {
                                  _formKey.currentState?.save();
                                  senddata();
                                }
                              } else {
                                // Handle case where _formKey.currentState is null
                              }

                              // if (_formKey.currentState != null) {
                              //   setState(() {
                              //     showCountryError = countryValue == null;

                              //     if (countryValue != null &&
                              //         stateValue == null) {
                              //       showStateError = true;
                              //     }
                              //     if (stateValue != null) {
                              //       showCityError = true;
                              //     }
                              //   });

                              //   if (_formKey.currentState!.validate() &&
                              //       !(showCountryError ||
                              //           showCountryError1 ||
                              //           showStateError ||
                              //           showStateError1 ||
                              //           showCityError ||
                              //           showCityError1)) {
                              //     _formKey.currentState?.save();
                              //     RegisteredAddress();

                              //     Fatqa.buildingNuma.value = BuldingNumber.text;
                              //     Fatqa.countrya.value = BuldingNumber.text;
                              //     Fatqa.citya.value = BuldingNumber.text;
                              //     Fatqa.officialPhonea.value =
                              //         BuldingNumber.text;
                              //     Fatqa.statea.value = BuldingNumber.text;
                              //     Fatqa.streetNAmea.value = BuldingNumber.text;
                              //     Fatqa.SecondaryNuma.value =
                              //         BuldingNumber.text;
                              //     Fatqa.zipCode.value = BuldingNumber.text;
                              //     Fatqa.faxa.value = BuldingNumber.text;
                              //     Fatqa.POboxa.value = BuldingNumber.text;
                              //     Fatqa.districta.value = BuldingNumber.text;

                              //     tabController?.animateTo(2);
                              //   }
                              // } else {
                              //   // Handle case where _formKey.currentState is null
                              // }

                              // if ((_formKey.currentState!.validate() &&
                              //     selectionsComplete == true &&
                              //     cityValue != null &&
                              //     stateValue != null &&
                              //     currentCountryValue != null)) {
                              //   _formKey.currentState?.save();
                              //   RegisteredAddress();

                              // Fatqa.buildingNuma.value = BuldingNumber.text;
                              // Fatqa.countrya.value = BuldingNumber.text;
                              // Fatqa.citya.value = BuldingNumber.text;
                              // Fatqa.officialPhonea.value = BuldingNumber.text;
                              // Fatqa.statea.value = BuldingNumber.text;
                              // Fatqa.streetNAmea.value = BuldingNumber.text;
                              // Fatqa.SecondaryNuma.value = BuldingNumber.text;
                              // Fatqa.zipCode.value = BuldingNumber.text;
                              // Fatqa.faxa.value = BuldingNumber.text;
                              // Fatqa.POboxa.value = BuldingNumber.text;
                              // Fatqa.districta.value = BuldingNumber.text;

                              //   tabController?.animateTo(2);
                              // }
                            },
                            child: Text(
                              S.of(context).Next,
                              style: TextController.btnText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
//           padding: const EdgeInsets.all(20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Container(
//                 height: 35,
//                 width: 140,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: ColorSelect.tabBorderColor)),
//                 child: TextButton(
//                   onPressed: () {
//                     tabController?.animateTo(0);
//                   }, // Switch tabs
//                   child: Text(
//                     S.of(context).Back,
//                     style: TextController.SideMenuText,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Container(
//                 height: 35,
//                 width: 140,
//                 decoration: BoxDecoration(
//                     color: ColorSelect.east_blue,
//                     border: Border.all(color: ColorSelect.tabBorderColor)),
//                 child: TextButton(
//                   onPressed: () {
//                     tabController?.animateTo(2);
//                   }, // Switch tabs
//                   child: Text(
//                     S.of(context).Next,
//                     style: TextController.btnText,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
