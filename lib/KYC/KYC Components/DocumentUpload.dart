import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/KYC/KYC%20Components/newInd.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DocumentUpload extends StatefulWidget {
  DocumentUpload({@required controller}) {
    tabController = controller;
  }
  @override
  State<DocumentUpload> createState() => _DocumentUploadState();

  static ValueNotifier<String> name = ValueNotifier("");
  static ValueNotifier<String> idname = ValueNotifier("");
}

TabController? tabController;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _DocumentUploadState extends State<DocumentUpload> {
  String btn = "Submit";
  List<MultipartFile> alldocs = [];
  Map<String, String> typename = {};
  var dio = Dio();
  String fileName = "";

  Uint8List fileBytes = new Uint8List(500);
  String _selectedFileName = '';
  var extentions = ["pdf", "docx"];
  Future<void> uploadPdf(String name) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      if (extentions.contains(file.name.split(".")[1])) {
        fileName = file.name;
      } else {
        Fluttertoast.showToast(
            msg: "Upload Only pdf/docx Type",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }

      fileBytes = file.bytes!;
      alldocs.add(MultipartFile.fromBytes(fileBytes, filename: fileName));
      typename[name] = fileName;
      setState(() {
        _selectedFileName = fileName;
      });
    }
  }

  Map<String, String> selectedFileNames = {};

  Future<void> senddata() async {
    setState(() {
      btn = "Loading...";
    });
    FormData data = FormData.fromMap({
      'ClientId': GlobalIndividual.individualclientid,
      'li': alldocs,
      'Typeofdoc': typename.keys.toList(),
      'category': category
    });

    print(data);
    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/DocUploadControllerIndividual/DocUpload/",
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );

    if (response.statusCode == 200) {
      // Request successful, handle the response
      // var responseData = jsonDecode(response.toString());
      print("Successfull");

      try {
        await GlobalPermission.reportsDownloadKYC(
            GlobalIndividual.individualclientid, "Individual");
      } catch (e) {}
      bool x = await GlobalPermission.formApproval("KYC",
          GlobalIndividual.individualclientid, DocumentUpload.name.value, 0);
      GlobalIndividual.individualdraftprogress = {};
      GlobalIndividual.individualclientid = 0;

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
      }
      GlobalPermission.SetDefault();
      setState(() {
        btn = "Submit";
      });

      // await formApproval();
    } else {
      setState(() {
        btn = "Submit";
      });
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

  void fetchReport() async {
    final username = 'Administrator';
    final password = 'hX9b7aBd\$2Z';
    final basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    final url =
        'http://eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fCorporate&rs:Command=Render&ID=4&rs:FORMAT=PDF';
    final response = await http.get(
      Uri.parse(url),
      headers: {'authorization': basicAuth},
    );

    if (response.statusCode == 200) {
      // Report fetched successfully, you can process the response here
      print('Report Content: ${response.body}');
    } else {
      // Handle errors
      print('Failed to fetch report. Status code: ${response.statusCode}');
    }
  }

  void launch() async {
    String reportUrl =
        'http://eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fCorporate&rs:Command=Render&ID=4&rs:FORMAT=PDF';
    String username = 'Administrator';
    String password = 'hX9b7aBd\$2Z';

    String encodedPassword = Uri.encodeComponent(password);
    String credentials =
        base64Encode(utf8.encode('$username:$encodedPassword'));

    try {
      final dio = Dio();
      dio.options.headers['authorization'] = 'Basic $credentials';
      dio.options.followRedirects = false;

      final response = await dio.post(reportUrl);

      if (response.statusCode == 200) {
        // DownloadReport
      } else {
        print(
            'Failed to download PDF report. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  _launchURLApp(int id) async {
    // Replace 'your_username' and 'your_password' with your actual credentials
    var username = 'Administrator';
    var password = 'hX9b7aBd\$2Z';
    var url = Uri.parse(
        "http://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2fIndividualFinal&rs:Command=Render&ID=${id}&rs:FORMAT=PDF");

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
    'Foreign Residents in the Kingdom Members of the Diplomatic Missions in the Kingdom',
    'Foreign Natural Persons not Residing in the Kingdom',
    'Opening an Investment Account for a Blind Person or a Person Unable to Read',
    'Opening an Investment Account for Persons Under the Age of (18) Hijri Calendar Years',
    'Opening an Investment Account for an Incapacitated Person',
    'Opening an Investment Account for a Person Unable to Write and Sign',
    'Opening Investment Accounts for the Interdicted Person',
  ];
  var Data = {
    'Saudi Natural Person': [
      "National Identity~m",
      "Passport~n",
      "Address Proof~n"
    ],
    'Citizen Of GCC Member State': ["ID Proof~m", "Passport~n"],
    'Foreign Resident in the kingdom': [
      "Resident Identity~ma",
      "Iqama Identity~ma",
      "Five Year Residency~ma",
      "Passport~n",
      "Address Proof~n"
    ],
    'Foreign Residents in the Kingdom Members of the Diplomatic Missions in the Kingdom':
        [
      "Verify an identification letter from the member's embassy.~m",
      "Valid diplomatic identity card information.~m",
      "Passport~n",
      "Address Proof~n"
    ],
    'Foreign Natural Persons not Residing in the Kingdom': [
      "Passport~m",
      "Address Proof~n"
    ],
    'Opening an Investment Account for a Blind Person or a Person Unable to Read':
        [
      "National Identity~n",
      "Iqama Identity~n",
      "Address Proof~n",
      "Passport~n"
    ],
    'Opening an Investment Account for Persons Under the Age of (18) Hijri Calendar Years':
        [
      "National Identity~n",
      "Iqama Identity~n",
      "Address Proof~n",
      "Passport~n"
    ],
    'Opening an Investment Account for an Incapacitated Person': [
      "National Identity~n",
      "Iqama Identity~n",
      "Address Proof~n",
      "Passport~n"
    ],
    'Opening an Investment Account for a Person Unable to Write and Sign': [
      "National Identity~n",
      "Iqama Identity~n",
      "Address Proof~n",
      "Passport~n"
    ],
    'Opening Investment Accounts for the Interdicted Person': [
      "National Identity~n",
      "Iqama Identity~n",
      "Address Proof~n",
      "Passport~n"
    ],
  };

  List<String> resultlist = [];

  bool IqamaCheck = false;
  bool fiveYearResidentIdentity = false;
  bool diplomatic = false;

  String? category;

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
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 400,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: ColorSelect.textField)),
                            child: DropdownButton<String>(
                              hint: Text("Select Here",
                                  style: TextController.labelText),
                              value: category,
                              isExpanded: true,
                              underline: Container(),
                              iconEnabledColor: ColorSelect.east_dark_blue,
                              items: items.map(
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
                                alldocs.clear();
                                typename.clear();
                                setState(() {
                                  category = newValue == null ? "" : newValue;
                                  print(category);
                                  resultlist = Data[category]!;
                                });
                              },
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: Container(
                        //     width: 270,
                        //     height:44,
                        //     padding: EdgeInsets.symmetric(horizontal: 15),
                        //     alignment: Alignment.centerLeft,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         border:
                        //             Border.all(color: ColorSelect.textField)),
                        //     child: DropdownButtonHideUnderline(
                        //       child: Theme(
                        //         data: Theme.of(context)
                        //             .copyWith(focusColor: Colors.white),
                        //         child: DropdownButtonFormField(
                        //           hint: Text(
                        //             S.of(context).SelectHere,
                        //             style: TextController.labelText,
                        //           ),
                        //           isExpanded: true,
                        //           icon: const Icon(Icons.keyboard_arrow_down),
                        //           decoration: InputDecoration(
                        //             enabledBorder: InputBorder.none,
                        //             border: InputBorder.none,
                        //             hoverColor: Colors.white,
                        //           ),
                        //           items: items.map((String citizenship) {
                        //             return DropdownMenuItem(
                        //               value: citizenship,
                        //               child: Text(citizenship,
                        //                   style: TextController.BodyText),
                        //             );
                        //           }).toList(),
                        //           onChanged: (newValue) {
                        //             alldocs.clear();
                        //             typename.clear();
                        //             setState(() {
                        //               category =
                        //                   newValue == null ? "" : newValue;
                        //               print(category);
                        //               resultlist = Data[category]!;
                        //             });
                        //           },
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  if (category == "Opening an Investment Account for a Blind Person or a Person Unable to Read" ||
                      category ==
                          "Opening an Investment Account for Persons Under the Age of (18) Hijri Calendar Years" ||
                      category ==
                          "Opening an Investment Account for an Incapacitated Person" ||
                      category ==
                          "Opening an Investment Account for a Person Unable to Write and Sign" ||
                      category ==
                          "Opening Investment Accounts for the Interdicted Person")
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          "Data must be completed manually with compliance",
                          style: TextController.BodyHeadingText,
                        )),
                  SizedBox(
                    height: 20,
                  ),
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
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      // height: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: resultlist.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () async {},
                              child: table(Data[category]![index]));
                        },
                      ),
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
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  ColorSelect.east_blue),
                            ),
                            onPressed: () async {
                              print("A:LLLLLLL");
                              print(GlobalIndividual.individualdraftprogress);
                              // print(allValuesTrue);
                              print(alldocs);
                              print(typename);
                              if (category != "") {
                                List<String> reqres = [];
                                List<String> availres = [];
                                bool flag = false;
                                for (String i in typename.keys.toList()) {
                                  if (i.split("~")[1] == 'm' ||
                                      i.split("~")[1] == "ma") {
                                    if (i.split("~")[1] == "ma") {
                                      setState(() {
                                        flag = true;
                                      });
                                    }
                                    availres.add(i);
                                  }
                                }
                                for (String i in resultlist) {
                                  if (i.split("~")[1] == 'm') {
                                    reqres.add(i);
                                  }
                                }

                                if (reqres.length != availres.length &&
                                    flag == false) {
                                  Fluttertoast.showToast(
                                      msg: "Please Upload Required Documents ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  var tempdraft =
                                      GlobalIndividual.individualdraftprogress;
                                  tempdraft["CustodianInformation"] = true;
                                  tempdraft["AllDocUploadIndividual"] = true;

                                  bool allValuesTrue = tempdraft.values
                                      .every((value) => value == true);
                                  if (allValuesTrue &&
                                      GlobalIndividual.individualclientid !=
                                          0) {
                                    Fluttertoast.showToast(
                                        msg: "Data Storing",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    senddata();
                                  } else {
                                    var field = "Personal Information";
                                    print(GlobalIndividual
                                        .individualdraftprogress.keys);
                                    for (var entry in GlobalIndividual
                                        .individualdraftprogress.keys) {
                                      print(entry);
                                      if (GlobalIndividual
                                              .individualdraftprogress[entry] ==
                                          false) {
                                        field = entry;
                                        print("ff$field");
                                        break; // Exit the loop when the first key with a false value is found.
                                      }
                                    }
                                    Fluttertoast.showToast(
                                        msg: "Please fill ${field}",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
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
                              }
                            }, // Switch tabs
                            child: Text(
                              btn,
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

  Widget table(String name) {
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
                          name.split("~")[0] +
                              (name.split("~")[1] == 'm' ? "*" : ""),
                          style: TextController.BodyText,
                        ))),
                    Container(
                        height: 50,
                        child: Center(
                            child: TextButton(
                          onPressed: () {
                            uploadPdf(name);
                          },
                          child: Text(
                            typename[name] ?? S.of(context).Browse,
                            style: TextController.browseText,
                          ),
                        ))),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
