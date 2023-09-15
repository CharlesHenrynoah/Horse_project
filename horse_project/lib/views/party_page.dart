import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: PartyPage(),
  ));
}

class PartyPage extends StatefulWidget {
  @override
  _PartyPageState createState() => _PartyPageState();
}

class _PartyPageState extends State<PartyPage> {
  UserProfile userProfile = UserProfile(
    pseudo: "Utilisateur",
    mail: "utilisateur@example.com",
    num: 1234567890,
    age: 30,
    ffeLink: "https://example.com", // Lien FFE par défaut
  );

  TextEditingController pseudoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController ffeLinkController = TextEditingController();

  void savePartyInfo() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soirée"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}

class UserProfile {
  String pseudo;
  String mail;
  int num;
  int age;
  String ffeLink;

  UserProfile({
    required this.pseudo,
    required this.mail,
    required this.num,
    required this.age,
    required this.ffeLink,
  });
}

class HorseInfo {
  String name;
  int age;
  String robe;
  String race;
  String sexe;
  String? specialite;

  HorseInfo({
    required this.name,
    required this.age,
    required this.robe,
    required this.race,
    required this.sexe,
    this.specialite,
  });
}
