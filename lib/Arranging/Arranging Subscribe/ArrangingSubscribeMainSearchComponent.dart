import 'dart:convert';
import 'package:csc_picker/csc_picker.dart';
import 'package:dio/dio.dart';
import 'package:east_bridge/Arranging/Arranging%20Subscribe/ArrangingSubscribe.dart';
import 'package:east_bridge/Fund%20Subscribe/FundSubscribe.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ArrangingSubscribeMainSearchComponent extends StatefulWidget {
  const ArrangingSubscribeMainSearchComponent({super.key});

  @override
  State<ArrangingSubscribeMainSearchComponent> createState() =>
      _ArrangingSubscribeMainSearchComponentsStat();
}

class _ArrangingSubscribeMainSearchComponentsStat
    extends State<ArrangingSubscribeMainSearchComponent> {
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

  // Arranging search
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
      'https://eastbridge.online/apicore/api/Search/CustomerSearch',
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
  }

  //

  void GetServices() async {
    print("Tannu");
    var response = await dio.get(
      'https://eastbridge.online/apicore/api/ArrangingAgreementTemplate/getTemplateNames',
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.toString());
      setState(() {
        fund = jsonDecode(response.toString());
        fkey.clear();
        fli.clear();
        ftotalvalue.clear();
        fduration.clear();
        fkey = fund.keys.toList();
        fli = fund.values.toList();

        fli.forEach((i) {
          print(i);
          ftotalvalue.add(int.parse(i.split('-')[1]));
          fduration.add(int.parse(i.split('-')[2]));
        });
      });

      print(fli);
      print(fkey);
      print(ftotalvalue);
      print(fduration);
      print("Successful");

      // Process the responseData
    } else {
      // Request failed, handle the error

      print("Error");
      // Display or handle the error
    }
  }

  List values = [];
  List fli = [];
  List fkey = [];
  List ftotalvalue = [];
  List fduration = [];

  Map fund = {};

  List<String> frange = [];
  var dio1 = Dio();
  void ArrangingSearch() async {
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
      'https://eastbridge.online/apicore/api/Search/FundSearch',
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
  }

  @override
  void initState() {
    super.initState();
    GetServices();
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
                              content: Container(
                                height: 200,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    hintText:
                                                        S.of(context).TypeHere,
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
                                                value: ClientTypeDropdownvalue,
                                                isExpanded: true,
                                                underline: Container(),
                                                iconEnabledColor:
                                                    ColorSelect.east_dark_blue,
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
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 200,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorSelect
                                                                  .textField)),
                                                      child: TextFormField(
                                                        controller: CountryName,
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
                                                            border: InputBorder
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
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 200,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                            border: InputBorder
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
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      width: 200,
                                                      height: 35,
                                                      alignment:
                                                          Alignment.centerLeft,
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
                                                            border: InputBorder
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
                                                        DateFormat('yyyy-MM-dd')
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
                                                        DateFormat('yyyy-MM-dd')
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
                              ),
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
                                      //   Navigator.of(context).pop();
                                      //   setState(
                                      //     () {
                                      //       isCustomerSearch = false;
                                      //     },
                                      //   );
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
                      setState(() {
                        isFundSearch = !isFundSearch;
                        isCustomerSearch = false;
                      });
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
                          S.of(context).ServiceSearch,
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

                  SingleChildScrollView(
                    child: Container(
                      height: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: li.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                //  ClientFundAgreementSearch.id.value=int.parse(key[index]);
                                //  customerGetAgreement.id.value=int.parse(key[index]);
                                //  tabController!.animateTo(1);
                                // ArrangingSubscribe.name.value = li[index];
                                // ArrangingSubscribe.clientid.value =
                                int.parse(key[index]);
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         new ArrangingSubscribe()));
                              },
                              child: card(li[index], key[index], context));
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Flexible(
                        //   child: Container(
                        //     width: double.infinity,
                        //     // color: ColorSelect.east_blue,
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           S.of(context).ServiceName,
                        //           style: TextController.BodyHeadingText,
                        //         ),
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           width: double.infinity,
                        //           height: 35,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               border: Border.all(
                        //                   color: ColorSelect.textField)),
                        //           child: TextFormField(
                        //             controller: FundName,
                        //             textAlignVertical: TextAlignVertical.center,
                        //             style: TextController.BodyHeadingText,
                        //             decoration: InputDecoration(
                        //                 isDense: true,
                        //                 hintText: S.of(context).TypeHere,
                        //                 hintStyle: TextController.labelText,
                        //                 border: InputBorder.none),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     width: double.infinity,
                        //     // color: ColorSelect.east_blue,
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           S.of(context).ServiceIndustry,
                        //           style: TextController.BodyHeadingText,
                        //         ),
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           width: double.infinity,
                        //           height: 35,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               border: Border.all(
                        //                   color: ColorSelect.textField)),
                        //           child: DropdownButton(
                        //             hint: Text("Select Here",
                        //                 style: TextController.labelText),
                        //             value: FundIndustryDropdownvalue,
                        //             isExpanded: true,
                        //             underline: Container(),
                        //             iconEnabledColor:
                        //                 ColorSelect.east_dark_blue,
                        //             items: FundIndustryItem.map(
                        //               (String items) {
                        //                 return DropdownMenuItem(
                        //                   value: items,
                        //                   child: Text(
                        //                     items,
                        //                     style: TextController.BodyText,
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList(),
                        //             onChanged: (String? newValue) {
                        //               setState(
                        //                 () {
                        //                   FundIndustryDropdownvalue = newValue!;
                        //                 },
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     width: double.infinity,
                        //     // color: ColorSelect.east_blue,
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           S.of(context).ServiceCatogory,
                        //           style: TextController.BodyHeadingText,
                        //         ),
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           width: double.infinity,
                        //           height: 35,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               border: Border.all(
                        //                   color: ColorSelect.textField)),
                        //           child: DropdownButton(
                        //             hint: Text("Select Here",
                        //                 style: TextController.labelText),
                        //             value: FundCategoryDropdownvalue,
                        //             isExpanded: true,
                        //             underline: Container(),
                        //             iconEnabledColor:
                        //                 ColorSelect.east_dark_blue,
                        //             items: FundCategoryItem.map(
                        //               (String items) {
                        //                 return DropdownMenuItem(
                        //                   value: items,
                        //                   child: Text(
                        //                     items,
                        //                     style: TextController.BodyText,
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList(),
                        //             onChanged: (String? newValue) {
                        //               setState(
                        //                 () {
                        //                   FundCategoryDropdownvalue = newValue!;
                        //                 },
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     width: double.infinity,
                        //     // color: ColorSelect.east_blue,
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           S.of(context).ServiceStatus,
                        //           style: TextController.BodyHeadingText,
                        //         ),
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           width: double.infinity,
                        //           height: 35,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               border: Border.all(
                        //                   color: ColorSelect.textField)),
                        //           child: DropdownButton(
                        //             hint: Text("Select Here",
                        //                 style: TextController.labelText),
                        //             value: FundStatusDropdownvalue,
                        //             isExpanded: true,
                        //             underline: Container(),
                        //             iconEnabledColor:
                        //                 ColorSelect.east_dark_blue,
                        //             items: FundStatusItem.map(
                        //               (String items) {
                        //                 return DropdownMenuItem(
                        //                   value: items,
                        //                   child: Text(
                        //                     items,
                        //                     style: TextController.BodyText,
                        //                   ),
                        //                 );
                        //               },
                        //             ).toList(),
                        //             onChanged: (String? newValue) {
                        //               setState(
                        //                 () {
                        //                   FundStatusDropdownvalue = newValue!;
                        //                 },
                        //               );
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // // Flexible(
                        // //   child: Container(
                        // //     width: double.infinity,
                        // //     // color: ColorSelect.east_blue,
                        // //     padding: EdgeInsets.all(10),
                        // //     child: Column(
                        // //       crossAxisAlignment: CrossAxisAlignment.start,
                        // //       children: [
                        // //         Text(
                        // //           S.of(context).TotalValueOfService,
                        // //           style: TextController.BodyHeadingText,
                        // //         ),
                        // //         SizedBox(
                        // //           height: 15,
                        // //         ),
                        // //         Container(
                        // //           padding: EdgeInsets.symmetric(horizontal: 10),
                        // //           width: double.infinity,
                        // //           height: 35,
                        // //           alignment: Alignment.centerLeft,
                        // //           decoration: BoxDecoration(
                        // //               color: Colors.white,
                        // //               border: Border.all(
                        // //                   color: ColorSelect.textField)),
                        // //           child: TextFormField(
                        // //             controller: TotalValueFund,
                        // //             keyboardType: TextInputType.number,
                        // //             inputFormatters: <TextInputFormatter>[
                        // //               FilteringTextInputFormatter.digitsOnly
                        // //             ],
                        // //             textAlignVertical: TextAlignVertical.center,
                        // //             style: TextController.BodyHeadingText,
                        // //             decoration: InputDecoration(
                        // //                 isDense: true,
                        // //                 hintText: S.of(context).TypeHere,
                        // //                 hintStyle: TextController.labelText,
                        // //                 border: InputBorder.none),
                        // //           ),
                        // //         ),
                        // //       ],
                        // //     ),
                        // //   ),
                        // // ),
                        // // Flexible(
                        // //   child: Container(
                        // //     width: double.infinity,
                        // //     // color: ColorSelect.east_blue,
                        // //     padding: EdgeInsets.all(10),
                        // //     child: Column(
                        // //       crossAxisAlignment: CrossAxisAlignment.start,
                        // //       children: [
                        // //         Text(
                        // //           S.of(context).FromDate,
                        // //           style: TextController.BodyHeadingText,
                        // //         ),
                        // //         SizedBox(
                        // //           height: 15,
                        // //         ),
                        // //         Container(
                        // //           padding: EdgeInsets.symmetric(horizontal: 10),
                        // //           width: double.infinity,
                        // //           height: 35,
                        // //           alignment: Alignment.centerLeft,
                        // //           decoration: BoxDecoration(
                        // //               color: Colors.white,
                        // //               border: Border.all(
                        // //                   color: ColorSelect.textField)),
                        // //           child: TextFormField(
                        // //             textAlignVertical: TextAlignVertical.center,
                        // //             style: TextController.BodyHeadingText,
                        // //             controller: FundFromDate,
                        // //             decoration: InputDecoration(
                        // //                 suffixIcon: Icon(
                        // //                   Icons.calendar_month_outlined,
                        // //                   size: 15,
                        // //                 ),
                        // //                 isDense: true,
                        // //                 hintText: S.of(context).DateFormat,
                        // //                 hintStyle: TextController.labelText,
                        // //                 border: InputBorder.none),
                        // //             //readOnly: true,
                        // //             onTap: () async {
                        // //               DateTime? datepicked =
                        // //                   await showDatePicker(
                        // //                       context: context,
                        // //                       initialDate: DateTime.now(),
                        // //                       firstDate: DateTime(2023),
                        // //                       lastDate: DateTime(3000));
                        // //               if (datepicked != null) {
                        // //                 print(
                        // //                     datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                        // //                 String formattedDate =
                        // //                     DateFormat('yyyy-MM-dd')
                        // //                         .format(datepicked!);
                        // //                 WidgetsBinding.instance
                        // //                     .addPostFrameCallback((_) =>
                        // //                         setState((FundFromDate.text =
                        // //                                 formattedDate)
                        // //                             as VoidCallback));
                        // //                 // format date in required form here we use yyyy-MM-dd that means time is remove
                        // //               } else {
                        // //                 print("Date is not selected");
                        // //               }
                        // //             },
                        // //           ),
                        // //         ),
                        // //       ],
                        // //     ),
                        // //   ),
                        // ),
                        // Flexible(
                        //   child: Container(
                        //     width: double.infinity,
                        //     // color: ColorSelect.east_blue,
                        //     padding: EdgeInsets.all(10),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           S.of(context).ToDate,
                        //           style: TextController.BodyHeadingText,
                        //         ),
                        //         SizedBox(
                        //           height: 15,
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.symmetric(horizontal: 10),
                        //           width: double.infinity,
                        //           height: 35,
                        //           alignment: Alignment.centerLeft,
                        //           decoration: BoxDecoration(
                        //               color: Colors.white,
                        //               border: Border.all(
                        //                   color: ColorSelect.textField)),
                        //           child: TextFormField(
                        //             textAlignVertical: TextAlignVertical.center,
                        //             style: TextController.BodyHeadingText,
                        //             controller: FundToDate,
                        //             decoration: InputDecoration(
                        //                 suffixIcon: Icon(
                        //                   Icons.calendar_month_outlined,
                        //                   size: 15,
                        //                 ),
                        //                 isDense: true,
                        //                 hintText: S.of(context).DateFormat,
                        //                 hintStyle: TextController.labelText,
                        //                 border: InputBorder.none),
                        //             //readOnly: true,
                        //             onTap: () async {
                        //               DateTime? datepicked =
                        //                   await showDatePicker(
                        //                       context: context,
                        //                       initialDate: DateTime.now(),
                        //                       firstDate: DateTime(2023),
                        //                       lastDate: DateTime(3000));
                        //               if (datepicked != null) {
                        //                 print(
                        //                     datepicked); //get the picked date in the format => 2022-07-04 00:00:00.000
                        //                 String formattedDate =
                        //                     DateFormat('yyyy-MM-dd')
                        //                         .format(datepicked!);
                        //                 WidgetsBinding.instance
                        //                     .addPostFrameCallback((_) =>
                        //                         setState((FundToDate.text =
                        //                                 formattedDate)
                        //                             as VoidCallback));
                        //                 // format date in required form here we use yyyy-MM-dd that means time is remove
                        //               } else {
                        //                 print("Date is not selected");
                        //               }
                        //             },
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Flexible(
                      //   child: Container(
                      //     height: 35,
                      //     width: 140,
                      //     margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      //     color: ColorSelect.east_blue,
                      //     child: TextButton(
                      //       style: TextButton.styleFrom(
                      //         side: BorderSide(
                      //           width: 1.0,
                      //           color: Color(0xFFC9BBBB),
                      //         ),
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(0),
                      //         ),
                      //       ),
                      //       onPressed: () {
                      //         ArrangingSearch();
                      //       },
                      //       child: Text(
                      //         S.of(context).search,
                      //         style: TextController.btnText,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // height: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: fli.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                //  ClientFundAgreementSearch.id.value=int.parse(key[index]);
                                //  customerGetAgreement.id.value=int.parse(key[index]);
                                //  tabController!.animateTo(1);
                                final split = fli[index].split(' ');
                                print(split);
                                print(ftotalvalue[index]);
                                // ArrangingSubscribe.fundname.value = fli[index];
                                // ArrangingSubscribe.totalValue.value =
                                //     ftotalvalue[index];
                                // ArrangingSubscribe.duration.value =
                                //     fduration[index];

                                // print(ArrangingSubscribe.duration.value);

                                // ArrangingSubscribe.persharevalue.value =
                                //     split[1];
                                // ArrangingSubscribe.fundid.value =
                                //     int.parse(fkey[index]);

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => newInd("")),

                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         new ArrangingSubscribe())
                                );
                              },
                              child: card(fli[index], fkey[index], context));
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

Widget card(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Expanded(
            flex: 1,
            child: Flexible(
              child: Card(
                elevation: 5.0,
                margin: EdgeInsets.all(4.0),
                child: Flexible(
                  child: Container(
                    width: 1000,
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          templateName,
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          templateKeys,
                          style: TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
