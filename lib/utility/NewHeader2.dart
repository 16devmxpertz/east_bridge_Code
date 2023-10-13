import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './Colors.dart';
import './TextController.dart';
import '../generated/l10n.dart';
import 'NewHeader1.dart';

class NewHeader2 extends StatefulWidget {
  // final toggleWidget;
  const NewHeader2({super.key});
  @override
  State<NewHeader2> createState() => _NewHeader2State();
}

class _NewHeader2State extends State<NewHeader2> {
  // late AnimationController _animationController;
  // late Animation<Offset> _animation;
  // bool _isContainerVisible = false;

  // @override
  // void initState() {
  //   super.initState();

  //   _animationController = AnimationController(
  //     duration: Duration(milliseconds: 500),
  //     vsync: this,
  //   );

  //   _animation = Tween<Offset>(
  //     begin: Offset(0.0, 0.0),
  //     end: Offset(-1.0, 0.0),
  //   ).animate(
  //     CurvedAnimation(
  //       parent: _animationController,
  //       curve: Curves.easeInOut,
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   _animationController.dispose();
  //   super.dispose();
  // }

  // void _toggleContainerVisibility() {
  //   setState(
  //     () {
  //       _isContainerVisible = !_isContainerVisible;
  //       if (_isContainerVisible) {
  //         _animationController.forward();
  //       } else {
  //         _animationController.reverse();
  //       }
  //     },
  //   );
  // }

  // bool _showFirstWidget = true;
  // void toggleWidget() {
  //   setState(() {
  //     _showFirstWidget = !_showFirstWidget;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderTop(),
        Container(
          margin: EdgeInsets.fromLTRB(0, 17, 0, 0),
          width: double.infinity,
          height: 40,
          color: ColorSelect.east_blue,
          child: Row(
            children: [
              // menu btn

              // Container(
              //   width: 100,
              //   height: 40,
              //   color: Colors.white,
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Container(
              //       margin: EdgeInsets.only(bottom: 16.0),
              //       child: ElevatedButton(
              //         onPressed: _toggleContainerVisibility,
              //         child: Icon(Icons.menu),
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                width: 100,
                height: 40,
                child: Container(
                  height: 40,
                  child: Center(
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.menu),
                      onPressed: () {},
                      // onPressed: () {

                      // _globalKey.currentState?.openDrawer();
                      // },
                    ),
                  ),
                ),
              ),

              // new
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.add_card_rounded,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).New,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // EDIT
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.edit_calendar_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).Edit,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // view
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.content_paste_search,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).View,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // cancel
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.free_cancellation_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).Cancel,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // print
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.print,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).Print,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // download
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.download,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).Download,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // saveDraft
              Container(
                // width: 100,
                height: 44,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Container(
                    //color: ColorSelect.east_blue,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.save_as_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Center(
                          child: Text(
                            S.of(context).SaveDraft,
                            style: TextController.ControllerText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
