import 'package:flutter/material.dart';
import 'package:tradedex/pages/login/start_page.dart';
import 'package:tradedex/SignIn/SignInPage.dart';
import 'package:tradedex/pages/home/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => StartPage());
      case '/sign_in':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => StartPage());
  }
}
