import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/GlobalCorporate.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../RiskAssessmentFormInvidual.dart';

enum SingingCharacter { yes, no }

class CC3 extends StatefulWidget {
  //const ClientClassification({Key? key}) : super(key: key);
  CC3({@required controller}) {
    tabController = controller;
  }
  @override
  State<CC3> createState() => _CC3State();
  static ValueNotifier<int> id = ValueNotifier(0);
}

TabController? tabController;
bool isChecked0 = false;
bool isChecked = false;
bool isChecked2 = false;
bool isChecked3 = false;
bool isChecked4 = false;
bool isChecked5 = false;
bool isChecked6 = false;
bool isChecked7 = false;
bool isChecked8 = false;
bool isChecked9 = false;
bool isChecked10 = false;
bool isChecked11 = false;
bool isChecked12 = false;
bool isChecked13 = false;
bool isChecked14 = false;
bool isChecked15 = false;
bool isChecked16 = false;
bool isChecked17 = false;
bool isChecked18 = false;
bool isChecked19 = false;
bool isChecked20 = false;
bool isChecked21 = false;
bool isChecked22 = false;
bool isChecked23 = false;

bool isButtonEnabled = false;

String fileName0 = "";
String fileName1 = "";
String fileName2 = "";
String fileName3 = "";
String fileName4 = "";
String fileName5 = "";
String fileName6 = "";
String fileName7 = "";
String fileName8 = "";
String fileName9 = "";
String fileName10 = "";
String fileName11 = "";
String fileName12 = "";
String fileName13 = "";
String fileName14 = "";
String fileName15 = "";
String fileName16 = "";
String fileName17 = "";
String fileName18 = "";
String fileName19 = "";
String fileName20 = "";
String fileName21 = "";
String fileName22 = "";
String fileName23 = "";
Uint8List fileBytes0 = new Uint8List(500);
Uint8List fileBytes1 = new Uint8List(500);
Uint8List fileBytes2 = new Uint8List(500);
Uint8List fileBytes3 = new Uint8List(500);
Uint8List fileBytes4 = new Uint8List(500);
Uint8List fileBytes5 = new Uint8List(500);

Uint8List fileBytes6 = new Uint8List(500);

Uint8List fileBytes7 = new Uint8List(500);
Uint8List fileBytes8 = new Uint8List(500);
Uint8List fileBytes9 = new Uint8List(500);
Uint8List fileBytes10 = new Uint8List(500);
Uint8List fileBytes11 = new Uint8List(500);
Uint8List fileBytes12 = new Uint8List(500);
Uint8List fileBytes13 = new Uint8List(500);
Uint8List fileBytes14 = new Uint8List(500);
Uint8List fileBytes15 = new Uint8List(500);

Uint8List fileBytes16 = new Uint8List(500);
Uint8List fileBytes17 = new Uint8List(500);
Uint8List fileBytes18 = new Uint8List(500);
Uint8List fileBytes19 = new Uint8List(500);
Uint8List fileBytes20 = new Uint8List(500);
Uint8List fileBytes21 = new Uint8List(500);
Uint8List fileBytes22 = new Uint8List(500);
Uint8List fileBytes23 = new Uint8List(500);
String ClientType = "";

class _CC3State extends State<CC3> {
  String btn = "Next";
  // CC2({@required controller}) {
  //   tabController = controller;
  // }

  var dio = Dio();

  void _onButtonPressed() {
    // Handle button press
    print("Button Pressed");
  }

  void showHtmlAlert(BuildContext context, String htmlContent) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please Click on This Link To Read Relavant Definitions'),
          content: SingleChildScrollView(
            child: Container(width: 800, child: Html(data: htmlContent)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String htmlContent = '''

<html lang="en">

<head>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        th,
        td {
            padding: 10px;
            flex: 50;
        }

        tr {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>

<body>
    <table>
        <tr>
            <th><b>Definitions</b></th>
            <th style="text-align: end;">تعريفات</th>
        </tr>
        <tr>
            <td><b>Retail client:</b> Any client who is not a qualified client or an institutional client.</td>
            <td style="text-align: end;"><b>عميل التجزئة:</b> أي عميل ليس عميلاً مؤهلاً أو عميلاً مؤسسيًا. </td>
        </tr>
        <tr>
            <td style="text-align: justify;"><b>Qualified client:</b> means any of the following:- A) a natural person who meets at least one
                of the following criteria: 1) has carried out at least 10 transactions per quarter over the
                last 12 months of a minimum total amount of 40 million Saudi Riyals on securities
                markets; 2) his net assets is not less than 5 million Saudi Riyals. 3) Works or has worked
                for at least three years in the financial sector in a professional position related to
                investment in securities. 4) holds a professional certificate in securities business and
                accredited by an internationally recognized entity. 5) holds the General Securities
                Qualification Certificate that is recognized by the Authority, and has an annual income
                that is not less than 600,000 Saudi Riyals in the last two years. 6) being a client of a
                Capital Market Institution authorized by the Authority to conduct managing activities,
                provided that the following is fulfilled: a. the offer shall be made to the Capital Market
                Institution, and that all related communications be made by it. b. the Capital Market
                Institution has been appointed on terms which enable it to make investment decisions on
                the client’s behalf without obtaining prior approval from the client. 31 7) registered
                persons of a Capital Market Institution if the offer is carried out by the Capital Market
                Institution itself. B) a legal person, which meets at least one of the following criteria: 1)
                any legal person acting for its own account and be any of the following: a. a company
                which owns, or which is a member of a group which owns, net assets of not less than 10
                million Saudi Riyals and not more than 50 million Saudi Riyals. b. any unincorporated
                body, partnership company or other organization which has net assets of not less than 10
                million Saudi Riyals and not more than 50 million Saudi riyals. c. a person acting in the
                capacity of director, officer or employee of a legal person and responsible for its securities
                activity, where that legal person falls within the definition of paragraph (1/a) or (1/b). 2)
                clients of a Capital Market Institution authorized by the Authority to conduct managing
                activities, provided that the following is fulfilled: a. the offer shall be made to the Capital
                Market Institution, and that all related communications be made by it; and b. the Capital
                Market Institution has been appointed on terms which enable it to make investment
                decisions on the client’s behalf without obtaining prior approval from the client. C) a
                company fully owned by a natural person who meets one of the criteria mentioned in
                paragraph (A) or a legal person who meets one of the criteria mentioned in paragraph (B)</td>
            <td style="text-align:justify ;direction: rtl;">العميل المؤهل: يعني أي مما يلي:- أ) الشخص الطبيعي الذي يستوفي واحدًا على الأقل من المعايير التالية: 1)
                أجرى ما لا يقل عن 10 معاملات ربع سنوية على مدار الـ 12 شهرًا الأخيرة بمبلغ إجمالي لا يقل عن 40 مليون
                سعودي. الريال في أسواق الأوراق المالية؛ 2) ألا يقل صافي أصوله عن 5 ملايين ريال سعودي. 3) أن يعمل أو عمل
                لمدة ثلاث سنوات على الأقل في القطاع المالي في وظيفة مهنية تتعلق بالاستثمار في الأوراق المالية. 4) حاصل
                على شهادة مهنية في أعمال الأوراق المالية ومعتمدة من جهة معترف بها دولياً. 5) أن يكون حاصلاً على شهادة
                التأهيل العام للأوراق المالية المعترف بها من قبل الهيئة، وأن لا يقل دخله السنوي عن 600,000 ريال سعودي في
                العامين الأخيرين. 6) أن يكون عميلاً لإحدى مؤسسات السوق المالية المرخص لها من قبل الهيئة بمزاولة أعمال
                الإدارة، بشرط استيفاء ما يلي: أ. يجب أن يتم تقديم العرض إلى مؤسسة السوق المالية، وأن تتم جميع الاتصالات
                ذات الصلة من قبلها. ب. تم تعيين مؤسسة السوق المالية بشروط تمكنها من اتخاذ قرارات الاستثمار نيابة عن
                العميل دون الحصول على موافقة مسبقة من العميل. 31 7) الأشخاص المسجلون لدى مؤسسة السوق المالية إذا تم
                تنفيذ الطرح من قبل مؤسسة السوق المالية نفسها. ب) الشخص الاعتباري الذي يستوفي أحد المعايير التالية على
                الأقل: 1) أي شخص اعتباري يعمل لحسابه الخاص ويكون أياً مما يلي: أ. الشركة التي تمتلك أو تكون عضواً في
                مجموعة تمتلك أصولاً صافية لا تقل عن 10 ملايين ريال سعودي ولا تزيد على 50 مليون ريال سعودي. ب. أي هيئة
                فردية أو شركة تضامن أو منظمة أخرى لا يقل صافي أصولها عن 10 ملايين ريال سعودي ولا
            </td>
        </tr>
        <tr>
            <td style="text-align: justify;"><b>Institutional client:</b> means any of the following: a. the Government of the Kingdom or
                any supranational authority recognized by the Authority. b. companies fully owned by
                the government or any government entity, either directly or through a portfolio managed
                by a Capital Market Institution authorized to carry on managing business. c. any legal
                person acting for its own account and be any of the following: 1) a company which owns,
                or is a member of a group which owns, net assets of more than 50 million Saudi Riyals;
                2) an unincorporated body, partnership company or other organization which has net
                assets of more than 50 million Saudi riyals. 3) a person acting in the capacity of director,
                officer or employee of a legal person and responsible for its securities activity, where that
                legal person falls within the definition of paragraph (c/1) or (c/2). d. a company fully
                owned by a legal person who meets the criteria of paragraph (b) or (c). e. an investment
                fund. f. a counterparty.</td>
            <td style="text-align: justify;direction: rtl;">العميل المؤسسي: يعني أياً مما يلي: أ. حكومة المملكة أو أي سلطة فوق وطنية تعترف بها الهيئة. ب. الشركات
                المملوكة بالكامل للحكومة أو أي جهة حكومية، سواء بشكل مباشر أو من خلال محفظة تدار من قبل مؤسسة سوق رأس
                المال المرخص لها بممارسة إدارة الأعمال. ج. أي شخص اعتباري يعمل لحسابه الخاص ويكون أياً مما يلي: 1) شركة
                تمتلك أو تكون عضواً في مجموعة تمتلك أصولاً صافية تزيد عن 50 مليون ريال سعودي. 2) هيئة فردية أو شركة
                تضامن أو منظمة أخرى يزيد صافي أصولها على 50 مليون ريال سعودي. 3) شخص يتصرف بصفة مدير أو مسؤول أو موظف في
                شخص اعتباري ومسؤول عن نشاط الأوراق المالية فيه، حيث يقع هذا الشخص الاعتباري ضمن تعريف الفقرة (ج/1) أو
                (ج/2). د. شركة مملوكة بالكامل لشخص اعتباري يستوفي شروط الفقرة (ب) أو (ج). ه. صندوق استثمار. F. الطرف
                المقابل.
            </td>
        </tr>
    </table>
</body>

</html>


''';

  @override
  Widget build(BuildContext context) {
    int selectedValue = -1;
    @override
    void initState() {
      super.initState();
    }

    String? _selectedFileName;

    Future<void> uploadPdf(String f) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      print(f);
      if (result != null) {
        PlatformFile file = result.files.first;
        String fileName = file.name;
        List<int> bytes = file.bytes ?? [];
        if (fileName.endsWith('.pdf') || fileName.endsWith('.docx')) {
          if (f == "0") {
            fileName0 = file.name;
            fileBytes0 = file.bytes!;
            setState(() {
              _selectedFileName = fileName0;
            });
          }
          if (f == "1") {
            fileName1 = file.name;
            fileBytes1 = file.bytes!;
            setState(() {
              _selectedFileName = fileName1;
            });
          }
          if (f == "2") {
            fileName2 = file.name;
            fileBytes2 = file.bytes!;
            setState(() {
              _selectedFileName = fileName2;
            });
          }
          if (f == "3") {
            fileName3 = file.name;
            fileBytes3 = file.bytes!;
            setState(() {
              _selectedFileName = fileName3;
            });
          }
          if (f == "4") {
            fileName4 = file.name;
            fileBytes4 = file.bytes!;
            setState(() {
              _selectedFileName = fileName4;
            });
          }
          if (f == "5") {
            fileName5 = file.name;
            fileBytes5 = file.bytes!;
            setState(() {
              _selectedFileName = fileName5;
            });
          }
          if (f == "6") {
            fileName6 = file.name;
            fileBytes6 = file.bytes!;
            setState(() {
              _selectedFileName = fileName6;
            });
          }
          if (f == "7") {
            fileName7 = file.name;
            fileBytes7 = file.bytes!;
            setState(() {
              _selectedFileName = fileName7;
            });
          }
          if (f == "8") {
            fileName8 = file.name;
            fileBytes8 = file.bytes!;
            setState(() {
              _selectedFileName = fileName8;
            });
          }
          if (f == "9") {
            fileName9 = file.name;
            fileBytes9 = file.bytes!;
            setState(() {
              _selectedFileName = fileName9;
            });
          }
          if (f == "10") {
            fileName10 = file.name;
            fileBytes10 = file.bytes!;
            setState(() {
              _selectedFileName = fileName10;
            });
          }
          if (f == "11") {
            fileName11 = file.name;
            fileBytes11 = file.bytes!;
            setState(() {
              _selectedFileName = fileName11;
            });
          }
          if (f == "12") {
            fileName12 = file.name;
            fileBytes12 = file.bytes!;
            setState(() {
              _selectedFileName = fileName12;
            });
          }
          if (f == "13") {
            fileName13 = file.name;
            fileBytes13 = file.bytes!;
            setState(() {
              _selectedFileName = fileName13;
            });
          }
          if (f == "14") {
            fileName14 = file.name;
            fileBytes14 = file.bytes!;
            setState(() {
              _selectedFileName = fileName14;
            });
          }
          if (f == "15") {
            fileName15 = file.name;
            fileBytes15 = file.bytes!;
            setState(() {
              _selectedFileName = fileName15;
            });
          }
          if (f == "16") {
            fileName16 = file.name;
            fileBytes16 = file.bytes!;
            setState(() {
              _selectedFileName = fileName16;
            });
          }
          if (f == "17") {
            fileName17 = file.name;
            fileBytes17 = file.bytes!;
            setState(() {
              _selectedFileName = fileName17;
            });
          }
          if (f == "18") {
            fileName18 = file.name;
            fileBytes18 = file.bytes!;
            setState(() {
              _selectedFileName = fileName18;
            });
          }
          if (f == "19") {
            fileName19 = file.name;
            fileBytes19 = file.bytes!;
            setState(() {
              _selectedFileName = fileName19;
            });
          }
          if (f == "20") {
            fileName20 = file.name;
            fileBytes20 = file.bytes!;
            setState(() {
              _selectedFileName = fileName20;
            });
          }
          if (f == "21") {
            fileName21 = file.name;
            fileBytes21 = file.bytes!;
            setState(() {
              _selectedFileName = fileName21;
            });
          }
          if (f == "22") {
            fileName22 = file.name;
            fileBytes22 = file.bytes!;
            setState(() {
              _selectedFileName = fileName22;
            });
          }
          if (f == "23") {
            fileName23 = file.name;
            fileBytes23 = file.bytes!;
            setState(() {
              _selectedFileName = fileName23;
            });
          }
        } else {
          // Show an error message for invalid file extension
          Fluttertoast.showToast(
              msg: "Select a PDF or DOCX file.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }

/////

    void senddata() async {
      setState(() {
        btn = "Loading...";
      });
      FormData data = FormData.fromMap({
        'ClientId': GlobalPermissionCorporate.corporateclientid,
        'ClientType': ClientType,
        'RetailClientPdf':
            MultipartFile.fromBytes(fileBytes0, filename: fileName0),
        'QCPdfA1': MultipartFile.fromBytes(fileBytes1, filename: fileName1),
        'QCPdfA2': MultipartFile.fromBytes(fileBytes2, filename: fileName2),
        'QCPdfA3': MultipartFile.fromBytes(fileBytes3, filename: fileName3),
        'QCPdfA4': MultipartFile.fromBytes(fileBytes4, filename: fileName4),
        'QCPdfA5': MultipartFile.fromBytes(fileBytes5, filename: fileName5),
        'QCPdfA6A': MultipartFile.fromBytes(fileBytes6, filename: fileName6),
        'QCPdfA6B': MultipartFile.fromBytes(fileBytes7, filename: fileName7),
        'QCPdfA7': MultipartFile.fromBytes(fileBytes8, filename: fileName8),
        'QCPdfB1A': MultipartFile.fromBytes(fileBytes9, filename: fileName9),
        'QCPdfB1B': MultipartFile.fromBytes(fileBytes10, filename: fileName10),
        'QCPdfB1C': MultipartFile.fromBytes(fileBytes11, filename: fileName11),
        'QCPdfB2A': MultipartFile.fromBytes(fileBytes12, filename: fileName12),
        'QCPdfB2B': MultipartFile.fromBytes(fileBytes13, filename: fileName13),
        'QCPdfCA': MultipartFile.fromBytes(fileBytes14, filename: fileName14),
        'QCPdfCB': MultipartFile.fromBytes(fileBytes15, filename: fileName15),
        'ICPdfA': MultipartFile.fromBytes(fileBytes16, filename: fileName16),
        'ICPdfB': MultipartFile.fromBytes(fileBytes17, filename: fileName17),
        'ICPdfC1': MultipartFile.fromBytes(fileBytes18, filename: fileName18),
        'ICPdfC2': MultipartFile.fromBytes(fileBytes19, filename: fileName19),
        'ICPdfC3': MultipartFile.fromBytes(fileBytes20, filename: fileName20),
        'ICPdfD': MultipartFile.fromBytes(fileBytes21, filename: fileName21),
        'ICPdfE': MultipartFile.fromBytes(fileBytes22, filename: fileName22),
        'ICPdfF': MultipartFile.fromBytes(fileBytes23, filename: fileName23),
      });

      var response = await dio.post(
        "${GlobalPermission.urlLink}/api/ClientClassificationCorporate/ClientClassificationCorporate",
        data: data,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );

      if (response.statusCode == 200) {
        // Request successful, handle the response

        GlobalPermissionCorporate.getdraftprogresscorporate(
            GlobalPermissionCorporate.corporateclientid);

        tabController?.animateTo(4);
        setState(() {
          btn = "Next";
        });

        // var responseData = jsonDecode(response.toString());
        print("Successfull");
        // Process the responseData
      } else {
        setState(() {
          btn = "Next";
        });
        print(response.statusCode);

        print("Error");
        // Display or handle the error
      }
    }

    return Container(
      height: 650,
      color: Colors.white,
      child: Scaffold(
        body: Container(
          child: Form(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              showHtmlAlert(context, htmlContent);
                            },
                            child: Text(
                              "Read The Definition Of" +
                                  " Retail,Qualified & Institutional Client",
                              style: TextController.browseText,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: isChecked ||
                                    isChecked2 ||
                                    isChecked3 ||
                                    isChecked4 ||
                                    isChecked5 ||
                                    isChecked6 ||
                                    isChecked7 ||
                                    isChecked8 ||
                                    isChecked9 ||
                                    isChecked10 ||
                                    isChecked11 ||
                                    isChecked12 ||
                                    isChecked13 ||
                                    isChecked14 ||
                                    isChecked15 ||
                                    isChecked16 ||
                                    isChecked17 ||
                                    isChecked18 ||
                                    isChecked19 ||
                                    isChecked20 ||
                                    isChecked21 ||
                                    isChecked22 ||
                                    isChecked23
                                ? false
                                : true,
                            child: Expanded(
                              child: RadioListTile(
                                title: Text(
                                  S.of(context).RetailClient,
                                  style: TextController.BodyText,
                                ),
                                value: "Retail",
                                tileColor: Colors.white,
                                groupValue: ClientType,
                                onChanged: (value) {
                                  setState(() {
                                    ClientType = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isChecked0 ||
                                    isChecked16 ||
                                    isChecked17 ||
                                    isChecked18 ||
                                    isChecked19 ||
                                    isChecked20 ||
                                    isChecked21 ||
                                    isChecked22 ||
                                    isChecked23
                                ? false
                                : true,
                            child: Expanded(
                              child: RadioListTile(
                                title: Text(
                                  S.of(context).QualifiedClient,
                                  style: TextController.BodyText,
                                ),
                                value: "Qualified",
                                tileColor: Colors.white,
                                groupValue: ClientType,
                                onChanged: (value) {
                                  setState(() {
                                    ClientType = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isChecked0 ||
                                    isChecked ||
                                    isChecked2 ||
                                    isChecked3 ||
                                    isChecked4 ||
                                    isChecked5 ||
                                    isChecked6 ||
                                    isChecked7 ||
                                    isChecked8 ||
                                    isChecked9 ||
                                    isChecked10 ||
                                    isChecked11 ||
                                    isChecked12 ||
                                    isChecked13 ||
                                    isChecked14 ||
                                    isChecked15
                                ? false
                                : true,
                            child: Expanded(
                              child: RadioListTile(
                                title: Text(
                                  S.of(context).InstitutionalClient,
                                  style: TextController.BodyText,
                                ),
                                value: "Institutional",
                                tileColor: Colors.white,
                                groupValue: ClientType,
                                onChanged: (value) {
                                  setState(() {
                                    ClientType = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (ClientType == "Retail")
                        Visibility(
                          visible: true,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  S.of(context).CCRetail,
                                  style: TextController.BodyHeadingText,
                                ),
                              ),
                              // Container(
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(top: 40),
                              //     child: Table(
                              //       border: TableBorder.all(
                              //           color: ColorSelect.tabBorderColor),
                              //       defaultVerticalAlignment:
                              //           TableCellVerticalAlignment.middle,
                              //       columnWidths: {
                              //         0: FixedColumnWidth(1000),
                              //         1: FixedColumnWidth(50),
                              //         2: FixedColumnWidth(150),
                              //       },
                              //       children: [
                              //         TableRow(children: [
                              //           Container(
                              //               height: 50,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     top: 15, left: 10),
                              //                 child: Text(
                              //                   "Retail client:",
                              //                   style:
                              //                       TextController.tableHeading,
                              //                 ),
                              //               )),
                              //           Container(
                              //               height: 50,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     left: 10),
                              //                 child: Text(
                              //                   "",
                              //                   style: TextController.BodyText,
                              //                   maxLines: 3,
                              //                 ),
                              //               )),
                              //           Container(
                              //               height: 50,
                              //               child: Center(
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       top: 15, left: 10),
                              //                   child: Text(
                              //                     "Document Upload",
                              //                     style: TextController
                              //                         .tableHeading,
                              //                     maxLines: 3,
                              //                   ),
                              //                 ),
                              //               )),
                              //         ]),
                              //         TableRow(children: [
                              //           Container(
                              //             height: 80,
                              //             child: Padding(
                              //               padding: const EdgeInsets.only(
                              //                   top: 15, left: 10),
                              //               child: Text(
                              //                 "Any client who is not a qualified client or an institutional client.",
                              //                 style: TextController.BodyText,
                              //               ),
                              //             ),
                              //           ),
                              //           Container(
                              //             height: 80,
                              //             child: Checkbox(
                              //               value: isChecked0,
                              //               onChanged: (value) {
                              //                 setState(() {
                              //                   isChecked0 = value!;
                              //                 });
                              //               },
                              //             ),
                              //           ),
                              //           Container(
                              //               height: 80,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     top: 15, left: 10),
                              //                 child: Center(
                              //                   child: Column(
                              //                     children: [
                              //                       Text(
                              //                         "",
                              //                         style: TextController
                              //                             .tableHeading,
                              //                         maxLines: 3,
                              //                       ),
                              //                       if (fileName0 == "")
                              //                         TextButton(
                              //                           style: TextButton.styleFrom(
                              //                               textStyle:
                              //                                   TextController
                              //                                       .browseText),
                              //                           onPressed: isChecked0
                              //                               ? () {
                              //                                   uploadPdf("0");
                              //                                 }
                              //                               : null,
                              //                           child: Text(
                              //                             S.of(context).Browse,
                              //                             style: TextController
                              //                                 .browseText,
                              //                           ),
                              //                         ),
                              // if (fileName0 != "")
                              //   Row(
                              //     children: [
                              //       Text(
                              //         fileName0,
                              //         style: TextController
                              //             .BodyHeadingText,
                              //       ),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               fileName0 =
                              //                   "";
                              //             });
                              //           },
                              //           child: Icon(
                              //             Icons
                              //                 .cancel_presentation,
                              //           ))
                              //                           ],
                              //                         ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               )),
                              //         ]),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (ClientType == "Qualified")
                        Visibility(
                          visible: isChecked0 ? false : true,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S
                                  .of(context)
                                  .SubmitrelevantdocumentsifyouareQualifiedClient,
                              style: TextController.BodyHeadingText,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (ClientType == "Qualified")
                        Visibility(
                          visible: isChecked0 ? false : true,
                          child: Table(
                            border: TableBorder.all(
                                color: ColorSelect.tabBorderColor),
                            columnWidths: const {
                              0: FlexColumnWidth(0.5),
                              1: FlexColumnWidth(9.5),
                              2: FlexColumnWidth(0.5),
                              3: FlexColumnWidth(2.5),
                            },
                            children: [
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "A",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "A natural person who meets at least one of the following criteria:",
                                        style: TextController.tableHeading,
                                      )),
                                  Container(
                                    height: 50,
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Document Upload",
                                        style: TextController.tableHeading,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "1)",
                                        style: TextController.tableHeading,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Has carried out at least 10 transactions per quarter over the last 12 months of a minimum total amount of 40 million Saudi Riyals on securities markets",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked = newValue!;
                                          if (isChecked == false) {
                                            fileName1 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName1 == "")
                                            TextButton(
                                              onPressed: isChecked
                                                  ? () {
                                                      uploadPdf("1");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName1 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Center(
                                                    child: Text(
                                                      fileName1,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      fileName1 = "";
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
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "2)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "His net assets is not less than 5 million Saudi Riyals.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked2,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked2 = newValue!;
                                          if (isChecked2 == false) {
                                            fileName2 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName2 == "")
                                            TextButton(
                                              onPressed: isChecked2
                                                  ? () {
                                                      uploadPdf("2");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName2 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName2,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName2 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ),
                                                  )
                                                ])
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "3)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Works or has worked for at least three years in the financial sector in a professional position related to investment in securities.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked3,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked3 = newValue!;
                                          if (isChecked3 == false) {
                                            fileName3 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName3 == "")
                                            TextButton(
                                              onPressed: isChecked3
                                                  ? () {
                                                      uploadPdf("3");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName3 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName3,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      fileName3 = "";
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_presentation,
                                                  ),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "4)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Holds a professional certificate in securities business and accredited by an internationally recognized entity.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked4,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked4 = newValue!;
                                          if (isChecked4 == false) {
                                            fileName4 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName4 == "")
                                            TextButton(
                                              onPressed: isChecked4
                                                  ? () {
                                                      uploadPdf("4");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName4 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName4,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      fileName4 = "";
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_presentation,
                                                  ),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "5)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Holds the General Securities Qualification Certificate that is recognized by the Authority, and has an annual income that is not less than 600,000 Saudi Riyals in the last two years.",
                                          style: TextController.BodyTextCC,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked5,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked5 = newValue!;
                                          if (isChecked5 == false) {
                                            fileName5 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName5 == "")
                                            TextButton(
                                              onPressed: isChecked5
                                                  ? () {
                                                      uploadPdf("5");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName5 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName5,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      fileName5 = "";
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.cancel_presentation,
                                                  ),
                                                )
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "6)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Being a client of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:",
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                ),
                                Container(),
                              ]),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "a)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "The offer shall be made to the Capital Market Institution, and that all related communications be made by it.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked6,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked6 = newValue!;
                                          if (isChecked6 == false) {
                                            fileName6 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName6 == "")
                                            TextButton(
                                              onPressed: isChecked6
                                                  ? () {
                                                      uploadPdf("6");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName6 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName6,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName6 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "b)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client.",
                                          style: TextController.BodyTextCC,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked7,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked7 = newValue!;
                                          if (isChecked7 == false) {
                                            fileName7 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName7 == "")
                                            TextButton(
                                              onPressed: isChecked7
                                                  ? () {
                                                      uploadPdf("7");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName7 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName7,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName7 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "7)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Registered persons of a Capital Market Institution if the offer is carried out by the Capital Market Institution itself.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked8,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked8 = newValue!;
                                          if (isChecked8 == false) {
                                            fileName8 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName8 == "")
                                            TextButton(
                                              onPressed: isChecked8
                                                  ? () {
                                                      uploadPdf("8");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName8 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName8,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName8 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "B",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "A legal person, which meets at least one of the following criteria:",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                ),
                                Container(),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "1)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Any legal person acting for its own account and be any of the following:",
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                ),
                                Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      child: Text(
                                        "",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                              ]),
                              TableRow(
                                children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "a)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "A company which owns, or which is a member of a group which owns, net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi Riyals.",
                                          style: TextController.BodyTextCC,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked9,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked9 = newValue!;
                                          if (isChecked9 == false) {
                                            fileName9 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName9 == "")
                                            TextButton(
                                              onPressed: isChecked9
                                                  ? () {
                                                      uploadPdf("9");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName9 != "")
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName9,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName9 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "b)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Any unincorporated body, partnership company or other organization which has net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi riyals.",
                                        style: TextController.BodyTextCC,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked10,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked10 = newValue!;
                                        if (isChecked10 == false) {
                                          fileName10 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName10 == "")
                                          TextButton(
                                            onPressed: isChecked10
                                                ? () {
                                                    uploadPdf("10");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName10 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName10,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName10 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "c)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (1/a) or (1/b).",
                                        style: TextController.BodyTextCC,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked11,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked11 = newValue!;
                                        if (isChecked11 == false) {
                                          fileName11 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName11 == "")
                                          TextButton(
                                            onPressed: isChecked11
                                                ? () {
                                                    uploadPdf("11");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName11 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName11,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName11 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "2)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Clients of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:",
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                ),
                                Container(
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 10),
                                      child: Text(
                                        "",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "a)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "The offer shall be made to the Capital Market Institution, and that all related communications be made by it;",
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked12,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked12 = newValue!;
                                        if (isChecked12 == false) {
                                          fileName12 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName12 == "")
                                          TextButton(
                                            onPressed: isChecked12
                                                ? () {
                                                    uploadPdf("12");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName12 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName12,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName12 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "b)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client.",
                                        style: TextController.BodyTextCC,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked13,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked13 = newValue!;
                                        if (isChecked13 == false) {
                                          fileName13 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName13 == "")
                                          TextButton(
                                            onPressed: isChecked13
                                                ? () {
                                                    uploadPdf("13");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName13 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName13,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName13 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "C",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "A company fully owned by a natural person who meets one of the criteria mentioned in paragraph:",
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                ),
                                Container(),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "a)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.of(context).CC15,
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked14,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked14 = newValue!;
                                        if (isChecked14 == false) {
                                          fileName14 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName14 == "")
                                          TextButton(
                                            onPressed: isChecked14
                                                ? () {
                                                    uploadPdf("14");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName14 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName14,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName14 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ]),
                              TableRow(children: [
                                Container(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "b)",
                                        style: TextController.tableHeading,
                                      ),
                                    )),
                                Container(
                                    height: 50,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        S.of(context).CC16,
                                        style: TextController.BodyText,
                                      ),
                                    )),
                                Container(
                                  height: 50,
                                  child: Checkbox(
                                    value: isChecked15,
                                    onChanged: (newValue) {
                                      setState(() {
                                        isChecked15 = newValue!;
                                        if (isChecked15 == false) {
                                          fileName15 = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    child: Center(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "",
                                          style: TextController.tableHeading,
                                          maxLines: 3,
                                        ),
                                        if (fileName15 == "")
                                          TextButton(
                                            onPressed: isChecked15
                                                ? () {
                                                    uploadPdf("15");
                                                  }
                                                : null,
                                            child: Text(
                                              S.of(context).Browse,
                                              style: TextController.browseText,
                                            ),
                                          ),
                                        if (fileName15 != "")
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    fileName15,
                                                    style: TextController
                                                        .BodyHeadingText,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        fileName15 = "";
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.cancel_presentation,
                                                    ))
                                              ])
                                      ],
                                    ))),
                              ])
                            ],
                          ),
                        ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 58, right: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Center(
                      //           //       child: Text(
                      //           //         "1)",
                      //           //         style: TextController.tableHeading,
                      //           //       ),
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Container(
                      //           //         padding: EdgeInsets.symmetric(
                      //           //             horizontal: 15),
                      //           //         alignment: Alignment.centerLeft,
                      //           //         child: Text(
                      //           //           "Has carried out at least 10 transactions per quarter over the last 12 months of a minimum total amount of 40 million Saudi Riyals on securities markets;",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked = newValue!;
                      //           //           if (isChecked == false) {
                      //           //             fileName1 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       alignment: Alignment.center,
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName1 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked
                      //           //                   ? () {
                      //           //                       uploadPdf("1");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName1 != "")
                      //           //             Row(children: [
                      //           //               Center(
                      //           //                 child: Text(
                      //           //                   fileName1,
                      //           //                   maxLines: 3,
                      //           //                   style: TextController
                      //           //                       .BodyHeadingText,
                      //           //                 ),
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName1 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "2)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "His net assets is not less than 5 million Saudi Riyals.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked2,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked2 = newValue!;
                      //           //           if (isChecked2 == false) {
                      //           //             fileName2 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       alignment: Alignment.center,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName2 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked2
                      //           //                   ? () {
                      //           //                       uploadPdf("2");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName2 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName2,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName2 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "3)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Works or has worked for at least three years in the financial sector in a professional position related to investment in securities.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked3,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked3 = newValue!;
                      //           //           if (isChecked3 == false) {
                      //           //             fileName3 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName3 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked3
                      //           //                   ? () {
                      //           //                       uploadPdf("3");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName3 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName3,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName3 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "4)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Holds a professional certificate in securities business and accredited by an internationally recognized entity.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked4,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked4 = newValue!;
                      //           //           if (isChecked4 == false) {
                      //           //             fileName4 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName4 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked4
                      //           //                   ? () {
                      //           //                       uploadPdf("4");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName4 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName4,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName4 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "5)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 15),
                      //           //           child: Text(
                      //           //             "Holds the General Securities Qualification Certificate that is recognized by the Authority, and has an annual income that is not less than 600,000 Saudi Riyals in the last two years.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked5,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked5 = newValue!;
                      //           //           if (isChecked5 == false) {
                      //           //             fileName5 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName5 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked5
                      //           //                   ? () {
                      //           //                       uploadPdf("5");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName5 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName5,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName5 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "6)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Being a client of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Document Upload",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 100),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(900),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "a)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "The offer shall be made to the Capital Market Institution, and that all related communications be made by it.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked6,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked6 = newValue!;
                      //           //           if (isChecked6 == false) {
                      //           //             fileName6 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName6 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked6
                      //           //                   ? () {
                      //           //                       uploadPdf("6");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName6 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName6,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName6 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "b)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked7,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked7 = newValue!;
                      //           //           if (isChecked7 == false) {
                      //           //             fileName7 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName7 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked7
                      //           //                   ? () {
                      //           //                       uploadPdf("7");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName7 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName7,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName7 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "7)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Registered persons of a Capital Market Institution if the offer is carried out by the Capital Market Institution itself.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked8,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked8 = newValue!;
                      //           //           if (isChecked8 == false) {
                      //           //             fileName8 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName8 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked8
                      //           //                   ? () {
                      //           //                       uploadPdf("8");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName8 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName8,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName8 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(1000),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "B",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "A legal person, which meets at least one of the following criteria:",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Document Upload",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 50,
                      //       ),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "1)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Any legal person acting for its own account and be any of the following:",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 100,
                      //       ),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(900),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "a)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "A company which owns, or which is a member of a group which owns, net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi Riyals.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked9,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked9 = newValue!;
                      //           //           if (isChecked9 == false) {
                      //           //             fileName9 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName9 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked9
                      //           //                   ? () {
                      //           //                       uploadPdf("9");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName9 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName9,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName9 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "b)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "Any unincorporated body, partnership company or other organization which has net assets of not less than 10 million Saudi Riyals and not more than 50 million Saudi riyals.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked10,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked10 = newValue!;
                      //           //           if (isChecked10 == false) {
                      //           //             fileName10 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName10 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked10
                      //           //                   ? () {
                      //           //                       uploadPdf("10");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName10 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName10,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName10 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "c)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (1/a) or (1/b).",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked11,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked11 = newValue!;
                      //           //           if (isChecked11 == false) {
                      //           //             fileName11 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName11 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked11
                      //           //                   ? () {
                      //           //                       uploadPdf("11");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName11 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName11,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName11 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 50,
                      //       ),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "2)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Clients of a Capital Market Institution authorized by the Authority to conduct managing activities, provided that the following is fulfilled:",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 100,
                      //       ),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(900),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "a)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "The offer shall be made to the Capital Market Institution, and that all related communications be made by it;",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked12,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked12 = newValue!;
                      //           //           if (isChecked12 == false) {
                      //           //             fileName12 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName12 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked12
                      //           //                   ? () {
                      //           //                       uploadPdf("12");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName12 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName12,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName12 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "b)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "The Capital Market Institution has been appointed on terms which enable it to make investment decisions on the client’s behalf without obtaining prior approval from the client.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked13,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked13 = newValue!;
                      //           //           if (isChecked13 == false) {
                      //           //             fileName13 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName13 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked13
                      //           //                   ? () {
                      //           //                       uploadPdf("13");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName13 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName13,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName13 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(top: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(1000),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "C",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "A company fully owned by a natural person who meets one of the criteria mentioned in paragraph:",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Document Upload",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Qualified")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //         left: 50,
                      //       ),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "a)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           S.of(context).CC15,
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked14,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked14 = newValue!;
                      //           //           if (isChecked14 == false) {
                      //           //             fileName14 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName14 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked14
                      //           //                   ? () {
                      //           //                       uploadPdf("14");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName14 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName14,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName14 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "b)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           S.of(context).CC16,
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked15,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked15 = newValue!;
                      //           //           if (isChecked15 == false) {
                      //           //             fileName15 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName15 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked15
                      //           //                   ? () {
                      //           //                       uploadPdf("15");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName15 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName15,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName15 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),

                      if (ClientType == "Institutional")
                        Visibility(
                          visible: true,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              S
                                  .of(context)
                                  .SubmitrelevantdocumentsifyouareInstitutionalClient,
                              style: TextController.BodyHeadingText,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (ClientType == "Institutional")
                        Visibility(
                          visible: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: Table(
                              border: TableBorder.all(
                                  color: ColorSelect.tabBorderColor),
                              columnWidths: {
                                0: FlexColumnWidth(0.5),
                                1: FlexColumnWidth(9.5),
                                2: FlexColumnWidth(0.5),
                                3: FlexColumnWidth(2.5),
                              },
                              children: [
                                TableRow(children: [
                                  Container(),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Means any of the following:",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, left: 10),
                                        child: Text(
                                          "",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Document Upload",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "a)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "The Government of the Kingdom or any supranational authority recognized by the Authority.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked16,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked16 = newValue!;
                                          if (isChecked16 == false) {
                                            fileName16 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName16 == "")
                                            TextButton(
                                              onPressed: isChecked16
                                                  ? () {
                                                      uploadPdf("16");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName16 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName16,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName16 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "b)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Companies fully owned by the government or any government entity, either directly or through a portfolio managed by a Capital Market Institution authorized to carry on managing business.",
                                          style: TextController.BodyTextCC,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked17,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked17 = newValue!;
                                          if (isChecked17 == false) {
                                            fileName17 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName17 == "")
                                            TextButton(
                                              onPressed: isChecked17
                                                  ? () {
                                                      uploadPdf("17");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName17 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName17,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName17 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "c)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Any legal person acting for its own account and be any of the following:",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                  ),
                                  Container(),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "1)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "A company which owns, or is a member of a group which owns, net assets of more than 50 million Saudi Riyals;",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked18,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked18 = newValue!;
                                          if (isChecked18 == false) {
                                            fileName18 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName18 == "")
                                            TextButton(
                                              onPressed: isChecked18
                                                  ? () {
                                                      uploadPdf("18");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName18 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName18,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName18 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "2)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "An unincorporated body, partnership company or other organization which has net assets of more than 50 million Saudi riyals.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked19,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked19 = newValue!;
                                          if (isChecked19 == false) {
                                            fileName19 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName19 == "")
                                            TextButton(
                                              onPressed: isChecked19
                                                  ? () {
                                                      uploadPdf("19");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName19 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName19,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName19 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "3)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (c/1) or (c/2).",
                                          style: TextController.BodyTextCC,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked20,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked20 = newValue!;
                                          if (isChecked20 == false) {
                                            fileName20 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName20 == "")
                                            TextButton(
                                              onPressed: isChecked20
                                                  ? () {
                                                      uploadPdf("20");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName20 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName20,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName20 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "d)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "A company fully owned by a legal person who meets the criteria of paragraph (b) or (c).",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked21,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked21 = newValue!;
                                          if (isChecked21 == false) {
                                            fileName21 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName21 == "")
                                            TextButton(
                                              onPressed: isChecked21
                                                  ? () {
                                                      uploadPdf("21");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName21 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName21,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName21 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "e)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "An Investment Fund.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked22,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked22 = newValue!;

                                          if (isChecked22 == false) {
                                            fileName22 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName22 == "")
                                            TextButton(
                                              onPressed: isChecked22
                                                  ? () {
                                                      uploadPdf("22");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName22 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName22,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName22 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ]),
                                TableRow(children: [
                                  Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "f)",
                                          style: TextController.tableHeading,
                                        ),
                                      )),
                                  Container(
                                      height: 50,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "A Counterparty.",
                                          style: TextController.BodyText,
                                        ),
                                      )),
                                  Container(
                                    height: 50,
                                    child: Checkbox(
                                      value: isChecked23,
                                      onChanged: (newValue) {
                                        setState(() {
                                          isChecked23 = newValue!;
                                          if (isChecked23 == false) {
                                            fileName23 = "";
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      child: Center(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "",
                                            style: TextController.tableHeading,
                                            maxLines: 3,
                                          ),
                                          if (fileName23 == "")
                                            TextButton(
                                              onPressed: isChecked23
                                                  ? () {
                                                      uploadPdf("23");
                                                    }
                                                  : null,
                                              child: Text(
                                                S.of(context).Browse,
                                                style:
                                                    TextController.browseText,
                                              ),
                                            ),
                                          if (fileName23 != "")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      fileName23,
                                                      style: TextController
                                                          .BodyHeadingText,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          fileName23 = "";
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .cancel_presentation,
                                                      ))
                                                ])
                                        ],
                                      ))),
                                ])
                              ],
                            ),
                          ),
                        ),
                      // if (ClientType == "Institutional")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "a)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "The Government of the Kingdom or any supranational authority recognized by the Authority.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked16,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked16 = newValue!;
                      //           //           if (isChecked16 == false) {
                      //           //             fileName16 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName16 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked16
                      //           //                   ? () {
                      //           //                       uploadPdf("16");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName16 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName16,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName16 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "b)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "Companies fully owned by the government or any government entity, either directly or through a portfolio managed by a Capital Market Institution authorized to carry on managing business.",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked17,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked17 = newValue!;
                      //           //           if (isChecked17 == false) {
                      //           //             fileName17 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName17 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked17
                      //           //                   ? () {
                      //           //                       uploadPdf("17");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName17 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName17,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName17 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "c)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "Any legal person acting for its own account and be any of the following:",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Institutional")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 100),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(900),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "1)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "A company which owns, or is a member of a group which owns, net assets of more than 50 million Saudi Riyals;",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked18,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked18 = newValue!;
                      //           //           if (isChecked18 == false) {
                      //           //             fileName18 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName18 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked18
                      //           //                   ? () {
                      //           //                       uploadPdf("18");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName18 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName18,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName18 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "2)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "An unincorporated body, partnership company or other organization which has net assets of more than 50 million Saudi riyals.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked19,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked19 = newValue!;
                      //           //           if (isChecked19 == false) {
                      //           //             fileName19 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName19 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked19
                      //           //                   ? () {
                      //           //                       uploadPdf("19");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName19 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName19,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName19 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "3)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //         child: Padding(
                      //           //           padding:
                      //           //               const EdgeInsets.only(left: 10),
                      //           //           child: Text(
                      //           //             "A person acting in the capacity of director, officer or employee of a legal person and responsible for its securities activity, where that legal person falls within the definition of paragraph (c/1) or (c/2).",
                      //           //             style: TextController.BodyTextCC,
                      //           //           ),
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked20,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked20 = newValue!;
                      //           //           if (isChecked20 == false) {
                      //           //             fileName20 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName20 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked20
                      //           //                   ? () {
                      //           //                       uploadPdf("20");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName20 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName20,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName20 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // if (ClientType == "Institutional")
                      //   Visibility(
                      //     visible: true,
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 50),
                      //       child: Table(
                      //         border: TableBorder.all(
                      //             color: ColorSelect.tabBorderColor),
                      //         columnWidths: {
                      //           0: FixedColumnWidth(50),
                      //           1: FixedColumnWidth(950),
                      //           2: FixedColumnWidth(50),
                      //           3: FixedColumnWidth(150),
                      //         },
                      //         children: [
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "d)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "A company fully owned by a legal person who meets the criteria of paragraph (b) or (c).",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked21,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked21 = newValue!;
                      //           //           if (isChecked21 == false) {
                      //           //             fileName21 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName21 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked21
                      //           //                   ? () {
                      //           //                       uploadPdf("21");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName21 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName21,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName21 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "e)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "An Investment Fund.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked22,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked22 = newValue!;

                      //           //           if (isChecked22 == false) {
                      //           //             fileName22 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName22 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked22
                      //           //                   ? () {
                      //           //                       uploadPdf("22");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName22 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName22,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName22 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ]),
                      //           // TableRow(children: [
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "f)",
                      //           //           style: TextController.tableHeading,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Padding(
                      //           //         padding: const EdgeInsets.only(
                      //           //             top: 15, left: 10),
                      //           //         child: Text(
                      //           //           "A Counterparty.",
                      //           //           style: TextController.BodyText,
                      //           //         ),
                      //           //       )),
                      //           //   Container(
                      //           //     height: 50,
                      //           //     child: Checkbox(
                      //           //       value: isChecked23,
                      //           //       onChanged: (newValue) {
                      //           //         setState(() {
                      //           //           isChecked23 = newValue!;
                      //           //           if (isChecked23 == false) {
                      //           //             fileName23 = "";
                      //           //           }
                      //           //         });
                      //           //       },
                      //           //     ),
                      //           //   ),
                      //           //   Container(
                      //           //       height: 50,
                      //           //       child: Center(
                      //           //           child: Column(
                      //           //         crossAxisAlignment:
                      //           //             CrossAxisAlignment.center,
                      //           //         children: [
                      //           //           Text(
                      //           //             "",
                      //           //             style: TextController.tableHeading,
                      //           //             maxLines: 3,
                      //           //           ),
                      //           //           if (fileName23 == "")
                      //           //             TextButton(
                      //           //               onPressed: isChecked23
                      //           //                   ? () {
                      //           //                       uploadPdf("23");
                      //           //                     }
                      //           //                   : null,
                      //           //               child: Text(
                      //           //                 S.of(context).Browse,
                      //           //                 style:
                      //           //                     TextController.browseText,
                      //           //               ),
                      //           //             ),
                      //           //           if (fileName23 != "")
                      //           //             Row(children: [
                      //           //               Text(
                      //           //                 fileName23,
                      //           //                 style: TextController
                      //           //                     .BodyHeadingText,
                      //           //               ),
                      //           //               SizedBox(
                      //           //                 width: 5,
                      //           //               ),
                      //           //               GestureDetector(
                      //           //                   onTap: () {
                      //           //                     setState(() {
                      //           //                       fileName23 = "";
                      //           //                     });
                      //           //                   },
                      //           //                   child: Icon(
                      //           //                     Icons.cancel_presentation,
                      //           //                   ))
                      //           //             ])
                      //           //         ],
                      //           //       ))),
                      //           // ])
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
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
                                tabController?.animateTo(2);
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
                                border: Border.all(
                                    color: ColorSelect.tabBorderColor)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    ColorSelect.east_blue),
                              ),
                              onPressed: () {
                                if (ClientType == "") {
                                  Fluttertoast.showToast(
                                      msg: "Select Client Type",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (ClientType == "Qualified" &&
                                    fileName1 == "" &&
                                    fileName2 == "" &&
                                    fileName3 == "" &&
                                    fileName4 == "" &&
                                    fileName5 == "" &&
                                    fileName6 == "" &&
                                    fileName7 == "" &&
                                    fileName8 == "" &&
                                    fileName9 == "" &&
                                    fileName10 == "" &&
                                    fileName11 == "" &&
                                    fileName12 == "" &&
                                    fileName13 == "" &&
                                    fileName14 == "" &&
                                    fileName15 == "") {
                                  Fluttertoast.showToast(
                                      msg: "Upload At Least One Document",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if ((ClientType == "Qualified") &&
                                    ((isChecked == true && fileName1 == "") ||
                                        (isChecked2 == true &&
                                            fileName2 == "") ||
                                        (isChecked3 == true &&
                                            fileName3 == "") ||
                                        (isChecked4 == true &&
                                            fileName4 == "") ||
                                        (isChecked5 == true &&
                                            fileName5 == "") ||
                                        (isChecked6 == true &&
                                            fileName6 == "") ||
                                        (isChecked7 == true &&
                                            fileName7 == "") ||
                                        (isChecked8 == true &&
                                            fileName8 == "") ||
                                        (isChecked9 == true &&
                                            fileName9 == "") ||
                                        (isChecked10 == true &&
                                            fileName10 == "") ||
                                        (isChecked11 == true &&
                                            fileName11 == "") ||
                                        (isChecked12 == true &&
                                            fileName12 == "") ||
                                        (isChecked13 == true &&
                                            fileName13 == "") ||
                                        (isChecked14 == true &&
                                            fileName14 == "") ||
                                        (isChecked15 == true &&
                                            fileName15 == ""))) {
                                  Fluttertoast.showToast(
                                      msg: "Upload Selected Document",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (ClientType == "Institutional" &&
                                    fileName16 == "" &&
                                    fileName17 == "" &&
                                    fileName18 == "" &&
                                    fileName19 == "" &&
                                    fileName20 == "" &&
                                    fileName21 == "" &&
                                    fileName22 == "" &&
                                    fileName23 == "") {
                                  Fluttertoast.showToast(
                                      msg: "Upload At Least One Document",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if ((ClientType == "Institutional") &&
                                    ((isChecked16 == true &&
                                            fileName16 == "") ||
                                        (isChecked17 == true &&
                                            fileName17 == "") ||
                                        (isChecked18 == true &&
                                            fileName18 == "") ||
                                        (isChecked19 == true &&
                                            fileName19 == "") ||
                                        (isChecked20 == true &&
                                            fileName20 == "") ||
                                        (isChecked21 == true &&
                                            fileName21 == "") ||
                                        (isChecked22 == true &&
                                            fileName22 == "") ||
                                        (isChecked23 == true &&
                                            fileName23 == ""))) {
                                  Fluttertoast.showToast(
                                      msg: "Upload Selected Document",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  if (GlobalPermissionCorporate
                                          .corporateclientid !=
                                      0) {
                                    senddata();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Please fill general info first",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                }
                              }, // Switch tabs
                              child: Text(
                                btn,
                                style: TextController.btnText,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
