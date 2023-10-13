import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FundDetailsA extends StatefulWidget {
FundDetailsA({@required controller}) {
    tabController = controller;
  }

  @override
  State<FundDetailsA> createState() => _FundDetailsAState();
}

TabController? tabController;

class _FundDetailsAState extends State<FundDetailsA> {
  TextEditingController dateOfIssuance = new TextEditingController();
  TextEditingController dateOfNotifyig = new TextEditingController();
  TextEditingController dateOfTC = new TextEditingController();
  TextEditingController dateOfFundEstablishment = new TextEditingController();
  TextEditingController dateOfClosingFund = new TextEditingController();
  TextEditingController closingDate = new TextEditingController();
  TextEditingController fundTermDate = new TextEditingController();

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
                  S.of(context).FundDetails,
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
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).DateofIssuanceofTCofFund,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: dateOfIssuance,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState(
                                                        (dateOfIssuance.text =
                                                                formattedDate)
                                                            as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Container(
                                        width: 300,
                                        child: Text(
                                          S.of(context).TheDateOfNotifying,
                                          style: TextController.BodyText,
                                        ),
                                      ),
                                    ),
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
                                        controller: dateOfNotifyig,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState(
                                                        (dateOfNotifyig.text =
                                                                formattedDate)
                                                            as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).TheDateTCWereLastUpdate,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: dateOfTC,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState((dateOfTC.text =
                                                            formattedDate)
                                                        as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).FundEstablishmentDate,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: dateOfFundEstablishment,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState(
                                                        (dateOfFundEstablishment
                                                                    .text =
                                                                formattedDate)
                                                            as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).FundFirstClosingDate,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: dateOfClosingFund,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState((dateOfClosingFund
                                                                .text =
                                                            formattedDate)
                                                        as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                      ),
                                    ),
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).ClosingDate,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: closingDate,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState((closingDate.text =
                                                            formattedDate)
                                                        as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
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
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).FundManagerHeadquaters,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Flexible(
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Flexible(
                                      child: Text(
                                        S.of(context).FundTermDate,
                                        style: TextController.BodyText,
                                      ),
                                    ),
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
                                        controller: fundTermDate,
                                        decoration: InputDecoration(
                                            suffixIcon: Icon(
                                              Icons.calendar_month_outlined,
                                              size: 15,
                                            ),
                                            isDense: true,
                                            hintText: S.of(context).DateFormat,
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none),
                                        //readOnly: true,
                                        onTap: () async {
                                          DateTime? datepicked =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2023),
                                                  lastDate: DateTime(3000));
                                          if (datepicked != null) {
                                            print(
                                                datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                            String formattedDate =
                                                DateFormat('dd-MM-yyyy')
                                                    .format(datepicked!);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) =>
                                                    setState(
                                                        (fundTermDate.text =
                                                                formattedDate)
                                                            as VoidCallback));
                                            // format date in required form here we use yyyy-MM-dd that means time is remove
                                          } else {
                                            print("Date is not selected");
                                          }
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
                                  tabController?.animateTo(1);
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
                                  tabController?.animateTo(3);
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
