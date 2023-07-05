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

class CinemaScreen extends StatefulWidget {
  CinemaScreen({Key? key, required this.placeData, required this.currentIndex,})
      : super(key: key);
  List<QueryDocumentSnapshot> placeData;
  int currentIndex;

  @override
  State<CinemaScreen> createState() => _CinemaScreenState();
}

class _CinemaScreenState extends State<CinemaScreen> {
  final storage = FirebaseStorage.instance;
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cinema = widget.placeData[widget.currentIndex];
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
                imagesLength: '${cinema['images'].length}',
                fontSize: 28,
                imageUrl: cinema['imageUrl'],
                endImageUrl: cinema['images'][0],
                itemName: cinema['name'],
                itemLocation: cinema['cityName'],
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
                        cinema['address'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(cinema['mapUrl']);
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
                    'assets/images/tickets.png',
                    width: 90,
                    height: 90,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      Text('Ticket Price',),
                      Text(
                        cinema['tickets'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kSizedBox,
              Divider(
                height: 0.5,
                thickness: 1,
                indent: 30,
                endIndent: 30,
                color: Colors.grey[300],
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
                              photos: cinema['images'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: cinema['images'][index],
                        child: CachedNetworkImage(
                          imageUrl: cinema['images'][index],
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
                itemCount: cinema['images'].length,
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
