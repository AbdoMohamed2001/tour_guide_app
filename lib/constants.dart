import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
const kSizedBox = SizedBox(height: 10,);
const kTextColor = Colors.white;
final CollectionReference kCityReference = FirebaseFirestore.instance.collection('cities');
final CollectionReference kCairoHotelsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('hotels');
final CollectionReference kCairoCinemasReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Cinema');
final kCairoMallsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Mall');
final kCairoMosquesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Mosques');
final kCairoChurchesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('churches');
final kCairoTourismCoompaniesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('Tourism coompanies');
final kCairoCafesReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('cafe');
final kCairoRestaurantsReference = kCityReference.doc('CairoU3CcWkb031dRzxuy').collection('restaurant');
