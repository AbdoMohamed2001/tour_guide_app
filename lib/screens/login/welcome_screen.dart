import 'package:TourGuideApp/resources/auth_methods.dart';
import 'package:TourGuideApp/screens/homePage/home_screen.dart';
import 'package:TourGuideApp/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome';
  const WelcomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                children:[
                  //----------------------------------------------------------------
                  const Image(
                    image: AssetImage('assets/images/applogo.png'),
                    width: 160,
                  ),
                  const SizedBox(height: 15,),
                  //----------------------------------------------------------------
                  // Welcome
                  const Text(
                    'WELCOME TO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'TOUR GUIDE',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        'APP',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  //----------------------------------------------------------------
                  //Login
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, LoginPage.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(20)),
                        color: Colors.white70,
                      ),
                      width: 190,
                      height: 40,
                      child: const Center(child: Text('LOG IN')),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //----------------------------------------------------------------
                  //Register
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, RegisterPage.id);

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(20)),
                        color: Colors.white70,
                      ),
                      width: 220,
                      height: 40,
                      child: const Center(child: Text('SIGN UP')),
                    ),
                  ),
                  SizedBox(height: 20,),
                  //----------------------------------------------------------------
                  //Guest
                  GestureDetector(
                    onTap: (){
                      AuthMethods().anonymousUser();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(20)),
                        color: Colors.white70,
                      ),
                      width: 190,
                      height: 40,
                      child:  Center(child: Text('Login as guest'.toUpperCase())),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}