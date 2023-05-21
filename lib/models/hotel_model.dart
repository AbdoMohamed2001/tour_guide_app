import 'package:cloud_firestore/cloud_firestore.dart';

class HotelModel {
  final String name;
  final double rate;
  final String location;
  final Map features;
  final String imageUrl;

  HotelModel({
    required this.name,
    required this.rate,
    required this.location,
    required this.features,
    required this.imageUrl,
  });


  factory HotelModel.fromJson(DocumentSnapshot doc) {

    return HotelModel(
      imageUrl   : doc['imageurl'],
        features : doc['features'],
        name     : doc['Name'],
        location :  doc['location'],
        rate     : doc['Rate']);
  }
}
