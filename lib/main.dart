
import 'package:TourGuideApp/screens/all_places_screen.dart';
import 'package:TourGuideApp/screens/homePage/all_cities_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/cafes/all_cafes.dart';
import 'package:TourGuideApp/screens/servicesProvider/cinemas/all_cinemas_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/hotels/all_hotels_screen.dart';
import 'package:TourGuideApp/screens/homePage/best_location_screen.dart';
import 'package:TourGuideApp/screens/homePage/home_screen.dart';
import 'package:TourGuideApp/screens/login/login_screen.dart';
import 'package:TourGuideApp/screens/login/register_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/malls/all_malls.dart';
import 'package:TourGuideApp/screens/servicesProvider/mosques/all_mosques_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/restaurants/all_restaurants_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/services_provider_screen.dart';
import 'package:TourGuideApp/screens/login/welcome_screen.dart';
import 'package:TourGuideApp/screens/test.dart';
import 'package:TourGuideApp/test_firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {

        WelcomeScreen.id    : (context) =>           WelcomeScreen(title: '',),
        LoginPage.id        : (context) =>     const LoginPage(),
        RegisterPage.id     : (context) =>     const RegisterPage(),
        HomePage.id         : (context) =>     const HomePage(),
        AllCities.id        : (context) =>     const AllCities(),
        ServicesProvider.id : (context) =>           ServicesProvider(),
        BestLocations.id    : (context) =>     const BestLocations(),
        TestPage.id             : (context) => TestPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Your Tour Guide',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfff9f9f9),
        appBarTheme:  AppBarTheme(
          elevation: 0,
          // backgroundColor: Colors.grey[200],
          backgroundColor: Color(0xfff9f9f9),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            // statusBarColor: Colors.grey[300],
            statusBarColor: Color(0xfff9f9f9),
          ),
        ),
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: Colors.black),
      ),
      initialRoute: HomePage.id,
    );
  }
}

