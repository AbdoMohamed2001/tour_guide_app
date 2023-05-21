import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CinemaScreen extends StatelessWidget {
  List<QueryDocumentSnapshot> cinemaData;
  int currentIndex;
  CinemaScreen({
    Key? key,
    required this.cinemaData,
    required this.currentIndex
  }
      ) : super(key: key);

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
                imagesLength: cinemaData.length.toString(),
                fontSize: 28,
                imageUrl: cinemaData[currentIndex]['Imageurl'],
                endImageUrl:
                'https://media.architecturaldigest.com/photos/58e2a407c0e88d1a6a20066b/16:9/w_1280,c_limit/Pyramid%20of%20Giza%201.jpg',
                itemName: cinemaData[currentIndex]['Name'],
                itemLocation: cinemaData[currentIndex]['cityName'],
              ),
              kSizedBox,
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width : 220,
                          child: Text(
                            cinemaData[currentIndex]['Address'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          cinemaData[currentIndex]['Rate'].toString(),
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
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              kSizedBox,
              const Text(
                'Nearly to this place ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kSizedBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    NearlyPlaceItem(
                      containerColor: Colors.black,
                      iconName: FontAwesomeIcons.hotel,
                      iconColor: Color(0xff613207),
                      containerName: 'Hotels',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NearlyPlaceItem(
                      containerColor: Color(0xff613207),
                      iconName: FontAwesomeIcons.utensils,
                      iconColor: Colors.black,
                      containerName: 'Restaurants',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NearlyPlaceItem(
                      containerColor: Color(0xff613207),
                      iconName: FontAwesomeIcons.utensils,
                      iconColor: Colors.black,
                      containerName: 'Restaurants',
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NearlyPlaceItem(
                      containerColor: Color(0xff66191c),
                      iconName: FontAwesomeIcons.film,
                      iconColor: Colors.black,
                      containerName: 'Cinemas',
                    ),
                  ],
                ),
              ),
              kSizedBox,
            ],
          ),
        ),
      ),

    );
  }
}
