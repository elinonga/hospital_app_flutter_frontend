import 'package:flutter/material.dart';
import 'package:medical_app/pages/widgets/appbar.dart';
import 'package:medical_app/pages/widgets/drawer.dart';
import 'package:medical_app/services/auth_service.dart';

class MyProfile extends StatefulWidget {
  final String accesstoken;
  const MyProfile({Key? key, required this.accesstoken}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  
  // instance of ApiClient class
  final AuthServices _apiClient = AuthServices();

  // get user data from AuthServices
  Future<Map<String, dynamic>> getUserData() async {
    dynamic response = await _apiClient.getUserProfileData(widget.accesstoken);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(title: "My Profile",),
      drawer: MainDrawer(accesstoken: widget.accesstoken,),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
        
          children: [

            // My Profile title
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // User data
            FutureBuilder<Map<String, dynamic>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  // get results from snapshot
                  String username = snapshot.data!['username'];
                  String fname = snapshot.data!['first_name'];
                  String lname = snapshot.data!['last_name'];
                  String email = snapshot.data!['email'];
                  // String phone = snapshot.data!['phone'];
                  // String address = snapshot.data!['address'];
                  // String city = snapshot.data!['city'];
                  // String state = snapshot.data!['state'];
                  // String country = snapshot.data!['country'];
                  // String zip = snapshot.data!['zip'];

                  
                  return Column(
                    children: [
                      // User name
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "Username: ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$username",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // First name
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "First name: ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$fname",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Last name
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "Last name: ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$lname",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Email
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            Text(
                              "Email: ",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "$email",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("${snapshot.error}"),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
