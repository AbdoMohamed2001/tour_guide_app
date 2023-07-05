import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final String address;
  final String email;
  final String imageUrl;
  final Map meals;
  final String name;
  final String phone;
  final String cityName;
  final double rate;
  final List images;
  final String mapUrl;
  final List menuImages;
  final List openingHours;

  RestaurantModel({
    required this.address,
    required this.email,
    required this.imageUrl,
    required this.meals,
    required this.name,
    required this.phone,
    required this.cityName,
    required this.rate,
    required this.images,
    required this.mapUrl,
    required this.menuImages,
    required this.openingHours,
  });

  factory RestaurantModel.fromJson(DocumentSnapshot doc) {
    return RestaurantModel(
      address: doc['Address'],
      email: doc['Email'],
      imageUrl: doc['imageurl'],
      meals: doc['imageurl'],
      name: doc['Name'],
      phone: doc['Phone'],
      cityName: doc['cityName'],
      rate: doc['Rate'],
      images: doc['images'],
      mapUrl: doc['mapUrl'],
      menuImages: doc['menuImages'],
      openingHours: doc['openingHours'],
    );
  }
}
