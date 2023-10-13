import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:js' as js;
 import 'dart:convert'; 

class MainCompanySettings extends StatefulWidget {
  const MainCompanySettings({super.key});

  @override
  State<MainCompanySettings> createState() => _MainCompanySettingsState();
}

String EnglishLogo =
    "${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyLogo?language=English";

String ArabicLogo =
    "${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyLogo?language=Arabic";

class _MainCompanySettingsState extends State<MainCompanySettings> {
  TextEditingController CompanyNameEn = new TextEditingController();
  TextEditingController CompanyNameAr = new TextEditingController();
  TextEditingController PEmail = new TextEditingController();
  TextEditingController SEmail = new TextEditingController();
  TextEditingController PNumber = new TextEditingController();
  TextEditingController SNumber = new TextEditingController();
  TextEditingController Website = new TextEditingController();

  Future<void> pickAndUploadImagEnglish() async {
    final imagePicker = ImagePicker();

    // Pick an image from the gallery or camera
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(
        () {
          EnglishLogo = pickedImage.path;
        },
      );
      print(EnglishLogo);
    }

    // Read the file as bytes
    final List<int> imageBytes = await pickedImage!.readAsBytes();

    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${GlobalPermission.urlLink}/api/CompanyDetail/UpdateEnglishLogo'),
    );
    print("Link Execute Hui");

    // Add the image file as a part of the request
    request.files.add(http.MultipartFile.fromBytes(
      'x',
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

  Future<void> pickAndUploadImagArabic() async {
    final imagePicker = ImagePicker();

    // Pick an image from the gallery or camera
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(
        () {
          ArabicLogo = pickedImage.path;
        },
      );
    }

    // Read the file as bytes
    final List<int> imageBytes = await pickedImage!.readAsBytes();

    // Create a multipart request
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${GlobalPermission.urlLink}/api/CompanyDetail/UpdateArabicLogo'),
    );
    print("Link Execute Hui");

    // Add the image file as a part of the request
    request.files.add(http.MultipartFile.fromBytes(
      'x',
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

  String imageUrl = '${GlobalPermission.urlLink}/api/Image/EastBridgeLogo';

  var extentions = ["jpg", "png"];



void SendData() async {
  var body = {
    "companyNameEnglish": CompanyNameEn.text,
    "companyNameArabic": CompanyNameAr.text,
    "companyEmail": PEmail.text,
    "companyEmail2": SEmail.text,
    "companyContactNumber": PNumber.text,
    "companyContactNumber2": SNumber.text,
    "companyUrl": Website.text
  };

  print(body);

  var headers = {
    'Content-Type': 'application/json',
  };

  var url = Uri.parse(
      '${GlobalPermission.urlLink}/api/CompanyDetail/InsertCompanyDetails'); // Replace with your API endpoint

  var response = await http.post(
    url,
    headers: headers,
    body: jsonEncode(body), // Encode the body as JSON
  );

  if (response.statusCode == 200) {
    print("Successful");
    // You can refresh the page using Flutter's Navigator or other methods,
     js.context.callMethod('eval', ['location.reload();']);
  } else {
    print('Request failed with status: ${response.body}');
  }
}


  //Get API
  Future<void> fetchData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyDetails'); // Replace with your API endpoint
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print("Successfull");
      // Request was successful
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      setState(() {
        CompanyNameEn.text = jsonResponse['companyNameEnglish'];
        CompanyNameAr.text = jsonResponse['companyNameArabic'];
        PEmail.text = jsonResponse['companyEmail'];
        SEmail.text = jsonResponse['companyEmail2'];
        PNumber.text = jsonResponse['companyContactNumber'];
        SNumber.text = jsonResponse['companyContactNumber2'];
        Website.text = jsonResponse['companyUrl'];
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  //   TextEditingController CompanyNameEn = new TextEditingController();
  // TextEditingController CompanyNameAr = new TextEditingController();
  // TextEditingController PEmail = new TextEditingController();
  // TextEditingController SEmail = new TextEditingController();
  // TextEditingController PNumber = new TextEditingController();
  // TextEditingController SNumber = new TextEditingController();
  // TextEditingController Website = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 1, color: ColorSelect.tabBorderColor),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Company Settings",
                    style: TextController.SubHeadingText,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 0.5,
                            color: ColorSelect.tabBorderColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: ColorSelect.east_grey,
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Custom Company Logo",
                              style: TextController.BodyHeadingText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "English",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          // margin: EdgeInsets.only(left: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // padding:
                                                //     EdgeInsets.symmetric(horizontal: 15),
                                                // alignment: Alignment.centerLeft,
                                                child: Image.network(
                                                  EnglishLogo,
                                                  width: 196.0,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    pickAndUploadImagEnglish();
                                                  },
                                                  child: Text("Upload"),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "Arabic",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          // margin: EdgeInsets.only(left: 50),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // padding:
                                                //     EdgeInsets.symmetric(horizontal: 15),
                                                // alignment: Alignment.centerLeft,
                                                child: Image.network(
                                                  ArabicLogo,
                                                  width: 196.0,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 15),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    pickAndUploadImagArabic();
                                                  },
                                                  child: Text("Upload"),
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            color: ColorSelect.east_grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Custom Company Name",
                              style: TextController.BodyHeadingText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "English",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: CompanyNameEn,
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Enter Company Name",
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "Arabic",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: CompanyNameAr,
                                          textDirection: TextDirection.rtl,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[\u0600-\u06FF\s]')),
                                          ],
                                          decoration: InputDecoration(
                                              isDense: true,
                                              hintText: "Enter Company Name",
                                              hintStyle:
                                                  TextController.labelText,
                                              border: InputBorder.none,
                                              errorStyle: TextController
                                                  .inputErrorText),
                                        ),
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
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: ColorSelect.tabBorderColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            color: ColorSelect.east_grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Company Email",
                              style: TextController.BodyHeadingText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "Primary Email",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: PEmail,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Enter Email",
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "Secondary Email",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: SEmail,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Enter Email",
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: ColorSelect.tabBorderColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            color: ColorSelect.east_grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Company Help Line",
                              style: TextController.BodyHeadingText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          "Primary Number",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: PNumber,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Enter Number",
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(left: 50),
                                        width: 150,
                                        child: Text(
                                          // textAlign: TextAlign.center,
                                          "Secondary Number",
                                          style: TextController.BodyHeadingText,
                                        ),
                                      ),
                                      Container(
                                        width: 270,
                                        height: 35,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        // margin: EdgeInsets.only(left: 50),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorSelect.textField),
                                        ),
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: TextController.BodyText,
                                          controller: SNumber,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Enter Number",
                                            hintStyle: TextController.labelText,
                                            border: InputBorder.none,
                                            errorStyle:
                                                TextController.inputErrorText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: ColorSelect.tabBorderColor,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: double.infinity,
                            color: ColorSelect.east_grey,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Text(
                              "Company Website",
                              style: TextController.BodyHeadingText1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(left: 50),
                                  width: 150,
                                  child: Text(
                                    // textAlign: TextAlign.center,
                                    "Edit URL",
                                    style: TextController.BodyHeadingText,
                                  ),
                                ),
                                Container(
                                  width: 270,
                                  height: 35,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  // margin: EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: ColorSelect.textField),
                                  ),
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.center,
                                    style: TextController.BodyText,
                                    controller: Website,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: "Enter Your Website",
                                      hintStyle: TextController.labelText,
                                      border: InputBorder.none,
                                      errorStyle: TextController.inputErrorText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 50,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 35,
                      width: 140,
                      decoration: BoxDecoration(
                        color: ColorSelect.east_blue,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorSelect.east_blue),
                        ),
                        onPressed: () {
                          SendData();
                          
                          // AddNew();
                        },
                        child: Text(
                          S.of(context).Save,
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
    );
  }
}
