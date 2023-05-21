import 'package:TourGuideApp/screens/servicesProvider/malls/mall.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllPlaces extends StatelessWidget {
  static String id = 'appPlaces';
  final DocumentReference cityDocId;

  AllPlaces({
    Key? key,
    required this.cityDocId,
  }) : super(key: key);
  CollectionReference cairoMallsCollection = FirebaseFirestore.instance
      .collection('cities')
      .doc('CairoU3CcWkb031dRzxuy')
      .collection('Mall');


  @override
  Widget build(BuildContext context) {
    CollectionReference places = cityDocId.collection('Places');
    return FutureBuilder<QuerySnapshot>(
        future: places.get(),
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
                  'All Malls',
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return MallNew(
                            mallData: allDocs,
                            currentIndex: index,
                          );
                        }));
                  },
                  child: Stack(
                    children: [
                      Image(
                        image: NetworkImage('${allDocs[index]['Imageurl']}'),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 130,
                        left: 20,
                        child: BorderedText(
                          strokeColor: Colors.black,
                          strokeWidth: 2,
                          strokeCap: StrokeCap.butt,
                          strokeJoin: StrokeJoin.bevel,
                          child: Text(
                            '${allDocs[index]['Name']}',
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ), //Done
                      Positioned(
                        top: 160,
                        left: 20,
                        child: BorderedText(
                          strokeColor: Colors.black,
                          strokeWidth: 2,
                          strokeCap: StrokeCap.butt,
                          strokeJoin: StrokeJoin.bevel,
                          child: Text(
                            '${allDocs[index]['cityName']}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.none) {
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
