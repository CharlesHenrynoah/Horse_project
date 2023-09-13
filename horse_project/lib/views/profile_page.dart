import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}

class UserProfile {
  String pseudo;
  String mail;
  int num;
  int age;

  UserProfile(
      {required this.pseudo,
      required this.mail,
      required this.num,
      required this.age});
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Center(
        child: Text('Page de profil'),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  UserProfile userProfile = UserProfile(
    pseudo: "Utilisateur",
    mail: "utilisateur@example.com",
    num: 1234567890,
    age: 30,
  );

  TextEditingController pseudoController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    pseudoController.text = userProfile.pseudo;
    mailController.text = userProfile.mail;
    numController.text = userProfile.num.toString();
    ageController.text = userProfile.age.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (isEditing) {
                  // Enregistrez les modifications ici
                  userProfile.pseudo = pseudoController.text;
                  userProfile.mail = mailController.text;
                  userProfile.num = int.parse(numController.text);
                  userProfile.age = int.parse(ageController.text);
                }
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pseudo:"),
            TextFormField(
              controller: pseudoController,
              readOnly: !isEditing,
            ),
            SizedBox(height: 16),
            Text("Mail:"),
            TextFormField(
              controller: mailController,
              readOnly: !isEditing,
            ),
            SizedBox(height: 16),
            Text("Numéro:"),
            TextFormField(
              controller: numController,
              readOnly: !isEditing,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text("Âge:"),
            TextFormField(
              controller: ageController,
              readOnly: !isEditing,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
