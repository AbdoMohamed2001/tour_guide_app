
import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore_for_file: must_be_immutable
class HotelScreen extends StatefulWidget {
  HotelScreen({
    Key? key,
    required this.hotelData,
    required this.currentIndex,
  }) : super(key: key);
  static String id = 'hotelScreen';
  List<QueryDocumentSnapshot> hotelData;
  int currentIndex;
  Icon starIcon = Icon(
    Icons.star_rate_rounded,
    color: Colors.yellow,
  );



  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;
  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(widget._url)) {
  //     throw Exception('Could not launch ${widget._url}');
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(-0.5),
          child: AppBar(
            elevation: 0,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImage(
                imagesLength: '+2',
                fontSize: 24,
                imageUrl:widget.hotelData[widget.currentIndex]['Imageurl'],
                endImageUrl: widget.hotelData[widget.currentIndex]['images'][0],
                itemName: widget.hotelData[widget.currentIndex]['Name'],
                itemLocation:  widget.hotelData[widget.currentIndex]['cityName'],
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
                          width: 250,
                          child: Text(
                            widget.hotelData[widget.currentIndex]['Address'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        child: Image.asset('assets/images/googlemaps.png',
                          width: 50,
                          height: 50,

                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${widget.hotelData[widget.currentIndex]['Rate']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Ratings'),
                    ],
                  ),
                  Row(
                    children: [
                      widget.starIcon,
                      widget.starIcon,
                      widget.starIcon,
                      widget.starIcon,
                      widget.starIcon,
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              //Features
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Feature1,2
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      widget.hotelData[widget.currentIndex]['features'][0].toString().contains('wifi')?
                      Icon(Icons.wifi):
                      widget.hotelData[widget.currentIndex]['features'][0].toString().contains('rest')?
                      Icon(Icons.restaurant_rounded):
                      widget.hotelData[widget.currentIndex]['features'][0].toString().contains('pool')?
                      Icon(Icons.restaurant_rounded)
                          : Icon(Icons.looks_one),
                      SizedBox(width: 10,),
                      Text(
                        '${widget.hotelData[widget.currentIndex]['features'][0]}'
                            .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('wifi')?
                      Icon(Icons.wifi):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('rest')?
                      Icon(Icons.restaurant_rounded):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('pool')?
                      Icon(Icons.pool):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('pet')?
                      Icon(Icons.pets):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('air')?
                      Icon(Icons.star_rounded):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('room')?
                      Icon(Icons.room_service):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('yoga')?
                      Icon(FontAwesomeIcons.star):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('coffee')?
                      Icon(FontAwesomeIcons.coffee):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('child')?
                      Icon(FontAwesomeIcons.child):
                      widget.hotelData[widget.currentIndex]['features'][1].toString().contains('accom')?
                      Icon(FontAwesomeIcons.houseUser)

                          : Icon(Icons.star),
                      SizedBox(width: 10,),
                      Text(
                        '${widget.hotelData[widget.currentIndex]['features'][1]}'
                            .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('wifi')?
                      Icon(Icons.wifi):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('rest')?
                      Icon(Icons.restaurant_rounded):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('pool')?
                      Icon(Icons.pool):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('pet')?
                      Icon(Icons.pets):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('air')?
                      Icon(Icons.star_rounded):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('room')?
                      Icon(Icons.room_service):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('yoga')?
                      Icon(FontAwesomeIcons.star):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('coffee')?
                      Icon(FontAwesomeIcons.coffee):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('child')?
                      Icon(FontAwesomeIcons.child):
                      widget.hotelData[widget.currentIndex]['features'][2].toString().contains('accom')?
                      Icon(FontAwesomeIcons.houseUser)

                          : Icon(Icons.star),
                      SizedBox(width: 10,),

                      Text(
                        '${widget.hotelData[widget.currentIndex]['features'][2]}'
                            .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('wifi')?
                      Icon(Icons.wifi):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('rest')?
                      Icon(Icons.restaurant_rounded):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('pool')?
                      Icon(Icons.pool):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('pet')?
                      Icon(Icons.pets):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('air')?
                      Icon(Icons.star_rounded):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('room')?
                      Icon(Icons.room_service):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('yoga')?
                      Icon(FontAwesomeIcons.star):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('coffee')?
                      Icon(FontAwesomeIcons.coffee):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('child')?
                      Icon(FontAwesomeIcons.child):
                      widget.hotelData[widget.currentIndex]['features'][3].toString().contains('accom')?
                      Icon(FontAwesomeIcons.houseUser)

                          : Icon(Icons.star),
                      SizedBox(width: 10,),
                      Text(
                        '${widget.hotelData[widget.currentIndex]['features'][3]}'
                            .toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              //Feature3,4
              SizedBox(height: 10,),
              GestureDetector(
                onTap: ()async {
                  var url = Uri.parse(
                      'https://goo.gl/maps/WA6j2X5mGqDKDeBZ9');
                  if (await canLaunchUrl(url,)) {
                    await launchUrl(url);
                  };
                },
                child: Container(
                  width: 120,
                  height: 60,
                  color: Colors.transparent,
                  child: Image.asset('assets/images/booking2.png'),
                ),
              ),
              SizedBox(height: 10,),
              //contact
              const Text(
                'Contact',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                color: const Color(0xfff1f1f1),
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text('Web Site'),
                          Text(
                            widget.hotelData[widget.currentIndex]['Email'],
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const VerticalDivider(
                        width: 2,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //------------------------------------
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text('Phone nubmer'),
                          Text(
                            widget.hotelData[widget.currentIndex]['Phone'].toString(),
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //------------------------------------

                    ],
                  ),

                ),
              ),
              kSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:
                    widget.hotelData[widget.currentIndex]['images'][0].toString().isEmpty ?
                    Text(''):
                    Image.network(widget.hotelData[widget.currentIndex]['images'][0],
                      width: 150,
                      height: 200,
                      fit: BoxFit.cover,
                    ),

                  ),
                  Container(
                    child:
                    widget.hotelData[widget.currentIndex]['images'].length == 1 ?
                    Text(''):

                    Image.network(widget.hotelData[widget.currentIndex]['images'][1],
                    width: 150,
                      height: 200,
                      fit: BoxFit.cover,
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
