import 'package:cloud_firestore/cloud_firestore.dart';

class TourismCompanyModel {
  final String address;
  final String name;
  final double phone;
  final double rate;
  final String website;


  TourismCompanyModel({
    required this.address,
    required this.name,
    required this.phone,
    required this.rate,
    required this.website,
  });

  factory TourismCompanyModel.fromJson(DocumentSnapshot doc) {
    return TourismCompanyModel(
      address: doc['Address'],
      name: doc['Name'],
      phone: doc['Phone'],
      rate: doc['Rate'],
      website: doc['Website'],
    );
  }
}
