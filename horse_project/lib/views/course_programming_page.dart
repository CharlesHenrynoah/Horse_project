import 'package:flutter/material.dart';

class Contest {
  final String name;
  final List<String> participants;

  Contest(this.name, this.participants);
}

class CourseProgrammingPage extends StatefulWidget {
  @override
  _CourseProgrammingPageState createState() => _CourseProgrammingPageState();
}

class _CourseProgrammingPageState extends State<CourseProgrammingPage> {
  final TextEditingController _contestNameController = TextEditingController();
  List<Contest> contests = [];

  void createContest() {
    final contestName = _contestNameController.text;
    final newContest = Contest(contestName, ['Utilisateur Actuel']);
    setState(() {
      contests.add(newContest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Programming'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _contestNameController,
              decoration: InputDecoration(labelText: 'Nom du concours'),
            ),
            ElevatedButton(
              onPressed: createContest,
              child: Text('Créer un concours'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contests.length,
                itemBuilder: (context, index) {
                  final contest = contests[index];
                  return ListTile(
                    title: Text(contest.name),
                    subtitle: Text(
                        'Participants: ${contest.participants.join(', ')}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
