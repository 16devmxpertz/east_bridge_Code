import 'package:east_bridge/generated/l10n.dart';
import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Color.fromRGBO(0, 0, 0, 0.363)),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
                            decoration: BoxDecoration(
                              color: ColorSelect.east_blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.people_outline,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    '2500',
                                    style: UserDashFormTextController.statusAmt,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    S.of(context).AllKYC,
                                    style: UserDashFormTextController.statusTxt,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Color.fromRGBO(0, 0, 0, 0.363)),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
                            decoration: BoxDecoration(
                              color: ColorSelect.east_blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.people_outline,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    '500',
                                    style: UserDashFormTextController.statusAmt,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    S.of(context).PendingKYC,
                                    style: UserDashFormTextController.statusTxt,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Color.fromRGBO(0, 0, 0, 0.363)),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
                            decoration: BoxDecoration(
                              color: ColorSelect.east_blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.people_outline,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    '2000',
                                    style: UserDashFormTextController.statusAmt,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    S.of(context).CompleteKYC,
                                    style: UserDashFormTextController.statusTxt,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Color.fromRGBO(0, 0, 0, 0.363)),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.fromLTRB(10, 2, 0, 2),
                            decoration: BoxDecoration(
                              color: ColorSelect.east_blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Center(
                                    child: Icon(
                                      Icons.people_outline,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 35,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    '2574',
                                    style: UserDashFormTextController.statusAmt,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    S.of(context).UserRegistration,
                                    style: UserDashFormTextController.statusTxt,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
