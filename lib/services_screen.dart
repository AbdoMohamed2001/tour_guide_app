
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

class ServicesScreen extends StatelessWidget {

  ServicesScreen({
    Key? key,
  }) : super(key: key);
  static String id = 'ServicesScreen';

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
    final DocumentReference cairo =
    FirebaseFirestore.instance.collection('cities').doc('CairoU3CcWkb031dRzxuy');
    return FutureBuilder<DocumentSnapshot>(

      future: cairo.get(),
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
                'All Services',
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
  'hotelImageUrl',
  'restImageUrl',
  'mallImageUrl',
  'cafeImageUrl',
  'tourCompanyImageUrl',
  'cinemaImageUrl',
];
List names = [
  'Hotels',
  'Restaurants',
  'Malls',
  'Cafes',
  'Tourism Companies',
  'Cinemas',
];
late DocumentReference cityDocId;