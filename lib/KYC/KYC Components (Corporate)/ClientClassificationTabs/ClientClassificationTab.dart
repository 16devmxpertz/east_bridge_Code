import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientClassificationTabs/CheckBoxState.dart';
import 'package:east_bridge/KYC/KYC%20Components%20(Corporate)/ClientClassificationTabs/TabsClientClassification/QualifiedClient.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'TabsClientClassification/InstitutionalClient.dart';
import 'TabsClientClassification/RetailsClient.dart';
import 'package:east_bridge/KYC/corporate.dart';

import 'package:flutter/material.dart';

class TabBarApp extends StatefulWidget {
  TabBarApp({@required controller}) {
    tabController = controller;
  }

  @override
  State<TabBarApp> createState() => _TabBarAppState();
}

TabController? tabController;
CheckboxState checkboxState = CheckboxState();
void translate() {
  tabController?.animateTo(4);
}

void translateBack() {
  tabController?.animateTo(2);
}

String ClientType = "";

class _TabBarAppState extends State<TabBarApp> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Visibility(
                     //   visible: !checkboxState.isRetail,
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
                  ),
                 
                  Expanded(
                    child: Center(
                      child: Visibility(
                        visible: !checkboxState.institutionalChecked1,
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
                  ),
                  Expanded(
                    child: Center(
                      child: Visibility(
                        visible: !checkboxState.institutionalChecked1 &&
                            !checkboxState.institutionalChecked2 &&
                            !checkboxState.institutionalChecked3 &&
                            !checkboxState.institutionalChecked4 &&
                            !checkboxState.institutionalChecked5 &&
                            !checkboxState.institutionalChecked6 &&
                            !checkboxState.institutionalChecked7 &&
                            !checkboxState.institutionalChecked8,
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
                  ),
                ],
              ),
            ),
            if (ClientType == "Retail")
              RetailClient(onButtonPressed: translate),
            if (ClientType == "Qualified")
              NestQaulifiedClient(onButtonPressed: translate),
            if (ClientType == "Institutional")
              InstitutionalClient(onButtonPressed: translate),

              
          ],
        ),
      ),
    );
  }
}
