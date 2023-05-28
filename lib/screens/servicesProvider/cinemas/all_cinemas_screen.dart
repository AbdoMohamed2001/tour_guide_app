import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/screens/servicesProvider/cinemas/cinema_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllCinemas extends StatelessWidget {
  static String id = 'AllCinemas';
  final DocumentReference cityDocId;

  AllCinemas({
    Key? key,
    required this.cityDocId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cityDocId);

    CollectionReference cinema = cityDocId.collection('Cinemas');
    return FutureBuilder<QuerySnapshot>(
        future: cinema.get(),
        builder: (context, snapshot) {
          List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
          if (allDocs == null) {
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
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
                title: const Text(
                  'All Cinemas',
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
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.separated(
                  itemBuilder: (context, index) => BuildAllItemNew(
                    allDocs: allDocs,
                    index: index,
                    pushedPage: CinemaScreen(
                      currentIndex: index,
                      placeData: allDocs,
                    ),
                  ),
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: 15,
                  ),
                ),
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
        });
  }
}

