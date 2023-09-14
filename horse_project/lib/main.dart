import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:horse_project/views/signup_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
=======
import 'package:horse_project/views/news_feed_page.dart';
import 'package:horse_project/views/login_page.dart';
import 'package:horse_project/views/signup_page.dart';
import 'package:horse_project/views/calendar_page.dart';
import 'package:horse_project/views/course_programming_page.dart';
import 'package:horse_project/views/horse_list_page.dart';
import 'package:horse_project/views/evening_proposal_page.dart';
import 'package:horse_project/views/profile_page.dart';

void main() {
  runApp(MyApp());
>>>>>>> origin/profil
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Horse Project',
      theme: ThemeData(
<<<<<<< HEAD
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SignupPage(),
      ),
    );
  }
}


=======
        primarySwatch: Colors.blue,
      ),
      home: NewsFeedPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/calendar': (context) => CalendarPage(),
        '/course_programming': (context) => CourseProgrammingPage(),
        '/horse_list': (context) => HorseListPage(),
        '/evening_proposal': (context) => EveningProposalPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
>>>>>>> origin/profil
