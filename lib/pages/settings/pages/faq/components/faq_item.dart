import 'package:flutter/material.dart';

class FaqItem extends StatefulWidget {
  final String title;
  final String text;

  FaqItem({@required this.title, @required this.text});

  @override
  _FaqItemState createState() => _FaqItemState(title: this.title, text: this.text);
}

class _FaqItemState extends State<FaqItem> {
  final String title;
  final String text;

  _FaqItemState({@required this.title, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          accentColor: Color(0xffee6c4d),
          textTheme: TextTheme(subtitle1: TextStyle(color: Colors.white)),
          unselectedWidgetColor: Colors.white,
        ),
        child: ExpansionTile(
          title: Text(
            this.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  this.text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
