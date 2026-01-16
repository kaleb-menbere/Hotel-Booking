// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/home/pages/profile/personal_info_page.dart';
import 'screens/home/pages/profile/address_page.dart';
import 'screens/home/pages/profile/notifications_page.dart';
import 'screens/home/pages/profile/privacy_security_page.dart';
import 'screens/home/pages/profile/payment_methods_page.dart';
import 'screens/home/pages/profile/my_bookings_page.dart';
import 'screens/home/pages/profile/favorites_page.dart';
import 'screens/home/pages/profile/reviews_page.dart';
import 'screens/home/pages/profile/contact_support_page.dart';
import 'screens/home/pages/profile/about_page.dart';
import 'screens/home/pages/profile/settings_page.dart';
import 'screens/home/pages/profile/terms_page.dart';
import 'screens/home/pages/profile/privacy_policy_page.dart';
import 'screens/home/pages/profile/help_center_page.dart';
import 'utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EthioStay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          elevation: 4,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.splash:
            return MaterialPageRoute(builder: (_) => SplashScreen());
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => LoginScreen());
          case AppRoutes.register:
            return MaterialPageRoute(builder: (_) => RegisterScreen());
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => HomeScreen());
          
          // Profile pages
          case AppRoutes.personalInfo:
            return MaterialPageRoute(builder: (_) => PersonalInfoPage());
          case AppRoutes.address:
            return MaterialPageRoute(builder: (_) => AddressPage());
          case AppRoutes.notifications:
            return MaterialPageRoute(builder: (_) => NotificationsPage());
          case AppRoutes.privacySecurity:
            return MaterialPageRoute(builder: (_) => PrivacySecurityPage());
          case AppRoutes.paymentMethods:
            return MaterialPageRoute(builder: (_) => PaymentMethodsPage());
          case AppRoutes.myBookings:
            return MaterialPageRoute(builder: (_) => MyBookingsPage());
          case AppRoutes.favorites:
            return MaterialPageRoute(builder: (_) => FavoritesPage());
          case AppRoutes.reviews:
            return MaterialPageRoute(builder: (_) => ReviewsPage());
          
          // Other pages
          case AppRoutes.contactSupport:
            return MaterialPageRoute(builder: (_) => ContactSupportPage());
          case AppRoutes.about:
            return MaterialPageRoute(builder: (_) => AboutPage());
          case AppRoutes.settings:
            return MaterialPageRoute(builder: (_) => SettingsPage());
          case AppRoutes.terms:
            return MaterialPageRoute(builder: (_) => TermsPage());
          case AppRoutes.privacyPolicy:
            return MaterialPageRoute(builder: (_) => PrivacyPolicyPage());
          case AppRoutes.helpCenter:
            return MaterialPageRoute(builder: (_) => HelpCenterPage());
          
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}