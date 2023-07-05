// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/cache/cacheHelper.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/resources/auth_methods.dart';
import 'package:TourGuideApp/screens/best_places/photo_view_page.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceScreenNew extends StatefulWidget {
  PlaceScreenNew({
    Key? key,
    required this.placeData,
    required this.currentIndex,
  }) : super(key: key);
  List<QueryDocumentSnapshot> placeData;
  int currentIndex;

  @override
  State<PlaceScreenNew> createState() => _PlaceScreenNewState();
}

class _PlaceScreenNewState extends State<PlaceScreenNew> {
  late var likedKey = widget.placeData[widget.currentIndex].id;
  late bool liked = false;
  final storage = FirebaseStorage.instance;
  final dataKey = new GlobalKey();
  bool isFavourite = false;
  bool isRated = false;
  Color iconColor = Colors.white;
  Color isRatedColor = Colors.black;
  @override
  void initState() {
    super.initState();
    _restorePersistedPref();
  }

  void _restorePersistedPref() async {
    var preferences = await SharedPreferences.getInstance();
    var liked = preferences.getBool(likedKey);
    setState(() {
      liked == null ? print(''):
      this.liked = liked;
    });
  }

  @override
  Widget build(BuildContext context) {

    var docID = widget.placeData[widget.currentIndex].id;
    var place = widget.placeData[widget.currentIndex];
    // var likedKey = docID;
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image(
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                      image: NetworkImage(place['imageUrl']),
                    ), //Done
                    //Pyramids
                    Positioned(
                      top: 245,
                      left: 20,
                      child: BorderedText(
                        strokeColor: Colors.black,
                        strokeWidth: 2,
                        strokeCap: StrokeCap.butt,
                        strokeJoin: StrokeJoin.bevel,
                        child: Text(
                          place['name'],
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ), //Done
                    //Giza
                    Positioned(
                      top: 280,
                      left: 20,
                      child: BorderedText(
                        strokeColor: Colors.black,
                        strokeWidth: 2,
                        strokeCap: StrokeCap.butt,
                        strokeJoin: StrokeJoin.bevel,
                        child: Text(
                          place['cityName'],
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ), //Done
                    //End Image
                    Positioned(
                      top: 290,
                      right: 20,
                      child: GestureDetector(
                        onTap: () {
                          Scrollable.ensureVisible(dataKey.currentContext!);
                        },
                        child: Container(
                          width: 55,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Colors.white,
                              width: 0.8,
                            ),
                          ),
                          child: ClipRRect(
                            child: Stack(
                              fit: StackFit.passthrough,
                              children: [
                                Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    place['images'][0],
                                  ),
                                ),
                                Center(
                                  child: BorderedText(
                                    strokeColor: Colors.black,
                                    strokeWidth: 1.5,
                                    strokeCap: StrokeCap.butt,
                                    strokeJoin: StrokeJoin.bevel,
                                    child: Text(
                                      '+${place['images'].length}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Favourite
                    Positioned(
                      right: 25,
                      top: 10,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              liked = !liked;

                            });
                            if (liked == true) {
                              CacheData.setData(
                                  key: likedKey, value: liked);
                              AuthMethods().addToFavourite(
                                context: context,
                                docID: docID,
                                address: place['address'],
                                description: place['description'],
                                imageUrl: place['imageUrl'],
                                name: place['name'],
                                rate: place['rate'],
                                cityName: place['cityName'],
                                images: place['images'],
                                mapUrl: place['mapUrl'],
                                openingHours: place['openingHours'],
                                tickets: place['tickets'],
                              );
                            } else {
                              CacheData.setData(
                                  key: likedKey, value: liked);
                              AuthMethods().deleteFromFavourite(
                                context: context,
                                docID: docID,
                              );
                            }
                          },
                        icon: Icon(
                          Icons.favorite,
                          color: liked ? Colors.red : Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                    //Back
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              //-------------------------------------------------------------------
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
                        place['address'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(place['mapUrl']);
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
              //-------------------------------------------------------------------
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
                            place['openingHours']['from'],
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
                            place['openingHours']['to'],
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
              //-------------------------------------------------------------------
              //tickets
              Row(
                children: [
                  //Ticket Icon
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: Image.asset('assets/images/tickets.png'),
                      ),
                      Text(
                        'Tickets',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //Ticket Price
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'FOREIGNERS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          place['tickets']['foreigners']['adult'] == null
                              ? Text('')
                              : place['tickets']['foreigners']['student'] ==
                                      null
                                  ? Text('')
                                  : Text(
                                      'Adult: ${place['tickets']['foreigners']['adult']} '
                                      '| Student: ${place['tickets']['foreigners']['student']}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'EGYPTIANS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              'Adult: ${place['tickets']['egyptians']['adult']} | '
                              'Student: ${place['tickets']['egyptians']['student']}'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              kSizedBox,
              //-------------------------------------------------------------------
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
                        place['description'],
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
              //-------------------------------------------------------------------
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
                              photos: place['images'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: place['images'][index],
                        child: CachedNetworkImage(
                          imageUrl: place['images'][index],
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
                itemCount: place['images'].length,
              ),
              kSizedBox,
              //-------------------------------------------------------------------
              //Nearly
              const Text(
                'Nearly to this place ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       //Hotels
              //       NearlyPlaceItem(
              //         containerColor: Colors.black,
              //         iconName: FontAwesomeIcons.hotel,
              //         iconColor: Color(0xff613207),
              //         containerName: 'Hotels',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       //-------------------------------------------
              //       //Restaurants
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff613207),
              //         iconName: FontAwesomeIcons.utensils,
              //         iconColor: Colors.black,
              //         containerName: 'Restaurants',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       //-------------------------------------------
              //       //Cafes
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff613207),
              //         iconName: FontAwesomeIcons.mugHot,
              //         iconColor: Colors.black,
              //         containerName: 'Cafes',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       //-------------------------------------------
              //       //Cinemas
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff66191c),
              //         iconName: FontAwesomeIcons.film,
              //         iconColor: Colors.black,
              //         containerName: 'Cinemas',
              //       ),
              //     ],
              //   ),
              // ),
              kSizedBox,
              //-------------------------------------------------------------------
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
  }) : super(key: key);

  List<QueryDocumentSnapshot> placeData;
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
              placeData[currentIndex]['images'][1],
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
