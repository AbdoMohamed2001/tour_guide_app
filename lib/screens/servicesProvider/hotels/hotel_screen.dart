import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/models/hotel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({
    Key? key,
    required this.hotelModel,
  }) : super(key: key);
  static String id = 'hotelScreen';
  final HotelModel hotelModel;

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;
  IconData starIcon = Icons.star_rounded;
  Color starColor = Colors.yellow;

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
                imagesLength: '2',
                fontSize: 24,
                imageUrl:
                    'https://pix10.agoda.net/hotelImages/2287337/0/fe8e5958b4c29bb2c6a844b1eef965a2.jpg?ca=17&ce=1&s=1024x768',
                topImageUrl:
                    'https://static21.com-hotel.com/uploads/hotel/60785/photo/ramses-hilton-hotel-casino_15382536028.jpg',
                middleImageUrl:
                    'https://pix10.agoda.net/hotelImages/886/8869/8869_18022806530062421262.jpg?ca=6&ce=1&s=1024x768',
                endImageUrl:
                    'https://cf.bstatic.com/images/hotel/max1024x768/138/13817494.jpg',
                itemName: widget.hotelModel.name,
                itemLocation: 'Cairo',
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
                        Text(
                          widget.hotelModel.location,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              starIcon,
                              color: starColor,
                              size: 24,
                            ),
                            Icon(
                              starIcon,
                              color: starColor,
                              size: 24,
                            ),
                            Icon(
                              starIcon,
                              color: starColor,
                              size: 24,
                            ),
                            Icon(
                              starIcon,
                              color: starColor,
                              size: 24,
                            ),
                            Icon(
                              starIcon,
                              color: starColor,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '${widget.hotelModel.rate}',
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Features',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.hotelModel.features['first']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '${widget.hotelModel.features['second']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.hotelModel.features['third']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    '${widget.hotelModel.features['fourth']}'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('- More Features : '),
                  const Text(
                    'www.hilton.com',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
                        children: const [
                          Text('Email'),
                          Text(
                            'ramses@hilton.com',
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
                        children: const [
                          Text('Phone no'),
                          Text(
                            '+20 2 25777444',
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                color: Colors.greenAccent,
                child: Row(
                  children: [
                    SignInButton(
                      Buttons.Facebook,
                      mini: true,
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
