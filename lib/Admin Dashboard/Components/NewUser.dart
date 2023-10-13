import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color.fromRGBO(0, 0, 0, 0.363),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            S.of(context).NewUser,
                            style: DashFormTextController.SubHeading,
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorSelect.east_grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          style: DashFormTextController.xAxis,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                color: ColorSelect.east_grey,
                              ),
                            ),
                            // hintText: 'Search',
                            // hintStyle: DashFormTextController.xAxis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorSelect.east_grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsetsDirectional.symmetric(
                        horizontal: 5,
                      ),
                      height: 25,
                      // width: 120,
                      child: DropdownButton(
                        value: dropdownvalue,
                        // isExpanded: true,
                        underline: Container(),
                        iconEnabledColor: Colors.black,
                        items: items.map(
                          (String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                S.of(context).ShowByAll,
                                style: DashFormTextController.xAxis,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          setState(
                            () {
                              dropdownvalue = newValue!;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 235,
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 1",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 2",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 3",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 4",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 5",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: ColorSelect.east_grey,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child:
                                    Image.asset('../../../images/person.png'),
                              ),
                              Container(
                                child: Text(
                                  "Person 6",
                                  style: DashFormTextController.Person,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Customer",
                                  style: DashFormTextController.Ctgry,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Icon(
                                  Icons.edit_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.delete_sweep_rounded,
                                  color: ColorSelect.tabTextColor,
                                  size: 15,
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
          ],
        ),
      ),
    );
  }
}
