import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore_for_file: must_be_immutable
class CafeScreen extends StatefulWidget {
  CafeScreen({
    Key? key,
    required this.cafeData,
    required this.currentIndex,
  }) : super(key: key);
  static String id = 'CafeScreen';
  List<QueryDocumentSnapshot> cafeData;
  int currentIndex;
  Icon starIcon = Icon(
    Icons.star_rate_rounded,
    color: Colors.yellow,
  );

  @override
  State<CafeScreen> createState() => _CafeScreenState();
}

class _CafeScreenState extends State<CafeScreen> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;
  final dataKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cafeDataWithCurrentIndex = widget.cafeData[widget.currentIndex];
    var images = cafeDataWithCurrentIndex['images'];
    var Imageurl = cafeDataWithCurrentIndex['imageUrl'];
    var name = cafeDataWithCurrentIndex['name'];
    var cityName = cafeDataWithCurrentIndex['cityName'];
    var address = cafeDataWithCurrentIndex['address'];
    var mapUrl = cafeDataWithCurrentIndex['mapUrl'];
    var rate = cafeDataWithCurrentIndex['rate'];
    var openingHours = cafeDataWithCurrentIndex['openingHours'];
    var menuImages = cafeDataWithCurrentIndex['menuImages'];
    var phone = cafeDataWithCurrentIndex['phone'];
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
              ),
              kSizedBox,
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
              kSizedBox,
              //--------------------------------------------------------------------------------
              //Menu
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
              //Images of menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //image 1
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MenuImagesScreen(
                            ImageIndex: 0,
                            cafeData: widget.cafeData,
                            currentIndex: widget.currentIndex);
                      }));
                    },
                    child: menuImages.length.toString().isEmpty
                        ? Text(' ')
                        : ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            child: menuImages[0] == null
                                ? Container()
                                : Image.network(
                                    menuImages[0],
                                    width: 230,
                                    height: 190,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                  ),
                  //Image 2,3
                  Column(
                    children: [
                      //image 2
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MenuImagesScreen(
                                ImageIndex: 1,
                                cafeData: widget.cafeData,
                                currentIndex: widget.currentIndex);
                          }));
                        },
                        child: menuImages.length <= 1
                            ? Text('')
                            : ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                                child: Image.network(
                                  menuImages[1],
                                  width: 120,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      kSizedBox,
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MenuImagesScreen(
                              ImageIndex: 2,
                              cafeData: widget.cafeData,
                              currentIndex: widget.currentIndex,
                            );
                          }));
                        },
                        child: menuImages.length <= 2
                            ? Text('')
                            : Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    child: Image.network(
                                      menuImages[2],
                                      width: 120,
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    right: 37,
                                    child: Text(
                                      '+10',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ],
              ),
              //-----------------------------------------------------------------------------
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
              //-----------------------------------------------------------------------------
              //Image 1 & 2
              GridView.count(
                physics: ScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                childAspectRatio: (0.6 / 1),
                mainAxisSpacing: 20,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ImageView(
                    dataKey: dataKey,
                    data: widget.cafeData,
                    widgetDataAndIndex: cafeDataWithCurrentIndex,
                    currentIndex: widget.currentIndex,
                    ImageIndex: 0,
                  ),
                  ImageView(
                    data: widget.cafeData,
                    widgetDataAndIndex: cafeDataWithCurrentIndex,
                    currentIndex: widget.currentIndex,
                    ImageIndex: 1,
                  ),
                  ImageView(
                    data: widget.cafeData,
                    widgetDataAndIndex: cafeDataWithCurrentIndex,
                    currentIndex: widget.currentIndex,
                    ImageIndex: 2,
                  ),
                  ImageView(
                    data: widget.cafeData,
                    widgetDataAndIndex: cafeDataWithCurrentIndex,
                    currentIndex: widget.currentIndex,
                    ImageIndex: 3,
                  ),
                  ImageView(
                    data: widget.cafeData,
                    widgetDataAndIndex: cafeDataWithCurrentIndex,
                    currentIndex: widget.currentIndex,
                    ImageIndex: 4,
                  ),

                ],
              ),

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
    required this.cafeData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> cafeData;
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
              cafeData[currentIndex]['images'][ImageIndex],
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
    required this.cafeData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> cafeData;
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
              cafeData[currentIndex]['menuImages'][ImageIndex],
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
