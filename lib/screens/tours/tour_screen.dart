import 'package:TourGuideApp/screens/tours/all_options.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TourScreen extends StatelessWidget {
  static String id = 'TourScreen';
  TourScreen({
    Key? key,
    required this.currentIndex,
    required this.tourDocId,
  }) : super(key: key);
  final int currentIndex;
  final DocumentReference tourDocId;
  late List pages = [
    AllOptions(tourDocId: tourDocId),
  ];
  List images = [
    'optionOneImageUrl',
  ];
  List names = [
    'Options',
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: tourDocId.get(),
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
                snapshot.data!['Name'],
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
                    return pages[index];
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
                          image: NetworkImage(snapshot.data!['${images[index]}']),
                          //'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg'
                          // NetworkImage(snapshot.data!['${images[index]}']),
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
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 10,
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


