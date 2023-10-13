import 'package:east_bridge/utility/Colors.dart';
import 'package:flutter/material.dart';
import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:intl/intl.dart';

import 'RegisteredAddress.dart';

enum SingingCharacter { yes, no }

class ClientDec extends StatefulWidget {
     ClientDec({@required controller}) {
    tabController = controller;
  }
 


  @override
  State<ClientDec> createState() => ClientDecState();
}

enum RadioSelected { RadioOne, RadioTwo }

class ClientDecState extends State<ClientDec> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameOfContracts = new TextEditingController();
    TextEditingController bussinessPhone = new TextEditingController();
    TextEditingController addressForCorrespondense =
        new TextEditingController();
    TextEditingController Email = new TextEditingController();
    TextEditingController Mobile = new TextEditingController();
    TextEditingController radioTwo = new TextEditingController();
    TextEditingController radioThree = new TextEditingController();
    TextEditingController radioOne = new TextEditingController();
    TextEditingController dateController = new TextEditingController();

    SingingCharacter? _character = SingingCharacter.yes;
    int? selectedValue = 1;

    String dropdownvalue;

    // List of items in our dropdown menu
    var items = [
      'Item 1',
      'Item 2',
      'Item 3',
      'Item 4',
      'Item 5',
    ];

    @override
    void initState() {
      super.initState();
      dateController.text = " ";
    }

    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 50, right: 200, top: 10, bottom: 10),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  S.of(context).Name,
                  style: TextController.BodyText,
                ),
                Container(
                  width: 300,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.textField)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: TextFormField(
                      controller: nameOfContracts,
                      decoration: InputDecoration(
                          hintText: S.of(context).TypeHere,
                          hintStyle: TextController.labelText,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Text(
                  S.of(context).DateFormat,
                  style: TextController.BodyText,
                ),
                Container(
                  width: 300,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.textField)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: TextFormField(
                      controller: nameOfContracts,
                      decoration: InputDecoration(
                          hintText: S.of(context).TypeHere,
                          hintStyle: TextController.labelText,
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Container(
                  width: 300,
                  height: 35,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: ColorSelect.textField)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: TextFormField(
                      controller: nameOfContracts,
                      decoration: InputDecoration(
                          hintText: S.of(context).TypeHere,
                          hintStyle: TextController.labelText,
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            Container(
              height: 125,
              width: 1200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorSelect.east_grey, // set the border color
                  width: 2.0, // set the width of the border
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(
                      S.of(context).Signatureinthepresenceof,
                      style: TextController.SubHeadingText,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 30),
                        child: Text(
                          S.of(context).Name,
                          style: TextController.BodyText,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10),
                          child: TextFormField(
                            controller: nameOfContracts,
                            decoration: InputDecoration(
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 125,
              width: 1200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorSelect.east_grey, // set the border color
                  width: 2.0, // set the width of the border
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 10, bottom: 20),
                    child: Text(
                      S.of(context).complainceApproved,
                      style: TextController.SubHeadingText,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 30),
                        child: Text(
                          S.of(context).Name,
                          style: TextController.BodyText,
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10),
                          child: TextFormField(
                            controller: nameOfContracts,
                            decoration: InputDecoration(
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Text(
                        S.of(context).DateFormat,
                        style: TextController.BodyText,
                      ),
                      Container(
                        width: 300,
                        height: 35,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: ColorSelect.textField)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, bottom: 10),
                          child: TextFormField(
                            controller: nameOfContracts,
                            decoration: InputDecoration(
                                hintText: S.of(context).TypeHere,
                                hintStyle: TextController.labelText,
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 70),
                        child: Container(
                          width: 300,
                          height: 35,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: ColorSelect.textField)),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 15, bottom: 10),
                            child: TextFormField(
                              controller: nameOfContracts,
                              decoration: InputDecoration(
                                  hintText: S.of(context).TypeHere,
                                  hintStyle: TextController.labelText,
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
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
                                tabController?.animateTo(0);
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
                            child: TextButton(
                              onPressed: () {
                                tabController?.animateTo(2);
                              }, // Switch tabs
                              child: Text(
                                S.of(context).Next,
                                style: TextController.btnText,
                              ),
                            ),
                          ),
                        ],
                      )
      ],
    );
  }
}









// Padding(
//           padding:
//               const EdgeInsets.only(left: 50, right: 200, top: 10, bottom: 10),
//           child: Container(
//             height: 400,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   S.of(context).Signatureinthepresenceof,
//                   style: TextController.SubHeadingText,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       S.of(context).Name,
//                       style: TextController.BodyText,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 35,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: ColorSelect.textField)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, bottom: 10),
//                         child: TextFormField(
//                           controller: nameOfContracts,
//                           decoration: InputDecoration(
//                               hintText: S.of(context).TypeHere,
//                               hintStyle: TextController.labelText,
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   S.of(context).complainceApproved,
//                   style: TextController.SubHeadingText,
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       S.of(context).ClientName,
//                       style: TextController.BodyText,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 35,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: ColorSelect.textField)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, bottom: 10),
//                         child: TextFormField(
//                           controller: nameOfContracts,
//                           decoration: InputDecoration(
//                               hintText: S.of(context).TypeHere,
//                               hintStyle: TextController.labelText,
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       S.of(context).DateFormat,
//                       style: TextController.BodyText,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 35,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: ColorSelect.textField)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, bottom: 10),
//                         child: TextFormField(
//                           controller: nameOfContracts,
//                           decoration: InputDecoration(
//                               hintText: S.of(context).TypeHere,
//                               hintStyle: TextController.labelText,
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: 300,
//                       height: 35,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: ColorSelect.textField)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, bottom: 10),
//                         child: TextFormField(
//                           controller: nameOfContracts,
//                           decoration: InputDecoration(
//                               hintText: S.of(context).TypeHere,
//                               hintStyle: TextController.labelText,
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       S.of(context).DateFormat,
//                       style: TextController.BodyText,
//                     ),
//                     Container(
//                       width: 300,
//                       height: 35,
//                       alignment: Alignment.centerLeft,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: ColorSelect.textField)),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 15, bottom: 10),
//                         child: TextFormField(
//                           controller: nameOfContracts,
//                           decoration: InputDecoration(
//                               hintText: S.of(context).TypeHere,
//                               hintStyle: TextController.labelText,
//                               border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
