import 'package:TourGuideApp/models/hotel_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  static String id = 'test';
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference cities = FirebaseFirestore.instance.collection('cities');
    CollectionReference cairoHotelsCollection = cities.doc('CairoU3CcWkb031dRzxuy').collection('hotels');
    DocumentReference firstHotel = cairoHotelsCollection.doc('HPbpzgbqa32MyZlerBDB');
    return FutureBuilder<QuerySnapshot>(
        future: cairoHotelsCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<HotelModel> hotelList = [];
            for (int i = 0 ; i < snapshot.data!.docs.length; i++) {
              hotelList.add(HotelModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              body: ListView.builder(
                itemCount: hotelList.length,
                itemBuilder: (context,index){
                  return TestItem(hotelModel: hotelList[index],);
                },
              ),
            );
          }
          return Text('Loading ...');
        });
  }



}
class TestItem extends StatelessWidget {
  HotelModel hotelModel;
  TestItem({
    Key? key,
  required this.hotelModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(
        color: Colors.red,
        width: double.infinity,
        height: 100,
        child: Text(hotelModel.name),
      ),
    );
  }
}

