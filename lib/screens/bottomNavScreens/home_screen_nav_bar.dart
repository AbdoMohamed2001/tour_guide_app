import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/constants.dart';
import 'package:TourGuideApp/screens/homePage/all_cities_screen.dart';
import 'package:TourGuideApp/screens/homePage/best_location_screen.dart';
import 'package:TourGuideApp/screens/places/place_screen.dart';
import 'package:TourGuideApp/services_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageNavBar extends StatefulWidget {

  List<QueryDocumentSnapshot> cinemaData;
  int currentIndex;
  static String id = 'placeScreen';
  final String? documentId;

   HomePageNavBar({
    Key? key,
    this.documentId,
    required this.cinemaData,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<HomePageNavBar> createState() => _HomePageNavBarState();
}

class _HomePageNavBarState extends State<HomePageNavBar> {

  @override
  Widget build(BuildContext context)  {
    CollectionReference citiesCollection = FirebaseFirestore.instance
        .collection('cities').doc('1OILZtcN2KjarkB4g04L').collection('Places');
    return FutureBuilder<QuerySnapshot>(

      future: citiesCollection.get(),
        builder: (context,snapshot){
          final List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
          if(allDocs==null) {Center(child: CircularProgressIndicator(
            color: Colors.orange,
          ));}
          else if (snapshot.connectionState == ConnectionState.done){
            return Padding(
            padding: const EdgeInsets.only(left: 12, top: 20,right: 12),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------------------------------------------------
                    //Explore
                    const Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    // Best Places in Egypt
                    const Text(
                      'Best Places in Egypt',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    //---------------------------StartTextFormField------------------------------
                    kSizedBox,
                    const SizedBox(
                      width: double.infinity,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          focusColor: Colors.orange,
                          prefixIconColor: Colors.orange,
                          hoverColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Enter city name',
                          hintStyle: TextStyle(fontSize: 14),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 0,
                          ),
                        ),
                      ),
                    ),
                    kSizedBox,
                    //---------------------------EndTextFormField------------------------------
                    // Categories
                    const Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    kSizedBox,
                    //----------------------------------------------------------------
                    // Categories Items Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Best Locations
                        ServiceProviderItem(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return AllBestPlaces();

                            }));
                          },
                          boxDecorationColor: const Color(0xff19131b),
                          boxDecorationBorderRadius: 10,
                          icon: FontAwesomeIcons.hotel,
                          iconColor: Colors.black,
                          iconSize: 32,
                          text: 'Best \n Places',

                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        //ALl Cities
                        ServiceProviderItem(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context){
                              return const AllCities();
                            }));
                          },

                          boxDecorationColor: const Color(0xff613207),
                          boxDecorationBorderRadius: 10,
                          icon: FontAwesomeIcons.solidBuilding,
                          iconColor:  Colors.black,
                          iconSize: 32,
                          text: 'All Cities',

                        ),
                      ],
                    ),
                    kSizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Tours and trips
                        ServiceProviderItem(
                          onPressed: (){},
                          boxDecorationColor: const Color(0xffed79d25),
                          boxDecorationBorderRadius: 10,
                          icon: FontAwesomeIcons.suitcase,
                          iconColor: Colors.black,
                          iconSize: 32,
                          text: 'Tours \n and Trips',

                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        //Services Provider
                        ServiceProviderItem(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ServicesScreen();
                            }));
                          },
                          boxDecorationColor:  const Color(0xff4069a7),
                          boxDecorationBorderRadius: 10,
                          icon: FontAwesomeIcons.servicestack,
                          iconColor:  Colors.black,
                          iconSize: 32,
                          text: 'Services \n Provider',

                        ),
                      ],
                    ),
                    kSizedBox,
                    //----------------------------------------------------------------
                    //Travel Places
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Travel Places',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Center(child: Text('View All')),
                          ),
                        ),
                      ],
                    ),
                    kSizedBox,
                    //Places
                    SizedBox(
                      height: 210,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=>Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (
                                    context) {
                                  return  PlacePage();
                                }));
                              },
                              child: Container(
                                width: 250,
                                height: 210,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  border: Border.all(
                                    width: 0.1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child:  Image(
                                        image: NetworkImage(
                                          allDocs[index]['Imageurl'],
                                          // 'https://cdn.mos.cms.futurecdn.net/YMa7Wx2FyjQFUjEeqa72Rm-1200-80.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 250,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Column(
                                            children:  [
                                              Text(
                                                allDocs[index]['Name'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(allDocs[index]['cityName']),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            color: Colors.greenAccent,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // const SizedBox(
                            //   width: 20,
                            // ),
                            // Container(
                            //   width: 250,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white10,
                            //     border: Border.all(
                            //       width: 0.1,
                            //       color: Colors.grey,
                            //     ),
                            //   ),
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       ClipRRect(
                            //         borderRadius: BorderRadius.circular(10),
                            //         child: const Image(
                            //           image: NetworkImage(
                            //             'https://egyptianstreets.com/wp-content/uploads/2015/12/museumegypt.jpg',
                            //           ),
                            //           fit: BoxFit.cover,
                            //           height: 100,
                            //           width: 250,
                            //         ),
                            //       ),
                            //       const SizedBox(
                            //         height: 20,
                            //       ),
                            //       Container(
                            //         margin: const EdgeInsets.only(left: 20, right: 20),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             Column(
                            //               children: const [
                            //                 Text(
                            //                   'Egyptian Museum',
                            //                   style: TextStyle(
                            //                       fontSize: 18,
                            //                       fontWeight: FontWeight.bold),
                            //                 ),
                            //                 Text('Cairo'),
                            //                 SizedBox(
                            //                   height: 20,
                            //                 )
                            //               ],
                            //             ),
                            //             Container(
                            //               width: 20,
                            //               height: 20,
                            //               color: Colors.greenAccent,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                        separatorBuilder: (context,index) => SizedBox(width: 10,),
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );}
          else if (snapshot.connectionState == ConnectionState.none){
            return Center(child: CircularProgressIndicator(
              color: Colors.orange,
            ));

          }
          return Center(child: CircularProgressIndicator(
            color: Colors.orange,
          ));
    });
  }
}

List<String> docs = [
  'CairoU3CcWkb031dRzxuy',
  'Alexandria',
  '1OILZtcN2KjarkB4g04L',
  'Sharm El-Sheikh',

];