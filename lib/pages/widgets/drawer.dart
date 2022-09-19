import 'package:flutter/material.dart';
import 'package:medical_app/pages/appointment.dart';
import 'package:medical_app/pages/favorite.dart';
import 'package:medical_app/pages/home.dart';
import 'package:medical_app/pages/message.dart';
import 'package:medical_app/services/auth_service.dart';

class MainDrawer extends StatefulWidget {
  final String accesstoken;

  const MainDrawer({Key? key, required this.accesstoken}) : super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  //instance of ApiClient class
  final AuthServices _apiClient = AuthServices();

  // get user data from AuthServices
  Future<Map<String, dynamic>> getUserData() async {
    dynamic response = await _apiClient.getUserProfileData(widget.accesstoken);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<Map<String, dynamic>>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // get results from snapshot
            String fname = snapshot.data!['first_name'];
            String lname = snapshot.data!['last_name'];
            String email = snapshot.data!['email'];
            
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/images/black.jpeg'),
                      ),
                      SizedBox(
                        height: 10,
                      ),                      
                      Text(
                        "$fname $lname",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                      
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(accesstoken: widget.accesstoken,),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text('Favorite'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favorite(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Message'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagePage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Appointment'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentPage(),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }
}
