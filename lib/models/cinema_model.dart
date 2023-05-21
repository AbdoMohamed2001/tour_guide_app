import 'package:cloud_firestore/cloud_firestore.dart';

class CinemaModel {
  final String address;
  final String name;
  final int phone;
  final double rate;
  final String webSite;

  CinemaModel({
    required this.address,
    required this.name,
    required this.phone,
    required this.rate,
    required this.webSite,
  });

  factory CinemaModel.fromJson(DocumentSnapshot doc) {
    return CinemaModel(
      address: doc['Address'],
      name:    doc['Name'],
      phone:   doc['Phone'],
      rate:    doc['Rate'],
      webSite: doc['Website'],
    );
  }
}
