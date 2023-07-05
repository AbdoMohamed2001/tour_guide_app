import 'package:TourGuideApp/constants.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: must_be_immutable
class TourGuideScreen extends StatefulWidget {
  TourGuideScreen({
    Key? key,
    required this.tourGuideData,
    required this.currentIndex,
  }) : super(key: key);
  static String id = 'TourGuideScreen';
  List<QueryDocumentSnapshot> tourGuideData;
  int currentIndex;
  Icon starIcon = Icon(
    Icons.star_rate_rounded,
    color: Colors.yellow,
  );

  @override
  State<TourGuideScreen> createState() => _TourGuideScreenState();
}

class _TourGuideScreenState extends State<TourGuideScreen> {
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
    var tourGuide = widget.tourGuideData[widget.currentIndex];
    // final Uri toLaunch =
    // Uri(scheme: 'https', host: tourGuide['website'], path: '');
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Image(
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                      image: NetworkImage(tourGuide['imageUrl']),
                    ), //Done
                    //Pyramids
                    Positioned(
                      top: 285,
                      left: 20,
                      child: BorderedText(
                        strokeColor: Colors.black,
                        strokeWidth: 2,
                        strokeCap: StrokeCap.butt,
                        strokeJoin: StrokeJoin.bevel,
                        child: Text(
                          tourGuide['name'],
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ), //Done
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

              //-------------------------------------------------------------------------
              //rate and stars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        '${tourGuide['rate']}',
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
                      //------------------------------------
                      //Phone Number
                      GestureDetector(
                        onTap: _hasCallSupport
                            ? () => setState(() {
                          _launched = _makePhoneCall(tourGuide['phone']);
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
                              tourGuide['phone'].toString(),
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
              //about
              const Text(
                'About',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              kSizedBox,
              //Text in about
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 80,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.hardEdge,
                    controller: ScrollController(),
                    child: Center(
                      child: Text(
                        tourGuide['about'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


