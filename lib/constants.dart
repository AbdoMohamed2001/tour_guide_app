import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
const kSizedBox = SizedBox(height: 10,);
const kSmallSizedBox = SizedBox(height: 4,);
const kDivider = Divider(
  endIndent: 35,
  indent: 35,
  height: 1,
  thickness: 1,
);
const kTextColor = Colors.white;
final CollectionReference kCityReference = FirebaseFirestore.instance.collection('cities');
final CollectionReference kCairoHotelsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('hotels');
final CollectionReference kCairoCinemasReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Cinema');
final kCairoMallsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Mall');
final kCairoMosquesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Mosques');
final kCairoChurchesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('churches');
final kCairoCafesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('cafe');
final kCairoRestaurantsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('restaurant');




