import 'dart:convert';
import 'dart:typed_data';
import 'package:east_bridge/DPM/DPM%20Agreement/CustomerDPMAgreementSearch.dart';
import 'package:east_bridge/DPM/DPMAgreementDownload.dart/DPMAgreementCustomerSearch.dart';
import 'package:east_bridge/NDPM/NDPMAgreementDownload.dart/NDPMAgreementCustomerSearch.dart';

import 'package:dio/dio.dart';
import 'package:east_bridge/FundAgreement/Customer%20Fund%20Agreement/Customer%20Fund%20Agreement/AgreementUploadCustomerSearch.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCUploadCustomerSearh.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

class NDPMPdfDownloadUpload extends StatefulWidget {
  @override
  NDPMPdfDownloadUploadState createState() => NDPMPdfDownloadUploadState();
  static ValueNotifier<int> id = new ValueNotifier(0);
  static ValueNotifier<String> clientName = new ValueNotifier("");
}

int? Id;

class NDPMPdfDownloadUploadState extends State<NDPMPdfDownloadUpload> {
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

  TextEditingController clientName = new TextEditingController();

  String clientType = "";
  var f1 = ["Please Search Client First"];
  var fundlist = [];
  String? ClientTypeDropdownvalue;
  var psv = {};
  List fundListkey = [];

  var fundMap = {};
  var key = {};
  var key1;

  void getAgreementList() async {
    print("clientid-------------");

    var url = Uri.parse(
        'https://eastbridge.online/apicore/api/GetNDPMAgreementNameByclientId/GetNDPMTemplateNamesByClientId?CustomerId=${NDPMPdfDownloadUpload.id.value}');

    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("----------done");
        var responseData = jsonDecode(response.body);
        print(responseData);
        setState(() {
          fundMap = responseData;
          f1.clear();
          fundlist = fundMap.values.toList();
          for (String i in fundlist) {
            f1.add(i.split(" ")[0]);
          }

          fundListkey = fundMap.keys.toList();
        });
        print("------f--");
        print(fundMap);
        print(psv);

        print("-------fl---done");
        print(fundlist);
        print("-------f1111---done");
        print(f1);
        print("------kyy----done");
        print(fundListkey);
        print(responseData);
      } else {
        var errorMessage = response.reasonPhrase;
        print(response.statusCode);
        print(response.body);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      clientName.text = NDPMPdfDownloadUpload.clientName.value;
    });
    getAgreementList();
  }

  final Dio dio = Dio();
  void agreementDownload() async {
    var li = fundMap.keys.toList();
    li.forEach((i) {
      if (fundMap[i] == ClientTypeDropdownvalue) {
        key1 = i;
      }
    });

    var downloadUrl =
        'https://eastbridge.online/apicore/api/FetchAgreemntOfNDPM/FetchNDPMPDF?ClientId=${NDPMPdfDownloadUpload.id.value}';
    var filename =
        '${NDPMPdfDownloadUpload.clientName.value}_NDPM.pdf'; // Set the desired filename

    try {
      final response = await dio.getUri(Uri.parse(downloadUrl),
          options: Options(responseType: ResponseType.bytes));

      if (response.statusCode == 200) {
        var responseData = response.data as Uint8List;

        // Trigger the file download
        downloadFile(responseData, filename);
      } else {
        var errorMessage = response.statusMessage;
        print(response.statusCode);
        print(response.data);
        print("error");
        print(errorMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void downloadFile(Uint8List data, String filename) {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchorElement = html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..style.display = 'none';

    html.document.body?.children.add(anchorElement);

    anchorElement.click();

    html.document.body?.children.remove(anchorElement);

    html.Url.revokeObjectUrl(url);
  }

  Future<void> uploadPdf() async {
    var dio = Dio();
    var li = fundMap.keys.toList();
    li.forEach((i) {
      if (fundMap[i] == ClientTypeDropdownvalue) {
        key1 = i;
      }
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      String fileName = file.name;
      Uint8List fileBytes = file.bytes!;

      FormData data = FormData.fromMap({
        'ClientId': NDPMPdfDownloadUpload.id.value,
        'form': MultipartFile.fromBytes(fileBytes, filename: fileName),
      });

      var response = await dio.post(
        "https://eastbridge.online/apicore/api/NDPMDocUpload/NDPMDocUpload/",
        data: data,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
      print(response.toString());
    } else {
      print("Result is Null");
    }
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

                                // new
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
                                // download
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
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
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
                                            S
                                                .of(context)
                                                .NDPMAgreementTemplateUpload,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  NDPMAgreementCustomerSearch(),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).ClientName,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 280,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            controller: clientName,
                                            readOnly: true,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            onChanged: (value) {
                                              print("onchangeeeeeeeeee");
                                              getAgreementList();
                                            },
                                            style:
                                                TextController.BodyHeadingText,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                hintText:
                                                    S.of(context).TypeHere,
                                                hintStyle:
                                                    TextController.labelText,
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        S.of(context).SelectAgreementName,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 280,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: DropdownButton(
                                            hint: Text("Select Here",
                                                style:
                                                    TextController.labelText),
                                            value: ClientTypeDropdownvalue,
                                            isExpanded: true,
                                            underline: Container(),
                                            iconEnabledColor:
                                                ColorSelect.east_dark_blue,
                                            items: f1.map(
                                              (String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    style:
                                                        TextController.BodyText,
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                            onChanged: (newValue) {
                                              setState(
                                                () {
                                                  print(fundMap);

                                                  ClientTypeDropdownvalue =
                                                      newValue;
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
                                              if (NDPMPdfDownloadUpload
                                                      .clientName.value ==
                                                  "") {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                          "Please Search Customer First",
                                                          style: TextController
                                                              .SubHeadingText,
                                                        ),
                                                        actions: <Widget>[
                                                          Container(
                                                            height: 35,
                                                            width: 140,
                                                            decoration: BoxDecoration(
                                                                color: ColorSelect
                                                                    .east_blue,
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .tabBorderColor)),
                                                            child: TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .OK,
                                                                style:
                                                                    TextController
                                                                        .btnText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                agreementDownload();
                                              }
                                            },
                                            child: Text(
                                              S.of(context).Download,
                                              style:
                                                  TextController.SideMenuText,
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
                                                color:
                                                    ColorSelect.tabBorderColor),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              if (NDPMPdfDownloadUpload
                                                      .clientName.value ==
                                                  "") {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Text(
                                                          "Please Search Customer First",
                                                          style: TextController
                                                              .SubHeadingText,
                                                        ),
                                                        actions: <Widget>[
                                                          Container(
                                                            height: 35,
                                                            width: 140,
                                                            decoration: BoxDecoration(
                                                                color: ColorSelect
                                                                    .east_blue,
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .tabBorderColor)),
                                                            child: TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  Navigator.pop(
                                                                      context);
                                                                });
                                                              },
                                                              child: Text(
                                                                S
                                                                    .of(context)
                                                                    .OK,
                                                                style:
                                                                    TextController
                                                                        .btnText,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                uploadPdf();
                                              }
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
