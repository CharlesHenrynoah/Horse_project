import 'package:flutter/material.dart';
import 'package:horse_project/models/contest.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CourseProgrammingPage(),
    );
  }
}

class CourseProgrammingPage extends StatefulWidget {
  @override
  _CourseProgrammingPageState createState() => _CourseProgrammingPageState();
}

class _CourseProgrammingPageState extends State<CourseProgrammingPage> {
  String _selectedLevel = 'Amateur';
  List<Contest> contests = [];
  TextEditingController _contestNameController = TextEditingController();
  TextEditingController _contestAddressController = TextEditingController();
  TextEditingController _participantNameController = TextEditingController();
  TextEditingController _dateAndTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Programming'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _contestNameController,
              decoration: InputDecoration(labelText: 'Nom du concours'),
            ),
            TextFormField(
              controller: _contestAddressController,
              decoration: InputDecoration(labelText: 'Adresse du concours'),
            ),
            TextFormField(
              controller: _dateAndTimeController,
              decoration: InputDecoration(
                  labelText: 'Date et heure (JJ/MM/AAAA HH:MM)'),
            ),
            TextFormField(
              controller: _participantNameController,
              decoration: InputDecoration(labelText: 'Nom du participant'),
            ),
            DropdownButton<String>(
              value: _selectedLevel,
              onChanged: (newValue) {
                setState(() {
                  _selectedLevel = newValue!;
                });
              },
              items: ['Amateur', 'Club1', 'Club2', 'Club3', 'Club4']
                  .map((level) => DropdownMenuItem<String>(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: () {
                final contestName = _contestNameController.text;
                final contestAddress = _contestAddressController.text;
                final dateAndTime = _dateAndTimeController.text;
                final participantName = _participantNameController.text;

                if (_isValidDateTime(dateAndTime)) {
                  final dateParts = dateAndTime.split(' ')[0].split('/');
                  final timeParts = dateAndTime.split(' ')[1].split(':');
                  final dateTime = DateTime(
                    int.parse(dateParts[2]),
                    int.parse(dateParts[1]),
                    int.parse(dateParts[0]),
                    int.parse(timeParts[0]),
                    int.parse(timeParts[1]),
                  );

                  final newContest = Contest(
                    contestName,
                    contestAddress,
                    dateTime,
                    [ContestParticipant(participantName, _selectedLevel)],
                  );

                  setState(() {
                    contests.add(newContest);
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Date mal enregistré'),
                        content: Text(
                            'Veuillez entrer une date et une heure valides .'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Créer un concours'),
            ),
            if (contests.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contests.length,
                itemBuilder: (context, index) {
                  final contest = contests[index];
                  return ListTile(
                    title: Text(contest.name),
                    subtitle: Text(
                        'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(contest.date)}'),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  bool _isValidDateTime(String dateAndTime) {
    try {
      final dateParts = dateAndTime.split(' ')[0].split('/');
      final timeParts = dateAndTime.split(' ')[1].split(':');
      final dateTime = DateTime(
        int.parse(dateParts[2]),
        int.parse(dateParts[1]),
        int.parse(dateParts[0]),
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
      return dateTime.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }
}
