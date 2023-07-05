import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/screens/tours/tour_screen_new.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllOptions extends StatelessWidget {
  static String id = 'allOptions';
  final DocumentReference tourDocId;

  AllOptions({
    Key? key,
    required this.tourDocId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference options = tourDocId.collection('Option 1');
    return FutureBuilder<QuerySnapshot>(
        future: options.get(),
        builder: (context, snapshot) {
          final List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
          if (allDocs == null) {
            Scaffold(
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
                title: const Text(
                  'All Options',
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
                itemBuilder: (context, index) => BuildAllOptionsNew(
                  allDocs: allDocs,
                  index: index,
                  pushedPage: TourScreenNew(
                    currentIndex: index,
                    tourData: allDocs,
                  ),
                ),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
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

