import 'package:TourGuideApp/screens/cities/city_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchtf = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchtf.addListener(_onSearchChanged);
  }
  _onSearchChanged(){
    print(searchtf.text);
  }

  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> _citiesStream = FirebaseFirestore.instance
        .collection('cities')
        .where(
          'cityName',
          isEqualTo: searchtf.text,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 10,
          ),
          child: TextField(
            keyboardType: TextInputType.name,
            controller: searchtf,
            decoration: InputDecoration(
              hintText: 'Search',
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _citiesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return CityScreen(
                        currentIndex: index,
                        cityDocId   : ds.reference,
                      );
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        snapshot.data!.docChanges[index].doc['cityName'],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
