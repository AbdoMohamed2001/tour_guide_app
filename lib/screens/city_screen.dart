
import 'package:TourGuideApp/screens/places/all_places_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/cafes/all_cafes.dart';
import 'package:TourGuideApp/screens/servicesProvider/churches/alll_churches.dart';
import 'package:TourGuideApp/screens/servicesProvider/cinemas/all_cinemas_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/hotels/all_hotels_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/malls/all_malls.dart';
import 'package:TourGuideApp/screens/servicesProvider/mosques/all_mosques_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/restaurants/all_restaurants_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/tourCompanies/all_tour_companies.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatelessWidget {

  CityScreen({
    Key? key,
    required this.cityData,
    required this.currentIndex,
    required this.querySnapshot,
    required this.cityDocId,
  }) : super(key: key);
  static String id = 'cityScreen';
  List<QueryDocumentSnapshot> cityData;
  int currentIndex;
  final QuerySnapshot querySnapshot;
  final DocumentReference cityDocId;
  late List pages = [
    AllPlaces(
      cityDocId: cityDocId,
    ),
    AllHotels(cityDocId: cityDocId),
    AllRestaurants(cityDocId: cityDocId),
    AllMallsNew(cityDocId: cityDocId),
    AllCafes(cityDocId: cityDocId),
    AllMosques(cityDocId: cityDocId),
    AllChurches(cityDocId: cityDocId),
    AllTourCompanies(cityDocId: cityDocId),
    AllCinemas(cityDocId: cityDocId),

  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(

        future: cityDocId.get(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: Text(
                  snapshot.data!['cityName'].toString(),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
              body: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return pages[index];
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                          // BoxShadow(
                          //   color: Colors.grey.shade300,
                          //   offset: const Offset(-5,0),
                          // ),
                          // BoxShadow(
                          //   color: Colors.grey.shade300,
                          //   offset: const Offset(5,0),
                          // )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image(
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            image:
                                NetworkImage(snapshot.data!['${images[index]}']),
                          ), //Done
                          //Pyramids
                          Positioned(
                            top: 170,
                            left: 20,
                            child: BorderedText(
                              strokeColor: Colors.black,
                              strokeWidth: 2,
                              strokeCap: StrokeCap.butt,
                              strokeJoin: StrokeJoin.bevel,
                              child: Text(
                                names[index],
                                // snapshot.data!['Name'],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ), //Done
                          //Giza
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: images.length,
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        },

    );
  }
}

List images = [
  'placeImageUrl',
  'hotelImageUrl',
  'restImageUrl',
  'mallImageUrl',
  'cafeImageUrl',
  'mosqueImageUrl',
  'churchsImageUrl',
  'tourCompanyImageUrl',
  'cinemaImageUrl',
];
List names = [
  'Places',
  'Hotels',
  'Restaurants',
  'Malls',
  'Cafes',
  'Mosques',
  'Churches',
  'Tourism Companies',
  'Cinemas',
];
late DocumentReference cityDocId;
