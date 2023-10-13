import 'dart:convert';

import 'package:east_bridge/Agreement%20Masters/CustomerGetAgreement.dart';
import 'package:east_bridge/DPM/AssignPortfolioManager.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/DefaultAgreement.dart';
import 'package:east_bridge/DPM/DPM%20Agreement/GetAgreement.dart';
import 'package:east_bridge/NDPM/AssignPortfolioManager.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PMSearchNDPM extends StatefulWidget {
  PMSearchNDPM({super.key, TabController? controller});

  @override
  State<PMSearchNDPM> createState() => _PMSearchNDPMState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

class _PMSearchNDPMState extends State<PMSearchNDPM> {
  List title = [];
  String dropdownvalue = 'Item 1';
  List li = [];
  List key = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void getData() async {
    try {
      print("ShahGet1");
      //Map fetchedData = await fetchData();
      print("ShahGet2");
      setState(() {
        print("ShahGet3");
        //title = fetchedData as List ;
        print("ShahGet4");
      });
    } catch (e) {
      print("ShahGetError");
      print(e);
    }
  }

  var services = [
    'DPM',
    'Non DPM',
    'Advisory',
    'Arranging',
    'Fund',
  ];

  double yOffset = 0;
  double xOffset = 0;
  bool sidBarOpen = false;
  bool _sidebarVisible = false;

  bool get sidebarVisible => _sidebarVisible;

  Map map = {};

  void toggleSidebar() {
    _sidebarVisible = !_sidebarVisible;
  }

  void setSideBarState() {
    setState(() {
      xOffset = sidBarOpen ? 250 : 0;
    });
  }

  void fetchData() async {
    print("Shah");
    final response = await http.get(Uri.parse(
        'https://eastbridge.online/apicore/api/GetPortfolioManager/GetPortfolioManager'));

    print("Shah1");
    print(PMSearchNDPM.id.value);

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      setState(() {
        map = jsonDecode(json);
      });

      // title=json.decode(response.body);
      li = map.values.toList();
      key = map.keys.toList();
      print(li);
      print("Shah3");
    } else {
      print("ShahError");
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 1000,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Table(
                border: TableBorder.all(color: ColorSelect.tabBorderColor),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1)
                  // 0: FixedColumnWidth(500),
                  // 1: FixedColumnWidth(500)
                },
                children: [
                  TableRow(children: [
                    Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                            child: Text(
                          S.of(context).PortfolioManagerId,
                          style: TextController.tableHeading,
                        ))),
                    Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                            child: Text(
                          S.of(context).PortfolioManagerName,
                          style: TextController.tableHeading,
                        ))),
                  ]),
                ],
              ),
            ),
            Container(
              // height: 800,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: li.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        AssignPortfolioManagerNDPM.portname.value = li[index];
                        AssignPortfolioManagerNDPM.pmid.value =
                            int.parse(key[index]);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                new AssignPortfolioManagerNDPM()));
                      },
                      child: table(li[index], key[index], context));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget table(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            width: 1000,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Table(
              border: TableBorder.all(color: ColorSelect.tabBorderColor),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
              children: [
                TableRow(children: [
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        templateName,
                        style: TextController.BodyText,
                      ))),
                  Container(
                      height: 50,
                      child: Center(
                          child: Text(
                        templateKeys,
                        style: TextController.BodyText,
                      ))),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget card(String templateName, String templateKeys, BuildContext context) {
  return SingleChildScrollView(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Container(
            //height: 80,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: ColorSelect.tabBorderColor, width: 1))),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Container(
              //color: Colors.white,
              //elevation: 5.0,
              margin: EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      templateName,
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      templateKeys,
                      style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                new GetAgreement(templateKeys)));
                      },
                      child: Icon(
                        Icons.edit,
                        color: ColorSelect.tabTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
