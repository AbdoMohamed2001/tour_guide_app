import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatelessWidget {
  static String id = 'EditAccount';

  const EditAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var docId = _auth.currentUser!.email.toString();
    CollectionReference users =
    FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(docId).get(),
        builder: (context, snapshot) {
          final Map<String, dynamic> allDocs = snapshot.data?.data() as Map<String, dynamic>;
          if (allDocs == null) {
            Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(),
              body: Text("Full Name ${allDocs['email']}"),
            );
          }
          else if (snapshot.connectionState == ConnectionState.none) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ));
        });
  }
}
//Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back_ios_new_sharp,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//
//         child: Column(
//           children: [
//             Text('Edit profile',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Image(
//               image: NetworkImage(
//                   'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
//               width: 100,
//               height: 100,
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 5,),
//                   SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Name',
//                         fillColor: Colors.grey[300],
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kSizedBox,
//                   SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         fillColor: Colors.grey[300],
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kSizedBox,
//                   SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'UserName',
//                         fillColor: Colors.grey[300],
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   kSizedBox,
//                   SizedBox(
//                     height: 40,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         fillColor: Colors.grey[300],
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       FirebaseAuth.instance.signOut();
//                     },
//                     child: Container(
//                       width: 110,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius:
//                         const BorderRadius.all(Radius.circular(10)),
//                       ),
//                       child: const Center(child: Text('Sign Out')),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );