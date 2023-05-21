import 'package:TourGuideApp/components.dart';
import 'package:TourGuideApp/models/place_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BestLocations extends StatefulWidget {
  static String id = 'bestLocations';

  const BestLocations({Key? key}) : super(key: key);

  @override
  State<BestLocations> createState() => _BestLocationsState();
}

class _BestLocationsState extends State<BestLocations> {
  @override
  Widget build(BuildContext context) {
    CollectionReference cities =
        FirebaseFirestore.instance.collection('cities');
    CollectionReference cairoPlacesCollection =
        cities.doc('CairoU3CcWkb031dRzxuy').collection('places');
    return FutureBuilder<QuerySnapshot>(
        future: cairoPlacesCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<PlaceModel> placeModelList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              placeModelList.add(PlaceModel.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore Best Locations in Egypt!',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => CustomImageItem(
                            index, context,
                            placeModel: placeModelList[index]),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: placeModelList.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            )),
          );
        });
  }
}

//  Container(width: 200, height: 200, child: Image(image: NetworkImage('https://wallpaperaccess.com/full/235503.jpg'),fit: BoxFit.fitHeight,)),
//         Image(image: NetworkImage('https://outdoortrip-web.s3.eu-central-1.amazonaws.com/4650-night-at-the-egyptian-museum-private-tour-in-cairo/night-at-the-egyptian-museum-private-tour-in-cairo.62406b97be5d6-full.jpg'),fit: BoxFit.fitHeight,),
//         Image(image: NetworkImage('https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Valley-of-Kings-Luxor-egypt.jpg'),fit: BoxFit.fitHeight,),
//         Image(image: NetworkImage('https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Citadel-of-Saladin-egypt.jpg'),fit: BoxFit.fitHeight,),
//         Image(image: NetworkImage('https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Rock-Temples-of-Abu-Simbel-egypt.jpg'),fit: BoxFit.fitHeight,),
//         Image(image: NetworkImage('https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/White-Desert-egypt.jpg'),fit: BoxFit.fitHeight,),
