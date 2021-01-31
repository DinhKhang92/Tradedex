import 'package:flutter/material.dart';
import 'package:tradedex/pages/contacts/contacts_page.dart';
import 'package:tradedex/pages/contacts/pages/contact_overview/contact_overview_page.dart';
import 'package:tradedex/pages/individual_collection/individual_collection_page.dart';
import 'package:tradedex/pages/individual_collection/pages/collection/collection_page.dart';
import 'package:tradedex/pages/start/start_page.dart';
import 'package:tradedex/pages/signin/signin_page.dart';
import 'package:tradedex/pages/home/home_page.dart';
import 'package:tradedex/pages/home/pages/primary/primary_page.dart';
import 'package:tradedex/pages/home/pages/secondary/secondary_page.dart';
import 'package:tradedex/pages/official_collection/official_collection_page.dart';
import 'package:tradedex/pages/about/about_page.dart';
import 'package:tradedex/pages/settings/settings_page.dart';
import 'package:tradedex/pages/settings/pages/language/language_page.dart';
import 'package:tradedex/pages/settings/pages/faq/faq_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SignInPage());
      case '/start':
        return MaterialPageRoute(builder: (_) => StartPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/primary':
        return MaterialPageRoute(builder: (_) => PrimaryPage());
      case '/secondary':
        return MaterialPageRoute(builder: (_) => SecondaryPage());
      case '/official':
        return MaterialPageRoute(builder: (_) => OfficialCollectionPage());
      case '/individual':
        return MaterialPageRoute(builder: (_) => IndividualCollectionPage());
      case '/collection':
        return MaterialPageRoute(
            builder: (_) => CollectionPage(collectionName: settings.arguments));
      case '/contacts':
        return MaterialPageRoute(builder: (_) => ContactsPage());
      case '/contact_overview':
        return MaterialPageRoute(builder: (_) => ContactOverviewPage());
      case '/settings':
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case '/language':
        return MaterialPageRoute(builder: (_) => LanguagePage());
      case '/faq':
        return MaterialPageRoute(builder: (_) => FaqPage());
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
