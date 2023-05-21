import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlaceScreenNew extends StatefulWidget {

  PlaceScreenNew({
    Key? key,
required this.placeData,
required this.currentIndex
  }
  ) : super(key: key);
List<QueryDocumentSnapshot> placeData;
int currentIndex;

  @override
  State<PlaceScreenNew> createState() => _PlaceScreenNewState();
}

class _PlaceScreenNewState extends State<PlaceScreenNew> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;
  // final ref = FirebaseStorage.instance.ref().child('testimage');
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUrl='';
    getImageUrl();
  }
  Future<void> getImageUrl() async {
    final ref = storage.ref().child('/cairo/places/Abdeen palace/IMG_4329.jpeg');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl=url;
    });
  }
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
                imagesLength: widget.placeData.length.toString(),
                fontSize: 28,
                imageUrl: widget.placeData[widget.currentIndex]['Imageurl'],
                endImageUrl:imageUrl,

                //'https://media.istockphoto.com/id/1322277517/photo/wild-grass-in-the-mountains-at-sunset.jpg?s=612x612&w=0&k=20&c=6mItwwFFGqKNKEAzv0mv6TaxhLN3zSE43bWmFN--J5w='
                itemName: widget.placeData[widget.currentIndex]['Name'],
                itemLocation: widget.placeData[widget.currentIndex]['cityName'],
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
                            widget.placeData[widget.currentIndex]['Address'],
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
 //Center(child: Text(placeData[currentIndex]['Name'].toString()))