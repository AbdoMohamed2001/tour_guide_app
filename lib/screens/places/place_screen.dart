import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/models/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PlacePage extends StatefulWidget {
  static String id = 'placeScreen';
  List<QueryDocumentSnapshot>? placeData;
  int? currentIndex;

  PlacePage({
    Key? key,
    this.placeData,
    this.currentIndex,
  }) : super(key: key);

  @override
  State<PlacePage> createState() => _PlacePageState();
}

class _PlacePageState extends State<PlacePage> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;
late String imageUrl;
final storage = FirebaseStorage.instance;
  final dataKey = new GlobalKey();
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

                imagesLength: widget.placeData!.length.toString(),
                fontSize: 28,
                imageUrl: widget.placeData![widget.currentIndex!]['Imageurl'],
                endImageUrl: imageUrl,
                    // 'https://media.architecturaldigest.com/photos/58e2a407c0e88d1a6a20066b/16:9/w_1280,c_limit/Pyramid%20of%20Giza%201.jpg',
                itemName: widget.placeData![widget.currentIndex!]['Name'],
                itemLocation: widget.placeData![widget.currentIndex!]
                    ['cityName'],
              ),
              kSizedBox,
              //Description and Rate Row
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: const [
                        Text(
                          '4.6',
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
              //Description
              Text(
                widget.placeData![widget.currentIndex!]['Description'],
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

// FutureBuilder<QuerySnapshot>(
// future: cairoHotelsCollection.get(),
// builder: (context,snapshot){
// if(snapshot.hasData) {
// List<HotelModel> hotelList = [];
// for(int i=0 ; i < snapshot.data!.docs.length;i++) {
// hotelList.add(HotelModel.fromJson(snapshot.data!.docs[i]));
// print(hotelList[i]);
// }
//
// }
//
// });
