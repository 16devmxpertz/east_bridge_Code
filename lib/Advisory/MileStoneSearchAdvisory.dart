import 'dart:convert';
//import 'dart:developer';
import 'package:east_bridge/Advisory/Advisory%20Subscribe/AdvisorySubscribe.dart';
import 'package:east_bridge/Advisory/AdvisoryManager.dart';
import 'package:east_bridge/Advisory/AdvisoryManagerforExpenseTracker.dart';
import 'package:east_bridge/Advisory/expenseTrackerAdvisory.dart';
import 'package:east_bridge/DPM/Buy.dart';
import 'package:east_bridge/DPM/DPMBuyMainSearchComponent.dart';
import 'package:east_bridge/Global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MileStoneSearchAdvisory extends StatefulWidget {
  MileStoneSearchAdvisory({@required controller}) {
    tabController = controller;
  }

  @override
  State<MileStoneSearchAdvisory> createState() =>
      _MileStoneSearchAdvisoryState();
  static ValueNotifier<String> name = new ValueNotifier("");
  static ValueNotifier<String> portname = new ValueNotifier("");
  static ValueNotifier<String> persharevalue = new ValueNotifier("");
  static ValueNotifier<int> clientid = new ValueNotifier(0);

  static ValueNotifier<int> pmid = new ValueNotifier(0);
}

TabController? tabController;

class _MileStoneSearchAdvisoryState extends State<MileStoneSearchAdvisory> {
  TextEditingController AdvisoryManagerName = new TextEditingController();
  TextEditingController clientName = new TextEditingController();
  TextEditingController PerShareValue = new TextEditingController();
  TextEditingController date = new TextEditingController();
  TextEditingController NoOfShares = new TextEditingController();
  TextEditingController Amount = new TextEditingController();
  int amnt = 0;
  int currentValue = 0;
  // String value = "";
  //int pershare = int.parse(MileStoneSearchAdvisory.persharevalue.value);
  // int noofshare = int.parse(NoOfShares.text);
  // int amnt = int.parse(Amount.text);

  @override
  void initState() {
    super.initState();

    print(MileStoneSearchAdvisory.name.value);
    //_calculation();

    setState(() {
      clientName.text = MileStoneSearchAdvisory.name.value;
      
      AdvisoryManagerName.text = MileStoneSearchAdvisory.portname.value;
    });
  }

  var clientId = MileStoneSearchAdvisory.name.value;

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

  List list = [];
  void sendData() async {
    var url = Uri.parse(
        '${GlobalPermission.urlLink}/api/PortFolioManagerClientRelation/PortFolioManagerClientRelation/');

  
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {
        "pmId": MileStoneSearchAdvisory.pmid.value,
        "clientId": MileStoneSearchAdvisory.clientid.value
      };
      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        tabController?.animateTo(1);
       
      } else {
        
        print(response.statusCode);
        print(response.body);
        print("error");
       
      }
   
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
            margin: EdgeInsets.only(top: 40),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 40,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color.fromRGBO(0, 0, 0, 0.363),
                        ),
                      ],
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Center(
                                //   child: Text(
                                //     S.of(context).AssignAdvisoryManager,
                                //     style: TextController.MainHeadingText,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          AdvisoryManagerSearchforExpenseTracker(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorSelect.east_grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          S.of(context).ClientName,
                                          style: TextController.BodyText,
                                        ),
                                        SizedBox(
                                          width: 40,
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
                                              readOnly: true,
                                              controller: clientName,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: TextController
                                                  .BodyHeadingText,
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
                                ],
                              ),
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorSelect.east_grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    color: ColorSelect.east_blue,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                          width: 1.0,
                                          color: Color(0xFFC9BBBB),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                      onPressed: () {
                                        sendData();
                                        // ExpenseTrackerAdvisory.clientid.value =
                                        //     int.parse(clientId);
                                        
                                      },
                                      child: Text(
                                        S.of(context).Submit,
                                        style: TextController.btnText,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(list.toString())
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
