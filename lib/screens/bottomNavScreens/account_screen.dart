import 'package:TourGuideApp/constants.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  static String id = 'AccountScreen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(

        child: Column(
          children: [
            Text('Edit profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            ),
            Image(
              image: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5,),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        fillColor: Colors.grey[300],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kSizedBox,
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        fillColor: Colors.grey[300],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kSizedBox,
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'UserName',
                        fillColor: Colors.grey[300],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  kSizedBox,
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        fillColor: Colors.grey[300],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
