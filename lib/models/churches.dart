import 'package:cloud_firestore/cloud_firestore.dart';

class ChurchesModel {
  final String address;
  final String name;
  final String imageUrl;
  final String description;



  ChurchesModel({
    required this.address,
    required this.name,
    required this.imageUrl,
    required this.description,


  });

  factory ChurchesModel.fromJson(DocumentSnapshot doc) {
    return ChurchesModel(
      address: doc['Address'],
      name: doc['Name'],
      imageUrl: doc['Image url'],
      description: doc['Description']
    );
  }
}
