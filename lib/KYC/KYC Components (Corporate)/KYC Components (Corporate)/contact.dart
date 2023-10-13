import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'RegisteredAddress.dart';

enum SingingCharacter { yes, no }

class ContactInfoo extends StatefulWidget {
  ContactInfoo({@required controller}) {
    tabController = controller;
  }

  @override
  State<ContactInfoo> createState() => ContactInfooState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> bn = ValueNotifier("");

  static ValueNotifier<String> street = ValueNotifier("");

  static ValueNotifier<String> city = ValueNotifier("");

  static ValueNotifier<String> state = ValueNotifier("");
  static ValueNotifier<String> country = ValueNotifier("");
}

bool WeWishError = false;

String? selectedValue;
TextEditingController nameOfContracts = new TextEditingController();
TextEditingController bussinessPhone = new TextEditingController();
TextEditingController addressForCorrespondense = new TextEditingController();
TextEditingController Email = new TextEditingController();
TextEditingController Mobile = new TextEditingController();
TextEditingController dateController = new TextEditingController();

final _formKey = GlobalKey<FormState>();

class ContactInfooState extends State<ContactInfoo> {
  bool MobileError = false;
  bool bussinessPhoneError = false;
  bool EmailError = false;
  bool nameOfContractsError = false;
  bool addressForCorrespondenseError = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      addressForCorrespondense.text = ContactInfoo.bn.value +", "+
          ContactInfoo.street.value +", "+
          ContactInfoo.city.value +", "+
          ContactInfoo.state.value +", "+
          ContactInfoo.country.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void contact() async {
      var url =
          Uri.parse('https://eastbridge.online/apicore/api/ContactCorporate');

      try {
        var headers = {
          'Content-Type': 'application/json',
        };
     
        var body = {
          "clientId": ContactInfoo.id.value,
          "nameOfContract": nameOfContracts.text,
          "eMail": Email.text,
          "businessPhone":
              bussinessPhone.text, // Use a default value if parsing fails
          "mobile": Mobile.text, // Use a default value if parsing fails
          "addressForCorrespondence": addressForCorrespondense.text,
          "wishToReceive": selectedValue,
        };
        var response =
            await http.post(url, headers: headers, body: jsonEncode(body));

        if (response.statusCode == 200) {
          print("Contact is working");
          // print(jsonDecode(response.body));
          tabController?.animateTo(5);
        } else {
          print(response.statusCode);
        }
      } catch (e) {
        print(e.toString());
      }
    }

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    return Container(
      height: 400,
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  child: Text(
                                    S.of(context).WeWishn + " *",
                                    style: TextController.SubHeadingText,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  S.of(context).EMailn,
                                  style: TextController.SubHeadingText,
                                ),
                              ),
                              Radio(
                                value: "Email",
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    WeWishError = false;
                                    selectedValue = value!; //<-- change this
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "mail",
                                  style: TextController.SubHeadingText,
                                ),
                              ),
                              Radio(
                                value: "Mail",
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  WeWishError = false;
                                  setState(() {
                                    selectedValue = value!; //<-- change this
                                  });
                                },
                              ),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    S.of(context).WeNotWishn,
                                    style: TextController.SubHeadingText,
                                  ),
                                ),
                              ),
                              Radio(
                                value: "We Do Not Wish to Recieve",
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    WeWishError = false;
                                    selectedValue = value!; //<-- change this
                                  });
                                },
                              ),
                            ],
                          ),
                          if (WeWishError)
                            Text(
                              "Select option",
                              style: TextController.errorText,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).NameofContract + " *",
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
                                        width: 350,
                                        height: 35,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                                nameOfContractsError = true;
                                              });
                                            } else {
                                              setState(() {
                                                nameOfContractsError = false;
                                              });
                                              return null;
                                            }
                                          },
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          controller: nameOfContracts,
                                          style: TextController.BodyText,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText:
                                                S.of(context).ContractNames,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                      if (nameOfContractsError)
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
                            width: 50,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).EMail + " *",
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
                                        width: 350,
                                        height: 35,
                                        padding:
                                            EdgeInsetsDirectional.symmetric(
                                                horizontal: 10),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              setState(() {
                                                EmailError = true;
                                              });
                                            } else if ((!RegExp(
                                                    "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                .hasMatch(value))) {
                                              setState(() {
                                                EmailError = true;
                                              });
                                            } else {
                                              setState(() {
                                                EmailError = false;
                                              });
                                              return null;
                                            }
                                          },
                                          controller: Email,
                                          style: TextController.BodyText,
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
                                      if (EmailError)
                                        Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child:
                                                ((!RegExp("[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                            .hasMatch(
                                                                Email.text)) &&
                                                        Email.text.isNotEmpty)
                                                    ? Text(
                                                        "Enter valid email",
                                                        style: TextController
                                                            .errorText,
                                                      )
                                                    : Text(
                                                        "This field is required",
                                                        style: TextController
                                                            .errorText,
                                                      ))
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
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).BusinessPhone + " *",
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
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        width: 350,
                                        height: 35,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                width: 70,
                                                child: CountryCodePicker(
                                                  textStyle:
                                                      TextController.BodyText,
                                                  alignLeft: true,
                                                  showFlag: false,
                                                  onChanged: print,
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: 'SA',
                                                  favorite: const ['SA', 'IN'],

                                                  showFlagDialog: false,

                                                  //Get the country information relevant to the initial selection
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                width: double.infinity,
                                                height: 35,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                alignment: Alignment.centerLeft,
                                                child: TextFormField(
                                                  controller: bussinessPhone,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      setState(() {
                                                        bussinessPhoneError =
                                                            true;
                                                      });
                                                    } else if (value
                                                            .isNotEmpty &&
                                                        (value.length < 4 ||
                                                            value.length >
                                                                12)) {
                                                      setState(() {
                                                        bussinessPhoneError =
                                                            true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        bussinessPhoneError =
                                                            false;
                                                      });
                                                      return null;
                                                    }
                                                  },
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    isDense: true,
                                                    hintText: S
                                                        .of(context)
                                                        .BusinessPhone,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle: TextController
                                                        .inputErrorText,
                                                  ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  maxLength: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (bussinessPhoneError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: (bussinessPhone.text.length <
                                                      4 &&
                                                  bussinessPhone
                                                      .text.isNotEmpty)
                                              ? Text(
                                                  "Enter valid number",
                                                  style:
                                                      TextController.errorText,
                                                )
                                              : Text(
                                                  "This field is required",
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
                            width: 50,
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).Mobile + " *",
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
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        width: 350,
                                        height: 35,
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Container(
                                                width: 70,
                                                child: CountryCodePicker(
                                                  textStyle:
                                                      TextController.BodyText,
                                                  alignLeft: true,
                                                  showFlag: false,
                                                  onChanged: print,
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: 'SA',
                                                  favorite: const ['SA', 'IN'],

                                                  showFlagDialog: false,

                                                  //Get the country information relevant to the initial selection
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                width: double.infinity,
                                                height: 35,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                alignment: Alignment.centerLeft,
                                                child: TextFormField(
                                                  controller: Mobile,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      setState(() {
                                                        MobileError = true;
                                                      });
                                                    } else if (value
                                                            .isNotEmpty &&
                                                        (value.length < 4 ||
                                                            value.length >
                                                                12)) {
                                                      setState(() {
                                                        MobileError = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        MobileError = false;
                                                      });
                                                      return null;
                                                    }
                                                  },
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style:
                                                      TextController.BodyText,
                                                  decoration: InputDecoration(
                                                    counterText: "",
                                                    isDense: true,
                                                    hintText:
                                                        S.of(context).MobLabel,
                                                    hintStyle: TextController
                                                        .labelText,
                                                    border: InputBorder.none,
                                                    errorStyle: TextController
                                                        .inputErrorText,
                                                  ),
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                  ],
                                                  maxLength: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (MobileError)
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: (Mobile.text.length < 4 &&
                                                  Mobile.text.isNotEmpty)
                                              ? Text(
                                                  "Enter valid number",
                                                  style:
                                                      TextController.errorText,
                                                )
                                              : Text(
                                                  "This field is required",
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  S.of(context).AddressforCorrespondence + " *",
                                  style: TextController.BodyText,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 35,
                                        ),
                                        width: 350,
                                        height: 100,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                color: ColorSelect.textField)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, bottom: 10),
                                          child: TextFormField(
                                            maxLines: null,
                                            controller:
                                                addressForCorrespondense,
                                            style: TextController.BodyText,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                setState(() {
                                                  addressForCorrespondenseError =
                                                      true;
                                                });
                                              } else {
                                                setState(() {
                                                  addressForCorrespondenseError =
                                                      false;
                                                });
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                                errorStyle: TextController
                                                    .inputErrorText,
                                                hintText:
                                                    S.of(context).AddressProof,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      if (addressForCorrespondenseError)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 35, top: 5),
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
                            width: 50,
                          ),
                          Flexible(child: Container())
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
                                tabController?.animateTo(3);
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
                                if (_formKey.currentState != null) {
                                  setState(() {
                                    WeWishError = selectedValue == null;
                                  });
                                  if ((_formKey.currentState!.validate()) &&
                                      !WeWishError) {
                                    _formKey.currentState?.save();
                                    tabController?.animateTo(5);
                                    contact();
                                  }
                                }
                                // if (selectedValue != null) {
                                // if ((_formKey.currentState!.validate())) {
                                //   _formKey.currentState?.save();

                                //   contact();
                                //   tabController?.animateTo(5);
                                // }
                                // } else {
                                //   setState(() {
                                //     WeWishError = true;
                                //   });
                                // }
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
        )),
      ),
    );
  }
}
