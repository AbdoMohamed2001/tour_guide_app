import 'package:TourGuideApp/screens/servicesProvider/hotels/all_hotels_screen.dart';
import 'package:TourGuideApp/screens/servicesProvider/mosques/mosque_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServicesProvider extends StatefulWidget {
  static String id = 'servicesProvider';
  const ServicesProvider({Key? key}) : super(key: key);

  @override
  State<ServicesProvider> createState() => _ServicesProviderState();
}

class _ServicesProviderState extends State<ServicesProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded,),

        color: Colors.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, AllHotels.id);
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Center(
                child: Text('Hotels',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              // Navigator.push(context, MosqueScreen.id);
            },
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Center(
                child: Text('Mosques',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){

            },

            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Center(
                child: Text('Cinemas',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){},
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Center(
                child: Text('Malls',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black38,
            ),
            child: Center(
              child: Text('Tourism Companies',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
