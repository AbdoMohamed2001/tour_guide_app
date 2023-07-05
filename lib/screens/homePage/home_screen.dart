import 'package:TourGuideApp/screens/bottomNavScreens/account_screen.dart';
import 'package:TourGuideApp/screens/bottomNavScreens/favourite_screen.dart';
import 'package:TourGuideApp/screens/bottomNavScreens/home_screen_nav_bar.dart';
import 'package:TourGuideApp/screens/bottomNavScreens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String id ='homePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _currentIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedBottomNavigationBar(
          gapLocation: GapLocation.center,
          icons: iconList,
          activeIndex: _currentIndex,
          activeColor: Colors.orange,
          gapWidth: 0,
          onTap: (index) => setState(() => _currentIndex = index),
          //other params
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            elevation: 0,),
        ),
        body: pages[_currentIndex],
      ),
    );
  }
}
final int currentIndex =0 ;
 String id = 'placeScreen';
final String? documentId='';

List<Widget> pages = [
  HomePageNavBar(
    currentIndex: currentIndex,
    documentId: documentId,
  ),
  SearchScreen(),
  FavouriteScreen(),
  AccountScreen(),
];
List<IconData> iconList = [
  FontAwesomeIcons.home,
FontAwesomeIcons.search,
  FontAwesomeIcons.heart,
FontAwesomeIcons.user,
];




