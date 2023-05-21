import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  static String id = 'testPage';

  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Test Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(
                    'https://static01.nyt.com/images/2022/09/13/science/30TB-PYRAMIDS1/30TB-PYRAMIDS1-superJumbo.jpg',
                  ),
                  height: 350,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 20,
                  bottom: 40,
                  child: Text(
                    'Pyramids',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                    left: 20,
                    bottom: 17,
                    child: Text(
                      'Giza',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Stack(
                    children: [
                      Container(
                        child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://assets.traveltriangle.com/blog/wp-content/uploads/2018/07/Valley-of-Kings-Luxor-egypt.jpg',
                            )),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(color: Colors.orange),
                      ),
                      Positioned(
                          right: 20,
                          top: 15 ,
                          child: Text('+5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          )),
                    ],

                  ),
                ),
                Positioned(
                   right: 30,
                  child: IconButton(
                      onPressed: (){},
                    icon: Icon(
                      Icons.favorite,
                      size: 45,
                      color: Colors.white,
                  )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: [
                    Text('4.5'),
                    Text('Ratings'),
                  ],
                ),
              ],
            ),
            Text('fdfsfdsfdsffddsdfdsfdsdsf'),
            Text(
              'Nearly to this place',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_balance,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Hotels',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu_outlined,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Restaurants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu_outlined,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Restaurants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.restaurant_menu_outlined,
                            size: 45,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Restaurants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
