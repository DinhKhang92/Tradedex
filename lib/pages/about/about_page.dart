import 'package:flutter/material.dart';
import 'package:tradedex/localization/app_localization.dart';

import 'package:tradedex/model/device.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> with Device {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff242423),
      body: SafeArea(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(height: Device.height / 10),
        Container(
          width: Device.width - 40,
          padding: EdgeInsets.only(top: 30, right: 24, bottom: 30, left: 24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.20),
            ),
          ),
          child: Center(
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: AppLocalizations.of(context)
                          .translate('PAGE_ABOUT.SUBTITLE'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  TextSpan(
                      text: AppLocalizations.of(context)
                          .translate('PAGE_ABOUT.TEXT_1'),
                      style: TextStyle(color: Colors.white)),
                  TextSpan(
                      text: AppLocalizations.of(context)
                          .translate('PAGE_ABOUT.TEXT_2'),
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 12),
      child: _buildNavbar(),
    );
  }

  Widget _buildNavbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Text(
          AppLocalizations.of(context).translate('PAGE_ABOUT.TITLE'),
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Container(
          width: 48,
          height: 48,
          padding: EdgeInsets.all(8),
        ),
      ],
    );
  }
}
