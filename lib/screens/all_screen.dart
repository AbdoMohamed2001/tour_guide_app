import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/screens/places/place_screen_new.dart';
import 'package:TourGuideApp/screens/servicesProvider/cinemas/cinema_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/hotels/hotel_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/malls/mall_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/restaurants/restaurants_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/tourGuides/tour_guides.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllScreen extends StatelessWidget {
  AllScreen({
    Key? key,
    required this.cityDocId,
    required this.collectionName,
    required this.appBarText,
  }) : super(key: key);
  static String id = 'AllScreen';
  final DocumentReference cityDocId;
  final String collectionName;
  final String appBarText;
  @override
  Widget build(BuildContext context) {
    CollectionReference collection = cityDocId.collection(collectionName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          appBarText,
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
      body: FutureBuilder<QuerySnapshot>(
          future: collection.get(),
          builder: (context, snapshot) {
            final List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
            if (allDocs == null) {
              Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                itemBuilder: (context, index) => BuildAllItemNew(
                  allDocs: allDocs,
                  index: index,
                  pushedPage: collectionName == 'Places'?
                  PlaceScreenNew(placeData: allDocs, currentIndex: index,):
                  collectionName == 'Hotels'?
                  HotelScreen(hotelData: allDocs, currentIndex: index,):
                  collectionName == 'TourGuides'?
                  TourGuideScreen(tourGuideData: allDocs, currentIndex: index,):
                  collectionName == 'Restaurants' || collectionName == 'Cafes'?
                  RestaurantScreen(restaurantData: allDocs, currentIndex: index,):
                  collectionName == 'Malls' || collectionName == 'Mosques' || collectionName == 'Churches'?
                  MallNewScreen(placeData: allDocs, currentIndex: index,):
                  CinemaScreen(placeData: allDocs, currentIndex: index,)


                ),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }),
    );
  }
}
