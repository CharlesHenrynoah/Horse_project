import 'package:flutter/material.dart';
import 'package:horse_project/views/news_feed_page.dart';
import 'package:horse_project/controllers/user_controller.dart'; // Import UserController
import 'package:horse_project/models/user.dart' as appUser; // Import User model
import 'package:uuid/uuid.dart';
import 'package:horse_project/views/calendar_page.dart';
import 'package:horse_project/views/contest_creation_page.dart'; // Replace '/course_programming' with '/contest_creation'
import 'package:horse_project/views/horse_list_page.dart';
import 'package:horse_project/views/evening_proposal_page.dart';
import 'package:horse_project/views/profile_page.dart';
import 'package:horse_project/views/login_page.dart'; // Import LoginPage
import 'package:horse_project/views/signup_page.dart'; // Import SignupPage
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<String?> userIdNotifier = ValueNotifier<String?>(null);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horse Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ValueListenableBuilder<String?>(
        valueListenable: userIdNotifier,
        builder: (context, userId, child) {
          if (userId == null) {
            return Builder(
              // Added Builder
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Bienvenue à Horse Project'),
                ),
                body: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20), // Add space before buttons
                      ElevatedButton(
                        child: Text('Connexion',
                            style: TextStyle(
                                fontSize: 16.0)), // Increase text size
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0), // Increase button size
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 20), // Add space between buttons
                      ElevatedButton(
                        child: Text('Inscription',
                            style: TextStyle(
                                fontSize: 16.0)), // Increase text size
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0), // Increase button size
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
                      SizedBox(width: 20), // Add space after buttons
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LoginPage(
                onLogin: (userId) => userIdNotifier.value = userId);
          }
        },
      ),
      routes: {
        '/login': (context) => LoginPage(
            onLogin: (userId) =>
                userIdNotifier.value = userId), // Corrected to LoginPage
        '/signup': (context) => SignupPage(), // Corrected to SignupPage
        '/calendar': (context) => CalendarPage(),
        '/contest_creation': (context) => ContestCreationPage(
            contests: []), // Remplace '/course_programming' par '/contest_creation'
        '/horse_list': (context) => HorseListPage(),
        '/contest_creation_page': (context) => ContestCreationPage(),
        '/profile': (context) => ProfilePage(),
        '/news_feed': (context) => NewsFeedPage(), // Add this line
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes
        return MaterialPageRoute(
            builder: (context) =>
                LoginPage(onLogin: (userId) => userIdNotifier.value = userId));
      },
    );
  }
}
