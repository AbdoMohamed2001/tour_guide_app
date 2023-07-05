// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/screens/best_places/photo_view_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MallNewScreen extends StatefulWidget {
  MallNewScreen({Key? key, required this.placeData, required this.currentIndex,})
      : super(key: key);
  List<QueryDocumentSnapshot> placeData;
  int currentIndex;

  @override
  State<MallNewScreen> createState() => _MallNewScreenState();
}

class _MallNewScreenState extends State<MallNewScreen> {
  final storage = FirebaseStorage.instance;
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var mall = widget.placeData[widget.currentIndex];
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
              //------------------------------------------------------------------------
              //Image
              CustomImage(
                dataKey: dataKey,
                imagesLength: '${mall['images'].length}',
                fontSize: 28,
                imageUrl: mall['imageUrl'],
                endImageUrl: mall['images'][0],
                itemName: mall['name'],
                itemLocation: mall['cityName'],
              ),
              kSizedBox,
              //------------------------------------------------------------------------
              //location and googleMaps
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //location
                    Container(
                      width: 250,
                      child: Text(
                        mall['address'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(mall['mapUrl']);
                        if (await canLaunchUrl(
                          url,
                        )) {
                          await launchUrl(url);
                        }
                        ;
                      },
                      child: Container(
                        child: Image.asset(
                          'assets/images/googlemaps.png',
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 0.5,
                thickness: 1,
                indent: 30,
                endIndent: 30,
                color: Colors.grey[300],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //Opening hours
              Row(
                children: [
                  Image.asset(
                    'assets/images/open.png',
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
                            mall['openingHours']['from'],
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
                            mall['openingHours']['to'],
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
              //Description and rate
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Description',
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
                        mall['description'],
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
              GridView.builder(
                key: dataKey,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(1),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(0.5),
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PhotoViewPage(
                              photos: mall['images'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: mall['images'][index],
                        child: CachedNetworkImage(
                          imageUrl: mall['images'][index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: mall['images'].length,
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
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
    required this.placeData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> placeData;
  int currentIndex;
  int ImageIndex;

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
              placeData[currentIndex]['images'][ImageIndex],
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
