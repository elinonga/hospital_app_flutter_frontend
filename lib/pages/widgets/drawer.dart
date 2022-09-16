import 'package:flutter/material.dart';
import 'package:medical_app/pages/appointment.dart';
import 'package:medical_app/pages/favorite.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/message.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        Column(children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            color: Colors.teal,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  // Pic
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/black.jpeg"),
                          fit: BoxFit.fill),
                    ),
                  ), 

                  // Name & Email
                  Column(
                    children: [
                      Text("David Mezza", style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),),
                      Text("david@mezza.com", style: TextStyle(
                          color: Colors.white
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ListTile(
          //   leading: Icon(Icons.home),
          //   title: Text("Home", style: TextStyle(
          //     fontSize: 18,
          //   ),),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => HomePage(),
          //         ));
          //   },
          // ),

          ListTile(
            leading: Icon(Icons.cloud_download),
            title: Text("Appointments", style: TextStyle(
              fontSize: 18,
            ),),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AppointmentPage(),
                  ));
            },
          ),

          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Favorite", style: TextStyle(
              fontSize: 18,
            ),),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Favorite(),
                  ));
            },
          ), 

          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Messages", style: TextStyle(
              fontSize: 18,
            ),),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessagePage(),
                  ));
            },
          ),

          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text("Profile", style: TextStyle(
          //     fontSize: 18,
          //   ),),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => Profile(),
          //         ));
          //   },
          // ),

          // ListTile(
          //   leading: Icon(Icons.arrow_back),
          //   title: Text("Logout", style: TextStyle(
          //     fontSize: 18,
          //   ),),
          //   onTap: () async {
          //     await logOut();
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => LoginPage(),
          //         ));
          //   },
          // ),



          // ListTile(
          //   leading: Icon(Icons.restaurant),
          //   title: Text("Hospitals", style: TextStyle(
          //     fontSize: 18,
          //   ),),
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => AllHospitals(),
          //         ));
          //   },
          // ),


          //There's a better way than using a SizedBox on getting the space
          //between the upper & lower ListTiles - USE THAT WAY!
          SizedBox(height: 100),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ListTile(
          //       leading: Icon(Icons.settings),
          //       title: Text("Settings", style: TextStyle(
          //         fontSize: 18,
          //       ),),
          //       onTap: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => TestProfile(),
          //             ));
          //       },
          //     ),

          //     ListTile(
          //       leading: Icon(Icons.headset),
          //       title: Text("Support", style: TextStyle(
          //         fontSize: 18,
          //       ),),
          //       onTap: () async {
          //         await logOut();
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => LoginPage(),
          //             ));
          //       },
          //     ),
          //   ],),
        ],
        ),
      ],
      ),
    );
  }
}
