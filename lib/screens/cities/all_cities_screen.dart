// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/screens/cities/city_screen.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCities extends StatefulWidget {
  static String id = 'allCities';

  const AllCities({Key? key}) : super(key: key);

  @override
  State<AllCities> createState() => _AllCitiesState();
}

class _AllCitiesState extends State<AllCities> {
  final CollectionReference cities =
      FirebaseFirestore.instance.collection('cities');

List<DocumentReference> allCitiesDocs = [
  FirebaseFirestore.instance.collection('cities').doc('Alexandria'),
  FirebaseFirestore.instance.collection('cities').doc('Cairo'),
  FirebaseFirestore.instance.collection('cities').doc('Giza'),
  FirebaseFirestore.instance.collection('cities').doc('Sharm El-Sheikh'),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'All Cities',
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
          future: cities.get(),
          builder: (context, snapshot) {
            List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
            if (allDocs == null) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              ));
            }
            else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => BuildAllCitiesItem(
                  index: index,
                  allDocs: allDocs,
                  cityDocId: allCitiesDocs[index],
                ),
                separatorBuilder: (context, index) => Container(
                  height: 10,
                ),
                itemCount: allDocs.length,
              );
            }
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            ));
          }),
    );
  }
}


class BuildAllCitiesItem extends StatelessWidget {
  List<QueryDocumentSnapshot>? allDocs;
  int index;
  final DocumentReference cityDocId;

  BuildAllCitiesItem({
    Key? key,
    required this.index,
    required this.allDocs,
    required this.cityDocId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CityScreen(
            currentIndex: index,
            cityDocId: cityDocId,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 0.75),
                ),
              ],
            ),
            child: Stack(
              children: [
                Image(
                  image: NetworkImage('${allDocs![index]['imageUrl']}',
                  ),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
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

                ),
                Positioned(
                  top: 145,
                  left: 20,
                  child: BorderedText(
                    strokeColor: Colors.black,
                    strokeWidth: 2,
                    strokeCap: StrokeCap.butt,
                    strokeJoin: StrokeJoin.bevel,
                    child: Text(
                      '${allDocs![index]['cityName']}',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 25,
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
    );
  }
}



