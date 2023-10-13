import 'dart:convert';

import 'package:east_bridge/Fund%20Creation/FundGlobal.dart';
import 'package:east_bridge/Fund%20Creation/TabOfFundCreation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/GloablIndividual.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FundPDFAgreementUpload extends StatefulWidget {
  FundPDFAgreementUpload({@required controller}) {
    tabController = controller;
  }
  @override
  State<FundPDFAgreementUpload> createState() => _AgrrementPdfViewerState();
  static ValueNotifier<String> name = ValueNotifier("");
}

TabController? tabController;

class _AgrrementPdfViewerState extends State<FundPDFAgreementUpload> {
  Map<String, String> typename = {};

  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];
  bool _agreementError = false;
  final _formKey = GlobalKey<FormState>();
  String button = "Browse";
  int? editIndex; // Updated type to int?
  bool btn = true;
  @override
  void initState() {
    super.initState();
    print("----");
  }

  bool pdfview = false;
  MultipartFile? FundPdf;
  Future<void> uploadPdf(String name) async {
    if (button == "loading...") {
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      var fileBytes = file.bytes!;
      setState(() {
        FundPdf = MultipartFile.fromBytes(fileBytes, filename: "FundPdf");
      });
      senddata();
    }
  }

  void senddata() async {
    setState(() {
      button = "loading...";
    });
    FormData data = FormData.fromMap({
      'FundId': GlobalPermissionFund.Fundclientid,
      'FundPdf': FundPdf,
    });

    var dio = Dio();

    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/FundAgreementPdf/FundPdfUpload",
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        pdfview = true;
        button = "Browse";
      });
      GlobalPermissionFund.getdraftprogressfund(
          GlobalPermissionFund.Fundclientid);
    }
  }

  Future<bool> saveData() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = {
      "generatedBy": GlobalPermission.employeeId,
      "FundId": GlobalPermissionFund.Fundclientid,
      "TemplateName": FundPDFAgreementUpload.name.value + " Agreement",
      "todos": finalitems
    };
    print(data);
    final response = await http.post(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/FundAgreeementCreation/FundAgreementTemplates'),
      headers: headers,
      body: jsonEncode(data),
    );

    print(response.body);
    if (response.statusCode == 200) {
      // Request successful, handle the response

      bool y = await GlobalPermission.formApproval(
          "Fund Creation",
          GlobalPermissionFund.Fundclientid,
          FundPDFAgreementUpload.name.value,
          0);
      GlobalPermissionFund.Fundclientid = 0;
      GlobalPermissionFund.Funddraftprogress = {};
      if (y == true) {
        Fluttertoast.showToast(
            msg: "Sent for Approval",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        print("Successful");
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Fail",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }

      // Process the responseData
    } else {
      // Request failed, handle the error
      var errorMessage = response.reasonPhrase;
      print(response.statusCode);
      print(response.body);
      print(jsonDecode(response.body));
      print("Error");
      return false;
      // Display or handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  height: 50,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        uploadPdf("pdf");
                      },
                      child: Text(
                        button,
                        style: TextController.browseText,
                      ),
                    ),
                  ),
                ),
                if (pdfview)
                  Container(
                    width: double.infinity,
                    // height: 1000, // Adjust the height as needed
                    // color: Colors.red,
                    child: Html(
                      data: '''
                <div>
            <iframe src="${GlobalPermission.urlLink}/api/FundAgreementPdf/FundPDF?Fundid=${GlobalPermissionFund.Fundclientid}"
                    type="application/pdf" width="100%" height="1000"></iframe>
                </div>
              ''',
                    ),
                  ),
                if (GlobalPermissionFund
                        .Funddraftprogress["FundAgreementPdf"] ==
                    true)
                  Container(
                    width: double.infinity,
                    // height: 1000, // Adjust the height as needed
                    // color: Colors.red,
                    child: Html(
                      data: '''
<h1>View PDF</h1>
                <div>
            <iframe src="${GlobalPermission.urlLink}/api/FundAgreementPdf/FundPDF?Fundid=${GlobalPermissionFund.Fundclientid}"
                    type="application/pdf" width="100%" height="1000"></iframe>
                </div>
              ''',
                    ),
                  ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 35,
                          width: 140,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: ColorSelect.tabBorderColor)),
                          child: TextButton(
                            onPressed: () {
                              tabController!.animateTo(3);
                            }, // Switch tabs
                            child: Text(
                              S.of(context).Back,
                              style: TextController.SideMenuText,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 140,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null) {
                            // setState(() {
                            //   _agreementError = tempName.text == "";
                            // });
                            if (btn == false) {
                              return;
                            }
                            setState(() {
                              btn = false;
                            });
                            print("pressedd");
                            bool x = false;
                            var tempdraft =
                                GlobalPermissionFund.Funddraftprogress;

                            bool allValuesTrue = tempdraft.values
                                .every((value) => value == true);

                            if (allValuesTrue &&
                                GlobalPermissionFund.Fundclientid != 0) {
                              Fluttertoast.showToast(
                                  msg: "Data Storing",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                              x = await saveData();
                              setState(() {
                                btn = true;
                              });
                            } else {
                              var field = "Fund Creation";
                              print(
                                  GlobalPermissionFund.Funddraftprogress.keys);
                              for (var entry in GlobalPermissionFund
                                  .Funddraftprogress.keys) {
                                print(entry);
                                if (GlobalPermissionFund
                                        .Funddraftprogress[entry] ==
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

                            if (x == true) {
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TabOfFundCreation()));
                              });
                            }
                          }

                          //customerGetAgreement.id.value=id;
                        },
                        child: Text("Save"),
                        style: ElevatedButton.styleFrom(
                          primary: ColorSelect
                              .east_blue, // Set the desired background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), // Set border radius to 0
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
