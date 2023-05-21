import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Image(image: NetworkImage('url'),
          width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description'),
              Column(children: [
                Text('4.5'),
                Text('rating'),
              ],),
            ],
          ),
          Text('cvcvx'),
          Text('data'),
          Row(
            children: [

            ],
          ),
        ],
      ),
    );
  }
}
