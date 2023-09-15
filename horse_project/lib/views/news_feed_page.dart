import 'package:flutter/material.dart';
import 'package:horse_project/views/contest_creation_page.dart'; // Import ContestCreationPage

void main() {
  runApp(MaterialApp(
    home: ContestCreationPage(contests: []),
  ));
}

class NewsFeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Feed'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == '/course_programming') {
                Navigator.pushNamed(context, '/contest_creation'); // Redirect to '/contest_creation' instead of '/news_feed'
              } else {
                Navigator.pushNamed(context, value);
              }
            },
            itemBuilder: (BuildContext context) {
              return {
                '/calendar': 'Calendrier',
                '/course_programming': 'Programmation',
                '/horse_list': 'Liste des Chevaux',
                '/evening_proposal': 'Proposition d\'événement',
                '/profile': 'Profil',
              }
                  .entries
                  .map((e) => PopupMenuItem<String>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contenu de la page principale'),
      ),
    );
  }
}
