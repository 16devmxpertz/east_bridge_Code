import 'dart:convert';

import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribe.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FundInvoiceSearch extends StatefulWidget {
  const FundInvoiceSearch({super.key});

  @override
  State<FundInvoiceSearch> createState() =>
      _FundInvoiceSearchsStat();
}

class _FundInvoiceSearchsStat
    extends State<FundInvoiceSearch> {
  bool isCustomerSearch = false;
  bool isFundSearch = false;

  // customer search
  TextEditingController ClientName = new TextEditingController();
  TextEditingController ClientEmail = new TextEditingController();
  TextEditingController CountryName = new TextEditingController();
  TextEditingController StateName = new TextEditingController();
  TextEditingController CityName = new TextEditingController();
  TextEditingController FromDate = new TextEditingController();
  TextEditingController ToDate = new TextEditingController();

  // fund search
  TextEditingController FundName = new TextEditingController();
  TextEditingController TotalValueFund = new TextEditingController();
  TextEditingController FundFromDate = new TextEditingController();
  TextEditingController FundToDate = new TextEditingController();

  String? ClientTypeDropdownvalue;
  String? FundIndustryDropdownvalue;
  String? FundCategoryDropdownvalue;
  String? FundStatusDropdownvalue;

  // List of items in our dropdown menu
  var ClientTypeItem = [
    'Individual',
    'Corporate',
  ];
  var FundIndustryItem = [
    'Banking & Financial Services',
    'Information Technology',
    'Engineering & Capital Goods',
    'Oil & Gas',
    'Pharmaceuticals',
    'Automotive',
    'Chemicals',
    'Utilities',
    'Metals & Mining',
    'Cement & Construction',
    'Miscellaneous',
    'Tobacco',
    'Manufacturing',
    'Telecommunication',
    'Consumer Non-durables',
    'Services',
    'Conglomerates',
    'Retail & Real Estate',
    'Food & Beverages',
    'Media & Entertainment',
    'Consumer Durables',
    'Tourism',
  ];
  var FundCategoryItem = [
    'Large Cap',
    'Medium Cap',
    'Small Cap',
  ];
  var FundStatusItem = [
    'Open Ended',
    'Closed Ended',
  ];

  List li = [];
  List key = [];
  List<bool> isChecked = [];

  Map customers = {};

  List<String> range = [];
  var dio = Dio();
  void customerSearch() async {
    var name = null;
    if (ClientName.text != "") {
      name = ClientName.text;
    }
    var email = null;
    if (ClientEmail.text != "") {
      email = ClientEmail.text;
    }
    var country = null;
    if (CountryName.text != "") {
      country = CountryName.text;
    }
    var state = null;
    if (StateName.text != "") {
      state = StateName.text;
    }
    var city = null;
    if (CityName.text != "") {
      city = CityName.text;
    }

    range.clear();
    print(FromDate.text);
    if (FromDate.text != "") {
      print("5555555555%%%%");
      range.add(FromDate.text);
    }
    if (ToDate.text != "") {
      range.add(ToDate.text);
    }

    FormData data = FormData.fromMap({
      "name": name,
      "email": email,
      "clienttype": ClientTypeDropdownvalue,
      "countryName": country,
      "state": state,
      "city": city,
      "range": range
    });
    print(range);
    var response = await dio.post(
      '${GlobalPermission.urlLink}/api/Search/CustomerSearch',
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.toString());
      setState(() {
        customers = jsonDecode(response.toString());
        li = customers.values.toList();
        key = customers.keys.toList();
      });

      print(responseData);
      print("Successful");

      // Process the responseData
    } else {
      // Request failed, handle the error

      print("Error");
      // Display or handle the error
    }
    if (li.isEmpty) {
      Navigator.of(context).pop();
      setState(
        () {
          isCustomerSearch = false;
        },
      );
    } else {
      Navigator.of(context).pop();
      setState(
        () {
          isCustomerSearch = true;
        },
      );
    }
  }

  List fli = [];
  List fkey = [];

  Map fund = {};

  List<String> frange = [];
  var dio1 = Dio();
  void fundSearch() async {
    var fundname = null;
    if (FundName.text != "") {
      fundname = FundName.text;
    }
    var total = null;
    if (TotalValueFund.text != "") {
      total = TotalValueFund.text;
    }

    frange.clear();
    print(FundFromDate.text);
    if (FundFromDate.text != "") {
      print("5555555555%%%%");
      frange.add(FundFromDate.text);
    }
    if (FundToDate.text != "") {
      frange.add(FundToDate.text);
    }

    FormData data = FormData.fromMap({
      "FundName": fundname,
      "FundCategory": FundCategoryDropdownvalue,
      "Fundindustry": FundIndustryDropdownvalue,
      "FundStatus": FundStatusDropdownvalue,
      "Totalvalue": total,
      "range": frange
    });
    print(frange);
    var response = await dio1.post(
      '${GlobalPermission.urlLink}/api/Search/FundSearch',
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.toString());
      setState(() {
        fund = jsonDecode(response.toString());
        fli = fund.values.toList();
        fkey = fund.keys.toList();
      });

      print(responseData);
      print("Successful");

      // Process the responseData
    } else {
      // Request failed, handle the error

      print("Error");
      // Display or handle the error
    }
    if (fli.isEmpty) {
      Navigator.of(context).pop();
      setState(
        () {
          isFundSearch = false;
        },
      );
    } else {
      Navigator.of(context).pop();
      setState(
        () {
          isFundSearch = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: isCustomerSearch
                          ? ColorSelect.east_grey
                          : Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            child: AlertDialog(
                              title: Text(
                                S.of(context).CustomerSearch,
                                style: TextController.BodyHeadingText,
                              ),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: double.infinity,
                                          // color: ColorSelect.east_blue,
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).ClientName,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  controller: ClientName,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).ClientType,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: DropdownButton(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value:
                                                      ClientTypeDropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: ClientTypeItem.map(
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
                                                  onChanged: (newValue) {
                                                    setState(
                                                      () {
                                                        ClientTypeDropdownvalue =
                                                            newValue;
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).Address,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S.of(context).Country,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: 200,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          controller:
                                                              CountryName,
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S.of(context).State,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 28,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: 200,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          controller: StateName,
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
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: double.infinity,
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 35,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          S.of(context).City,
                                                          style: TextController
                                                              .BodyText,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 35,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        width: 200,
                                                        height: 35,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .textField)),
                                                        child: TextFormField(
                                                          controller: CityName,
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
                                              )
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FromDate,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  controller: FromDate,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 15,
                                                      ),
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .DateFormat,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
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
                                                                DateTime(3000));
                                                    if (datepicked != null) {
                                                      print(
                                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  datepicked!);
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback((_) =>
                                                              setState((FromDate
                                                                          .text =
                                                                      formattedDate)
                                                                  as VoidCallback));
                                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                                    } else {
                                                      print(
                                                          "Date is not selected");
                                                    }
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).ToDate,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  controller: ToDate,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 15,
                                                      ),
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .DateFormat,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
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
                                                                DateTime(3000));
                                                    if (datepicked != null) {
                                                      print(
                                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  datepicked!);
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback(
                                                              (_) => setState((ToDate
                                                                          .text =
                                                                      formattedDate)
                                                                  as VoidCallback));
                                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                                    } else {
                                                      print(
                                                          "Date is not selected");
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
                                );
                              }),
                              actions: <Widget>[
                                Container(
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
                                    onPressed: () {
                                      customerSearch();

                                      // if (li.isEmpty) {
                                      // } else {
                                      //   Navigator.of(context).pop();
                                      //   setState(
                                      //     () {
                                      //       isCustomerSearch = true;
                                      //     },
                                      //   );
                                      // }
                                      // setState(() {
                                      //   isCustomerSearch = li.isNotEmpty;
                                      // });
                                    },
                                    child: Text(
                                      S.of(context).search,
                                      style: TextController.btnText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                      // setState(() {
                      //   isCustomerSearch = !isCustomerSearch;
                      //   isFundSearch = false;
                      // });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 25,
                          color: Color(0xFF565252),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).CustomerSearch,
                          style: TextController.BodyHeadingText,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
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
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          isFundSearch ? ColorSelect.east_grey : Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 200,
                            child: AlertDialog(
                              title: Text(
                                S.of(context).FundSearch,
                                style: TextController.BodyHeadingText,
                              ),
                              content: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: 200,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: double.infinity,
                                          // color: ColorSelect.east_blue,
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FundName,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  controller: FundName,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FundIndustry,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: DropdownButton(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value:
                                                      FundIndustryDropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: FundIndustryItem.map(
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
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(
                                                      () {
                                                        FundIndustryDropdownvalue =
                                                            newValue!;
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FundCategory,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: DropdownButton(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value:
                                                      FundCategoryDropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: FundCategoryItem.map(
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
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(
                                                      () {
                                                        FundCategoryDropdownvalue =
                                                            newValue!;
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FundStatus,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: DropdownButton(
                                                  hint: Text("Select Here",
                                                      style: TextController
                                                          .labelText),
                                                  value:
                                                      FundStatusDropdownvalue,
                                                  isExpanded: true,
                                                  underline: Container(),
                                                  iconEnabledColor: ColorSelect
                                                      .east_dark_blue,
                                                  items: FundStatusItem.map(
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
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(
                                                      () {
                                                        FundStatusDropdownvalue =
                                                            newValue!;
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).TotalValueOfFund,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  controller: TotalValueFund,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .TypeHere,
                                                      hintStyle: TextController
                                                          .labelText,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).FromDate,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  controller: FundFromDate,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 15,
                                                      ),
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .DateFormat,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
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
                                                                DateTime(3000));
                                                    if (datepicked != null) {
                                                      print(
                                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  datepicked!);
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback((_) =>
                                                              setState((FundFromDate
                                                                          .text =
                                                                      formattedDate)
                                                                  as VoidCallback));
                                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                                    } else {
                                                      print(
                                                          "Date is not selected");
                                                    }
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                S.of(context).ToDate,
                                                style: TextController
                                                    .BodyHeadingText,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
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
                                                child: TextFormField(
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  style: TextController
                                                      .BodyHeadingText,
                                                  controller: FundToDate,
                                                  decoration: InputDecoration(
                                                      suffixIcon: Icon(
                                                        Icons
                                                            .calendar_month_outlined,
                                                        size: 15,
                                                      ),
                                                      isDense: true,
                                                      hintText: S
                                                          .of(context)
                                                          .DateFormat,
                                                      hintStyle: TextController
                                                          .labelText,
                                                      border: InputBorder.none),
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
                                                                DateTime(3000));
                                                    if (datepicked != null) {
                                                      print(
                                                          datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                      String formattedDate =
                                                          DateFormat(
                                                                  'yyyy-MM-dd')
                                                              .format(
                                                                  datepicked!);
                                                      WidgetsBinding.instance
                                                          .addPostFrameCallback((_) =>
                                                              setState((FundToDate
                                                                          .text =
                                                                      formattedDate)
                                                                  as VoidCallback));
                                                      // format date in required form here we use yyyy-MM-dd that means time is remove
                                                    } else {
                                                      print(
                                                          "Date is not selected");
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
                                );
                              }),
                              actions: <Widget>[
                                Container(
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
                                    onPressed: () {
                                      fundSearch();

                                      // if (fli.isEmpty) {
                                      // } else {
                                      //   Navigator.of(context).pop();
                                      //   setState(
                                      //     () {
                                      //       isFundSearch = true;
                                      //     },
                                      //   );
                                      // }
                                      // setState(() {
                                      //   isCustomerSearch = li.isNotEmpty;
                                      // });
                                    },
                                    child: Text(
                                      S.of(context).search,
                                      style: TextController.btnText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );

                      // setState(() {
                      //   isFundSearch = !isFundSearch;
                      //   isCustomerSearch = false;
                      // });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt_outlined,
                          size: 25,
                          color: Color(0xFF565252),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).FundSearch,
                          style: TextController.BodyHeadingText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          //custoer search
          if (isCustomerSearch)
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: ColorSelect.tabBorderColor))),
              child: Column(
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //   margin: EdgeInsets.symmetric(vertical: 5),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).ClientName,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   controller: ClientName,
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   decoration: InputDecoration(
                  //                       isDense: true,
                  //                       hintText: S.of(context).TypeHere,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).ClientType,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: DropdownButton(
                  //                   hint: Text("Select Here",
                  //                       style: TextController.labelText),
                  //                   value: ClientTypeDropdownvalue,
                  //                   isExpanded: true,
                  //                   underline: Container(),
                  //                   iconEnabledColor:
                  //                       ColorSelect.east_dark_blue,
                  //                   items: ClientTypeItem.map(
                  //                     (String items) {
                  //                       return DropdownMenuItem(
                  //                         value: items,
                  //                         child: Text(
                  //                           items,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       );
                  //                     },
                  //                   ).toList(),
                  //                   onChanged: (newValue) {
                  //                     setState(
                  //                       () {
                  //                         ClientTypeDropdownvalue = newValue;
                  //                       },
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).Address,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       height: 35,
                  //                       child: Align(
                  //                         alignment: Alignment.centerLeft,
                  //                         child: Text(
                  //                           S.of(context).Country,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 10,
                  //                     ),
                  //                     Flexible(
                  //                       child: Container(
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: 10),
                  //                         width: 200,
                  //                         height: 35,
                  //                         alignment: Alignment.centerLeft,
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             border: Border.all(
                  //                                 color:
                  //                                     ColorSelect.textField)),
                  //                         child: TextFormField(
                  //                           controller: CountryName,
                  //                           textAlignVertical:
                  //                               TextAlignVertical.center,
                  //                           style:
                  //                               TextController.BodyHeadingText,
                  //                           decoration: InputDecoration(
                  //                               isDense: true,
                  //                               hintText:
                  //                                   S.of(context).TypeHere,
                  //                               hintStyle:
                  //                                   TextController.labelText,
                  //                               border: InputBorder.none),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Container(
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       height: 35,
                  //                       child: Align(
                  //                         alignment: Alignment.centerLeft,
                  //                         child: Text(
                  //                           S.of(context).State,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 28,
                  //                     ),
                  //                     Flexible(
                  //                       child: Container(
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: 10),
                  //                         width: 200,
                  //                         height: 35,
                  //                         alignment: Alignment.centerLeft,
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             border: Border.all(
                  //                                 color:
                  //                                     ColorSelect.textField)),
                  //                         child: TextFormField(
                  //                           controller: StateName,
                  //                           textAlignVertical:
                  //                               TextAlignVertical.center,
                  //                           style:
                  //                               TextController.BodyHeadingText,
                  //                           decoration: InputDecoration(
                  //                               isDense: true,
                  //                               hintText:
                  //                                   S.of(context).TypeHere,
                  //                               hintStyle:
                  //                                   TextController.labelText,
                  //                               border: InputBorder.none),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               Container(
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 child: Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       height: 35,
                  //                       child: Align(
                  //                         alignment: Alignment.centerLeft,
                  //                         child: Text(
                  //                           S.of(context).City,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       width: 35,
                  //                     ),
                  //                     Flexible(
                  //                       child: Container(
                  //                         padding: EdgeInsets.symmetric(
                  //                             horizontal: 10),
                  //                         width: 200,
                  //                         height: 35,
                  //                         alignment: Alignment.centerLeft,
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             border: Border.all(
                  //                                 color:
                  //                                     ColorSelect.textField)),
                  //                         child: TextFormField(
                  //                           controller: CityName,
                  //                           textAlignVertical:
                  //                               TextAlignVertical.center,
                  //                           style:
                  //                               TextController.BodyHeadingText,
                  //                           decoration: InputDecoration(
                  //                               isDense: true,
                  //                               hintText:
                  //                                   S.of(context).TypeHere,
                  //                               hintStyle:
                  //                                   TextController.labelText,
                  //                               border: InputBorder.none),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FromDate,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   controller: FromDate,
                  //                   decoration: InputDecoration(
                  //                       suffixIcon: Icon(
                  //                         Icons.calendar_month_outlined,
                  //                         size: 15,
                  //                       ),
                  //                       isDense: true,
                  //                       hintText: S.of(context).DateFormat,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                   //readOnly: true,
                  //                   onTap: () async {
                  //                     DateTime? datepicked =
                  //                         await showDatePicker(
                  //                             context: context,
                  //                             initialDate: DateTime.now(),
                  //                             firstDate: DateTime(2023),
                  //                             lastDate: DateTime(3000));
                  //                     if (datepicked != null) {
                  //                       print(
                  //                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                  //                       String formattedDate =
                  //                           DateFormat('yyyy-MM-dd')
                  //                               .format(datepicked!);
                  //                       WidgetsBinding.instance
                  //                           .addPostFrameCallback((_) =>
                  //                               setState((FromDate.text =
                  //                                       formattedDate)
                  //                                   as VoidCallback));
                  //                       // format date in required form here we use yyyy-MM-dd that means time is remove
                  //                     } else {
                  //                       print("Date is not selected");
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).ToDate,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   controller: ToDate,
                  //                   decoration: InputDecoration(
                  //                       suffixIcon: Icon(
                  //                         Icons.calendar_month_outlined,
                  //                         size: 15,
                  //                       ),
                  //                       isDense: true,
                  //                       hintText: S.of(context).DateFormat,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                   //readOnly: true,
                  //                   onTap: () async {
                  //                     DateTime? datepicked =
                  //                         await showDatePicker(
                  //                             context: context,
                  //                             initialDate: DateTime.now(),
                  //                             firstDate: DateTime(2023),
                  //                             lastDate: DateTime(3000));
                  //                     if (datepicked != null) {
                  //                       print(
                  //                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                  //                       String formattedDate =
                  //                           DateFormat('yyyy-MM-dd')
                  //                               .format(datepicked!);
                  //                       WidgetsBinding.instance
                  //                           .addPostFrameCallback((_) =>
                  //                               setState((ToDate.text =
                  //                                       formattedDate)
                  //                                   as VoidCallback));
                  //                       // format date in required form here we use yyyy-MM-dd that means time is remove
                  //                     } else {
                  //                       print("Date is not selected");
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Flexible(
                  //       child: Container(
                  //         height: 35,
                  //         width: 140,
                  //         margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  //         color: ColorSelect.east_blue,
                  //         child: TextButton(
                  //           style: TextButton.styleFrom(
                  //             side: BorderSide(
                  //               width: 1.0,
                  //               color: Color(0xFFC9BBBB),
                  //             ),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(0),
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             customerSearch();
                  //           },
                  //           child: Text(
                  //             S.of(context).search,
                  //             style: TextController.btnText,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 50,
                  // ),

                  Container(
                    width: 1000,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Table(
                      border:
                          TableBorder.all(color: ColorSelect.tabBorderColor),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        // 1: FlexColumnWidth(1)
                        // 0: FixedColumnWidth(500),
                        // 1: FixedColumnWidth(500)
                      },
                      children: [
                        TableRow(children: [
                          Container(
                              height: 50,
                              color: ColorSelect.east_grey,
                              child: Center(
                                  child: Text(
                                S.of(context).ClientName,
                                style: TextController.tableHeading,
                              ))),
                          // Container(
                          //     height: 50,
                          //     color: ColorSelect.east_grey,
                          //     child: Center(
                          //         child: Text(
                          //       S.of(context).ClientId,
                          //       style: TextController.tableHeading,
                          //     ))),
                        ]),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: li.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                // FundInvoiceMain.name.value = li[index];
                                // FundInvoiceMain.clientid.value =
                                //     int.parse(key[index]);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => new FundInvoiceMain()),
                                   // );
                                setState(
                                  () {
                                    isCustomerSearch = false;
                                  },
                                );
                              },
                              child: table(li[index], key[index], context));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

          //fund search
          if (isFundSearch)
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: ColorSelect.tabBorderColor))),
              child: Column(
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  //   margin: EdgeInsets.symmetric(vertical: 5),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FundName,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   controller: FundName,
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   decoration: InputDecoration(
                  //                       isDense: true,
                  //                       hintText: S.of(context).TypeHere,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FundIndustry,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: DropdownButton(
                  //                   hint: Text("Select Here",
                  //                       style: TextController.labelText),
                  //                   value: FundIndustryDropdownvalue,
                  //                   isExpanded: true,
                  //                   underline: Container(),
                  //                   iconEnabledColor:
                  //                       ColorSelect.east_dark_blue,
                  //                   items: FundIndustryItem.map(
                  //                     (String items) {
                  //                       return DropdownMenuItem(
                  //                         value: items,
                  //                         child: Text(
                  //                           items,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       );
                  //                     },
                  //                   ).toList(),
                  //                   onChanged: (String? newValue) {
                  //                     setState(
                  //                       () {
                  //                         FundIndustryDropdownvalue = newValue!;
                  //                       },
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FundCategory,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: DropdownButton(
                  //                   hint: Text("Select Here",
                  //                       style: TextController.labelText),
                  //                   value: FundCategoryDropdownvalue,
                  //                   isExpanded: true,
                  //                   underline: Container(),
                  //                   iconEnabledColor:
                  //                       ColorSelect.east_dark_blue,
                  //                   items: FundCategoryItem.map(
                  //                     (String items) {
                  //                       return DropdownMenuItem(
                  //                         value: items,
                  //                         child: Text(
                  //                           items,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       );
                  //                     },
                  //                   ).toList(),
                  //                   onChanged: (String? newValue) {
                  //                     setState(
                  //                       () {
                  //                         FundCategoryDropdownvalue = newValue!;
                  //                       },
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FundStatus,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: DropdownButton(
                  //                   hint: Text("Select Here",
                  //                       style: TextController.labelText),
                  //                   value: FundStatusDropdownvalue,
                  //                   isExpanded: true,
                  //                   underline: Container(),
                  //                   iconEnabledColor:
                  //                       ColorSelect.east_dark_blue,
                  //                   items: FundStatusItem.map(
                  //                     (String items) {
                  //                       return DropdownMenuItem(
                  //                         value: items,
                  //                         child: Text(
                  //                           items,
                  //                           style: TextController.BodyText,
                  //                         ),
                  //                       );
                  //                     },
                  //                   ).toList(),
                  //                   onChanged: (String? newValue) {
                  //                     setState(
                  //                       () {
                  //                         FundStatusDropdownvalue = newValue!;
                  //                       },
                  //                     );
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).TotalValueOfFund,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   controller: TotalValueFund,
                  //                   keyboardType: TextInputType.number,
                  //                   inputFormatters: <TextInputFormatter>[
                  //                     FilteringTextInputFormatter.digitsOnly
                  //                   ],
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   decoration: InputDecoration(
                  //                       isDense: true,
                  //                       hintText: S.of(context).TypeHere,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).FromDate,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   controller: FundFromDate,
                  //                   decoration: InputDecoration(
                  //                       suffixIcon: Icon(
                  //                         Icons.calendar_month_outlined,
                  //                         size: 15,
                  //                       ),
                  //                       isDense: true,
                  //                       hintText: S.of(context).DateFormat,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                   //readOnly: true,
                  //                   onTap: () async {
                  //                     DateTime? datepicked =
                  //                         await showDatePicker(
                  //                             context: context,
                  //                             initialDate: DateTime.now(),
                  //                             firstDate: DateTime(2023),
                  //                             lastDate: DateTime(3000));
                  //                     if (datepicked != null) {
                  //                       print(
                  //                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                  //                       String formattedDate =
                  //                           DateFormat('yyyy-MM-dd')
                  //                               .format(datepicked!);
                  //                       WidgetsBinding.instance
                  //                           .addPostFrameCallback((_) =>
                  //                               setState((FundFromDate.text =
                  //                                       formattedDate)
                  //                                   as VoidCallback));
                  //                       // format date in required form here we use yyyy-MM-dd that means time is remove
                  //                     } else {
                  //                       print("Date is not selected");
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Container(
                  //           width: double.infinity,
                  //           // color: ColorSelect.east_blue,
                  //           padding: EdgeInsets.all(10),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 S.of(context).ToDate,
                  //                 style: TextController.BodyHeadingText,
                  //               ),
                  //               SizedBox(
                  //                 height: 15,
                  //               ),
                  //               Container(
                  //                 padding: EdgeInsets.symmetric(horizontal: 10),
                  //                 width: double.infinity,
                  //                 height: 35,
                  //                 alignment: Alignment.centerLeft,
                  //                 decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     border: Border.all(
                  //                         color: ColorSelect.textField)),
                  //                 child: TextFormField(
                  //                   textAlignVertical: TextAlignVertical.center,
                  //                   style: TextController.BodyHeadingText,
                  //                   controller: FundToDate,
                  //                   decoration: InputDecoration(
                  //                       suffixIcon: Icon(
                  //                         Icons.calendar_month_outlined,
                  //                         size: 15,
                  //                       ),
                  //                       isDense: true,
                  //                       hintText: S.of(context).DateFormat,
                  //                       hintStyle: TextController.labelText,
                  //                       border: InputBorder.none),
                  //                   //readOnly: true,
                  //                   onTap: () async {
                  //                     DateTime? datepicked =
                  //                         await showDatePicker(
                  //                             context: context,
                  //                             initialDate: DateTime.now(),
                  //                             firstDate: DateTime(2023),
                  //                             lastDate: DateTime(3000));
                  //                     if (datepicked != null) {
                  //                       print(
                  //                           datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                  //                       String formattedDate =
                  //                           DateFormat('yyyy-MM-dd')
                  //                               .format(datepicked!);
                  //                       WidgetsBinding.instance
                  //                           .addPostFrameCallback((_) =>
                  //                               setState((FundToDate.text =
                  //                                       formattedDate)
                  //                                   as VoidCallback));
                  //                       // format date in required form here we use yyyy-MM-dd that means time is remove
                  //                     } else {
                  //                       print("Date is not selected");
                  //                     }
                  //                   },
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Flexible(
                  //       child: Container(
                  //         height: 35,
                  //         width: 140,
                  //         margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  //         color: ColorSelect.east_blue,
                  //         child: TextButton(
                  //           style: TextButton.styleFrom(
                  //             side: BorderSide(
                  //               width: 1.0,
                  //               color: Color(0xFFC9BBBB),
                  //             ),
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(0),
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             fundSearch();
                  //           },
                  //           child: Text(
                  //             S.of(context).search,
                  //             style: TextController.btnText,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  if (fli.isNotEmpty)
                    Container(
                      width: 1000,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          // 1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          TableRow(children: [
                            Container(
                                height: 50,
                                color: ColorSelect.east_grey,
                                child: Center(
                                    child: Text(
                                  S.of(context).FundName,
                                  style: TextController.tableHeading,
                                ))),
                            // Container(
                            //     height: 50,
                            //     color: ColorSelect.east_grey,
                            //     child: Center(
                            //         child: Text(
                            //       "Fund Id",
                            //       style: TextController.tableHeading,
                            //     ))),
                          ]),
                        ],
                      ),
                    ),
                  SingleChildScrollView(
                    child: Container(
                      // height: 300,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: fli.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                //  ClientFundAgreementSearch.id.value=int.parse(key[index]);
                                //  customerGetAgreement.id.value=int.parse(key[index]);
                                final split = fli[index].split('~');
                                // print(split);
                               // FundInvoiceMain.fundname.value = split[0];
                                // FundSubscribe.persharevalue.value = split[1];

                                // double d = double.parse(split[1]);

                                // String formattedAmount =
                                //     ThousandsSeparatorInputFormatter()
                                //         .formatEditUpdate(
                                //           TextEditingValue(),
                                //           TextEditingValue(
                                //               text: d.toStringAsFixed(
                                //                   2)), // Format with two decimal places
                                //         )
                                //         .text;
                                

                                // FundInvoiceMain.fundid.value =
                                //     int.parse(fkey[index]);

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => new FundInvoiceMain()));
                                setState(
                                  () {
                                    isFundSearch = false;
                                  },
                                );
                              },
                              child: table(fli[index], fkey[index], context));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget table(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            width: 1000,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Table(
              border: TableBorder.all(color: ColorSelect.tabBorderColor),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1)
                // 0: FixedColumnWidth(500),
                // 1: FixedColumnWidth(500)
              },
              children: [
                TableRow(children: [
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        templateName.split("~")[0],
                        style: TextController.BodyText,
                      ))),
                  // Container(
                  //     height: 50,
                  //     child: Center(
                  //         child: Text(
                  //       templateKeys,
                  //       style: TextController.BodyText,
                  //     ))),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
