import 'package:flutter/material.dart';
import 'package:horse_project/models/contest.dart';

class NewsFeedPage extends StatelessWidget {
  final List<Contest> contests;

  NewsFeedPage({required this.contests});

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Contenu de la page principale'),
            if (contests.isNotEmpty)
              Column(
                children: contests.map((contest) {
                  return Card(
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nom du concours: ${contest.name}'),
                          Text('Adresse du concours: ${contest.address}'),
                          Text('Date du concours: ${contest.date}'),
                          Text('Participants:'),
                          Column(
                            children: contest.participants.map((participant) {
                              return Text(
                                  '- ${participant.name} (${participant.level})');
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
