import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: NewsFeedPage(),
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
              Navigator.pushNamed(context, value);
            },
            itemBuilder: (BuildContext context) {
              return {
                '/calendar': 'Calendrier',
                '/horse_list': 'Liste des Chevaux',
                '/contest_creation_page': 'contest',
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
