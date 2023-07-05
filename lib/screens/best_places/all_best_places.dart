import 'package:TourGuideApp/screens/best_places/best_place.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllBestPlaces extends StatefulWidget {
  static String id = 'AllBestPlaces';

  const AllBestPlaces({Key? key}) : super(key: key);

  @override
  State<AllBestPlaces> createState() => _AllBestPlacesState();
}

class _AllBestPlacesState extends State<AllBestPlaces> {
  final CollectionReference bestplaces =
  FirebaseFirestore.instance.collection('bestplaces');
  late final QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'All Best Places',
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
          future: bestplaces.orderBy('id').get(),
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return BestPlaceScreen(
                        placeData: allDocs,
                        currentIndex: index,
                      );
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image(
                            image: NetworkImage('${allDocs[index]['imageUrl']}'),
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
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
                                '${allDocs[index]['name']}',
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


