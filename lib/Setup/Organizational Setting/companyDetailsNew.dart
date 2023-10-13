// import 'package:east_bridge/Advisory/AdvisoryGlobal.dart';
import 'dart:typed_data';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/bankSettings.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/mainCompanySettings.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/themeSetting.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:js' as js;
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/BranchSettings.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/EmployeeSettings.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/departmentSettings.dart';
import 'package:east_bridge/Setup/Organizational%20Setting/Company%20Details%20Component/officeSettings.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetailsNew extends StatefulWidget {
  const CompanyDetailsNew({super.key});

  @override
  State<CompanyDetailsNew> createState() => _CompanyDetailsNewState();
}

class _CompanyDetailsNewState extends State<CompanyDetailsNew> {
  bool isCompany = false;
  bool isBranch = false;
  bool isOffice = false;
  bool isDepartments = false;
  bool isEmployees = false;
  bool isBank = true;
  bool isLicense = false;
  bool isTheme = false;
  late final id;

  TextEditingController CompanyName = new TextEditingController();

  String deparment = "";
  var deparmentList = [""];
  String employees = "";
  var employeesList = [""];
  String deparment2 = "";
  var deparmentList2 = [""];
  String employees2 = "";
  var employeesList2 = [""];
  bool isChange = false;
  String logo = "English-Logo.jpeg";
  late Map<String, dynamic> permission = {};
  static List<TextEditingController> li = [];
  static List<TextEditingController> duration = [];

  var branchData = {
    "Branch 1": "office 1",
    "Branch 2": "office 2",
    "Branch 3": "office 3",
  };

  List li1 = [];
  List li2 = [];

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

  String imageUrl =
      '${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyLogo?language=English';

  var extentions = ["jpg", "png"];

  Future<void> pickAndUploadImage() async {
    final imagePicker = ImagePicker();

    // Pick an image from the gallery or camera
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      // User canceled image selection
      return;
    }

    // Read the file as bytes
    final List<int> imageBytes = await pickedImage.readAsBytes();

    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(
          '${GlobalPermission.urlLink}/api/CompanyDetail/UpdateEnglishLogo'),
    );
    print("Link Execute Hui");

    // Add the image file as a part of the request
    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageBytes,
      filename: 'image.jpg',
      contentType:
          MediaType('image', 'jpeg'), // Replace with the correct MIME type
    ));

    final response = await request.send();
    print("Final tak pahuncha");

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Image uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      print('Failed to upload image. Status code: ${response.statusCode}');
      print(response.statusCode);
      print(response);
      print('Failed to upload image. Status code: ${response.statusCode}');
      final responseString = await response.stream.bytesToString();
      print('Response body: $responseString');
      // print(jsonDecode(response));
      print("Error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      // String logo = "English-Logo.jpeg";
      li1 = branchData.keys.toList();
      li2 = branchData.values.toList();
    });
  }

  void EditLogo() {
    showDialog(
      context: context,
      builder: (builder) {
        return Container(
          child: AlertDialog(
            title: Text(
              "Edit Company Logo and Name",
              style: TextController.BodyHeadingText,
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 350,
                  child: Column(
                    children: [
                      MouseRegion(
                        onEnter: (event) {
                          setState(
                            () {
                              isChange = true;
                            },
                          );
                        },
                        onExit: (event) {
                          setState(
                            () {
                              isChange = false;
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: ColorSelect.tabBorderColor),
                              ),
                              alignment: Alignment.center,
                              child: Image.network(
                                imageUrl,
                                // Use the imageKey here
                                width: 196.0,
                              ),
                            ),
                            if (isChange)
                              GestureDetector(
                                onTap: () {
                                  imageCache.clear();
                                  imageCache.clearLiveImages();
                                  pickAndUploadImage();
                                  print("object");
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.black87,
                                    border: Border.all(
                                        width: 0.5,
                                        color: ColorSelect.tabBorderColor),
                                  ),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.photo_camera_rounded,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "${logo}",
                          style: TextController.BodyHeadingText,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Company Name",
                            style: TextController.BodyText,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            width: 250,
                            height: 35,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField),
                            ),
                            child: TextFormField(
                              controller: CompanyName,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextController.BodyText,
                              decoration: InputDecoration(
                                  isDense: true,
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).Cancel,
                ),
              ),
              TextButton(
                onPressed: () {
                  js.context.callMethod('eval', ['location.reload();']);
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Save Changes",
                ),
              ),
            ],
          ),
        );
      },
    );
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
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) =>
                                        //       CorporateKYC(""),
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
                                        //   builder: (context) =>
                                        //       KYCPdfUploadIND(),
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
                                // download
                                if (permission['Download'] == true)
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
                                        //   builder: (context) =>
                                        //       KYCPdfUploadIND(),
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
                                    onPressed: () {
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       CorporateDraftList(),
                                      // ));
                                    },
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
                                              "Draft",
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
                      ), // HEADER END

                      Stack(
                        children: [
                          AnimatedContainer(
                            transform: Matrix4.translationValues(
                                xOffset, yOffset, 1.0),
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorSelect.tabBorderColor,
                                        width: 0.5,
                                      ),
                                      color: Color(0xFFF6F7FB),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            S.of(context).CompanyDetails,
                                            style:
                                                TextController.MainHeadingText,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 300,
                                        margin: EdgeInsets.all(15),
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1,
                                              color:
                                                  ColorSelect.tabBorderColor),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              width: 160,
                                              alignment: Alignment.center,
                                              child: Image.network(
                                                imageUrl,
                                                width: 196.0,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Row(
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        "East Bridge Capital",
                                                        style: TextController
                                                            .BodyHeadingText,
                                                      ),
                                                    ),
                                                  ),
                                                  // GestureDetector(
                                                  //   onTap: () {
                                                  //     EditLogo();
                                                  //   },
                                                  //   child: Container(
                                                  //     child: Icon(
                                                  //       Icons.edit,
                                                  //       color: ColorSelect
                                                  //           .east_blue,
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = true;
                                                  isLicense = false;
                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = false;
                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isCompany)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    // bottom: BorderSide(
                                                    //     width: 0.5,
                                                    //     color: ColorSelect
                                                    //         .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.settings_suggest,
                                                        color: (isCompany)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Company Settings",
                                                          style: (isCompany)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isCompany)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            //     setState(() {
                                            //       isCompany = false;
                                            //       isLicense = true;
                                            //       isBranch = false;
                                            //       isOffice = false;
                                            //       isDepartments = false;
                                            //       isEmployees = false;
                                            //       isBank = false;
                                            //       isTheme = false;
                                            //     });
                                            //   },
                                            //   child: Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: 15,
                                            //         vertical: 15),
                                            //     decoration: BoxDecoration(
                                            //       color: (isLicense)
                                            //           ? ColorSelect.east_blue
                                            //           : Colors.white,
                                            //       border: Border(
                                            //         top: BorderSide(
                                            //             width: 0.5,
                                            //             color: ColorSelect
                                            //                 .tabBorderColor),
                                            //         // bottom: BorderSide(
                                            //         //     width: 0.5,
                                            //         //     color: ColorSelect
                                            //         //         .tabBorderColor),
                                            //       ),
                                            //     ),
                                            //     width: double.infinity,
                                            //     child: Row(
                                            //       children: [
                                            //         Container(
                                            //           child: Icon(
                                            //             Icons.policy_sharp,
                                            //             color: (isLicense)
                                            //                 ? Colors.white
                                            //                 : ColorSelect
                                            //                     .east_blue,
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           width: 20,
                                            //         ),
                                            //         Flexible(
                                            //           child: Container(
                                            //             width: double.infinity,
                                            //             child: Text(
                                            //               "License Settings",
                                            //               style: (isLicense)
                                            //                   ? TextController
                                            //                       .btnText
                                            //                   : TextController
                                            //                       .SideMenuText,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         Container(
                                            //           child: Icon(
                                            //             Icons.arrow_right,
                                            //             color: (isLicense)
                                            //                 ? Colors.white
                                            //                 : ColorSelect
                                            //                     .east_blue,
                                            //           ),
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = true;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = false;
                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isBranch)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    // bottom: BorderSide(
                                                    //     width: 0.5,
                                                    //     color: ColorSelect
                                                    //         .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.room,
                                                        color: (isBranch)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Branch Settings",
                                                          style: (isBranch)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isBranch)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = false;
                                                  isOffice = true;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = false;
                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isOffice)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    // bottom: BorderSide(
                                                    //     width: 0.5,
                                                    //     color: ColorSelect
                                                    //         .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.work,
                                                        color: (isOffice)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Office Settings",
                                                          style: (isOffice)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isOffice)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = true;
                                                  isEmployees = false;
                                                  isBank = false;
                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isDepartments)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    // bottom: BorderSide(
                                                    //     width: 0.5,
                                                    //     color: ColorSelect
                                                    //         .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.library_books,
                                                        color: (isDepartments)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Department Settings",
                                                          style: (isDepartments)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isDepartments)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = true;
                                                  isBank = false;

                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isEmployees)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.person,
                                                        color: (isEmployees)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Employees Settings",
                                                          style: (isEmployees)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isEmployees)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = true;

                                                  isTheme = false;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isBank)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.monetization_on,
                                                        color: (isBank)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Bank Settings",
                                                          style: (isBank)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isBank)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;
                                                  isLicense = false;

                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = false;
                                                  isTheme = true;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isTheme)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons
                                                            .color_lens_rounded,
                                                        color: (isTheme)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Theme Settings",
                                                          style: (isTheme)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isTheme)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isCompany = false;

                                                  isBranch = false;
                                                  isOffice = false;
                                                  isDepartments = false;
                                                  isEmployees = false;
                                                  isBank = true;
                                                });
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15,
                                                    vertical: 15),
                                                decoration: BoxDecoration(
                                                  color: (isBank)
                                                      ? ColorSelect.east_blue
                                                      : Colors.white,
                                                  border: Border(
                                                    top: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                    bottom: BorderSide(
                                                        width: 0.5,
                                                        color: ColorSelect
                                                            .tabBorderColor),
                                                  ),
                                                ),
                                                width: double.infinity,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.monetization_on,
                                                        color: (isBank)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Flexible(
                                                      child: Container(
                                                        width: double.infinity,
                                                        child: Text(
                                                          "Bank Settings",
                                                          style: (isBank)
                                                              ? TextController
                                                                  .btnText
                                                              : TextController
                                                                  .SideMenuText,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Icon(
                                                        Icons.arrow_right,
                                                        color: (isBank)
                                                            ? Colors.white
                                                            : ColorSelect
                                                                .east_blue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (isCompany)
                                        Flexible(
                                          child: MainCompanySettings(),
                                        ),
                                      // if (isLicense)
                                      //   Flexible(
                                      //     child: CompanyLicense(),
                                      //   ),
                                      if (isBranch)
                                        Flexible(
                                          child: BranchSettingsMain(),
                                        ),
                                      if (isOffice)
                                        Flexible(
                                          child: OfficeSettingsMain(),
                                        ),
                                      if (isDepartments)
                                        Flexible(
                                          child: DepartmentSettingsMain(),
                                        ),
                                      if (isEmployees)
                                        Flexible(
                                          child: EmployessSettingsMain(),
                                        ),
                                      if (isBank)
                                        Flexible(
                                          child: BankSettings(),
                                        ),
                                      if (isTheme)
                                        Flexible(
                                          child: ThemeSettings(),
                                        ),
                                    ],
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
