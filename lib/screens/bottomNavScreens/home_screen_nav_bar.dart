// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/screens/best_places/best_place.dart';
import 'package:TourGuideApp/screens/cities/all_cities_screen.dart';
import 'package:TourGuideApp/screens/best_places/all_best_places.dart';
import 'package:TourGuideApp/screens/upcomingEvents/all_upcoming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../tours/all_tours.dart';

class HomePageNavBar extends StatefulWidget {
  int currentIndex;
  static String id = 'homepageNavBar';
  final String? documentId;

  HomePageNavBar({
    Key? key,
    this.documentId,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<HomePageNavBar> createState() => _HomePageNavBarState();
}

class _HomePageNavBarState extends State<HomePageNavBar> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    CollectionReference bestplaces =
        FirebaseFirestore.instance.collection('bestplaces');
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: bestplaces.get(),
          builder: (context, snapshot) {
            final List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
            if (allDocs == null) {
              Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, top: 20, right: 12),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //---------------------------------------------------------
                        //Explore
                        const Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 28,
                          ),
                        ),
                        // Best Places in Egypt
                        const Text(
                          'Best Places in Egypt',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(1),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 35,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.6 / .45,
                          ),
                          itemBuilder: (context, index) {
                            return ServiceProviderItem(
                              fileName:
                                  listOfServicesProviderModel[index].fileName,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return listOfServicesProviderModel[index]
                                      .pushedPage;
                                }));
                              },
                              boxDecorationColor:
                                  listOfServicesProviderModel[index]
                                      .containerColor,
                              boxDecorationBorderRadius: 10,
                              text: listOfServicesProviderModel[index].name,
                            );
                          },
                          itemCount: 4,
                        ),
                        kSizedBox,
                        //----------------------------------------------------------------
                        //Travel Places
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Travel Places',
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllBestPlaces()));
                              },
                              child: Container(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                child: const Center(child: Text('View All')),
                              ),
                            ),
                          ],
                        ),
                        kSizedBox,
                        //Places
                        SizedBox(
                          height: 210,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return BestPlaceScreen(
                                          placeData: allDocs,
                                          currentIndex: index);
                                    }));
                                  },
                                  child: Container(
                                    width: screenWidth * 0.65,
                                    height: screenHeight * 0.5,
                                    decoration: BoxDecoration(
                                      color: Colors.white10,
                                      border: Border.all(
                                        width: 0.1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(
                                              allDocs[index]['imageUrl'],
                                              // 'https://cdn.mos.cms.futurecdn.net/YMa7Wx2FyjQFUjEeqa72Rm-1200-80.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                            height: 100,
                                            width: 250,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    allDocs[index]['name'],
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(allDocs[index]
                                                      ['cityName']),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: 20,
                                                height: 20,
                                                color: Colors.greenAccent,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                            itemCount: 5,
                          ),
                        ),
                        //----------------------------------------------------------------
                      ],
                    ),
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              ));
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            ));
          }),
    );
  }
}

List<ServicesProviderModel> listOfServicesProviderModel = [
  ServicesProviderModel(
    name: 'Best \n Places',
    containerColor: Color(0xff19131b),
    pushedPage: AllBestPlaces(),
    icon: FontAwesomeIcons.hotel,
    fileName: 'bestPlace',
  ),
  ServicesProviderModel(
      name: 'All Cities',
      containerColor: Color(0xff613207),
      pushedPage: AllCities(),
      icon: FontAwesomeIcons.solidBuilding,
      fileName: 'allCities'),
  ServicesProviderModel(
      name: 'Tours \n and Trips',
      containerColor: Color(0xffed79d25),
      pushedPage: AllTours(),
      icon: FontAwesomeIcons.suitcase,
      fileName: 'tour',

  ),
  ServicesProviderModel(
    name: 'Upcoming \n Events',
    containerColor: Color(0xff4069a7),
    pushedPage: AllUpcoming(),
    icon: Icons.today,
    fileName: 'event',
  ),
];

class ServicesProviderModel {
  final String name;
  final String fileName;
  final Color containerColor;
  final Widget pushedPage;
  final IconData icon;

  ServicesProviderModel({
    required this.name,
    required this.containerColor,
    required this.pushedPage,
    required this.icon,
    required this.fileName,
  });
}
