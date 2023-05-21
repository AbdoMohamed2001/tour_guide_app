import 'package:cloud_firestore/cloud_firestore.dart';

class MosqueModel {
  final String address;
  final String description;
  final String name;
  MosqueModel({
    required this.address,
    required this.description,
    required this.name,

  });


  factory MosqueModel.fromJson(DocumentSnapshot doc) {

    return MosqueModel(
        address: doc['Address'],
        name: doc['Name'],
        description: doc['Description']
    );
  }
}
