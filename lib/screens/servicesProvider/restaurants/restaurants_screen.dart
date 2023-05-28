import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RestaurantScreen extends StatefulWidget {
  static String id = 'RestaurantScreen';
  List<QueryDocumentSnapshot> restaurantData;
  int currentIndex;

  RestaurantScreen({Key? key, required this.restaurantData, required this.currentIndex,})
      : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                imagesLength: widget.restaurantData.length.toString(),
                fontSize: 28,
                imageUrl:widget.restaurantData[widget.currentIndex]['Imageurl'],
                endImageUrl:
                'https://media.architecturaldigest.com/photos/58e2a407c0e88d1a6a20066b/16:9/w_1280,c_limit/Pyramid%20of%20Giza%201.jpg',
                itemName: widget.restaurantData[widget.currentIndex]['Name'],
                itemLocation: widget.restaurantData[widget.currentIndex]['cityName'],
              ),
              kSizedBox,
              //Description and Rate Row
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Container(
                       width : 220,
                       child: Text(
                        widget.restaurantData[widget.currentIndex]['Address'],
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                     ),
                    Column(
                      children:  [
                        Text(
                          widget.restaurantData[widget.currentIndex]['Rate'].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Ratings'),
                      ],
                    ),
                  ],
                ),
              ),
              kSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Open Date : ${widget.restaurantData[widget.currentIndex]['openDate']}',
                  style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold,
                  ),

                  ),
                  Text('Close Date : ${widget.restaurantData[widget.currentIndex]['closeDate']}',
                    style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),

                  ),

                ],
              ),

              kSizedBox,
            ],
          ),
        ),
      ),
    );
  }
}


