import 'package:flutter/material.dart';
import 'package:horse_project/models/contest.dart';
import 'package:intl/intl.dart';

class CourseProgrammingPage extends StatefulWidget {
  @override
  _CourseProgrammingPageState createState() => _CourseProgrammingPageState();
}

class _CourseProgrammingPageState extends State<CourseProgrammingPage> {
  String _selectedLevel = 'Amateur';
  List<Contest> contests = [];
  TextEditingController _contestNameController = TextEditingController();
  TextEditingController _contestAddressController = TextEditingController();
  TextEditingController _contestPhotoUrlController = TextEditingController();
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
        child: Column(
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
              controller: _contestPhotoUrlController,
              decoration: InputDecoration(labelText: 'URL de la photo'),
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
                final contestPhotoUrl = _contestPhotoUrlController.text;
                final dateAndTime = _dateAndTimeController.text;
                final participantName = _participantNameController.text;

                // Extract the date and time from the input
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
                  contestPhotoUrl,
                  dateTime,
                  [ContestParticipant(participantName, _selectedLevel)],
                );

                setState(() {
                  contests.add(newContest);
                });
              },
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
                        'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(contest.date)}'),
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
