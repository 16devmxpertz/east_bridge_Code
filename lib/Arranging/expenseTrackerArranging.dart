import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/ClientFundAgreementSearch.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/Customer%20Fund%20Components/CustomerAgreementTemplate.dart';
import 'package:http/http.dart' as http;
import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker/model/select_status_model.dart';
import 'package:east_bridge/Agreement%20Masters/CustomerGetAgreement.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ExpenseTrackerArranging extends StatefulWidget {
  const ExpenseTrackerArranging({super.key, TabController? controller});

  @override
  State<ExpenseTrackerArranging> createState() => _ExpenseTrackerArrangingsStat();
}

class _ExpenseTrackerArrangingsStat extends State<ExpenseTrackerArranging> {
  bool isCustomerSearch = true;

  List li = [];
  List key = [];
  List<bool> isChecked = [];

  Map customers = {};

  @override
  void initState() {
    super.initState();
    //fetchData();
  }

  // customer search
  TextEditingController expenseName = new TextEditingController();
  TextEditingController expenseAmt = new TextEditingController();
  TextEditingController ExpenseDate = new TextEditingController();
  TextEditingController expenseDescription = new TextEditingController();

  List<String> range = [];

  String? ExpenseCatagDropdownvalue;

  var ExpenseCatag = [
    "Travel Expenses",
    "Transportation",
    "Meals and Entertainment",
    "Office Supplies",
    "Communication Expenses",
    "Training and Professional Development",
    "Business Meals and Hospitality",
    "Conferences and Events",
    "Subscriptions and Memberships",
    "Business-related Accommodation",
    "Miscellaneous Expenses",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: ColorSelect.tabBorderColor),
                bottom: BorderSide(width: 1, color: ColorSelect.tabBorderColor),
              ),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(),
                  decoration: BoxDecoration(
                    // color: isCustomerSearch
                    //     ? ColorSelect.east_blue
                    //     : ColorSelect.east_grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: Text(
                    S.of(context).expenseTracker,
                    style: TextController.MainHeadingText,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: ColorSelect.tabBorderColor))),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          // color: ColorSelect.east_blue,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).expenseName,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: expenseName,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyHeadingText,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          // color: ColorSelect.east_blue,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).expensecategory,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
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
                                  value: ExpenseCatagDropdownvalue,
                                  isExpanded: true,
                                  underline: Container(),
                                  iconEnabledColor: ColorSelect.east_dark_blue,
                                  items: ExpenseCatag.map(
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
                                        ExpenseCatagDropdownvalue = newValue;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          // color: ColorSelect.east_blue,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).expenseAmt,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  controller: expenseAmt,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyHeadingText,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).TypeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          // color: ColorSelect.east_blue,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).Date,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyHeadingText,
                                  controller: ExpenseDate,
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
                                    DateTime? datepicked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2023),
                                        lastDate: DateTime(3000));
                                    if (datepicked != null) {
                                      print(
                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(datepicked!);
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) => setState(
                                              (ExpenseDate.text = formattedDate)
                                                  as VoidCallback));
                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          width: double.infinity,
                          // color: ColorSelect.east_blue,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).expenseDescription,
                                style: TextController.BodyHeadingText,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: double.infinity,
                                height: 100,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField)),
                                child: TextFormField(
                                  maxLines: null,
                                  controller: expenseDescription,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextController.BodyHeadingText,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      hintText: S.of(context).descibeHere,
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        height: 35,
                        width: 140,
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
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
                          onPressed: () {},
                          child: Text(
                            S.of(context).Next,
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
        ],
      ),
    );
  }
}
