import 'package:TourGuideApp/screens/login/welcome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static String id = 'AccountScreen';


  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = FirebaseAuth.instance.currentUser?.uid;
    final CollectionReference users =
    FirebaseFirestore.instance.collection('users');
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
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(currentUser).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.data?.data() == null) {
            return Scaffold(
          body: Center(
          child: Text('No data to shown'),
          ),
          );
          }
          else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('111111111111111111111'),
              ),
            );

          }
          else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100),),
                    child: Image.network(
                        height: 200,
                        width: 200,
                        data['photoUrl'].toString(),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 110,
                        child: Text('User name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        ),
                      ),
                      Text(data['username'],
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 110,
                        child: Center(
                          child: Text('Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Text(data['email'],
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context){
                        return WelcomeScreen(title: '');
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100.0),
                      child: Container(
                        width: double.infinity,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.orange[300],
                          borderRadius: BorderRadius.all(Radius.circular(8),),
                        ),
                        child: Center(child: Text('Sign out')),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.waiting){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Colors.orange,),
              ),
            );
          }
          else return Scaffold(
            body: Center(
              child: Text('55555555555555555'),
            ),
          );
        },
      ),
    );
  }
}
