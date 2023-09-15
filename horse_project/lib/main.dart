import 'package:flutter/material.dart';
import 'package:horse_project/views/news_feed_page.dart';
import 'package:horse_project/controllers/user_controller.dart';
import 'package:horse_project/models/user.dart' as appUser;
import 'package:uuid/uuid.dart';
import 'package:horse_project/views/calendar_page.dart';
import 'package:horse_project/views/horse_list_page.dart';
import 'package:horse_project/views/evening_proposal_page.dart';
import 'package:horse_project/views/profile_page.dart';
import 'package:horse_project/views/login_page.dart';
import 'package:horse_project/views/signup_page.dart';
import 'package:horse_project/views/contest_creation_page.dart';
import 'package:horse_project/views/party_page.dart'; // Importer PartyPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<String?> userIdNotifier = ValueNotifier<String?>(null);

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
              builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text('Bienvenue à Horse Project'),
                ),
                body: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 20),
                      ElevatedButton(
                        child:
                            Text('Connexion', style: TextStyle(fontSize: 16.0)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        child: Text('Inscription',
                            style: TextStyle(fontSize: 16.0)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
                      SizedBox(width: 20),
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
        '/login': (context) =>
            LoginPage(onLogin: (userId) => userIdNotifier.value = userId),
        '/signup': (context) => SignupPage(),
        '/calendar': (context) => CalendarPage(),
        '/horse_list': (context) => HorseListPage(),
        '/contest_creation_page': (context) => ContestCreationPage(),
        '/profile': (context) => ProfilePage(),
        '/news_feed': (context) => NewsFeedPage(),
        '/party_page': (context) =>
            PartyPage(), // Ajout de la route vers la page "Party Page"
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) =>
                LoginPage(onLogin: (userId) => userIdNotifier.value = userId));
      },
    );
  }
}
