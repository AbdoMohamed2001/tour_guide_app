import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/screens/best_places/photo_view_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  final dataKey = new GlobalKey();
  bool _hasCallSupport = false;
  Future<void>? _launched;
  String _phone = '';

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {
        _hasCallSupport = result;
      });
    });
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    var hotel = widget.hotelData[widget.currentIndex];
    // final Uri toLaunch =
    // Uri(scheme: 'https', host: hotel['website'], path: '');
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
              //-------------------------------------------------------------------------
              //image
              CustomImage(
                dataKey: dataKey,
                imagesLength: '${hotel['images'].length}',
                fontSize: 24,
                imageUrl: hotel['imageUrl'],
                endImageUrl: hotel['images'][0],
                itemName: hotel['name'],
                itemLocation: hotel['cityName'],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //Location and google map
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //location
                    Container(
                      width: 250,
                      child: Text(
                        hotel['address'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(hotel['mapUrl']);
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
              kSizedBox,
              //-------------------------------------------------------------------------
              //rate and stars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${hotel['rate']}',
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
              kSizedBox,
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //-------------------------------------------------------------------------
              //Features
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      hotel['features'][0].toString().contains('wifi')
                          ? Icon(Icons.wifi)
                          : hotel['features'][0].toString().contains('rest')
                              ? Icon(Icons.restaurant_rounded)
                              : hotel['features'][0].toString().contains('pool')
                                  ? Icon(Icons.restaurant_rounded)
                                  : Icon(Icons.looks_one),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${hotel['features'][0]}'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      hotel['features'][1].toString().contains('wifi')
                          ? Icon(Icons.wifi)
                          : hotel['features'][1].toString().contains('rest')
                              ? Icon(Icons.restaurant_rounded)
                              : hotel['features'][1].toString().contains('pool')
                                  ? Icon(Icons.pool)
                                  : hotel['features'][1]
                                          .toString()
                                          .contains('pet')
                                      ? Icon(Icons.pets)
                                      : hotel['features'][1]
                                              .toString()
                                              .contains('air')
                                          ? Icon(Icons.star_rounded)
                                          : hotel['features'][1]
                                                  .toString()
                                                  .contains('room')
                                              ? Icon(Icons.room_service)
                                              : hotel['features'][1]
                                                      .toString()
                                                      .contains('yoga')
                                                  ? Icon(FontAwesomeIcons.star)
                                                  : hotel['features'][1]
                                                          .toString()
                                                          .contains('coffee')
                                                      ? Icon(FontAwesomeIcons
                                                          .coffee)
                                                      : hotel['features'][1]
                                                              .toString()
                                                              .contains('child')
                                                          ? Icon(
                                                              FontAwesomeIcons
                                                                  .child)
                                                          : hotel['features'][1]
                                                                  .toString()
                                                                  .contains(
                                                                      'accom')
                                                              ? Icon(
                                                                  FontAwesomeIcons
                                                                      .houseUser)
                                                              : Icon(
                                                                  Icons.star),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${hotel['features'][1]}'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      hotel['features'][2].toString().contains('wifi')
                          ? Icon(Icons.wifi)
                          : hotel['features'][2].toString().contains('rest')
                              ? Icon(Icons.restaurant_rounded)
                              : hotel['features'][2].toString().contains('pool')
                                  ? Icon(Icons.pool)
                                  : hotel['features'][2]
                                          .toString()
                                          .contains('pet')
                                      ? Icon(Icons.pets)
                                      : hotel['features'][2]
                                              .toString()
                                              .contains('air')
                                          ? Icon(Icons.star_rounded)
                                          : hotel['features'][2]
                                                  .toString()
                                                  .contains('room')
                                              ? Icon(Icons.room_service)
                                              : hotel['features'][2]
                                                      .toString()
                                                      .contains('yoga')
                                                  ? Icon(FontAwesomeIcons.star)
                                                  : hotel['features'][2]
                                                          .toString()
                                                          .contains('coffee')
                                                      ? Icon(FontAwesomeIcons
                                                          .coffee)
                                                      : hotel['features'][2]
                                                              .toString()
                                                              .contains('child')
                                                          ? Icon(
                                                              FontAwesomeIcons
                                                                  .child)
                                                          : hotel['features'][2]
                                                                  .toString()
                                                                  .contains(
                                                                      'accom')
                                                              ? Icon(
                                                                  FontAwesomeIcons
                                                                      .houseUser)
                                                              : Icon(
                                                                  Icons.star),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${hotel['features'][2]}'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      hotel['features'][3].toString().contains('wifi')
                          ? Icon(Icons.wifi)
                          : hotel['features'][3].toString().contains('rest')
                              ? Icon(Icons.restaurant_rounded)
                              : hotel['features'][3].toString().contains('pool')
                                  ? Icon(Icons.pool)
                                  : hotel['features'][3]
                                          .toString()
                                          .contains('pet')
                                      ? Icon(Icons.pets)
                                      : hotel['features'][3]
                                              .toString()
                                              .contains('air')
                                          ? Icon(Icons.star_rounded)
                                          : hotel['features'][3]
                                                  .toString()
                                                  .contains('room')
                                              ? Icon(Icons.room_service)
                                              : hotel['features'][3]
                                                      .toString()
                                                      .contains('yoga')
                                                  ? Icon(FontAwesomeIcons.star)
                                                  : hotel['features'][3]
                                                          .toString()
                                                          .contains('coffee')
                                                      ? Icon(FontAwesomeIcons
                                                          .coffee)
                                                      : hotel['features'][3]
                                                              .toString()
                                                              .contains('child')
                                                          ? Icon(
                                                              FontAwesomeIcons
                                                                  .child)
                                                          : hotel['features'][3]
                                                                  .toString()
                                                                  .contains(
                                                                      'accom')
                                                              ? Icon(
                                                                  FontAwesomeIcons
                                                                      .houseUser)
                                                              : Icon(
                                                                  Icons.star),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${hotel['features'][3]}'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //Booking.com
              GestureDetector(
                onTap: () async {
                  var url = Uri.parse(hotel['booking']);
                  if (await canLaunchUrl(
                    url,
                  )) {
                    await launchUrl(url);
                  }
                  ;
                },
                child: Container(
                  width: 120,
                  height: 60,
                  color: Colors.transparent,
                  child: Image.asset('assets/images/booking.png'),
                ),
              ),
              kSizedBox,
              //-------------------------------------------------------------------------
              //contact
              const Text(
                'Contact',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              //Contact website and phone number
              Container(
                width: double.infinity,
                color: const Color(0xfff1f1f1),
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //WebSite
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.laptop,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'WebSite',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 3.0, left: 2),
                              child: Icon(
                                Icons.north_east,
                                size: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------------------
                      //Email
                      GestureDetector(
                        onTap: () async {
                          String? encodeQueryParameters(
                              Map<String, String> params) {
                            return params.entries
                                .map((MapEntry<String, String> e) =>
                                    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                .join('&');
                          }

                          final Uri emailUrl = Uri(
                            scheme: 'mailto',
                            path: 'abdo.mohammed1778@gmail.com',
                            query: encodeQueryParameters(<String, String>{
                              'subject':
                                  'Example Subject & Symbols are allowed!',
                            }),
                          );
                          //'mailto:${toEmail}?subject=${Uri.encodeFull(subject)}&body=${message}';
                          if (await canLaunchUrl(emailUrl)) {
                            await launchUrl(emailUrl);
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Email',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 3.0, left: 2),
                              child: Icon(
                                Icons.north_east,
                                size: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------------------
                      //Phone Number
                      GestureDetector(
                        onTap: _hasCallSupport
                            ? () => setState(() {
                                  _launched = _makePhoneCall(hotel['phone']);
                                })
                            : null,
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 22,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              hotel['phone'].toString(),
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------------------
                    ],
                  ),
                ),
              ),
              kSizedBox,
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
                              photos: hotel['images'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: hotel['images'][index],
                        child: CachedNetworkImage(
                          imageUrl: hotel['images'][index],
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
                itemCount: hotel['images'].length,
              ),
              //-------------------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}


