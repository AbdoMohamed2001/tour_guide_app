import 'package:cloud_firestore/cloud_firestore.dart';

class PlaceModel {
  final String name;
  final String description;

  PlaceModel({
    required this.name,
    required this.description,
  });

  factory PlaceModel.fromJson(DocumentSnapshot doc) {
    return PlaceModel(
      name: doc['Name'],
      description: doc['Description'],
    );
  }
}
