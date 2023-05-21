
import 'package:TourGuideApp/screens/servicesProvider/malls/all_malls.dart';
import 'package:TourGuideApp/screens/servicesProvider/mosques/all_mosques_screen.dart';
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
                      return AllMallsNew(
                        cityDocId: cityDocId,
                      );
                    }));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(
                      children: [
                        Image(
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          image:
                              NetworkImage(snapshot.data!['${images[index]}']),
                        ), //Done
                        //Pyramids
                        Positioned(
                          top: 110,
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
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
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
