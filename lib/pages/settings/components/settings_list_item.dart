import 'package:flutter/material.dart';
import 'package:tradedex/model/device.dart';

class SettingsListItem extends StatelessWidget with Device {
  final Function fn;
  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;

  SettingsListItem({
    @required this.leadingIcon,
    @required this.title,
    @required this.fn,
    @required this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () => this.fn(),
        child: Container(
          padding: EdgeInsets.only(top: 12, right: 20, bottom: 12, left: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.20),
            ),
          ),
          width: Device.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(this.leadingIcon, color: Colors.white),
                  SizedBox(width: 25),
                  Text(this.title, style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
              Icon(this.trailingIcon, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
