import 'package:cloud_firestore/cloud_firestore.dart';

class MallModel {
  final String address;
  final String imageUrl;
  final String name;
  final double rate;

  MallModel({
    required this.address,
    required this.imageUrl,
    required this.name,
    required this.rate,
  });

  factory MallModel.fromJson(doc) {
    return MallModel(
      address  : doc['Address'],
      imageUrl : doc['Imageurl'],
      name     : doc['Name'],
      rate     : doc['Rate'],
    );
  }
}
