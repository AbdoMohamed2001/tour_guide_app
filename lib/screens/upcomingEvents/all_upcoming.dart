import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/screens/upcomingEvents/upcoming_event_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllUpcoming extends StatelessWidget {
  static String id = 'AllUpcoming';

  AllUpcoming({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference upcomingEvents = FirebaseFirestore.instance.collection('Events');
    return FutureBuilder<QuerySnapshot>(
        future: upcomingEvents.get(),
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
                  'Upcoming Events',
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
                itemBuilder: (context, index) => BuildAllUpcomingEvents(
                  allDocs: allDocs,
                  index: index,
                  pushedPage: UpcomingEventScreen(
                    currentIndex: index,
                    upcomingEventData: allDocs,
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

