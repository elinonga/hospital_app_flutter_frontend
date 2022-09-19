import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medical_app/services/auth_service.dart';

class TopBar extends StatefulWidget {
  final String accesstoken;
  const TopBar({
    Key? key,
    required this.accesstoken,
  }) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  bool isLoading = false;

  //instance of ApiClient class
  final AuthServices _apiClient = AuthServices();

  // get user data from AuthServices
  Future<Map<String, dynamic>> getUserData() async {
    setState(() {
      isLoading = true;
    });
    dynamic response = await _apiClient.getUserProfileData(widget.accesstoken);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Column
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Hello,"),

            // User data
            isLoading ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<Map<String, dynamic>>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // get results from snapshot
                  String fname = snapshot.data!['first_name'];
                  String lname = snapshot.data!['last_name'];
                  
                  return Column(
                    children: [
                      Text(
                        "$fname $lname 👋",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("${snapshot.error}"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ]),

          // Row (Notification + Avatar)
          Row(
            children: [
              Stack(children: [
                // Notification
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: HexColor("e8f2f9")),
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.blue,
                  ),
                ),

                // Red dot
                Positioned(
                  right: 10,
                  child: Container(
                    width: 11,
                    height: 11,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.red),
                  ),
                )
              ]),

              const SizedBox(
                width: 10,
              ),

              // Avatar
              const CircleAvatar(
                radius: 25,
                foregroundImage: AssetImage("assets/images/black.jpeg"),
              )
            ],
          )
        ],
      ),
    );
  }
}
