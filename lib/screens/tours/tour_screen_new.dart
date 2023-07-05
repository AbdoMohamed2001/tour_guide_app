// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class TourScreenNew extends StatefulWidget {
  TourScreenNew({Key? key, required this.tourData, required this.currentIndex})
      : super(key: key);
  List<QueryDocumentSnapshot> tourData;
  int currentIndex;

  @override
  State<TourScreenNew> createState() => _TourScreenNewState();
}

class _TourScreenNewState extends State<TourScreenNew> {
  final storage = FirebaseStorage.instance;
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var tour = widget.tourData[widget.currentIndex];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(-0.5),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Image
              CustomImage(
                dataKey: dataKey,
                imagesLength: tour['images'].length.toString(),
                fontSize: 18,
                imageUrl: tour['imageUrl'],
                endImageUrl: tour['images'][0],
                itemName: tour['tourName'],
                itemLocation: tour['state'],
              ),
              kSizedBox,

              //-------------------------------------------------------------------------
              //Tour duration
              Row(
                children: [
                  Image.asset(
                    'assets/images/duration-icon-3.jpg',
                    color: Colors.orange[300],
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'From:  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tour['startingTime'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'To:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            tour['endTime'],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //Tour Date
              Row(
                children: [
                  Image.asset(
                    'assets/images/calendar.png',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'From:  ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '15/6/2023',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          Text(
                            'To:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '15/6/2023',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //trip organizer
              Row(
                children: [
                  Text(
                    'More information :',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var url = Uri.parse(tour['website']);
                      if (await canLaunchUrl(
                        url,
                      )) {
                        await launchUrl(url);
                      }
                      ;
                    },
                    child: Image.asset(
                      'assets/images/nilesun.png',
                      width: 120,
                      height: 70,
                    ),
                  )
                ],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //Tour Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tour Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              // Text in description
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 80,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.hardEdge,
                    controller: ScrollController(),
                    child: Center(
                      child: Text(
                        tour['tourSummary'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //-------------------------------------------------------------------------
              //Images
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Images',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              kSizedBox,
              GridView.count(
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: (0.6 / 1),
                mainAxisSpacing: 20,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  //image 1
                  ImageView(
                    dataKey: dataKey,
                    data: widget.tourData,
                    ImageIndex: 0,
                    currentIndex: widget.currentIndex,
                    widgetDataAndIndex: tour,
                  ),
                  //image 2

                ],
              ),

              //End Images
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  DetailScreen({
    Key? key,
    required this.tourData,
    required this.currentIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> tourData;
  int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              tourData[currentIndex]['images'][1],
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
