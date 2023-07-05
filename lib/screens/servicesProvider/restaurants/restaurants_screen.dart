import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/screens/best_places/photo_view_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: must_be_immutable
class RestaurantScreen extends StatefulWidget {
  RestaurantScreen({
    Key? key,
    required this.restaurantData,
    required this.currentIndex,
  }) : super(key: key);
  static String id = 'RestaurantScreen';
  List<QueryDocumentSnapshot> restaurantData;
  int currentIndex;
  Icon starIcon = Icon(
    Icons.star_rate_rounded,
    color: Colors.yellow,
  );

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
    var restaurant = widget.restaurantData[widget.currentIndex];
    var images = restaurant['images'];
    var Imageurl = restaurant['imageUrl'];
    var name = restaurant['name'];
    var cityName = restaurant['cityName'];
    var address = restaurant['address'];
    var mapUrl = restaurant['mapUrl'];
    var rate = restaurant['rate'];
    var openingHours = restaurant['openingHours'];
    var phone = restaurant['phone'];
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
                dataKey: dataKey,
                imagesLength: '${images.length}',
                fontSize: 24,
                imageUrl: Imageurl,
                endImageUrl: images[0],
                itemName: name,
                itemLocation: cityName,
              ),
              kSizedBox,
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
                        address,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: () async {
                        var url = Uri.parse(mapUrl);
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
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
                            openingHours['from'],
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
                            openingHours['to'],
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
              SizedBox(
                height: 10,
              ),
              //----------------------------------------------------
              //Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.restaurant_menu),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Full Menu',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3.0, left: 2),
                        child: Icon(
                          Icons.north_east,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${rate}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Ratings'),
                    ],
                  ),
                ],
              ),
              //Images of menu
              GridView.builder(
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
                              photos: restaurant['menuImages'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: restaurant['menuImages'][index],
                        child: CachedNetworkImage(
                          imageUrl: restaurant['menuImages'][index],
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
                itemCount: restaurant['menuImages'].length,
              ),
              //------------------------------------------------------------------------
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
                              Icons.laptop,
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
                                size: 15,
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
                            Icon(Icons.email_outlined),
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
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //------------------------------------
                      //Phone Number
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
                            Icon(Icons.phone),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              phone.toString(),
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
              //------------------------------------------------------------------------
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
                              photos: restaurant['images'], index: index),
                        ),
                      ),
                      child: Hero(
                        tag: restaurant['images'][index],
                        child: CachedNetworkImage(
                          imageUrl: restaurant['images'][index],
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
                itemCount: restaurant['images'].length,
              ),
              kSizedBox,
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
    required this.restaurantData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> restaurantData;
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
              restaurantData[currentIndex]['images'][ImageIndex],
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

class MenuImagesScreen extends StatelessWidget {
  MenuImagesScreen({
    Key? key,
    required this.restaurantData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> restaurantData;
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
              restaurantData[currentIndex]['menuImages'][ImageIndex],
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
