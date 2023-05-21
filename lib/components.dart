// ignore_for_file: must_be_immutable
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/models/place_model.dart';
import 'package:TourGuideApp/screens/city_screen.dart';
import 'package:TourGuideApp/screens/places/place_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

//------------------------------------------------------------------------------------
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(-0.1),
      child: AppBar(
        elevation: 0,
      ),
    );
  }
}
//------------------------------------------------------------------------------------
class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    required this.obscureText,
    this.textInputType,
    this.onChanged,
    this.validator,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  final String labelText;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
  bool obscureText = false;
  TextInputType? textInputType;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText,
        cursorColor: Colors.white,
        style: const TextStyle(
          color: kTextColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: kTextColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: kTextColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: kTextColor,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: kTextColor,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------------

class SmallContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color boxDecorationBorderColor;
  final String? imageUrl;

  const SmallContainer({
    Key? key,
    required this.width,
    required this.height,
    required this.boxDecorationBorderColor,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: boxDecorationBorderColor,
          width: 0.8,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          fit: BoxFit.cover,
          image: NetworkImage(imageUrl!),
          //
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------------

class ServiceProviderItem extends StatelessWidget {
  final double? width;
  final double? height;
  final Color boxDecorationColor;
  final double boxDecorationBorderRadius;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String text;
  final void Function()? onPressed;

  ServiceProviderItem({
    Key? key,
    this.height,
    this.width,
    required this.onPressed,
    required this.iconSize,
    required this.boxDecorationColor,
    required this.boxDecorationBorderRadius,
    required this.icon,
    required this.iconColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 155,
        height: 100,
        decoration: BoxDecoration(
          color: boxDecorationColor,
          borderRadius:
              BorderRadius.all(Radius.circular(boxDecorationBorderRadius)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: iconSize,
                  )),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//------------------------------------------------------------------------------------

class CustomImage extends StatefulWidget {
  CustomImage({
    Key? key,
    required this.imageUrl,
    this.endImageUrl,
    required this.itemName,
    required this.itemLocation,
    required this.fontSize,
    required this.imagesLength,
  }) : super(key: key);
  String imageUrl;
  String? endImageUrl;
  String? itemName;
  String? itemLocation;
  String? description;
  double fontSize;
  String imagesLength;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  bool isFavourite = false;
  bool isRated = false;
  Color color = Colors.white;
  Color isRatedColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image(
            width: double.infinity,
            height: 350,
            fit: BoxFit.cover,
            image: NetworkImage(widget.imageUrl),
          ), //Done
          //Pyramids
          Positioned(
            top: 265,
            left: 20,
            child: BorderedText(
              strokeColor: Colors.black,
              strokeWidth: 2,
              strokeCap: StrokeCap.butt,
              strokeJoin: StrokeJoin.bevel,
              child: Text(
                widget.itemName!,
                maxLines: 2,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ), //Done
          //Giza
          Positioned(
            top: 300,
            left: 20,
            child: BorderedText(
              strokeColor: Colors.black,
              strokeWidth: 2,
              strokeCap: StrokeCap.butt,
              strokeJoin: StrokeJoin.bevel,
              child: Text(
                widget.itemLocation!,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ), //Done
          //Top Image
          //End Image
          Positioned(
            top: 290,
            right: 20,
            child: Container(
              width: 55,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white,
                  width: 0.8,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.endImageUrl = "${widget.endImageUrl}",
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.imagesLength,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //Favourite
          Positioned(
            right: 25,
            top: 10,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isFavourite = !isFavourite;
                  isFavourite == false
                      ? color = Colors.white
                      : color = Colors.red;
                });
              },
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
            ),
          ),
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
    );
  }
}
//------------------------------------------------------------------------------------

//------------------------------------------------------------------------------------

bool isFavourite = false;
bool isRated = false;
Color color = Colors.white;
Color isRatedColor = Colors.black;
IconData starIcon = Icons.star_rounded;
Color starColor = Colors.yellow;


//--------------------------------------------------------------------------------

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

//-------------------------------------------------------------

class CustomImageItem extends StatelessWidget {
  CustomImageItem(
    this.index,
    this.context, {
    Key? key,
    required this.placeModel,
  }) : super(key: key);
  BuildContext context;
  PlaceModel placeModel;
  int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PlacePage.id);
      },
      child: ClipRRect(
        child: Stack(
          children: [
            Image(
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              image: NetworkImage(bestLocationsImage[index]),
            ), //Done
            //Pyramids
            Positioned(
              top: 140,
              left: 20,
              child: BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 2,
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.bevel,
                child: Text(
                  placeModel.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ), //Done
            //Giza
            Positioned(
              top: 165,
              left: 20,
              child: BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 2,
                strokeCap: StrokeCap.butt,
                strokeJoin: StrokeJoin.bevel,
                child: Text(
                  'Cairo',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ), //Done
          ],
        ),
      ),
    );
  }
}

List<String> bestLocationsImage = [
  'https://static01.nyt.com/images/2022/09/13/science/30TB-PYRAMIDS1/30TB-PYRAMIDS1-superJumbo.jpg',
  'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Valley-of-Kings-Luxor-egypt.jpg',
  'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Citadel-of-Saladin-egypt.jpg',
  'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Citadel-of-Saladin-egypt.jpg',
  'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Citadel-of-Saladin-egypt.jpg',
];
List<String> bestLocationsName = [
  'Pyramids',
  'Valley-of-Kings',
  'Citadel-of-Saladin',
];
List<String> bestLocationsLocation = [
  'Giza',
  'Luxor',
  'Alex',
];

//-------------------------------------------------------------

class NearlyPlaceItem extends StatelessWidget {
  NearlyPlaceItem({
    Key? key,
    required this.containerColor,
    required this.iconName,
    required this.iconColor,
    required this.containerName,
  }) : super(key: key);

  final Color containerColor;
  final IconData iconName;
  final Color iconColor;
  final String containerName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                      child: Icon(
                    iconName,
                    color: iconColor,
                  )),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                containerName,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------

class CityFeatures extends StatelessWidget {
  CityFeatures({
    Key? key,
    required this.index,
    required this.pageName,
  }) : super(key: key);

  final int index;
  final String pageName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, pageName);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image(
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                image: NetworkImage('containerImage[index]'),
              ), //Done
              //Pyramids
              Positioned(
                top: 100,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    'containerName[index]',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ), //Done
              //Giza
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------------------

//-------------------------------------------------------------
class BuildAllCitiesItem extends StatelessWidget {
  List<QueryDocumentSnapshot>? allDocs;
  int index;
  final QuerySnapshot querySnapshot;
  final DocumentReference cityDocId;
  BuildAllCitiesItem({
    Key? key,
    required this.index,
    required this.allDocs,
    required this.querySnapshot,
    required this.cityDocId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CityScreen(
            cityData: allDocs!,
            currentIndex: index,
            querySnapshot: querySnapshot,
            cityDocId: cityDocId,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image(
                image: NetworkImage('${allDocs![index]['imageUrl']}'),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 145,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs![index]['cityName']}',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ), //Done
            ],
          ),
        ),
      ),
    );
  }
}

//---------------------------------------------

class BuildAllItemNew extends StatelessWidget {
  BuildAllItemNew({
    Key? key,
    required this.allDocs,
    required this.index,
    required this.pushedPage,
  }) : super(key: key);
  var allDocs;
  int index;
  Widget pushedPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return pushedPage;
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade700,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: Stack(
            children: [
              Image(
                image: NetworkImage('${allDocs[index]['Imageurl']}'),
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 140,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs[index]['Name']}',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ), //Done
              Positioned(
                top: 170,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs[index]['cityName']}',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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


//---------------------------------------------

