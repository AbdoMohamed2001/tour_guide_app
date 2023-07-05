// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailRestaurantScreen extends StatelessWidget {
  DetailRestaurantScreen({
    Key? key,
    required this.restaurantData,
    required this.currentIndex,
    required this.ImageIndex,
  }) : super(key: key);

  List<QueryDocumentSnapshot> restaurantData;
  int currentIndex;
  int ImageIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              restaurantData[currentIndex]['menuImages'][ImageIndex],
              fit: BoxFit.cover,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
