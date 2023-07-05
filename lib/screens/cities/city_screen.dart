import 'package:TourGuideApp/screens/all_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/hotels/all_hotels_screen.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CityScreen extends StatelessWidget {
  CityScreen({
    Key? key,
    required this.currentIndex,
    required this.cityDocId,
  }) : super(key: key);
  static String id = 'cityScreen';
  int currentIndex;
  DocumentReference cityDocId;
  late List<AllModel> listOfAllModel = [
    //place
    AllModel(
      image: 'placeImageUrl',
      name: 'Places',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Places',
          appBarText: 'All Places'),
    ),
    //hotel
    AllModel(
      image: 'hotelImageUrl',
      name: 'Hotels',
      pushedPage: AllHotels(
        cityDocId: cityDocId,
      ),
    ),
    //rest
    AllModel(
      image: 'restImageUrl',
      name: 'Restaurants',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Restaurants',
          appBarText: 'All Restaurants'),
    ),
    //mall
    AllModel(
      image: 'mallImageUrl',
      name: 'Malls',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Malls',
          appBarText: 'All Malls'),
    ),
    //cafe
    AllModel(
      image: 'cafeImageUrl',
      name: 'Cafes',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Cafes',
          appBarText: 'All Cafes'),
    ),
    //mosque
    AllModel(
      image: 'mosqueImageUrl',
      name: 'Mosques',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Mosques',
          appBarText: 'All Mosques'),
    ),
    //church
    AllModel(
      image: 'churchsImageUrl',
      name: 'Churches',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Churches',
          appBarText: 'All Churches'),
    ),
    //tourCompanies
    AllModel(
      image: 'tourCompanyImageUrl',
      name: 'Tourism Companies',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'TourCompanies',
          appBarText: 'All TourCompanies'),
    ),
    //cinema
    AllModel(
      image: 'cinemaImageUrl',
      name: 'Cinemas',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'Cinemas',
          appBarText: 'All Cinemas'),
    ),
    //tourGuides
    AllModel(
      image: 'tourGuideImageUrl',
      name: 'Tour Guides',
      pushedPage: AllScreen(
          cityDocId: cityDocId,
          collectionName: 'TourGuides',
          appBarText: 'All Tour Guides'),
    ),
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
        } else if (snapshot.connectionState == ConnectionState.done) {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return listOfAllModel[index].pushedPage;
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.5,
                          blurRadius: 4,
                          offset: const Offset(0, 0.75),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Image(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 220,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          width: double.infinity,
                          height: 220,
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(snapshot.data!['${listOfAllModel[index].image}']),
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
                              listOfAllModel[index].name,
                              // snapshot.data!['Name'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ), //Done
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
              ),
              itemCount: listOfAllModel.length,
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

class AllModel {
  final String image;
  final String name;
  final Widget pushedPage;

  AllModel({required this.image, required this.name, required this.pushedPage});
}
