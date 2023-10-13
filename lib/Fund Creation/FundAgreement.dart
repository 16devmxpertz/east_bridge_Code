import 'package:east_bridge/FundAgreement/FundAgreement.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:east_bridge/Fund Creation/TabOfFundCreation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utility/Drawer.dart';
import 'FundCreation.dart';

//import 'package:todo/Colors.dart';

class FundCreationAgreement extends StatefulWidget {
  FundCreationAgreement({@required controller}) {
    tabController = controller;
  }
  @override
  _FundCreationAgreementState createState() => _FundCreationAgreementState();
  static ValueNotifier<int> id = ValueNotifier(0);
  static ValueNotifier<String> name = ValueNotifier("");

  static ValueNotifier<String> fmcompany = ValueNotifier("");
  static ValueNotifier<String> custodianAddress = ValueNotifier("");
  static ValueNotifier<String> custodianCompany = ValueNotifier("");
  static ValueNotifier<String> foaddress = ValueNotifier("");
  static ValueNotifier<String> focompany = ValueNotifier("");
  static ValueNotifier<String> ataddress = ValueNotifier("");
  static ValueNotifier<String> le = ValueNotifier("");
  static ValueNotifier<String> investmentExp = ValueNotifier("");
  static ValueNotifier<String> riskAbility = ValueNotifier("");
  static ValueNotifier<String> investmentObj = ValueNotifier("");
  static ValueNotifier<String> source = ValueNotifier("");
  static ValueNotifier<String> annualIncome = ValueNotifier("");
  static ValueNotifier<String> netWorth = ValueNotifier("");
  static ValueNotifier<String> boardDirector = ValueNotifier("");
  static ValueNotifier<String> pep = ValueNotifier("");
  static ValueNotifier<String> owner = ValueNotifier("");
}

TabController? tabController;

class _FundCreationAgreementState extends State<FundCreationAgreement> {
  final HtmlEditorController controller = HtmlEditorController();
  TextEditingController tempName = new TextEditingController();
  String? valueText;
  List<String> finalitems = [];

  int? editIndex; // Updated type to int?

  @override
  void initState() {
    super.initState();
    loadTodoItems();
    print("----");
  }

  void loadTodoItems() async {
    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      Uri.parse(
          '${GlobalPermission.urlLink}/api/DefaultAgreements/DefaultAgreementGet?type=Fund'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      // Request successful, handle the response
      var responseData = jsonDecode(response.body);
      print("Successful");
      List<String> li = [];
      for (int i = 0; i < responseData.length; i++) {
        li.add(responseData[i]);
      }
      setState(() {
        finalitems = li;
      });
    } else {
      print("Error");
    }
  }

  void startEdit(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            height: 500,
            width: 1500,
            child: Column(
              children: [
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                      shouldEnsureVisible: true,
                      initialText: finalitems[index]),
                ),
                TextButton(
                  onPressed: () async {
                    print("press");
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      setState(() {
                        finalitems[index] = newItem;
                      });
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text('Update Todo'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void Addtodo() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
            height: 500,
            width: 1500,
            child: Column(
              children: [
                HtmlEditor(
                  controller: controller,
                  htmlEditorOptions: HtmlEditorOptions(
                      shouldEnsureVisible: true, initialText: ""),
                ),
                TextButton(
                  onPressed: () async {
                    print("press");
                    final newItem = await controller.getText();
                    if (newItem.isNotEmpty) {
                      setState(() {
                        finalitems.add(newItem);
                      });
                      Navigator.pop(context); // Close the AlertDialog
                    }
                  },
                  child: Text('Add TodoTodo'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> senddata() async {
    print("data sending");
    var headers = {
      'Content-Type': 'application/json',
    };

    var data = {
      "generatedBy": GlobalPermission.employeeId,
      "FundId": FundCreationAgreement.id.value,
      "TemplateName": valueText,
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

      bool y = await GlobalPermission.formApproval("Fund Creation",
          FundCreationAgreement.id.value, FundCreationAgreement.name.value, 0);
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
        child: Container(
          height: 7000,
          width: 600,
          child: Column(
            children: [
              Card(
                child: Container(
                  color: ColorSelect.east_grey,
                  child: Center(
                      child: Text(
                    "                        شروطوأحكام\n           صندوق الروادالسياحيالثقافي\n صندوق استثمار أسهم ملكية خاصة خاصمغلق",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: ColorSelect.east_blue),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'مدير الصندوق: شركة جسر الشرق املالية',
                        textDirection: TextDirection.ltr,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "مشغل الصندوق وأمين الحفظ: شركة البالد املالية",
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("تاريخ إصدار شروطوأحكام الصندوق"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("تاريخ إصدار شروطوأحكام الصندوق"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child:
                            Text("تاريخ إشعارالهيئةلطرح وحداتصندوق االستثمار"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("2022/12/27 م"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("تاريخ آخر تحديثالشروطواألحكام"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("النسخة األولى"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "اليجوز توزيع هذا املستند في اململكة إال على األشخاص املحددين في الئحة صناديق االستثمار الصادرة عن هيئة السوق املالية. وال تعطي هيئة السوقامالية أي تأكيد يتعلق بدقة هذا املستند أواكتماله، وتخلي الهيئة نفسها من أي مسؤولية أو أي خسارة تنتج عماورد في هذا املستند أواالعتماد على أيجز منه. ويجب على الراغبين في الشتراك في األوراق املالية املطروحة بموجب هذا املستند تحريمدى صحة املعلومات املتعلقة باألوراق املالية محل الطرح. وفي حال تعذر فهم محتويات هذا املستند، يجب عليهم األخذ بمشورة مستشار مالي مرخص له."),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "يجبعلىاملستثمرين قراءة هذهالشروطواألحكام واملستنداتاألخرى الخاصةبالصندوق."),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 170),
                        child: Card(
                          child: Container(
                            width: 1450,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "قائمة املحتويات:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "أ. إشعار هام ................................................................................................................................................................................ 4"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "ب. دليل الصندوق ......................................................................................................................................................................... 5"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "ج. املصطلحات والتعريفات ............................................................................................................................. ............................... 6"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".19...............................................................................................................................................................اسم الصندوق ونوعه"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".2 ................................................................................................................نوان املقرالرئيس ملديرالصندوق للكتروني9."),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".39.....................................................................................................................................................مدةالصندوق ومدةالتمديد9."),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".4.9.....................................................................................................................................................................أهداف الصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "5.9 .................................................................................وصف لغرضالصندوق وأهدافه،وسياسةتوزيع األرباح علىمالكي الوحدات"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".7 ..................................................................................................................................................مخاطراالستثمارفيالصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".8.....................................................................................................االشتراك"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".9.....................................................................................................تداول وحداتالصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".10.....................................................................................................إنهاءوتصفيةالصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "11......................................................................................................الرسوم واألتعابواملصاريف"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "12......................................................................................................أصول الصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "13........................................................................................................................................................................مديرالصندوق"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "14......................................................................................................مشغل"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "15......................................................................................................أمين الحفظ"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ". 17....................................................................................................................................................................... القوائم املالية."),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "18...................................................................................................................................................................... تعارضمصالح."),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "19 ............................................................................................................................................ تقديم التقاريرإلىمالكي الوحدات  "),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "ا 22....................................................................................................................................................جتماعات مالكي الوحدات"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      "اجتماعات مالكي الوحدات ......................................................................................................................................................21"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      " قائمةبحقوق مالكي الوحدات..................................................................................................................................................23"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                      ".مسؤوليةمالكي الوحدات........................................................................................................................................................23"),
                                ),
                                Card(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 120),
                                        child: Table(
                                          columnWidths: {
                                            0: FixedColumnWidth(400),
                                            1: FixedColumnWidth(400),
                                            2: FixedColumnWidth(400),
                                            3: FixedColumnWidth(400),
                                          },
                                          border: TableBorder.all(
                                              color:
                                                  ColorSelect.tabBorderColor),
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: ValueListenableBuilder(
                                                    builder: (
                                                      BuildContext context,
                                                      String value,
                                                      Widget? child,
                                                    ) {
                                                      return Center(
                                                          child: Text(value));
                                                    },
                                                    valueListenable:
                                                        FundCreationAgreement
                                                            .name,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'شركة جسر الشرق املالية',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text('مدير الصندوق',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text('أمين الحفظ',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'شركة البالد املالية',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'طريق امللك فهد، ص ب 140 الرياض 11411',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text('مشغل الصندوق',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'شركة البالد املالية',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'طريق امللك فهد، ص ب 140 الرياض 11411',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text('مراجع الحسابات',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'شركة طالل أبو غزالة وشركاه محاسبون قانونيون',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'مبنى صباح سنتر رقم ،6374 الطابق الثالث،طريق امللك عبدالعزيز فرعي – حي الخالدية، جدة',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      ' املستشار القانوني',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text('العوهلي وشركاه',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 150,
                                                child: Center(
                                                  child: Text(
                                                      'مكتب ،11/10 املنطقة أ، مبنى رقم ، بوابة األعمال طريق املطار، الرياض 11683 ',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 50, right: 20),
                                        child: Table(
                                          border: TableBorder.all(
                                              color:
                                                  ColorSelect.tabBorderColor),
                                          columnWidths: {
                                            0: FixedColumnWidth(700),
                                            1: FixedColumnWidth(700),
                                          },
                                          children: [
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text('مصاريفالتأسيس',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'مصاريفالتأسيساملتعلقةبالصندوق والتي تكبدها قبل تأسيسه أساساالحتسابوتوقيته: بحد أعلى 100 ألفريال سعودي مباشرةبعد تأسيسالصندوق توقيت الخصم: بعد انتهاء فترة الطرح األولى، سيدفع جميعمالكو الوحدات مبالغاالشتراكات لحساب الصندوق، عند وصول املبلغ لحساب الصندوق ، سوف يقوم مدير الصندوق بخصم تكاليف تأسيس الصندوق من هذه املبالغ.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text('رسوم االشتراك',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'تخصم رسوم االشتراك من إجمالي االلتزامات الرأسمالية الكلية، وبقيمة تصل إلى %1 من إجمالي االلتزامات الرأسمالية الكلية.ويحق ملدير الصندوقالتنازل عن و/أو حسم كامل رسوم لتقديره االشتراكوفقا املطلق، بحيث يتم خصمها عند االشتراكفيالصندوق. أساساالحتسابوتوقيته:من إجماليااللتزامات الرأسمالية الكلية، عند االشتراك. توقيتالخصم :يتم خصمها عند االشتراكفيالصندوق.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text('أتعاب اإلدارة',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'إعتبارا اإلقفال األول، يحصل مدير الصندوق، على املصاريف السنويةلإلدارة لكل سنةمالية )"أتعاب اإلدارة"( كل نصف عام مقدما ب ا قيمة مليون ريال سعودي سنوي أو ما يعادل نسبة ٪٢ من إجمالي االلتزامات الرأسمالية الكلية، أيهما أعلى. أساساالحتسابوتوقيته:من إجمالي االلتزامات الرأسمالية الكلية.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text('رسوم الحفظ',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'يدفع الصندوق ألمين الحفظ أتعاب حفظ سنوية )"أتعاب الحفظ"( تبلغ 185,000 يدفعها ريال سعودي سنويا الصندوق ألمين الحفظ بشكل ربع سنوي، يضاف اليها مبلغ 10,000 وملرة واحدة، ريال سعودي يدفع مقدما و 35,000 ريال عند تأسيسأي شركةذاتغرضخاصإضافية.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'أتعابمشغل الصندوق',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'يدفع الصندوق ملشغل الصندوق أتعاب شهريةتبلغ 18,250 ريال سعودي ا، يضافإليها مبلغ تدفع شهري 18,250 ريال سعودي ا إلعداد القوائم املالية للصندوق، سنوي و 37,000 ريال سعودي ا لحفظ قائمة مشتركي سنوي الصندوق،معإمكانيةدفعتكاليفإضافية عند طلبخدماتإضافيةتدفعبعد تقديم الخدماتللصندوق.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'أتعاب مراجع الحسابات',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'يدفع الصندوق ملراجع الحسابات أتعاب سنوية تبلغ 45 ألف ريال سعودي بعد تقديم الخدمات تدفع سنويا للصندوق.  أساساالحتسابوتوقيته: مبلغ محدد. توقيتالخصم :عند بعد تقديم الخدماتللصن استحقاقها، حيثتدفع سنويا دوق.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'مصاريف التمويل وأتعاب ترتيب التمويل',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'أتعاب مدير الصندوق لترتيب التمويل سكون بحد أقص ى %0.5 من قيمة التمويل، وكذلك مصاريف التمويل الفعليةومباشرة للصندوق خالل السنة )حسبالسعر السائد فيالسوق(. أساساالحتسابوتوقيته: حسب السعر السائد فيالسوق في حينه. توقيتالخصم :عند الحصول علىالتمويل.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
                                            TableRow(children: [
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'ضريبة القيمة املضافة',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                              Container(
                                                height: 300,
                                                child: Center(
                                                  child: Text(
                                                      'يخضع، أو قد يخضع توريد الخدمات للصندوق من جانب مدير الصندوق وأمين الحفظ ومستشاري الصندوق ومقدمي الخدماتاآلخرين، للضريبة علىالقيمةاملضافة. ال تتضمن الرسوم واألتعابالواردتعدادها في هذا البند )الرسوم واألتعاب واملصاريف)واملرتبطةبتوريدخدماتللصندوق،الضريبة على القيمةاملضافة،وهيصافيةمنها. وبشكل عام يتحمل الصندوق الضريبة على القيمة املضافة عن هذه الخدمات،ما لم يتم االتفاق فيما بين املورد والصندوق )كل على حدة( على خالفذلك.',
                                                      style: TextStyle(
                                                          fontSize: 20.0)),
                                                ),
                                              ),
                                            ]),
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
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: finalitems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        child: ListTile(
                          title: Html(
                            data: finalitems[index],
                            style: {
                              'body': Style(fontSize: FontSize.medium),
                            },
                          ),
                          trailing: SizedBox(
                            width: 80,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    startEdit(index);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      finalitems.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 1100, top: 15, bottom: 15, right: 15),
                    child: Container(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          Addtodo();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: ColorSelect
                              .east_blue, // Set the desired background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                0), // Set border radius to 0
                          ),
                        ),
                        child: Text("Add"),
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  S.of(context).Save,
                                  style: TextController.SubHeadingText,
                                ),
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        S.of(context).EnterTemplateName,
                                        style: TextController.BodyText,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          width: 290,
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.textField)),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                valueText = value;
                                              });
                                            },
                                            controller: tempName,
                                            textAlignVertical:
                                                TextAlignVertical.center,
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
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  Container(
                                    height: 35,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: ColorSelect.tabBorderColor)),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        S.of(context).Cancel,
                                        style: TextController.SideMenuText,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: ColorSelect.east_blue,
                                        border: Border.all(
                                            color: ColorSelect.tabBorderColor)),
                                    child: TextButton(
                                      onPressed: () async {
                                        print("pressedd");
                                        bool x = await senddata();
                                        if (x == true) {
                                          setState(() {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TabOfFundCreation()));
                                          });
                                        }
                                      },
                                      child: Text(
                                        S.of(context).OK,
                                        style: TextController.btnText,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });

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
    );
  }
}
