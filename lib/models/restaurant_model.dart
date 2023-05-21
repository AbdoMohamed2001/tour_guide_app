import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final String address;
  final String imageUrl;
  final String name;
  final double phone;
  final double rate;
  final String openDate;
  final String closeDate;
  final Map males;


  RestaurantModel({
    required this.address,
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.rate,
    required this.openDate,
    required this.closeDate,
    required this.males,

  });

  factory RestaurantModel.fromJson(DocumentSnapshot doc) {
    return RestaurantModel(
      address: doc['Address'],
      imageUrl: doc['Image url'],
      closeDate: doc['close date'],
      openDate: doc['open date'],
      males: doc['males'],
      name: doc['Name'],
      phone: doc['Phone'],
      rate: doc['Rate'],
    );
  }
}
