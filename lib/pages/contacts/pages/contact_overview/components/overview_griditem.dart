import 'package:flutter/material.dart';

class OverviewGridItem extends StatefulWidget {
  final String collectionLength;
  final String title;
  final IconData icon;
  final Color iconColor;
  OverviewGridItem({
    @required this.collectionLength,
    @required this.title,
    @required this.icon,
    @required this.iconColor,
  });

  @override
  _OverviewGridItemState createState() => _OverviewGridItemState(
        collectionLength: this.collectionLength,
        title: this.title,
        icon: this.icon,
        iconColor: this.iconColor,
      );
}

class _OverviewGridItemState extends State<OverviewGridItem> {
  final String collectionLength;
  final String title;
  final IconData icon;
  final Color iconColor;

  _OverviewGridItemState({
    @required this.collectionLength,
    @required this.title,
    @required this.icon,
    @required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.5,
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      child: GridTile(
        header: Padding(
          padding: EdgeInsets.only(top: 5, left: 5),
          child: Text(
            this.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        child: Icon(
          this.icon,
          size: 40,
          color: this.iconColor,
        ),
        footer: Padding(
          padding: EdgeInsets.only(bottom: 5, right: 5),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              this.collectionLength,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
