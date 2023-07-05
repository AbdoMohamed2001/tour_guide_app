// ignore_for_file: must_be_immutable
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
class ServiceProviderItem extends StatelessWidget {
  final double? width;
  final double? height;
  final Color boxDecorationColor;
  final double boxDecorationBorderRadius;
  final String text;
  final void Function()? onPressed;
  final String fileName;

  ServiceProviderItem({
    Key? key,
    this.height,
    this.width,
    required this.onPressed,
    required this.boxDecorationColor,
    required this.boxDecorationBorderRadius,
    required this.text,
    required this.fileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.15,
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
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/$fileName.svg',
                      fit: BoxFit.cover,

                    ),
                    onPressed: () {},
                    iconSize: 50,
                  )),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.5,
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
    required this.dataKey,
    this.favouriteFunction,
  }) : super(key: key);
  String imageUrl;
  String? endImageUrl;
  String? itemName;
  String? itemLocation;
  String? description;
  double fontSize;
  String imagesLength;

  GlobalKey dataKey = new GlobalKey();
  Function()? favouriteFunction;

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
            top: 245,
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
            top: 280,
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
          //End Image
          Positioned(
            top: 290,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Scrollable.ensureVisible(widget.dataKey.currentContext!);
              },
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
                        child: BorderedText(
                          strokeColor: Colors.black,
                          strokeWidth: 1.5,
                          strokeCap: StrokeCap.butt,
                          strokeJoin: StrokeJoin.bevel,
                          child: Text(
                            '+${widget.imagesLength}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          //Favourite
          Positioned(
            right: 25,
            top: 10,
            child: IconButton(
              onPressed: widget.favouriteFunction,
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
class CustomImageWithoutEndImage extends StatefulWidget {
  CustomImageWithoutEndImage({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.itemLocation,
    required this.fontSize,
    required this.imagesLength,
    required this.dataKey,
    this.addToFavourite,
  }) : super(key: key);
  String imageUrl;
  String? itemName;
  String? itemLocation;
  String? description;
  double fontSize;
  String imagesLength;
  GlobalKey dataKey = new GlobalKey();
  Function? addToFavourite;

  @override
  State<CustomImageWithoutEndImage> createState() =>
      _CustomImageWithoutEndImageState();
}

class _CustomImageWithoutEndImageState
    extends State<CustomImageWithoutEndImage> {
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
          ),
          //Pyramids
          Positioned(
            top: 245,
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
          ),
          //Giza
          Positioned(
            top: 280,
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

//--------------------------------------------------------------------------------
void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}

void showToast({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.orange[300],
      textColor: Colors.white,
      fontSize: 14.0);
}

//-------------------------------------------------------------
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
                color: Colors.grey.shade500,
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Image(
                image: NetworkImage(
                  '${allDocs[index]['imageUrl']}',
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        height: 230,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    );
                  }
                },
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 160,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs[index]['name']}',
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
                top: 190,
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
class BuildMallItem extends StatelessWidget {
  BuildMallItem({
    Key? key,
    required this.allDocs,
    required this.currentIndex,
    required this.pushedPage,
  }) : super(key: key);
  List<QueryDocumentSnapshot> allDocs;
  int currentIndex;

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
                image: NetworkImage('${allDocs[currentIndex]['imageUrl']}'),
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 130,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs[currentIndex]['name']}',
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
                top: 160,
                left: 20,
                child: BorderedText(
                  strokeColor: Colors.black,
                  strokeWidth: 2,
                  strokeCap: StrokeCap.butt,
                  strokeJoin: StrokeJoin.bevel,
                  child: Text(
                    '${allDocs[currentIndex]['cityName']}',
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
class BuildAllOptionsNew extends StatelessWidget {
  BuildAllOptionsNew({
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
                image: NetworkImage(
                  '${allDocs[index]['imageUrl']}',
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    );
                  }
                },
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
                    '${allDocs[index]['tourName']}',
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
                    '${allDocs[index]['state']}',
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

//-------------------------------------------------------
class BuildAllUpcomingEvents extends StatelessWidget {
  BuildAllUpcomingEvents({
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
                image: NetworkImage(
                  '${allDocs[index]['imageUrl']}',
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    );
                  }
                },
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
                    '${allDocs[index]['name']}',
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
                    '${allDocs[index]['location']}',
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

//-------------------------------------------------------
class DetailScreen extends StatelessWidget {
  DetailScreen({
    Key? key,
    required this.data,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> data;
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
              data[currentIndex]['images'][ImageIndex],
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

class ImageView extends StatelessWidget {
  ImageView({
    required this.data,
    required this.widgetDataAndIndex,
    required this.currentIndex,
    required this.ImageIndex,
    this.dataKey,
  });

  int ImageIndex;
  List<QueryDocumentSnapshot<Object?>> data;
  int currentIndex;
  QueryDocumentSnapshot<Object?> widgetDataAndIndex;
  Key? dataKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailScreen(
            ImageIndex: ImageIndex,
            data: data,
            currentIndex: currentIndex,
          );
        }));
      },
      child: Container(
        key: dataKey,
        child: widgetDataAndIndex['images'][ImageIndex].toString().isEmpty
            ? Text('')
            : Image.network(
                widgetDataAndIndex['images'][ImageIndex],
                width: 150,
                height: 200,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
//-------------------------------------------------------
