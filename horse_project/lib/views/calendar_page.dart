import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  final List<CalendarEvent> events = [
    CalendarEvent(DateTime(2023, 9, 10, 10, 0), "Cours 1", false),
    CalendarEvent(DateTime(2023, 9, 5, 14, 30), "Cours 2", false),
    CalendarEvent(DateTime(2023, 9, 3, 9, 0), "Cours 3", false),
    CalendarEvent(DateTime(2023, 9, 17, 11, 0), "Cours 4", true),
    CalendarEvent(DateTime(2023, 9, 20, 15, 0), "Cours 5", true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Légende:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text('Cours Passés', style: TextStyle(fontSize: 16)),
                SizedBox(width: 20),
                Container(
                  width: 20,
                  height: 20,
                  color: Colors.red,
                ),
                SizedBox(width: 5),
                Text('Cours à Venir', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final isPastEvent = event.isPast;
                final cellColor = isPastEvent ? Colors.blue : Colors.red;

                return Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: cellColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.dateTime.hour.toString().padLeft(2, '0') +
                            ":" +
                            event.dateTime.minute.toString().padLeft(2, '0'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        event.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarEvent {
  final DateTime dateTime;
  final String name;
  final bool isPast;

  CalendarEvent(this.dateTime, this.name, this.isPast);
}
