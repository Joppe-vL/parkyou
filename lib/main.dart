import 'package:flutter/material.dart';
import 'package:parkyou/features/navigation_bar.dart';
import 'package:parkyou/pages/pages_barrel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(),
  );
}

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  bool _isBottomNavBarVisible(String routeName) {
    List<String> screensWithoutNavBar = [
      '/loginscreen',
      '/forgotpassword',
      '/registerscreen',
    ];

    return !screensWithoutNavBar.contains(routeName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parkyou',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      initialRoute: '/mapscreen',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => _wrapScrollConfiguration(
            settings,
            _getPage(settings),
          ),
          settings: settings,
        );
      },
    );
  }

  Widget _wrapScrollConfiguration(RouteSettings settings, Widget page) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: page,
            ),
            if (_isBottomNavBarVisible(settings.name.toString()))
              NavigationBara(destination: settings.name.toString()),
          ],
        ),
      ),
    );
  }

  Widget _getPage(RouteSettings settings) {
    switch (settings.name) {
      case '/removeparkscreen':
        return RemoveParkSpot();
      case '/releaseparkscreen':
        return ReleaseParkSpot();
      case '/mapscreen':
        return OpenStreetMap();
      case '/vehiclescreen':
        return VehicleScreen();
      case '/accountscreen':
        return AccountScreen();
      case '/edit_vehiclescreen':
        return EditVehicle();
      case '/addvehicle':
        return AddVehicle();
      case '/reserveparkspot':
        return ReserveParkSpot();
      case '/loginscreen':
        return LoginScreen();
      case '/changepassword':
        return ChangePassword();
      case '/forgotpassword':
        return ForgotPasswordscreen();
      case '/registerscreen':
        return Registerscreen();
      default:
        throw Exception('Invalid route: ${settings.name}');
    }
  }
}
