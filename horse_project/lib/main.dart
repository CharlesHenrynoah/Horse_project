import 'package:flutter/material.dart';
import 'package:horse_project/views/news_feed_page.dart';
import 'package:horse_project/controllers/user_controller.dart'; // Import UserController
import 'package:horse_project/models/user.dart' as appUser; // Import User model
import 'package:uuid/uuid.dart';
import 'package:horse_project/views/calendar_page.dart';
import 'package:horse_project/views/course_programming_page.dart';
import 'package:horse_project/views/horse_list_page.dart';
import 'package:horse_project/views/evening_proposal_page.dart';
import 'package:horse_project/views/profile_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horse Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsFeedPage(),
      routes: {
        '/login': (context) => _LoginPageState(),
        '/signup': (context) => _SignupPageState(),
        '/calendar': (context) => CalendarPage(),
        '/course_programming': (context) => CourseProgrammingPage(),
        '/horse_list': (context) => HorseListPage(),
        '/evening_proposal': (context) => EveningProposalPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}