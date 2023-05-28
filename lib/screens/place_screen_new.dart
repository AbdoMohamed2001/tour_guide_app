import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                dataKey: dataKey,
                imagesLength: widget.placeData.length.toString(),
                fontSize: 28,
                imageUrl: widget.placeData[widget.currentIndex]['Imageurl'],
                endImageUrl:widget.placeData[widget.currentIndex]['images'][0],
                itemName: widget.placeData[widget.currentIndex]['Name'],
                itemLocation: widget.placeData[widget.currentIndex]['cityName'],
              ),
              kSizedBox,
              //location and googleMaps
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //location
                    Container(
                      width: 250,
                      child: Text(
                        widget.placeData[widget.currentIndex]['Address'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //google map
                    GestureDetector(
                      onTap: ()async {
                        var url = Uri.parse(widget.placeData[widget.currentIndex]['mapUrl']
                        );
                        if (await canLaunchUrl(url,)) {
                          await launchUrl(url);
                        };
                      },
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
              // Padding(
              //   padding: const EdgeInsets.only(right: 8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             width : 220,
              //             child: Text(
              //               widget.placeData[widget.currentIndex]['Address'],
              //               maxLines: 2,
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 15,),
              Divider(
                height: 0.5,
                thickness: 1,
                indent: 30,
                endIndent: 30,
                color: Colors.grey[300],
              ),
              kSizedBox,
              //Description and rate
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.all(Radius.circular(10),),
                      ),
                      child: Center(
                        // child: Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       '${widget.placeData[widget.currentIndex]['Rate']}',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(width: 5,),
                        //     Text('Ratings'),
                        //   ],
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              kSizedBox,
              // Text in description
               Container(
                 height: 80,
                 child: SingleChildScrollView(
                   clipBehavior: Clip.hardEdge,
                   controller: ScrollController(
                   ),
                   child: Center(
                     child: Text(
                       widget.placeData[widget.currentIndex]['Description'],
                       style: TextStyle(
                        fontSize: 16,
                      ),
              ),
                   ),
                 ),
               ),
              SizedBox(height: 20,),
              //Opening hours
              Row(
                children: [
                  Image.asset('assets/images/open.png',
                  width: 100,
                    height: 100,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('From:  ',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          ),
                          Text('06:00 AM',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('To:       ',
                            style: TextStyle(
                              fontSize: 18,
                            ),

                          ),
                          Text('06:00 PM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),

                ],
              ),
              SizedBox(height: 10,),
              //Images
              Text('Images',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              kSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //image 1
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      key: dataKey,
                      child:
                      widget.placeData[widget.currentIndex]['images'][0].toString().isEmpty ?
                      Text(''):
                      Image.network(widget.placeData[widget.currentIndex]['images'][0],
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),

                    ),
                  ),
                  //image 2
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return DetailScreen(placeData: widget.placeData, currentIndex: widget.currentIndex);
                      }));
                    },
                    child: Container(
                      child:
                      widget.placeData[widget.currentIndex]['images'].length == 1 ?
                      Text(''):

                      Image.network(widget.placeData[widget.currentIndex]['images'][1],
                        width: 150,
                        height: 200,
                        fit: BoxFit.cover,
                      ),

                    ),
                  ),
                ],
              ),
              kSizedBox,
              // const Text(
              //   'Nearly to this place ',
              //   style: TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // kSizedBox,
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       NearlyPlaceItem(
              //         containerColor: Colors.black,
              //         iconName: FontAwesomeIcons.hotel,
              //         iconColor: Color(0xff613207),
              //         containerName: 'Hotels',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff613207),
              //         iconName: FontAwesomeIcons.utensils,
              //         iconColor: Colors.black,
              //         containerName: 'Restaurants',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff613207),
              //         iconName: FontAwesomeIcons.utensils,
              //         iconColor: Colors.black,
              //         containerName: 'Restaurants',
              //       ),
              //       const SizedBox(
              //         width: 20,
              //       ),
              //       NearlyPlaceItem(
              //         containerColor: Color(0xff66191c),
              //         iconName: FontAwesomeIcons.film,
              //         iconColor: Colors.black,
              //         containerName: 'Cinemas',
              //       ),
              //     ],
              //   ),
              // ),
              // kSizedBox,
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
    required this.placeData,
    required this.currentIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> placeData;
  int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
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
              placeData[currentIndex]['images'][1],
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
