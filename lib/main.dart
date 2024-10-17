// import 'package:flutter/material.dart';

// import 'src/app.dart';
// import 'src/settings/settings_controller.dart';
// import 'src/settings/settings_service.dart';

// void main() async {
//   // Set up the SettingsController, which will glue user settings to multiple
//   // Flutter Widgets.
//   final settingsController = SettingsController(SettingsService());

//   // Load the user's preferred theme while the splash screen is displayed.
//   // This prevents a sudden theme change when the app is first displayed.
//   await settingsController.loadSettings();

//   // Run the app and pass in the SettingsController. The app listens to the
//   // SettingsController for changes, then passes it further down to the
//   // SettingsView.
//   runApp(MyApp(settingsController: settingsController));
// }

// import 'package:flutter/material.dart';
//
//
// void main() {
//   runApp(const MaterialApp(
//     home: Home(),
//   ));
// }
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//
//   List<String> Club = ['ClubA', 'ClubB', 'ClubC', 'ClubD', 'ClubE', 'ClubF','ClubG','ClubH'];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(30),
//           child: SingleChildScrollView(
//             child: Column(
//               children: Club.map((club) => SizedBox(
//                 height: 150, // Set a constant height
//                 child: Container(
//                   width: double.infinity,
//                   color: Colors.pink,
//                   padding: EdgeInsets.all(8.0),
//                   margin: EdgeInsets.symmetric(vertical: 4.0),
//                   child: Text(
//                     club,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24, // Set a larger font size
//                     ),
//                   ),
//                 ),
//               )).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> clubs = [];

  @override
  void initState() {
    super.initState();
    fetchClubs();
  }

  Future<void> fetchClubs() async {
    final response = await http.get(Uri.parse('http://192.168.1.33:3000/clubs'));

    if (response.statusCode == 200) {
      setState(() {
        clubs = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load clubs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: Container(
        padding: EdgeInsets.all(30),
    child: SingleChildScrollView(
    child: Column(
    children: clubs.map((club) => SizedBox(
    height: 150, // Set a constant height
    child: Container(
    width: double.infinity,
    color: Colors.pink,
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.symmetric(vertical: 4.0),
    child: Text(
    club['name'], // Assuming the JSON has a 'name' field
    textAlign: TextAlign.center,
    style: TextStyle(
    color: Colors.white,
    fontSize: 24, // Set a larger font size
    ),
    ),
    ),
    )).toList(),
    ),
    ),
    ),
    ),
    );
  }
}