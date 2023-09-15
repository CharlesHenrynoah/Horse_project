import 'package:flutter/material.dart';

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
                '/login': 'Connexion',
                '/signup': 'Inscription',
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
