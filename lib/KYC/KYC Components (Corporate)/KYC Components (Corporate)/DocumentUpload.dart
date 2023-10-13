import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/KYC/corporate.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class DocumentUploadCorporate extends StatefulWidget {
  DocumentUploadCorporate({@required controller}) {
    tabController = controller;
  }
  @override
  State<DocumentUploadCorporate> createState() =>
      _DocumentUploadCorporateState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");
}

TabController? tabController;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _DocumentUploadCorporateState extends State<DocumentUploadCorporate> {
  List<MultipartFile> alldocs = [];
  List<String> typename = [];
  var dio = Dio();
  String fileName = "";

  Uint8List fileBytes = new Uint8List(500);
  String _selectedFileName = '';

  Future<void> uploadPdf(String name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      fileName = file.name;
      fileBytes = file.bytes!;
      alldocs.add(MultipartFile.fromBytes(fileBytes, filename: fileName));
      typename.add(name);
      setState(() {
        _selectedFileName = fileName;
      });
    }
  }

  Map<String, String> selectedFileNames = {};

  Future<void> uploadPdf1(String name, String buttonId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      String fileName = file.name;
      List<int> fileBytes = file.bytes!;
      alldocs.add(MultipartFile.fromBytes(fileBytes, filename: fileName));
      typename.add(name);

      setState(() {
        selectedFileNames[buttonId] =
            fileName; // Update the selected file name for the specific button
      });
    }
  }

/////
  ///
  Future<void> senddata() async {
    FormData data = FormData.fromMap({
      'ClientId': DocumentUploadCorporate.id.value,
      'li': alldocs,
      'Typeofdoc': typename,
      'category': category
    });

    print(data);
    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/DocUpload/DocUpload",
      data: data,
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response
      // var responseData = jsonDecode(response.toString());
      print("Successfull");
      bool x = await GlobalPermission.formApproval(
          "KYC",
          DocumentUploadCorporate.id.value,
          DocumentUploadCorporate.name.value,
          0);
      if (x == true) {
        Fluttertoast.showToast(
            msg: "Sent for Approval",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => newInd(""),
          ),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => newInd(""),
          ),
        );
      }

      // await formApproval();
    } else {
      print(response.statusCode);
      print("Error");
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
      // Display or handle the error
    }
  }

  _launchURLApp() async {
    var url = Uri.parse(
        "http://desktop-41r8d69/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fIndividualFinal&rs:Command=Render&rs:Format=PDF&ID=${DocumentUploadCorporate.id.value}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Import the 'dart:convert' library

  var items = [
    'Saudi Natural Person',
    'Citizen Of GCC Member State',
    'Foreign Resident in the kingdom',
    'Foregin Natural Person not residing in the Kingdom',
    'Blind Person',
    'Minor (Age less than 18)',
    'Incapacitated Person',
    'Person Unable to Write & Sign',
    'Interdicted Person',
    'Saudi Company & Company of GCC Member State',
    'Foreign Legal Person',
    'Qualified Foreign Investor',
    'Funds Owned by a Governmental Entity',
    'Non-profit Organisations in the Kingdom',
    'Endowment',
    'Governmetal Entities',
    'International Organization & Institution',
    'Investment Funds Established in the Kingdom or in a GCC member state',
    'Other'
  ];

  bool IqamaCheck = false;
  bool fiveYearResidentIdentity = false;
  bool diplomatic = false;

  String category = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Category,
                          style: TextController.BodyText,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Container(
                            width: 270,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                              ),
                              child: DropdownButtonHideUnderline(
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(focusColor: Colors.white),
                                  child: DropdownButtonFormField(
                                    hint: Text(
                                      S.of(context).SelectHere,
                                      style: TextController.labelText,
                                    ),
                                    isExpanded: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "hdxjk";
                                      }
                                    },
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hoverColor: Colors.white,
                                    ),
                                    items: items.map((String citizenship) {
                                      return DropdownMenuItem(
                                        value: citizenship,
                                        child: Text(citizenship,
                                            style: TextController.BodyText),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        category = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Table(
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
                            color: ColorSelect.east_grey,
                            child: Center(
                                child: Text(
                              S.of(context).DocumentType,
                              style: TextController.tableHeading,
                            ))),
                        Container(
                            height: 50,
                            color: ColorSelect.east_grey,
                            child: Center(
                                child: Text(
                              S.of(context).DocumentUpload,
                              style: TextController.tableHeading,
                            ))),
                      ]),
                      TableRow(children: [
                        Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              "ID",
                              style: TextController.BodyText,
                            ))),
                        Container(
                            height: 50,
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                uploadPdf1("National ID", "btn1");
                              },
                              child: Text(
                                selectedFileNames['btn1'] ??
                                    S.of(context).Browse,
                                style: TextController.browseText,
                              ),
                            ))),
                      ]),
                      TableRow(children: [
                        Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              S.of(context).Passport,
                              style: TextController.BodyText,
                            ))),
                        Container(
                            height: 50,
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                uploadPdf1("Passport", "btn2");
                              },
                              child: Text(
                                selectedFileNames['btn2'] ??
                                    S.of(context).Browse,
                                style: TextController.browseText,
                              ),
                            ))),
                      ]),
                      TableRow(children: [
                        Container(
                            height: 50,
                            child: Center(
                                child: Text(
                              S.of(context).AddressProof,
                              style: TextController.BodyText,
                            ))),
                        Container(
                            height: 50,
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                uploadPdf1("Address Proof", "btn3");
                              },
                              child: Text(
                                selectedFileNames['btn3'] ??
                                    S.of(context).Browse,
                                style: TextController.browseText,
                              ),
                            ))),
                      ]),
                    ],
                  ),
                  if (category == "Foreign Resident in the kingdom")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1),

                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(200),
                          // 2: FixedColumnWidth(500),
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         "",
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IqamaID,
                                  style: TextController.BodyText,
                                ))),
                            // Container(
                            //   height: 50,
                            //   child: Checkbox(
                            //     value: IqamaCheck,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         IqamaCheck = newValue!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Address Proof", "btn4");

                                    if (IqamaCheck == true) {
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Valid Document ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Text(
                                    selectedFileNames['btn4'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FiveYearResidencyCard,
                                  style: TextController.BodyText,
                                ))),
                            // Container(
                            //   height: 50,
                            //   child: Checkbox(
                            //     value: fiveYearResidentIdentity,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         fiveYearResidentIdentity = newValue!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    if (fiveYearResidentIdentity == true) {
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Valid Document ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Text(
                                    S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).LetterFromEmbassyorDiplomaticID,
                                  style: TextController.BodyText,
                                ))),
                            // Container(
                            //   height: 50,
                            //   child: Checkbox(
                            //     value: diplomatic,
                            //     onChanged: (newValue) {
                            //       setState(() {
                            //         diplomatic = newValue!;
                            //       });
                            //     },
                            //   ),
                            // ),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    if (diplomatic == true) {
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Valid Document ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Text(
                                    S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category ==
                      "Foregin Natural Person not residing in the Kingdom")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).Passport,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Passport", "btn5");
                                  },
                                  child: Text(
                                    selectedFileNames['btn5'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Blind Person")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
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
                                  S.of(context).RefreeIdentityCard,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Refree Identity Card", "btn6");
                                  },
                                  child: Text(
                                    selectedFileNames['btn6'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Minor (Age less than 18)")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).ClientNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Client National ID", "btn7");
                                  },
                                  child: Text(
                                    selectedFileNames['btn7'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GuardianNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Guardian National ID", 'btn8');
                                  },
                                  child: Text(
                                    selectedFileNames['btn8'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FamilyCard,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1("Family Card", 'btn9');
                                  },
                                  child: Text(
                                    selectedFileNames['btn9'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).CopyOfGuardianDeed,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        "Copy Of Guardian Deed", "btn10");
                                  },
                                  child: Text(
                                    selectedFileNames['btn10'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IqamaIdifForeginResidentUnder18,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .IqamaIdifForeginResidentUnder18,
                                        "btn11");
                                  },
                                  child: Text(
                                    selectedFileNames['btn11'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Incapacitated Person")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).ClientNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).ClientNationalID,
                                        "btn12");
                                  },
                                  child: Text(
                                    selectedFileNames['btn12'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GuardianNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GuardianNationalID,
                                        "btn13");
                                  },
                                  child: Text(
                                    selectedFileNames['btn13'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FamilyCard,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).FamilyCard, "btn14");
                                  },
                                  child: Text(
                                    selectedFileNames['btn14'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IncapacitatedPersonCertificate,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .IncapacitatedPersonCertificate,
                                        "btn15");
                                  },
                                  child: Text(
                                    selectedFileNames['btn15'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Interdicted Person")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).ClientNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).ClientNationalID,
                                        "btn16");
                                  },
                                  child: Text(
                                    selectedFileNames['btn16'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GuardianNationalID,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GuardianNationalID,
                                        "btn17");
                                  },
                                  child: Text(
                                    selectedFileNames['btn17'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Saudi Company & Company of GCC Member State")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S
                                      .of(context)
                                      .Thecommercialregisterissuedbythecompetentauthority,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .Thecommercialregisterissuedbythecompetentauthority,
                                        "btn18");
                                  },
                                  child: Text(
                                    selectedFileNames['btn18'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S
                                      .of(context)
                                      .Thecompanysarticlesofassociationbylawsandtheirannexesandamendments,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .Thecompanysarticlesofassociationbylawsandtheirannexesandamendments,
                                        "btn19");
                                  },
                                  child: Text(
                                    selectedFileNames['btn19'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S
                                      .of(context)
                                      .ListofBoardOfDirectorsSeniorManagers,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .ListofBoardOfDirectorsSeniorManagers,
                                        "btn20");
                                  },
                                  child: Text(
                                    selectedFileNames['btn20'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GCCMS4,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GCCMS4, "btn21");
                                  },
                                  child: Text(
                                    selectedFileNames['btn21'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GCCMS5,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GCCMS5, "btn22");
                                  },
                                  child: Text(
                                    selectedFileNames['btn22'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GCCMS6,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GCCMS6, "btn23");
                                  },
                                  child: Text(
                                    selectedFileNames['btn23'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Foreign Legal Person")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).SwapAgreement,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).SwapAgreement, "btn24");
                                  },
                                  child: Text(
                                    selectedFileNames['btn24'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Qualified Foreign Investor")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI1, "btn25");
                                  },
                                  child: Text(
                                    selectedFileNames['btn25'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI2, "btn26");
                                  },
                                  child: Text(
                                    selectedFileNames['btn26'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI3, "btn27");
                                  },
                                  child: Text(
                                    selectedFileNames['btn27'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI4,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI4, "btn28");
                                  },
                                  child: Text(
                                    selectedFileNames['btn28'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Funds Owned by a Governmental Entity")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).TheFundByLaws,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).TheFundByLaws, "btn29");
                                  },
                                  child: Text(
                                    selectedFileNames['btn29'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FGE1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).FGE1, "btn30");
                                  },
                                  child: Text(
                                    selectedFileNames['btn30'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FGE2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).FGE2, "btn31");
                                  },
                                  child: Text(
                                    selectedFileNames['btn31'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FGE3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).FGE3, "btn32");
                                  },
                                  child: Text(
                                    selectedFileNames['btn32'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Non-profit Organisations in the Kingdom")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S
                                      .of(context)
                                      .ThelicenseissuedbytheCompetentauthority,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S
                                            .of(context)
                                            .ThelicenseissuedbytheCompetentauthority,
                                        "btn33");
                                  },
                                  child: Text(
                                    selectedFileNames['btn33'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI2, "btn34");
                                  },
                                  child: Text(
                                    selectedFileNames['btn34'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).QFI3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).QFI3, "btn35");
                                  },
                                  child: Text(
                                    selectedFileNames['btn35'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Endowment")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).Endowment1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).Endowment1, "btn36");
                                  },
                                  child: Text(
                                    selectedFileNames['btn36'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).Endowment2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).Endowment2, "btn37");
                                  },
                                  child: Text(
                                    selectedFileNames['btn37'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).Endowment3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).Endowment3, "btn38");
                                  },
                                  child: Text(
                                    selectedFileNames['btn38'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).Endowment4,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(
                                        S.of(context).Endowment4, "btn39");
                                  },
                                  child: Text(
                                    selectedFileNames['btn39'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Governmetal Entities")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GE1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GE1, "btn40");
                                  },
                                  child: Text(
                                    selectedFileNames['btn40'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GE2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GE2, "btn41");
                                  },
                                  child: Text(
                                    selectedFileNames['btn41'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).GE3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).GE3, "btn42");
                                  },
                                  child: Text(
                                    selectedFileNames['btn42'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "International Organization & Institution")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IOI1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IOI1, "btn43");
                                  },
                                  child: Text(
                                    selectedFileNames['btn43'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IOI2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IOI2, "btn44");
                                  },
                                  child: Text(
                                    selectedFileNames['btn44'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IOI3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IOI3, "btn45");
                                  },
                                  child: Text(
                                    selectedFileNames['btn45'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category ==
                      "Investment Funds Established in the Kingdom or in a GCC member state")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IF1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IF1, "btn46");
                                  },
                                  child: Text(
                                    selectedFileNames['btn46'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IF2,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IF2, "btn47");
                                  },
                                  child: Text(
                                    selectedFileNames['btn47'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IF3,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IF3, "btn48");
                                  },
                                  child: Text(
                                    selectedFileNames['btn48'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).IF4,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).IF4, "btn49");
                                  },
                                  child: Text(
                                    selectedFileNames['btn49'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).FGE1,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).FGE1, "btn50");
                                  },
                                  child: Text(
                                    selectedFileNames['btn50'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  if (category == "Other")
                    Visibility(
                      visible: true,
                      child: Table(
                        border:
                            TableBorder.all(color: ColorSelect.tabBorderColor),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(1)
                          // 0: FixedColumnWidth(500),
                          // 1: FixedColumnWidth(500)
                        },
                        children: [
                          // TableRow(children: [
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentType,
                          //         style: TextController.tableHeading,
                          //       ))),
                          //   Container(
                          //       height: 50,
                          //       color: ColorSelect.east_grey,
                          //       child: Center(
                          //           child: Text(
                          //         S.of(context).DocumentUpload,
                          //         style: TextController.tableHeading,
                          //       ))),
                          // ]),
                          TableRow(children: [
                            Container(
                                height: 50,
                                child: Center(
                                    child: Text(
                                  S.of(context).AuthorityApproval,
                                  style: TextController.BodyText,
                                ))),
                            Container(
                                height: 50,
                                child: Center(
                                    child: TextButton(
                                  onPressed: () {
                                    uploadPdf1(S.of(context).AuthorityApproval,
                                        "btn51");
                                  },
                                  child: Text(
                                    selectedFileNames['btn51'] ??
                                        S.of(context).Browse,
                                    style: TextController.browseText,
                                  ),
                                ))),
                          ]),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
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
                              tabController?.animateTo(12);
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
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (category != "") {
                                if (selectedFileNames.length < 3) {
                                  Fluttertoast.showToast(
                                      msg: "Please Upload Documents ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  senddata();
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please Select Category ",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                // senddata();

                                // FutureBuilder<void>(
                                //   future: senddata(),
                                //   builder: (context, snapshot) {
                                //     if (snapshot.connectionState ==
                                //         ConnectionState.waiting) {
                                //       // API request is still loading, display a loader
                                //       return CircularProgressIndicator();
                                //     } else if (snapshot.hasError) {
                                //       // API request failed, display an error message
                                //       return Text('Error: ${snapshot.error}');
                                //     } else {
                                //       // API request completed successfully, display your content
                                //       return newInd("");
                                //     }
                                //   },
                                // );
                                // launch();
                                // _launchURLApp();
                                // fetchReport();
                                // formApproval();
                              }
                            }, // Switch tabs
                            child: Text(
                              S.of(context).Submit,
                              style: TextController.btnText,
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
      ),
    );
  }
}
