import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class CustomerDetails extends StatefulWidget {
  CustomerDetails({@required controller}) {
    tabController = controller;
  }

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

TabController? tabController;

class _CustomerDetailsState extends State<CustomerDetails> {
  String? currentCountryValue = "";
  String? currentCityValue = "";
  String? currentStateValue = "";
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Material(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  S.of(context).CustomerDetails,
                  style: TextController.SubHeadingText,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color.fromRGBO(0, 0, 0, 0.363),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      S.of(context).Name,
                                      style: TextController.BodyText,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 55,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 290,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyHeadingText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).TypeHere,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 290,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyHeadingText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).FatherName,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 290,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyHeadingText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText:
                                                S.of(context).GrandFatherName,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      width: 290,
                                      height: 35,
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField)),
                                      child: TextFormField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: TextController.BodyHeadingText,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            hintText: S.of(context).FamilyName,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      width: 400,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 40,
                                                margin: EdgeInsets.only(
                                                    right: 15, bottom: 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).Country,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                margin:
                                                    EdgeInsets.only(bottom: 15),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).State,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 40,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    S.of(context).City,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 40,
                                          ),
                                          Flexible(
                                            child: Container(
                                              width: 270,
                                              alignment: Alignment.centerLeft,
                                              child: CSCPicker(
                                                layout: Layout.vertical,
                                                flagState: CountryFlag.DISABLE,
                                                onCountryChanged: (value) {
                                                  setState(() {
                                                    currentCountryValue = value;
                                                  });
                                                },
                                                onStateChanged: (value) {
                                                  setState(() {
                                                    currentStateValue = value;
                                                  });
                                                },
                                                onCityChanged: (value) {
                                                  setState(() {
                                                    currentCityValue = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsetsDirectional.only(
                                              bottom: 25),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S.of(context).Mobile,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          width: 280,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: Row(
                                                            children: [
                                                              Flexible(
                                                                child:
                                                                    Container(
                                                                  width: 70,
                                                                  child:
                                                                      CountryCodePicker(
                                                                    textStyle:
                                                                        TextController
                                                                            .BodyText,
                                                                    alignLeft:
                                                                        true,
                                                                    showFlag:
                                                                        false,
                                                                    onChanged:
                                                                        print,
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
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  height: 35,
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child:
                                                                      TextFormField(
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0xFF070404),
                                                                    ),
                                                                    decoration: InputDecoration(
                                                                        isDense:
                                                                            true,
                                                                        hintText: S
                                                                            .of(
                                                                                context)
                                                                            .MobLabel,
                                                                        hintStyle:
                                                                            TextController
                                                                                .labelText,
                                                                        border:
                                                                            InputBorder.none),
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
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S.of(context).EMail,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          width: 280,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: TextFormField(
                                                            textAlignVertical:
                                                                TextAlignVertical
                                                                    .center,
                                                            style: TextController
                                                                .BodyHeadingText,
                                                            decoration: InputDecoration(
                                                                isDense: true,
                                                                hintText: S
                                                                    .of(context)
                                                                    .TypeHere,
                                                                hintStyle:
                                                                    TextController
                                                                        .labelText,
                                                                border:
                                                                    InputBorder
                                                                        .none),
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
                                        Container(
                                          margin: EdgeInsetsDirectional.only(
                                              bottom: 25),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Container(
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Flexible(
                                                          child: Container(
                                                            width: 80,
                                                            child: Text(
                                                              S
                                                                  .of(context)
                                                                  .ClientClassification,
                                                              style:
                                                                  TextController
                                                                      .BodyText,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          width: 280,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: DropdownButton(
                                                            value:
                                                                dropdownvalue,
                                                            isExpanded: true,
                                                            underline:
                                                                Container(),
                                                            iconEnabledColor:
                                                                ColorSelect
                                                                    .east_dark_blue,
                                                            items: items.map(
                                                              (String items) {
                                                                return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(
                                                                    'Select Here',
                                                                    style: TextController
                                                                        .BodyText,
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(
                                                                () {
                                                                  dropdownvalue =
                                                                      newValue!;
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Flexible(
                                                child: Container(
                                                  width: 500,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S
                                                              .of(context)
                                                              .ClientType,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          width: 280,
                                                          height: 35,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .textField)),
                                                          child: DropdownButton(
                                                            value:
                                                                dropdownvalue,
                                                            isExpanded: true,
                                                            underline:
                                                                Container(),
                                                            iconEnabledColor:
                                                                ColorSelect
                                                                    .east_dark_blue,
                                                            items: items.map(
                                                              (String items) {
                                                                return DropdownMenuItem(
                                                                  value: items,
                                                                  child: Text(
                                                                    'Select Here',
                                                                    style: TextController
                                                                        .BodyText,
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(
                                                                () {
                                                                  dropdownvalue =
                                                                      newValue!;
                                                                },
                                                              );
                                                            },
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
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Row(
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
                          Flexible(
                            child: Container(
                              height: 35,
                              width: 140,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              color: ColorSelect.east_blue,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  side: BorderSide(
                                    width: 1.0,
                                    color: Color(0xFFC9BBBB),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                onPressed: () {
                                  tabController?.animateTo(2);
                                },
                                child: Text(
                                  S.of(context).Next,
                                  style: TextController.btnText,
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
      ),
    );
  }
}
