import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/contest_creation_page': (context) => ContestCreationPage(),
    },
  ));
}

class Contest {
  final String contestName;
  final String contestAddress;
  final String dateAndTime;
  final String selectedLevel;

  Contest(
    this.contestName,
    this.contestAddress,
    this.dateAndTime,
    this.selectedLevel,
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/contest_creation_page');
          },
          child: Text('Create Contest'),
        ),
      ),
    );
  }
}

class ContestCreationPage extends StatefulWidget {
  @override
  _ContestCreationPageState createState() => _ContestCreationPageState();
}

class _ContestCreationPageState extends State<ContestCreationPage> {
  String _selectedLevel = 'Amateur';
  TextEditingController _contestNameController = TextEditingController();
  TextEditingController _contestAddressController = TextEditingController();
  TextEditingController _dateAndTimeController = TextEditingController();
  List<Contest> _contestList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest Creation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _contestNameController,
              decoration: InputDecoration(labelText: 'Contest Name'),
            ),
            TextFormField(
              controller: _contestAddressController,
              decoration: InputDecoration(labelText: 'Contest Address'),
            ),
            TextFormField(
              controller: _dateAndTimeController,
              decoration: InputDecoration(
                labelText: 'Date and Time (DD/MM/YYYY HH:MM)',
              ),
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
              onPressed: () async {
                // Gérez la création de concours ici
                Contest newContest = Contest(
                  _contestNameController.text,
                  _contestAddressController.text,
                  _dateAndTimeController.text,
                  _selectedLevel,
                );

                setState(() {
                  _contestList.add(newContest);
                });

                _contestNameController.clear();
                _contestAddressController.clear();
                _dateAndTimeController.clear();
              },
              child: Text('Create Contest'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Concours créés :',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _contestList.map((contest) {
                return Card(
                  child: ListTile(
                    title: Text('Nom : ${contest.contestName}'),
                    subtitle: Text('Adresse : ${contest.contestAddress}\n'
                        'Date et heure : ${contest.dateAndTime}\n'
                        'Niveau : ${contest.selectedLevel}'),
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
