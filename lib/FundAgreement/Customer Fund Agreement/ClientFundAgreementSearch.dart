import 'dart:convert';

import 'package:east_bridge/Agreement%20Masters/CustomerGetAgreement.dart';
import 'package:east_bridge/Global.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/Navigation.dart';
import 'package:east_bridge/utility/NewHeader1.dart';
import 'package:east_bridge/utility/SideMenuBar.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClientFundAgreementSearch extends StatefulWidget {
  ClientFundAgreementSearch({super.key, TabController? controller});

  @override
  State<ClientFundAgreementSearch> createState() => _AgreementSearchState();
  static ValueNotifier<int> id = new ValueNotifier(0);
}

class _AgreementSearchState extends State<ClientFundAgreementSearch> {
  List title = [];
  String dropdownvalue = 'Item 1';
  List li = [];
  List agId = [];
  List agName = [];
  List fId = [];

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
        '${GlobalPermission.urlLink}/api/FundAgreeementCreation/GetFundAgreementTemplateNames'));

    print("Shah1");
    print(ClientFundAgreementSearch.id.value);

    if (response.statusCode == 200) {
      print("Shah2");
      final json = response.body;
      //print(json.decode(response.body));
      setState(() {
        li = jsonDecode(json);
      });

      // title=json.decode(response.body);
      for (String i in li) {
        setState(() {
          agId.add(i.split("-")[0]);
          agName.add(i.split("-")[1]);
          fId.add(i.split("-")[2]);
        });
      }
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
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: ColorSelect.east_grey,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Flexible(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               S.of(context).TemplateName,
            //               style: TextController.BodyText,
            //             ),
            //             SizedBox(
            //               width: 10,
            //             ),
            //             Flexible(
            //               child: Container(
            //                 padding: EdgeInsets.symmetric(horizontal: 10),
            //                 width: 280,
            //                 height: 35,
            //                 alignment: Alignment.centerLeft,
            //                 decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     border:
            //                         Border.all(color: ColorSelect.textField)),
            //                 child: TextFormField(
            //                   textAlignVertical: TextAlignVertical.center,
            //                   style: TextController.BodyHeadingText,
            //                   decoration: InputDecoration(
            //                       isDense: true,
            //                       hintText: S.of(context).TypeHere,
            //                       hintStyle: TextController.labelText,
            //                       border: InputBorder.none),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(
            //     horizontal: 10,
            //   ),
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: ColorSelect.east_grey,
            //         width: 1,
            //       ),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Flexible(
            //         child: Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 40, 0),
            //           height: 35,
            //           width: 100,
            //           color: ColorSelect.east_blue,
            //           child: TextButton(
            //             style: TextButton.styleFrom(
            //               side: BorderSide(
            //                 width: 1.0,
            //                 color: Color(0xFFC9BBBB),
            //               ),
            //               shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(0),
            //               ),
            //             ),
            //             onPressed: () {
            //               //SearchTemplate();
            //             },
            //             child: Text(
            //               S.of(context).search,
            //               style: TextController.btnText,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
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
                          S.of(context).AgreementId,
                          style: TextController.tableHeading,
                        ))),
                    Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                            child: Text(
                          S.of(context).AgreementName,
                          style: TextController.tableHeading,
                        ))),
                    Container(
                        height: 50,
                        color: ColorSelect.east_grey,
                        child: Center(
                            child: Text(
                          S.of(context).Edit,
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
                  return table(agName[index], agId[index], context);
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              new customerGetAgreement(templateKeys)));
                    },
                    child: Icon(
                      Icons.edit,
                      color: ColorSelect.tabTextColor,
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
