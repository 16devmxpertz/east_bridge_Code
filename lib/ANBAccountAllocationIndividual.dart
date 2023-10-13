import 'dart:convert';

import 'package:east_bridge/ANBAccountCustomerSearch.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'generated/l10n.dart';
import 'utility/Colors.dart';
import 'utility/TextController.dart';

class ANBAccountIndividual extends StatefulWidget {
  const ANBAccountIndividual({super.key});

  @override
  State<ANBAccountIndividual> createState() => _ANBAccountIndividualState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");
}

final _formKey = GlobalKey<FormState>();

class _ANBAccountIndividualState extends State<ANBAccountIndividual> {
  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool get sidebarVisible => _sidebarVisible;

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  TextEditingController _bankName = new TextEditingController();
  TextEditingController _branchName = new TextEditingController();
  TextEditingController _accountNum = new TextEditingController();
  TextEditingController _accountName = new TextEditingController();
  TextEditingController _bankCode = new TextEditingController();

  void anbbank() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/ANBBankAccountAllocation/ANBBankAccount/');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "clientId": ANBAccountIndividual.id.value,
        "bankName": _bankName.text,
        "branchName": _branchName.text,
        "mainAccountNumber": _accountNum.text,
        "accountHolderName": _accountName.text,
        "bankCode": _bankCode.text,
      };

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => newInd(""),
          ),
        );
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission(
        "Client\'s Investment Account Opening");
    setState(() {
      permission = data;
    });
  }

  void initState() {
    super.initState();
    setState(() {
      _accountName.text = ANBAccountIndividual.name.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // HEADER START
                    Column(
                      children: [
                        HeaderTop(),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
                          width: double.infinity,
                          height: 40,
                          color: ColorSelect.east_blue,
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 40,
                                child: Container(
                                  height: 40,
                                  child: Center(
                                    child: IconButton(
                                      color: Colors.white,
                                      icon: Icon(Icons.menu),
                                      onPressed: () {
                                        sidBarOpen = !sidBarOpen;
                                        setSideBarState();
                                        toggleSidebar();
                                      },
                                      // onPressed: () {

                                      // _globalKey.currentState?.openDrawer();
                                      // },
                                    ),
                                  ),
                                ),
                              ),

                              // new
                              if (permission['New'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            ANBAccountIndividual(),
                                      ));
                                    },
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.add_card_rounded,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).New,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // EDIT
                              if (permission['Edit'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.edit_calendar_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Edit,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // view
                              if (permission['View'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.content_paste_search,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).View,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // cancel
                              if (permission['Delete'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.free_cancellation_outlined,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Cancel,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // print
                              if (permission['Print'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => KYCPdfUploadIND(),
                                      // ));
                                    },
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.print,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Print,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              //
                              if (permission['Download'] == true)
                                Container(
                                  // width: 100,
                                  height: 44,
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Container(
                                      //color: ColorSelect.east_blue,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Icon(
                                              Icons.download,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Center(
                                            child: Text(
                                              S.of(context).Download,
                                              style:
                                                  TextController.ControllerText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              // saveDraft
                              Container(
                                // width: 100,
                                height: 44,
                                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                ),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Container(
                                    //color: ColorSelect.east_blue,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.save_as_outlined,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Center(
                                          child: Text(
                                            S.of(context).SaveDraft,
                                            style:
                                                TextController.ControllerText,
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
                    // HEADER END

                    Stack(
                      children: [
                        AnimatedContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          transform:
                              Matrix4.translationValues(xOffset, yOffset, 1.0),
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          color: Colors.white,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 60),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Card(
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 260),
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 0, 0, 0),
                                                        color:
                                                            Color(0xFFFFF2F5F7),
                                                        height: 45,
                                                        width: double.infinity,
                                                        child: Center(
                                                            child: Text(
                                                                S
                                                                    .of(context)
                                                                    .ANBBankAccountAllocation,
                                                                style: TextController
                                                                    .MainHeadingText)),
                                                      ),
                                                      ANBAccountCustomerSearch(),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                20, 30, 0, 0),
                                                        child: Column(
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "Client Name : " +
                                                                    ANBAccountIndividual
                                                                        .name
                                                                        .value,
                                                                style: TextController
                                                                    .BodyHeadingText,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(S.of(context).BankName, style: TextController.BodyText),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                width: 270,
                                                                                height: 35,
                                                                                alignment: Alignment.centerLeft,
                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'This field is required.';
                                                                                    }
                                                                                    return null; // Return null if the input is valid
                                                                                  },
                                                                                  controller: _bankName,
                                                                                  textAlignVertical: TextAlignVertical.center,
                                                                                  style: TextController.BodyHeadingText,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: S.of(context).TypeHere,
                                                                                    hintStyle: TextController.labelText,
                                                                                    border: InputBorder.none,
                                                                                    errorStyle: TextController.inputErrorText,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Text('Main Account\nNumber (IBAN)', style: TextController.BodyText),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                width: 270,
                                                                                height: 35,
                                                                                alignment: Alignment.centerLeft,
                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'This field is required.';
                                                                                    }

                                                                                    return null; // Return null if the input is valid
                                                                                  },
                                                                                  controller: _branchName,
                                                                                  textAlignVertical: TextAlignVertical.center,
                                                                                  style: TextController.BodyHeadingText,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: S.of(context).IbanLabel,
                                                                                    hintStyle: TextController.labelText,
                                                                                    border: InputBorder.none,
                                                                                    errorStyle: TextController.inputErrorText,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        // Row(
                                                                        //   mainAxisAlignment:
                                                                        //       MainAxisAlignment
                                                                        //           .spaceBetween,
                                                                        //   children: [
                                                                        //     Container(
                                                                        //       margin: EdgeInsets
                                                                        //           .fromLTRB(
                                                                        //               0,
                                                                        //               20,
                                                                        //               0,
                                                                        //               0),
                                                                        //       child: Text(
                                                                        //           S
                                                                        //               .of(
                                                                        //                   context)
                                                                        //               .BankCode,
                                                                        //           style: TextController
                                                                        //               .BodyText),
                                                                        //     ),
                                                                        //     Flexible(
                                                                        //       child:
                                                                        //           Container(
                                                                        //         margin: EdgeInsets
                                                                        //             .fromLTRB(
                                                                        //                 0,
                                                                        //                 20,
                                                                        //                 0,
                                                                        //                 0),
                                                                        //         height: 35,
                                                                        //         width: 270,
                                                                        //         // margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
                                                                        //         child: TextField(
                                                                        //             controller: _bankCode,
                                                                        //             decoration: InputDecoration(
                                                                        //               enabledBorder: OutlineInputBorder(
                                                                        //                   borderSide: BorderSide(color: Color(0xFFC9BBBB), width: 0.5),
                                                                        //                   borderRadius: BorderRadius.zero),
                                                                        //               border:
                                                                        //                   OutlineInputBorder(borderRadius: BorderRadius.zero),
                                                                        //               labelText: S
                                                                        //                   .of(context)
                                                                        //                   .TypeHere,
                                                                        //               labelStyle:
                                                                        //                   TextController.labelText,
                                                                        //             )),
                                                                        //       ),
                                                                        //     ),
                                                                        //   ],
                                                                        // )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 30),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              child: Text(S.of(context).BranchName, style: TextController.BodyText),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                width: 270,
                                                                                height: 35,
                                                                                alignment: Alignment.centerLeft,
                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'This field is required.';
                                                                                    }
                                                                                    return null; // Return null if the input is valid
                                                                                  },
                                                                                  controller: _accountNum,
                                                                                  textAlignVertical: TextAlignVertical.center,
                                                                                  style: TextController.BodyHeadingText,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: S.of(context).TypeHere,
                                                                                    hintStyle: TextController.labelText,
                                                                                    border: InputBorder.none,
                                                                                    errorStyle: TextController.inputErrorText,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      Container(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 30),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                                                              child: Text('Account Holder\nName', style: TextController.BodyText),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                width: 270,
                                                                                height: 35,
                                                                                alignment: Alignment.centerLeft,
                                                                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: ColorSelect.textField)),
                                                                                child: TextFormField(
                                                                                  validator: (value) {
                                                                                    if (value!.isEmpty) {
                                                                                      return 'This field is required.';
                                                                                    }
                                                                                    return null; // Return null if the input is valid
                                                                                  },
                                                                                  controller: _accountName,
                                                                                  textAlignVertical: TextAlignVertical.center,
                                                                                  style: TextController.BodyHeadingText,
                                                                                  decoration: InputDecoration(
                                                                                    isDense: true,
                                                                                    hintText: S.of(context).TypeHere,
                                                                                    hintStyle: TextController.labelText,
                                                                                    border: InputBorder.none,
                                                                                    errorStyle: TextController.inputErrorText,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        Container())
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0, 110, 30, 0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    width: 140,
                                                                    height: 35,
                                                                    color: ColorSelect
                                                                        .east_blue,
                                                                    child:
                                                                        TextButton(
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        side:
                                                                            BorderSide(
                                                                          width:
                                                                              0.5,
                                                                          color:
                                                                              ColorSelect.tabBorderColor,
                                                                        ),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(0),
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          _formKey
                                                                              .currentState!
                                                                              .save();
                                                                          if (ANBAccountIndividual.id.value !=
                                                                              0) {
                                                                            anbbank();
                                                                          } else {
                                                                            Fluttertoast.showToast(
                                                                                msg: "Please select client first",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.CENTER,
                                                                                timeInSecForIosWeb: 3,
                                                                                backgroundColor: Colors.red,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0);
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        S
                                                                            .of(context)
                                                                            .Submit,
                                                                        style: TextController
                                                                            .btnText,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (sidebarVisible) SideBar() else Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Navigation(),
          ],
        ),
      ),
    );
  }
}
