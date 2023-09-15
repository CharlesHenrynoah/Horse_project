import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:horse_project/models/contest.dart';

class ContestCreationPage extends StatefulWidget {
  final List<Contest> contests;

  ContestCreationPage({required this.contests});

  @override
  _ContestCreationPageState createState() => _ContestCreationPageState();
}

class _ContestCreationPageState extends State<ContestCreationPage> {
  String _selectedLevel = 'Amateur';
  TextEditingController _contestNameController = TextEditingController();
  TextEditingController _contestAddressController = TextEditingController();
  TextEditingController _dateAndTimeController = TextEditingController();

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
                final contestName = _contestNameController.text;
                final contestAddress = _contestAddressController.text;
                final dateAndTime = _dateAndTimeController.text;

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
                  );

                  setState(() {
                    widget.contests.add(newContest);
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Invalid Date'),
                        content: Text('Please enter a valid date and time.'),
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
              child: Text('Create Contest'),
            ),
            if (widget.contests.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.contests.length,
                itemBuilder: (context, index) {
                  final contest = widget.contests[index];
                  return ListTile(
                    title: Text(contest.contestName),
                    subtitle: Text(
                        'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(contest.dateAndTime)}'),
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
