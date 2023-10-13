import 'package:east_bridge/utility/Colors.dart';
import 'package:east_bridge/utility/TextController.dart';
import 'package:flutter/material.dart';

class ThemeSettings extends StatefulWidget {
  const ThemeSettings({super.key});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: ColorSelect.tabBorderColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Theme Settings",
                    style: TextController.SubHeadingText,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10.0, // Horizontal spacing between containers
                runSpacing: 10.0, // Vertical spacing between rows of containers
                children: [
                  Container(
                    clipBehavior: Clip.antiAlias,
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 204, 204, 204),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: 10,
                          height: 200,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
