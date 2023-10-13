import 'dart:convert';

import 'package:east_bridge/AppLocalization.dart';
import 'package:east_bridge/Approval/Approval_Client.dart';
import 'package:east_bridge/Approval/invoice_generation.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/KYC/KYC%20Components/KYC%20pdf%20Upload/KYCPdfUploadIND.dart';
import 'package:east_bridge/Log%20In/Login.dart';
import 'package:east_bridge/RiskAssessmentFormInvidual.dart';
import 'package:flutter/material.dart';
import './Colors.dart';
import './TextController.dart';
import '../generated/l10n.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class HeaderTop extends StatefulWidget {
  HeaderTop({super.key});

  @override
  State<HeaderTop> createState() => _HeaderTopState();
}

class _HeaderTopState extends State<HeaderTop> {
  Future CountForms(String tformName, String? tapby) async {
    print("Countinmg");
    String apby = "";
    if (tapby != null) {
      apby = tapby;
    }
    tapby = apby.split(" ").join("%20");

    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/FormTableLive/getFormsForApproval?FormName=$tformName&Approvalby=$tapby');

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      print('tanveer-----');

    var li = jsonDecode(response.body);
      setState(() {
        setState(() {
          int i = GlobalPermission.notificationList.indexOf(tformName);
          GlobalPermission.notifiacationbottomvalues[i] = li.length;
          int sum = 0;
          for (int number in GlobalPermission.notifiacationbottomvalues) {
            sum += number;
          }
          GlobalPermission.count = sum;
        });
      });
    } else {
      print("Error");
    }
  }

  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    print("header intii");
    print(GlobalPermission.notificationList);
    for (String i in GlobalPermission.notificationList) {
      CountForms(i, GlobalPermission.userType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: Image.network(
              '${GlobalPermission.urlLink}/api/CompanyDetail/GetCompanyLogo?language=English',
              width: 196.0,
              height: 80.0,
            ),
          ),
          // SizedBox(
          //   width: 400,
          // ),

          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: 232,
                          height: 34,
                          child: TextField(
                            // cursorColor: Colors.black,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                hintText: S.of(context).search,
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Frutiger',
                                    color: Color(0xFFB8B1B1)),
                                prefixIcon: const Icon(Icons.search),
                                prefixIconColor: Color(0xFFD9D9D9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFCACACA)),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Stack(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications),
                              onPressed: () async {
                                if (isButtonDisabled) {
                                  return; // Exit the function if the button is disabled
                                }
                                isButtonDisabled = true;
                                for (String i
                                    in GlobalPermission.notificationList) {
                                  await CountForms(
                                      i, GlobalPermission.userType);
                                }
                                isButtonDisabled = false;
                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    150,
                                    140,
                                    120,
                                    0,
                                  ), // Adjust position as needed

                                  items: [
                                    PopupMenuItem(
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                          // Set highlightColor and hoverColor to transparent
                                          highlightColor: Colors.transparent,
                                          // hoverColor: Colors.transparent,
                                        ),
                                        child: Container(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Notifications',
                                                  style:
                                                      TextController.browseText,
                                                ),
                                              ),
                                              Divider(),
                                              Container(
                                                height: 200,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: GlobalPermission
                                                      .notificationList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: ColorSelect
                                                                .east_grey,
                                                          ),
                                                        ),
                                                      ),
                                                      child: ListTile(
                                                        onTap: () {
                                                          print(GlobalPermission
                                                                  .notificationList[
                                                              index]);
                                                          if (GlobalPermission
                                                                          .notificationList[
                                                                      index] ==
                                                                  "Product Invoice" ||
                                                              GlobalPermission
                                                                          .notificationList[
                                                                      index] ==
                                                                  "MileStone Achived") {
                                                            InvoiceGeneration
                                                                    .type =
                                                                GlobalPermission
                                                                        .notificationList[
                                                                    index];
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    InvoiceGeneration(
                                                                        // li2: [],
                                                                        ),
                                                              ),
                                                            );
                                                          } else {
                                                            ClientApproval
                                                                    .type =
                                                                GlobalPermission
                                                                        .notificationList[
                                                                    index];
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ClientApproval(
                                                                        // li2: [],
                                                                        ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        title: Text(
                                                          GlobalPermission
                                                                  .notificationList[
                                                              index],
                                                          style: TextController
                                                              .BodyHeadingText,
                                                        ),
                                                        subtitle: Text(
                                                            GlobalPermission
                                                                .notifiacationbottomvalues[
                                                                    index]
                                                                .toString()),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            // Show badge if there are notifications
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                // padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.red, // Set badge background color
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    GlobalPermission.count.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Logins(),
                          ));
                        },
                        child: Container(
                          width: 105,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: Color(0xFFDDDDDD))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Image.asset(
                                  'images/logout_icon.png',
                                  width: 26,
                                  height: 26,
                                  color: Color(0xFF316A8C),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                S.of(context).Logout,
                                style: TextStyle(
                                  fontFamily: 'Gotham',
                                  fontSize: 12.0,
                                  color: Color(0xFF565252),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        width: 125,
                        height: 42,
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD7CFCF))),
                        child: TextButton(
                          onPressed: () {
                            S.load(Locale('en', 'US'));
                          },
                          child: Row(
                            children: [
                              Image.asset(
                                'images/En_Flag.png',
                                width: 46,
                                height: 32,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "En",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Frutiger',
                                  fontSize: 16.0,
                                  color: Color(0xFF000000),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                          width: 125,
                          height: 42,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFD7CFCF))),
                          child: TextButton(
                            onPressed: () {
                              S.load(Locale('ar', 'SA'));
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Image.asset(
                                    'images/Ar_Flag.png',
                                    width: 43,
                                    height: 29,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Ar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Frutiger',
                                    fontSize: 16.0,
                                    color: Color(0xFF000000),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 50, top: 10),
                    child: Text(
                      GlobalPermission.userType!,
                      style: TextController.BodyHeadingText,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
