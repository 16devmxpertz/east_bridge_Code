// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/Fatqa.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/contact.dart';
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
  static ValueNotifier<bool> draft = ValueNotifier(false);
}

TabController? tabController;
// String? currentCountryValue;
// String? currentStateValue;
// String? currentCityValue;
// String? currentCountryValue2;
// String? currentStateValue2;
// String? currentCityValue2;

// Define a variable to track if all selections are made

// TextEditingController currentcurrentCountryValue = new TextEditingController();
// TextEditingController currentcurrentStateValue = new TextEditingController();
// TextEditingController currentcurrentCityValue = new TextEditingController();

// TextEditingController countryValueController = TextEditingController();
// TextEditingController cityValueController = TextEditingController();
// TextEditingController stateValueController = TextEditingController();
// TextEditingController currentCountryValueController = TextEditingController();
// TextEditingController currentCityValueController = TextEditingController();
// TextEditingController currentStateValueController = TextEditingController();

class Registered_AddressState extends State<Registered_Address> {
  String btn = "Next";
  String? sameAddress;
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
  TextEditingController currentCountryValue = new TextEditingController();
  TextEditingController currentStateValue = new TextEditingController();
  TextEditingController currentCityValue = new TextEditingController();

  TextEditingController BuldingNumber2 = new TextEditingController();
  TextEditingController OfficailPhoneNumber2 = new TextEditingController();
  TextEditingController StreetName2 = new TextEditingController();
  TextEditingController SecondaryPhoneNumber2 = new TextEditingController();
  TextEditingController ZipCode2 = new TextEditingController();
  TextEditingController Fax2 = new TextEditingController();
  TextEditingController POBox2 = new TextEditingController();
  TextEditingController District2 = new TextEditingController();
  TextEditingController currentCountryValue2 = new TextEditingController();
  TextEditingController currentStateValue2 = new TextEditingController();
  TextEditingController currentCityValue2 = new TextEditingController();
  bool isstate = false;
  bool iscity = false;
  bool isstate2 = false;
  bool iscity2 = false;
  String _selectedItem = ''; // To store the selected item

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
  // List<String> dropdownlist = [""];
  List<String> dropdownlistcountry = ["Loading..."];
  List<String> dropdownliststate = [""];
  List<String> dropdownlistcity = [""];

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

  void Senddata() async {
    setState(() {
      btn = "Loading...";
    });
    // int commercial = int.parse(CommercialRegistraction.text);
    //int percentageOwnership = int.parse(percentage.text);
    print("aaaffsdfsdfsdfsd");
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "buldingNumber": BuldingNumber.text,
      "officialPhoneNumber": OfficailPhoneNumber.text,
      "country": currentCountryValue.text,
      "state": currentStateValue.text,
      "city": currentCityValue.text,
      "district": District.text,
      "streetName": StreetName.text,
      "fax": Fax.text,
      "poBox": POBox.text,
      "zipCode": ZipCode.text,
      "secondaryPhoneNumber": SecondaryPhoneNumber.text,
      //
      "currentCountry": currentCountryValue2.text,
      "currentOfficialPhoneNumber": OfficailPhoneNumber2.text,
      "currentBuldingNumber": BuldingNumber2.text,
      "currentState": currentStateValue2.text,
      "currentCity": currentCityValue2.text,
      "currentDistrict": District2.text,
      "currentStreetName": StreetName2.text,
      "currentFax": Fax2.text,
      "currentPOBox": POBox2.text,
      "currentZipCode": ZipCode2.text,
      "currentSecondaryPhoneNumber": SecondaryPhoneNumber2.text,
    };
    print(body);
    final response = await http.post(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/RegisteredAddressCorporate/RegisteredAddressCorporate/'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      Fatqa.buildingnumber.value = BuldingNumber.text;
      Fatqa.district.value = District.text;
      Fatqa.streetname.value = StreetName.text;
      Fatqa.POboxa.value = POBox.text;
      Fatqa.zipcode.value = ZipCode.text;
      Fatqa.country.value = currentCountryValue.text;
      Fatqa.city.value = currentCityValue.text;
      Fatqa.state.value = currentStateValue.text;

      ContactInfoo.bn.value = BuldingNumber.text;
      ContactInfoo.street.value = StreetName.text;

      ContactInfoo.city.value = currentCityValue.text;
      ContactInfoo.state.value = currentStateValue.text;

      ContactInfoo.country.value = currentCountryValue.text;
      // Request successful, handle the response
      // var responseData = jsonDecode(response.body);
      print("Successfull");
      GlobalPermissionCorporate.getdraftprogresscorporate(
          GlobalPermissionCorporate.corporateclientid);
      tabController?.animateTo(2);
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

  Future<void> fetchData(int id) async {
    var url =
        '${GlobalPermission.urlLink}/api/RegisteredAddressCorporate/RegisteredAddressCorporate/${id}'; // Replace with your API endpoint

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Request successful, parse the response body

        var jsonResponse = json.decode(response.body);
        print(jsonResponse);

        setState(() {
          BuldingNumber.text = jsonResponse['buldingNumber'];
          OfficailPhoneNumber.text = jsonResponse['officialPhoneNumber'];
          currentCountryValue.text = jsonResponse['country'];
          currentStateValue.text = jsonResponse['state'];
          currentCityValue.text = jsonResponse['city'];
          District.text = jsonResponse['district'];
          StreetName.text = jsonResponse['streetName'];
          Fax.text = jsonResponse['fax'];
          POBox.text = jsonResponse['poBox'];
          ZipCode.text = jsonResponse['zipCode'];
          SecondaryPhoneNumber.text = jsonResponse['secondaryPhoneNumber'];
          //
          currentCountryValue2.text = jsonResponse['currentCountry'];
          OfficailPhoneNumber2.text =
              jsonResponse['currentOfficialPhoneNumber'];
          BuldingNumber2.text = jsonResponse['currentBuldingNumber'];
          currentStateValue2.text = jsonResponse['currentState'];
          currentCityValue2.text = jsonResponse['currentCity'];
          District2.text = jsonResponse['currentDistrict'];
          StreetName2.text = jsonResponse['currentStreetName'];
          Fax2.text = jsonResponse['currentFax'];
          POBox2.text = jsonResponse['currentPOBox'];
          ZipCode2.text = jsonResponse['currentZipCode'];
          SecondaryPhoneNumber2.text =
              jsonResponse['currentSecondaryPhoneNumber'];
          sameAddress = BuldingNumber2.text != "" ? "No" : "Yes";
        });

        // setState(() {
        //   data = jsonDecode(response.body);
        // });
      } else {
        // Request failed, handle the error
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Request failed, handle the exception
      print('Exception occurred while fetching data: $e');
    }
  }

  void putdata(int Id) async {
    setState(() {
      btn = "Loading...";
    });
    // int commercial = int.parse(CommercialRegistraction.text);
    //int percentageOwnership = int.parse(percentage.text);

    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "clientId": GlobalPermissionCorporate.corporateclientid,
      "buldingNumber": BuldingNumber.text,
      "officialPhoneNumber": OfficailPhoneNumber.text,
      "country": currentCountryValue.text,
      "state": currentStateValue.text,
      "city": currentCityValue.text,
      "district": District.text,
      "streetName": StreetName.text,
      "fax": Fax.text,
      "poBox": POBox.text,
      "zipCode": ZipCode.text,
      "secondaryPhoneNumber": SecondaryPhoneNumber.text,
      //
      "currentCountry": currentCountryValue2.text,
      "currentOfficialPhoneNumber": OfficailPhoneNumber2.text,
      "currentBuldingNumber": BuldingNumber2.text,
      "currentState": currentStateValue2.text,
      "currentCity": currentCityValue2.text,
      "currentDistrict": District2.text,
      "currentStreetName": StreetName2.text,
      "currentFax": Fax2.text,
      "currentPOBox": POBox2.text,
      "currentZipCode": ZipCode2.text,
      "currentSecondaryPhoneNumber": SecondaryPhoneNumber2.text,
    };
    print(body);
    final response = await http.put(
        Uri.parse(
            '${GlobalPermission.urlLink}/api/RegisteredAddressCorporate/RegisteredAddressCorporate?ClientId=${GlobalPermissionCorporate.corporateclientid}'),
        headers: headers,
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      // Request successful, handle the response

      print("Successfull");
      tabController?.animateTo(2);
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

  String url =
      "https://raw.githubusercontent.com/dr5hn/countries-states-cities-database/master/countries%2Bstates%2Bcities.json";

  var _countries = [];
  var _states = [];
  var _cities = [];

// these will be the values after selection of the item
  String? country;
  String? city;
  String? state;

// this will help to show the widget after
  bool isCountrySelected = false;
  bool isStateSelected = false;

  Future getLocalData() async {
    try {
      // Load the JSON file from the assets folder
      String jsonString = await rootBundle.loadString('images/countries.json');

      // Parse the JSON data
      var jsonResponse = jsonDecode(jsonString);

      setState(() {
        _countries = jsonResponse;
      });

      // print(_countries);
    } catch (e) {
      // Handle any errors here
      print("Error loading and parsing JSON: $e");
    }
  }

  @override
  void initState() {
    getLocalData();
    super.initState();
    print(GlobalPermissionCorporate.corporateclientid);
    if (GlobalPermissionCorporate
            .corporatedraftprogress["RegisteredAddressCorporate"] ==
        true) {
      print("ftechinggg----------");
      fetchData(GlobalPermissionCorporate.corporateclientid);
    } else {}
    print(GlobalPermissionCorporate.corporatedraftprogress);
    // fetchData();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  // Future<void> fetchData() async {
  //   var url =
  //       '${GlobalPermission.urlLink}/api/RegisteredAddressCorporate/RegisteredAddressCorporate/'; // Replace with your API endpoint

  //   try {
  //     var response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       // Request successful, parse the response body
  //       setState(() {
  //         data = jsonDecode(response.body);
  //       });
  //     } else {
  //       // Request failed, handle the error
  //       print('Request failed with status: ${response.statusCode}.');
  //     }
  //   } catch (e) {
  //     // Request failed, handle the exception
  //     print('Exception occurred while fetching data: $e');
  //   }
  // }

  // // Function to check if all selections are made
  // // void checkSelectionsComplete() {
  // //   if (currentCountryValue != null &&
  // //       currentStateValue != null &&
  // //       currentCityValue != null) {
  // //     setState(() {
  // //       selectionsComplete = true;
  // //     });
  // //   } else {
  // //     setState(() {
  // //       selectionsComplete = false;
  // //     });
  // //   }
  // // }

  // void senddata() async {
  //   // int commercial = int.parse(CommercialRegistraction.text);
  //   //int percentageOwnership = int.parse(percentage.text);

  //   var headers = {
  //     'Content-Type': 'application/json',
  //   };

  //   var body = {
  //     "clientId": Registered_Address.id.value,
  //     "buldingNumber": BuldingNumber.text,
  //     "officialPhoneNumber": OfficailPhoneNumber.text,
  //     "country": currentCountryValue,
  //     "state": currentStateValue,
  //     "city": currentCityValue,
  //     "district": District.text,
  //     "streetName": StreetName.text,
  //     "fax": Fax.text,
  //     "poBox": POBox.text,
  //     "zipCode": ZipCode.text,
  //     "secondaryPhoneNumber": SecondaryPhoneNumber.text,
  //     "currentCountry": "currentCountryValue2",
  //     "currentOfficialPhoneNumber": OfficailPhoneNumber2.text,
  //     "currentBuldingNumber": BuldingNumber2.text,
  //     "currentState": "currentStateValue2",
  //     "currentCity": "currentCityValue2",
  //     "currentDistrict": District2.text,
  //     "currentStreetName": StreetName2.text,
  //     "currentFax": Fax2.text,
  //     "currentPOBox": POBox2.text,
  //     "currentZipCode": ZipCode2.text,
  //     "currentSecondaryPhoneNumber": SecondaryPhoneNumber2.text
  //   };
  //   final response = await http.post(
  //       Uri.parse(
  //           '${GlobalPermission.urlLink}/api/RegisteredAddressCorporate/RegisteredAddressCorporate'),
  //       headers: headers,
  //       body: jsonEncode(body));

  //   if (response.statusCode == 200) {
  //     print("Registered Address Working");
  //     Fatqa.buildingnumber.value = BuldingNumber.text;
  //     Fatqa.district.value = District.text;
  //     Fatqa.streetname.value = StreetName.text;
  //     Fatqa.POboxa.value = POBox.text;
  //     Fatqa.zipcode.value = ZipCode.text;
  //     Fatqa.country.value = ZipCode.text;
  //     Fatqa.city.value = ZipCode.text;
  //     Fatqa.state.value = ZipCode.text;

  //     ContactInfoo.bn.value = BuldingNumber.text;
  //     ContactInfoo.street.value = StreetName.text;

  //     ContactInfoo.city.value = currentCityValue!;
  //     ContactInfoo.state.value = currentStateValue!;

  //     ContactInfoo.country.value = currentCountryValue!;

  //     tabController!.animateTo(2);

  //     // Process the responseData
  //   } else {
  //     // Request failed, handle the error
  //     var errorMessage = response.reasonPhrase;
  //     print(response.statusCode);
  //     print(response.body);
  //     print(jsonDecode(response.body));
  //     print("Error");
  //     // Display or handle the error
  //   }
  // }

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
                                                // inputFormatters: [
                                                //   FilteringTextInputFormatter
                                                //       .allow(RegExp(r'[0-9]')),
                                                // ],
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
                                      Container(
                                        child: Text(
                                          "Official Phone Number*",
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
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        ColorSelect.textField),
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
                                                    AutovalidateMode.disabled,
                                                showDropdownIcon: false,
                                                pickerDialogStyle:
                                                    PickerDialogStyle(
                                                  width: 400,
                                                ),
                                                showCountryFlag: false,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: OfficailPhoneNumber,
                                                dropdownTextStyle:
                                                    TextController.BodyText,
                                                style: TextController.BodyText,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  counterText: "",
                                                  hintText:
                                                      S.of(context).ResPhLabel,
                                                  hintStyle:
                                                      TextController.labelText,
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
                                            if (OfficailPhoneNumberError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  "This field is required",
                                                  style:
                                                      TextController.errorText,
                                                ),
                                              )
                                          ],
                                        ),
                                      ),
                                      // Flexible(
                                      //   flex: 2,
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //         CrossAxisAlignment.start,
                                      //     children: [
                                      //       Container(
                                      //         padding: EdgeInsets.symmetric(
                                      //             horizontal: 10),
                                      //         decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           border: Border.all(
                                      //               color:
                                      //                   ColorSelect.textField),
                                      //         ),
                                      //         width: 270,
                                      //         height: 35,
                                      //         child: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             Flexible(
                                      //               child: Container(
                                      //                 width: 70,
                                      //                 child: CountryCodePicker(
                                      //                   textStyle:
                                      //                       TextController
                                      //                           .BodyText,
                                      //                   alignLeft: true,
                                      //                   showFlag: false,
                                      //                   onChanged: print,
                                      //                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                      //                   initialSelection: 'SA',
                                      //                   favorite: const [
                                      //                     'SA',
                                      //                     'IN'
                                      //                   ],

                                      //                   showFlagDialog: false,

                                      //                   //Get the country information relevant to the initial selection
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //             Flexible(
                                      //               child: Container(
                                      //                 width: double.infinity,
                                      //                 height: 35,
                                      //                 alignment:
                                      //                     Alignment.centerLeft,
                                      //                 child: TextFormField(
                                      //                   textAlignVertical:
                                      //                       TextAlignVertical
                                      //                           .center,
                                      //                   style: TextController
                                      //                       .BodyText,
                                      //                   controller:
                                      //                       OfficailPhoneNumber,
                                      //                   decoration: InputDecoration(
                                      //                       isDense: true,
                                      //                       hintText: S
                                      //                           .of(context)
                                      //                           .BusinessPhone,
                                      //                       hintStyle:
                                      //                           TextController
                                      //                               .labelText,
                                      //                       border: InputBorder
                                      //                           .none,
                                      //                       counterText: '',
                                      //                       errorStyle:
                                      //                           TextStyle(
                                      //                               height:
                                      //                                   0.0)),
                                      //                   // validator: (value) {
                                      //                   //   if (value!.isEmpty) {
                                      //                   //     setState(() {
                                      //                   //       OfficailPhoneNumberError =
                                      //                   //           true;
                                      //                   //     });
                                      //                   //   } else {
                                      //                   //     setState(() {
                                      //                   //       OfficailPhoneNumberError =
                                      //                   //           false;
                                      //                   //     });
                                      //                   //   }
                                      //                   // },
                                      //                   validator: (value) {
                                      //                     if (value!.isEmpty) {
                                      //                       setState(() {
                                      //                         OfficailPhoneNumberError =
                                      //                             true;
                                      //                       });
                                      //                       return "";
                                      //                     } else if (value
                                      //                             .isNotEmpty &&
                                      //                         (value.length <
                                      //                                 4 ||
                                      //                             value.length >
                                      //                                 12)) {
                                      //                       setState(() {
                                      //                         OfficailPhoneNumberError =
                                      //                             true;
                                      //                       });
                                      //                       return "";
                                      //                     } else {
                                      //                       setState(() {
                                      //                         OfficailPhoneNumberError =
                                      //                             false;
                                      //                       });
                                      //                     }
                                      //                     return null;
                                      //                   },
                                      //                   inputFormatters: [
                                      //                     FilteringTextInputFormatter
                                      //                         .allow(RegExp(
                                      //                             r'[0-9]')),
                                      //                   ],
                                      //                   maxLength: 12,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       if (OfficailPhoneNumberError)
                                      //         Container(
                                      //           margin: EdgeInsets.only(top: 5),
                                      //           child: (OfficailPhoneNumber
                                      //                           .text.length <
                                      //                       4 &&
                                      //                   OfficailPhoneNumber
                                      //                       .text.isNotEmpty)
                                      //               ? Text(
                                      //                   "Enter valid number",
                                      //                   style: TextController
                                      //                       .errorText,
                                      //                 )
                                      //               : Text(
                                      //                   "This field is required",
                                      //                   style: TextController
                                      //                       .errorText,
                                      //                 ),
                                      //         ),
                                      //     ],
                                      //   ),
                                      // ),
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
                                                // inputFormatters: [
                                                //   FilteringTextInputFormatter
                                                //       .allow(RegExp(r'[0-9]')),
                                                // ],
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
                                              alignment: Alignment.centerLeft,
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
                                                            currentCountryValue,
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
                                                                .Country)),
                                                suggestionsCallback: (pattern) {
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
                                                  currentCountryValue.text =
                                                      suggestion;
                                                  print(
                                                      "selectetd countryy uis ${currentCountryValue.text}");
                                                  setState(() {
                                                    currentStateValue.text = "";
                                                    currentCityValue.text = "";
                                                    isstate = false;
                                                    iscity = false;

                                                    if (currentCountryValue
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
                                                    _selectedItem = suggestion;
                                                    currentCountryValue.text =
                                                        suggestion;
                                                    print("fdgfdgdfg-");
                                                  });

                                                  GlobalPermission.getState(
                                                      currentCountryValue.text);
                                                },
                                              ),
                                            ),
                                            if (showCountryError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select Country',
                                                  style:
                                                      TextController.errorText,
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
                                              alignment: Alignment.centerLeft,
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
                                                            currentStateValue,
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
                                                                .State)),
                                                suggestionsCallback: (pattern) {
                                                  // Return a filtered list of suggestions based on the search pattern.
                                                  return GlobalPermission.states
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
                                                  currentStateValue.text =
                                                      suggestion;
                                                  currentCityValue.text = "";
                                                  print(
                                                      "Select ted satted is ${currentStateValue.text}");
                                                  setState(() {
                                                    if (currentStateValue
                                                            .text ==
                                                        "") {
                                                      iscity = false;
                                                    } else {
                                                      print("city ture");
                                                      iscity = true;
                                                    }
                                                  });
                                                  setState(() {
                                                    _selectedItem = suggestion;
                                                    currentStateValue.text =
                                                        suggestion;
                                                  });
                                                  GlobalPermission.getCity(
                                                      currentCountryValue.text,
                                                      currentStateValue.text);
                                                },
                                              ),
                                            ),
                                            if (showStateError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select State',
                                                  style:
                                                      TextController.errorText,
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
                                              alignment: Alignment.centerLeft,
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
                                                              currentCityValue,
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
                                                    setState(
                                                      () {
                                                        _selectedItem =
                                                            suggestion;
                                                        currentCityValue.text =
                                                            suggestion;
                                                      },
                                                    );
                                                  }),
                                            ),
                                            if (showCityError)
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  'Select City',
                                                  style:
                                                      TextController.errorText,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
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
                                          errorStyle: TextStyle(height: 0.0)),
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
                                BuldingNumber2.text = "";
                                OfficailPhoneNumber2.text = "";
                                StreetName2.text = "";
                                SecondaryPhoneNumber2.text = "";
                                ZipCode2.text = "";
                                Fax2.text = "";
                                POBox2.text = "";
                                District2.text = "";
                                currentCountryValue2.text = "";
                                currentStateValue2.text = "";
                                currentCityValue2.text = "";

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

                if (sameAddress == "No")
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
                                                      // inputFormatters: [
                                                      //   FilteringTextInputFormatter
                                                      //       .allow(RegExp(
                                                      //           r'[0-9]')),
                                                      // ],
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
                                            Container(
                                              child: Text(
                                                "Official Phone\nNumber *",
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
                                                      controller:
                                                          OfficailPhoneNumber2,
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
                                                        border:
                                                            InputBorder.none,
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
                                                  if (OfficailPhoneNumberError2)
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "This field is required",
                                                        style: TextController
                                                            .errorText,
                                                      ),
                                                    )
                                                ],
                                              ),
                                            ),

                                            // =============================
                                            // Flexible(
                                            //   flex: 2,
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       Container(
                                            //         padding:
                                            //             EdgeInsets.symmetric(
                                            //                 horizontal: 10),
                                            //         decoration: BoxDecoration(
                                            //           color: Colors.white,
                                            //           border: Border.all(
                                            //               color: ColorSelect
                                            //                   .textField),
                                            //         ),
                                            //         width: 270,
                                            //         height: 35,
                                            //         child: Row(
                                            //           mainAxisAlignment:
                                            //               MainAxisAlignment
                                            //                   .center,
                                            //           children: [
                                            //             Flexible(
                                            //               child: Container(
                                            //                 width: 70,
                                            //                 child:
                                            //                     CountryCodePicker(
                                            //                   textStyle:
                                            //                       TextController
                                            //                           .BodyText,
                                            //                   alignLeft: true,
                                            //                   showFlag: false,
                                            //                   onChanged: print,
                                            //                   // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                            //                   initialSelection:
                                            //                       'SA',
                                            //                   favorite: const [
                                            //                     'SA',
                                            //                     'IN'
                                            //                   ],

                                            //                   showFlagDialog:
                                            //                       false,

                                            //                   //Get the country information relevant to the initial selection
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //             Flexible(
                                            //               child: Container(
                                            //                 width:
                                            //                     double.infinity,
                                            //                 height: 35,
                                            //                 alignment: Alignment
                                            //                     .centerLeft,
                                            //                 child:
                                            //                     TextFormField(
                                            //                   textAlignVertical:
                                            //                       TextAlignVertical
                                            //                           .center,
                                            //                   style:
                                            //                       TextController
                                            //                           .BodyText,
                                            //                   controller:
                                            //                       OfficailPhoneNumber2,
                                            //                   decoration: InputDecoration(
                                            //                       isDense: true,
                                            //                       hintText: S
                                            //                           .of(
                                            //                               context)
                                            //                           .BusinessPhone,
                                            //                       hintStyle:
                                            //                           TextController
                                            //                               .labelText,
                                            //                       border:
                                            //                           InputBorder
                                            //                               .none,
                                            //                       counterText:
                                            //                           '',
                                            //                       errorStyle:
                                            //                           TextController
                                            //                               .inputErrorText),
                                            //                   // validator: (value) {
                                            //                   //   if (value!.isEmpty) {
                                            //                   //     setState(() {
                                            //                   //       OfficailPhoneNumberError =
                                            //                   //           true;
                                            //                   //     });
                                            //                   //   } else {
                                            //                   //     setState(() {
                                            //                   //       OfficailPhoneNumberError =
                                            //                   //           false;
                                            //                   //     });
                                            //                   //   }
                                            //                   // },
                                            //                   validator:
                                            //                       (value) {
                                            //                     if (value!
                                            //                         .isEmpty) {
                                            //                       setState(() {
                                            //                         OfficailPhoneNumberError2 =
                                            //                             true;
                                            //                       });
                                            //                     } else if (value
                                            //                             .isNotEmpty &&
                                            //                         (value.length <
                                            //                                 4 ||
                                            //                             value.length >
                                            //                                 12)) {
                                            //                       setState(() {
                                            //                         OfficailPhoneNumberError2 =
                                            //                             true;
                                            //                       });
                                            //                     } else {
                                            //                       setState(() {
                                            //                         OfficailPhoneNumberError2 =
                                            //                             false;
                                            //                       });
                                            //                     }
                                            //                   },
                                            //                   inputFormatters: [
                                            //                     FilteringTextInputFormatter
                                            //                         .allow(RegExp(
                                            //                             r'[0-9]')),
                                            //                   ],
                                            //                   maxLength: 12,
                                            //                 ),
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //       if (OfficailPhoneNumberError2)
                                            //         Container(
                                            //           margin: EdgeInsets.only(
                                            //               top: 5),
                                            //           child: (OfficailPhoneNumber2
                                            //                           .text
                                            //                           .length <
                                            //                       4 &&
                                            //                   OfficailPhoneNumber2
                                            //                       .text
                                            //                       .isNotEmpty)
                                            //               ? Text(
                                            //                   "Enter valid number",
                                            //                   style:
                                            //                       TextController
                                            //                           .errorText,
                                            //                 )
                                            //               : Text(
                                            //                   "This field is required",
                                            //                   style:
                                            //                       TextController
                                            //                           .errorText,
                                            //                 ),
                                            //         ),
                                            //     ],
                                            //   ),
                                            // ),
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
                                            width: 270,
                                            child: FormField<String>(
                                              builder: (FormFieldState<String>
                                                  field) {
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
                                                                  horizontal:
                                                                      10),
                                                          width:
                                                              double.infinity,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: TypeAheadField(
                                                            textFieldConfiguration: TextFieldConfiguration(
                                                                onTap: () {},
                                                                controller:
                                                                    currentCountryValue2,
                                                                style:
                                                                    TextController
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
                                                              currentCountryValue2
                                                                      .text =
                                                                  suggestion;
                                                              print(
                                                                  "selectetd countryy uis ${currentCountryValue2.text}");
                                                              setState(() {
                                                                currentStateValue2
                                                                    .text = "";
                                                                currentCityValue2
                                                                    .text = "";
                                                                isstate2 =
                                                                    false;
                                                                iscity2 = false;

                                                                if (currentCountryValue2
                                                                        .text ==
                                                                    "") {
                                                                  print(
                                                                      "state false");
                                                                  isstate2 =
                                                                      false;
                                                                } else {
                                                                  print(
                                                                      "state ture");
                                                                  isstate2 =
                                                                      true;
                                                                }
                                                              });
                                                              setState(() {
                                                                _selectedItem =
                                                                    suggestion;
                                                                currentCountryValue2
                                                                        .text =
                                                                    suggestion;
                                                                print(
                                                                    "fdgfdgdfg-");
                                                              });

                                                              GlobalPermission
                                                                  .getState(
                                                                      currentCountryValue2
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
                                                                  horizontal:
                                                                      10),
                                                          width:
                                                              double.infinity,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: TypeAheadField(
                                                            textFieldConfiguration: TextFieldConfiguration(
                                                                enabled:
                                                                    isstate2,
                                                                onTap: () {},
                                                                controller:
                                                                    currentStateValue2,
                                                                style:
                                                                    TextController
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
                                                              currentStateValue2
                                                                      .text =
                                                                  suggestion;
                                                              currentCityValue2
                                                                  .text = "";
                                                              print(
                                                                  "Select ted satted is ${currentStateValue2.text}");
                                                              setState(() {
                                                                if (currentStateValue2
                                                                        .text ==
                                                                    "") {
                                                                  iscity2 =
                                                                      false;
                                                                } else {
                                                                  print(
                                                                      "city ture");
                                                                  iscity2 =
                                                                      true;
                                                                }
                                                              });
                                                              setState(() {
                                                                _selectedItem =
                                                                    suggestion;
                                                                currentStateValue2
                                                                        .text =
                                                                    suggestion;
                                                              });
                                                              GlobalPermission.getCity(
                                                                  currentCountryValue2
                                                                      .text,
                                                                  currentStateValue2
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
                                                                  horizontal:
                                                                      10),
                                                          width:
                                                              double.infinity,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: TypeAheadField(
                                                              textFieldConfiguration:
                                                                  TextFieldConfiguration(
                                                                      enabled:
                                                                          iscity2,
                                                                      onTap:
                                                                          () {
                                                                        // setState(
                                                                        //     () async {

                                                                        // });
                                                                      },
                                                                      controller:
                                                                          currentCityValue2,
                                                                      style: TextController
                                                                          .BodyText,
                                                                      decoration: InputDecoration(
                                                                          isDense:
                                                                              true,
                                                                          enabledBorder: InputBorder
                                                                              .none,
                                                                          hintStyle: TextController
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
                                                                            pattern.toLowerCase()))
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
                                                                    currentCityValue2
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
                        height: 10,
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorSelect.east_blue),
                            ),
                            onPressed: () {
                              if (_formKey.currentState != null) {
                                setState(() {
                                  // statementError = true;
                                  // statement2Error = true;
                                  // statementError1 = true;
                                  showCountryError =
                                      currentCountryValue.text == "";
                                  sameAddressError = sameAddress == null;
                                  OfficailPhoneNumberError =
                                      OfficailPhoneNumber.text == "";
                                  if (isYes) {
                                    showCountryError1 =
                                        currentCountryValue2.text == "";
                                    OfficailPhoneNumberError2 =
                                        OfficailPhoneNumber2.text == "";
                                  }
                                  // showCountryError1 = countryValue2 == "";

                                  if (currentCountryValue.text != "" &&
                                      currentStateValue.text == "") {
                                    showStateError = true;
                                  } else {
                                    showStateError = false;
                                  }
                                  if (currentStateValue.text != "" &&
                                      currentCityValue.text == "") {
                                    showCityError = true;
                                  } else {
                                    showCityError = false;
                                  }

                                  // if (sameAddress != "") {
                                  //   sameAddressError = true;
                                  // } else {
                                  //   sameAddressError = false;
                                  // }

                                  if (currentCountryValue2.text != "" &&
                                      currentStateValue2.text == "") {
                                    showStateError1 = true;
                                  } else {
                                    showStateError1 = false;
                                  }
                                  if (currentStateValue2.text != "" &&
                                      currentCityValue2.text == "") {
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
                                    (!OfficailPhoneNumberError2 &&
                                        !OfficailPhoneNumberError &&
                                        !showCountryError &&
                                        !showStateError &&
                                        !showCityError &&
                                        !showCountryError1 &&
                                        !showStateError1 &&
                                        !showCityError1 &&
                                        !sameAddressError)) {
                                  _formKey.currentState?.save();
                                  if (GlobalPermissionCorporate
                                              .corporatedraftprogress[
                                          "RegisteredAddressCorporate"] ==
                                      true) {
                                    putdata(GlobalPermissionCorporate
                                        .corporateclientid);
                                  } else {
                                    if (GlobalPermissionCorporate
                                            .corporateclientid !=
                                        0) {
                                      Senddata();
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
                              btn,
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
