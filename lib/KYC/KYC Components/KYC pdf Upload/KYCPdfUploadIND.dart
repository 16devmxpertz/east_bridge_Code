import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/ANBAccountAllocationIndividual.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCUploadCustomerSearh.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class KYCPdfUploadIND extends StatefulWidget {
  @override
  KYCPdfUploadINDState createState() => KYCPdfUploadINDState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<String> name = new ValueNotifier("");
}

int? Id;

class KYCPdfUploadINDState extends State<KYCPdfUploadIND> {
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

  late Map<String, dynamic> permission = {};

  void a() async {
    var data = await GlobalPermission.formPermission("KYC Upload");
    setState(() {
      permission = data;
    });
  }

  String clientType = "";

  void clientIdentification() async {
    print("Shah");
    print({KYCPdfUploadIND.id.value});

    final response = await http.post(Uri.parse(
        '${GlobalPermission.urlLink}/api/ClientIdentificationApi/ClientIdentification?id=${KYCPdfUploadIND.id.value}'));

    print("Shah1");

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      setState(() {
        clientType = response.body;
      });
      print(clientType);
      print("Shah3");
    } else {
      print("ShahError");
      throw Exception('Failed to fetch data');
    }
  }

  static reportsDownloadKYC(int id, String formname) async {
    if (id != 0) {
      if (formname == "Individual") {
        formname = "IndividualFinal";
      }
      if (formname == "Corporate") {
        formname = "Corporate";
      }
      if (formname == "POA") {
        formname = "POAFinal";
      }
      // Replace 'your_username' and 'your_password' with your actual credentials
      var username = 'Administrator';
      var password = 'hX9b7aBd\$2Z';
      var url = Uri.parse(
          "https://${username}:${password}@eastbridge.online/ReportServer/Pages/ReportViewer.aspx?%2fEastBridgeReport%2f${formname}&rs:Command=Render&ID=${id}");

      //   if (await canLaunchUrl(url)) {
      //     await launchUrl(url);
      //   } else {
      //     print("error can' ssrs launch");
      //   }
      await launchUrl(url);
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

  String fileName = '';
  late MultipartFile
      uploadedFile; // Changed the variable name to 'uploadedFile'
  String? newName;

  String? _selectedFileName;

  Future<void> uploadPdf1() async {
    if (KYCPdfUploadIND.id.value != 0) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile platformFile =
            result.files.first; // Rename the variable to avoid conflict
        String fileName = platformFile.name;
        List<int> fileBytes = platformFile.bytes!;
        uploadedFile = MultipartFile.fromBytes(fileBytes,
            filename: fileName); // Assign to 'uploadedFile'

        setState(() {
          _selectedFileName =
              fileName; // Update the selected file name for the specific button
        });
      }
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

  var dio = Dio();

  Future<void> uploadPdfIndividual() async {
    FormData data = FormData.fromMap({
      'ClientId': KYCPdfUploadIND.id.value,
      'CheckBoxPdf': uploadedFile,
    });

    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/IndividualPdf/IndividualPdf/",
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      print(_selectedFileName);
      Fluttertoast.showToast(
          msg: "Document Uploaded Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ANBAccountIndividual(),
        ),
      );
    } else {
      print("Result is Null");
    }
  }

  Future<void> uploadPdfCorporate() async {
    FormData data = FormData.fromMap({
      'ClientId': KYCPdfUploadIND.id.value,
      'CheckBoxPdf': uploadedFile,
    });

    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/CorporatePdf/CorporatePdf/",
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    if (response.statusCode == 200) {
      print(response.toString());
      print(_selectedFileName);
      Fluttertoast.showToast(
          msg: "Please fill personal info first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ANBAccountIndividual(),
        ),
      );
    } else {
      print("Result is Null");
    }
  }

  Future<void> uploadPdfPOA() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    FormData data = FormData.fromMap({
      'ClientId': KYCPdfUploadIND.id.value,
      'CheckBoxPdf': uploadedFile,
    });

    var response = await dio.post(
      "${GlobalPermission.urlLink}/api/POAPdf/POAPdf/",
      data: data,
      onSendProgress: (int sent, int total) {
        print('$sent $total');
      },
    );
    if (response.statusCode == 200) {
      print(response.toString());
      print(_selectedFileName);
      Fluttertoast.showToast(
          msg: "Please fill personal info first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ANBAccountIndividual(),
        ),
      );
    } else {
      print("Result is Null");
    }
  }

  void initState() {
    super.initState();
    clientIdentification();
    a();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                color: Colors.white,
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
                                              KYCPdfUploadIND(),
                                        ));
                                      },
                                      child: Container(
                                        //color: ColorSelect.east_blue,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Icon(
                                                Icons
                                                    .free_cancellation_outlined,
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
                                                style: TextController
                                                    .ControllerText,
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                                              padding:
                                                  const EdgeInsets.all(5.0),
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
                                                style: TextController
                                                    .ControllerText,
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
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    margin: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFFFFF),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: ColorSelect.east_grey,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            S.of(context).KYCUpload,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  KYCUploadCustomerSearch(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Client Name : " +
                                            KYCPdfUploadIND.name.value,
                                        style: TextController.BodyHeadingText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 40),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: 35,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: ColorSelect
                                                          .tabBorderColor)),
                                              child: TextButton(
                                                onPressed: () {
                                                  reportsDownloadKYC(
                                                      KYCPdfUploadIND.id.value,
                                                      clientType);
                                                },
                                                child: Text(
                                                  S.of(context).Download,
                                                  style: TextController
                                                      .SideMenuText,
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
                                                    color: ColorSelect
                                                        .tabBorderColor),
                                              ),
                                              child: TextButton(
                                                onPressed: () {
                                                  // uploadPdfIndividual();
                                                  uploadPdf1();
                                                  // if (clientType == "Individual") {
                                                  //   uploadPdfIndividual();
                                                  // }
                                                  // if (clientType == "Corporate") {
                                                  //   uploadPdfCorporate();
                                                  // }
                                                  // if (clientType == "POA") {
                                                  //   uploadPdfPOA();
                                                  // }
                                                },
                                                child: Text(
                                                  "Upload",
                                                  style: TextController.btnText,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      if (_selectedFileName != null)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(_selectedFileName!,
                                                style: TextController
                                                    .BodyHeadingText),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedFileName = null;
                                                });
                                              },
                                              child: Icon(
                                                Icons.cancel_presentation,
                                              ),
                                            )
                                          ],
                                        ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(50.0),
                                    child: Container(
                                      height: 35,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: ColorSelect.east_blue,
                                        border: Border.all(
                                            color: ColorSelect.tabBorderColor),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          // uploadPdfIndividual();

                                          if (clientType == "Individual") {
                                            uploadPdfIndividual();
                                          }
                                          if (clientType == "Corporate") {
                                            uploadPdfCorporate();
                                          }
                                          if (clientType == "POA") {
                                            uploadPdfPOA();
                                          }
                                        },
                                        child: Text(
                                          "Submit",
                                          style: TextController.btnText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (sidebarVisible) SideBar() else Container(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Navigation(),
            ],
          ),
        ),
      ),
    );
  }
}
