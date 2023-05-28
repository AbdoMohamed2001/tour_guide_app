import 'package:TourGuideApp/components.dart';
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
  final DocumentReference giza = FirebaseFirestore.instance
      .collection('cities')
      .doc('1OILZtcN2KjarkB4g04L');

List<DocumentReference> allCitiesDocs = [
  FirebaseFirestore.instance.collection('cities').doc('1OILZtcN2KjarkB4g04L'),
  FirebaseFirestore.instance.collection('cities').doc('Alexandria'),
  FirebaseFirestore.instance.collection('cities').doc('CairoU3CcWkb031dRzxuy'),
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
                  querySnapshot: snapshot.data!,
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


