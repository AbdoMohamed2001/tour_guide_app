// ignore_for_file: must_be_immutable

import 'package:TourGuideApp/screens/servicesProvider/hotels/hotel_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllHotels extends StatelessWidget {
  static String id = 'allHotels';
  final DocumentReference cityDocId;
  Icon starIcon = Icon(Icons.star_rate_rounded,
    color: Colors.yellow,
  );

  AllHotels({
    Key? key,
    required this.cityDocId,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CollectionReference hotels = cityDocId.collection('Hotels');
    return FutureBuilder<QuerySnapshot>(
        future: hotels.get(),
        builder: (context, snapshot) {
          final List<QueryDocumentSnapshot>? allDocs = snapshot.data?.docs;
          if (allDocs == null) {
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                title: const Text(
                  'All Hotels',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
              body: ListView.separated(
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return HotelScreen(
                                hotelData: allDocs,
                                currentIndex: index,
                              );
                            }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade600,
                                spreadRadius: 1,
                                blurRadius: 3,
                                blurStyle: BlurStyle.outer,
                                offset: const Offset(0, 5),

                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4.0),
                            child: Column(
                              children: [
                                SizedBox(height: 5,),
                                Stack(
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                          '${allDocs[index]['imageUrl']}'),
                                      width: double.infinity,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(allDocs[index]['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        starIcon,
                                        starIcon,
                                        starIcon,
                                        starIcon,
                                        starIcon,
                                      ],
                                    ),
                                  ],
                                ),
                                Text(allDocs[index]['address']),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          width: 70,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('wifi') ?
                                              Icon(Icons.wifi) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('rest') ?
                                              Icon(Icons.restaurant_rounded) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('pool') ?
                                              Icon(Icons.pool) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('pet') ?
                                              Icon(Icons.pets) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('air') ?
                                              Icon(Icons.star_rounded) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('room') ?
                                              Icon(Icons.room_service) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('yoga') ?
                                              Icon(FontAwesomeIcons.star) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('coffee') ?
                                              Icon(FontAwesomeIcons.coffee) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('child') ?
                                              Icon(FontAwesomeIcons.child) :
                                              allDocs[index]['features'][0]
                                                  .toString()
                                                  .contains('accom') ?
                                              Icon(FontAwesomeIcons.houseUser)

                                                  : Icon(Icons.star),
                                              Text(
                                                allDocs[index]['features'][0],
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 130,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('wifi') ?
                                              Icon(Icons.wifi) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('rest') ?
                                              Icon(Icons.restaurant_rounded) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('pool') ?
                                              Icon(Icons.pool) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('pet') ?
                                              Icon(Icons.pets) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('air') ?
                                              Icon(Icons.star_rounded) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('room') ?
                                              Icon(Icons.room_service) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('yoga') ?
                                              Icon(FontAwesomeIcons.star) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('coffee') ?
                                              Icon(FontAwesomeIcons.coffee) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('child') ?
                                              Icon(FontAwesomeIcons.child) :
                                              allDocs[index]['features'][1]
                                                  .toString()
                                                  .contains('accom') ?
                                              Icon(FontAwesomeIcons.houseUser)

                                                  : Icon(Icons.star),
                                              Text(
                                                allDocs[index]['features'][1],
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          child: Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('wifi') ?
                                              Icon(Icons.wifi) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('rest') ?
                                              Icon(Icons.restaurant_rounded) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('pool') ?
                                              Icon(Icons.pool) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('pet') ?
                                              Icon(Icons.pets_outlined) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('air') ?
                                              Icon(Icons.star_rounded) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('room') ?
                                              Icon(Icons.room_service) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('yoga') ?
                                              Icon(FontAwesomeIcons.star) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('coffee') ?
                                              Icon(FontAwesomeIcons.coffee) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('child') ?
                                              Icon(FontAwesomeIcons.child) :
                                              allDocs[index]['features'][2]
                                                  .toString()
                                                  .contains('accom') ?
                                              Icon(FontAwesomeIcons.houseUser)

                                                  : Icon(Icons.star),
                                              Text(
                                                allDocs[index]['features'][2],
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) =>
                    SizedBox(
                      height: 20,
                    ),
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.none) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          );
        });
  }
}

class FeaturesContainer extends StatelessWidget {
  const FeaturesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: const BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.looks_one_outlined,
              ),
              Text('Free Wifi'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.looks_two_outlined),
              Text('Room Services'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.looks_3_outlined),
              Text('Outdoor Pool'),
            ],
          ),
        ],
      ),
    );
  }
}
