import 'package:flutter/material.dart';
import 'package:tradedex/pages/individual_collection/individual_collection_page.dart';
import 'package:tradedex/pages/login/start_page.dart';
import 'package:tradedex/SignIn/SignInPage.dart';
import 'package:tradedex/pages/home/home_page.dart';
import 'package:tradedex/pages/home/pages/primary/primary_page.dart';
import 'package:tradedex/pages/home/pages/secondary/secondary_page.dart';
import 'package:tradedex/pages/official_collection/official_collection_page.dart';
import 'package:tradedex/pages/about/about_page.dart';
import 'package:tradedex/pages/settings/settings_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => StartPage());
      case '/signin':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/primary':
        return MaterialPageRoute(builder: (_) => PrimaryPage());
      case '/secondary':
        return MaterialPageRoute(builder: (_) => SecondaryPage());
      case '/official':
        return MaterialPageRoute(builder: (_) => OfficialCollectionPage());
      case '/individual':
        return MaterialPageRoute(builder: (_) => IndividualCollectionPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/about':
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => StartPage());
  }
}
