import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final List<CalendarEvent> events = [
    CalendarEvent(DateTime(2023, 9, 10, 10, 0), "Cours 1", false),
    CalendarEvent(DateTime(2023, 9, 5, 14, 30), "Cours 2", false),
    CalendarEvent(DateTime(2023, 9, 3, 9, 0), "Cours 3", false),
    CalendarEvent(DateTime(2023, 9, 17, 11, 0), "Cours 4", true),
    CalendarEvent(DateTime(2023, 9, 20, 15, 0), "Cours 5", true),
  ];

  List<Color> cellColors = List.generate(7 * (18 - 9), (_) => Colors.blue);
  List<String> cellLabels = List.generate(7 * (18 - 9), (_) => "Cours libre");

  void toggleCellColor(int index) {
    setState(() {
      if (cellColors[index] == Colors.blue) {
        cellColors[index] = Colors.red;
        cellLabels[index] = "Cours";
      } else {
        cellColors[index] = Colors.blue;
        cellLabels[index] = "Cours libre";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emploi du temps'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                Text('Cours libre', style: TextStyle(fontSize: 16)),
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, // Nombre de colonnes (jours de la semaine)
                childAspectRatio: 1.2, // Ratio pour chaque cellule
              ),
              itemCount: 7 * (18 - 9), // Nombre de cellules (jours x heures)
              itemBuilder: (context, index) {
                final day = index % 7;
                final hour = index ~/ 7 + 9; // Commencer à 9:00
                final currentDate =
                    DateTime(2023, 9, 3).add(Duration(days: day, hours: hour));

                // Vérifier si l'heure est dans la plage horaire de 12:00 à 13:00
                if (hour >= 12 && hour < 13) {
                  return Container(
                    margin: EdgeInsets.all(2),
                    color: Colors.grey, // Couleur pour l'heure de pause
                  );
                }

                final isPastEvent = events.any((event) =>
                    event.dateTime.isAtSameMomentAs(currentDate) &&
                    event.isPast);
                final cellColor = isPastEvent ? Colors.blue : cellColors[index];
                final label = cellLabels[index];

                return GestureDetector(
                  onTap: () {
                    toggleCellColor(index);
                  },
                  child: Container(
                    margin: EdgeInsets.all(2),
                    color: cellColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${currentDate.hour.toString().padLeft(2, '0')}:${currentDate.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
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
