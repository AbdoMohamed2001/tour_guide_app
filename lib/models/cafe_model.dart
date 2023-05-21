import 'package:cloud_firestore/cloud_firestore.dart';

class CafeModel {
  final String address;
  final String imageUrl;
  final String name;
  final double phone;
  final double rate;
  final String website;
  final String openDate;
  final String closeDate;
  final Map males;


  CafeModel({
    required this.address,
    required this.imageUrl,
    required this.name,
    required this.phone,
    required this.rate,
    required this.website,
    required this.openDate,
    required this.closeDate,
    required this.males,

  });

  factory CafeModel.fromJson(DocumentSnapshot doc) {
    return CafeModel(
      address: doc['Address'],
      imageUrl: doc['Image url'],
      closeDate: doc['close date'],
      openDate: doc['open date'],
      males: doc['males'],
      name: doc['Name'],
      phone: doc['Phone'],
      rate: doc['Rate'],
      website: doc['Website'],
    );
  }
}
