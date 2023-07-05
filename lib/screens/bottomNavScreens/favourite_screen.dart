
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var docId = _auth.currentUser!.email.toString();

    CollectionReference favourite =
    FirebaseFirestore.instance.collection('favouritePlaces').doc(docId).collection('Places');
    return FutureBuilder<QuerySnapshot>(
        future: favourite.get(),
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
              appBar: AppBar(),
              body: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, int index) => GestureDetector(
                  onTap: () {

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
          return Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ));
        });  }
}
